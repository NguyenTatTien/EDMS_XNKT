<template>
   
      <div class="flex justify-center flex-wrap h-full bg-[#f8fafc]">
        <n-infinite-scroll class="workflow-container h-full" :distance="10">
          <div class="mt-2 flex justify-end w-full px-2">
          <n-select v-model:value="selectedValue" :options="modelData" clearable value-field="id" label-field="name" class="w-[300px]"/>
        </div>
        <div class="flex h-max">
          <div
            v-for="column in columns"
            :key="column.title"
            class="px-2 column-width rounded mr-4 h-max py-2"
          >
            <div class="flex items-center bg-white rounded-sm" style="box-shadow: 0 0 #0000, 0 0 #0000, 0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1);"><p class="text-gray-700 font-semibold font-sans tracking-wide text-sm px-2"> <Badge :severity="column.titleColor" class="mr-2"/>{{ column.title }}</p></div>
          <VueDraggableNext
          class="dragArea list-group w-full min-h-[70vh]"
          :list="column.tasks"
          group="people"
          :move="checkMove" :id="column.id" @end="onEnd" @change="onChange">
              <ProjectTaskCard
                v-for="task in column.tasks"
                :key="task.id"
                :task="task"
                :phaseName="column.phaseName"
                class="mt-3 cursor-move" @updateTask="updateTask" @updateProject="updateProject" @updatePhase="updatePhase"></ProjectTaskCard>
              </VueDraggableNext>
          </div>
        </div></n-infinite-scroll>
        <Toast />
      </div>
  </template>
  <script setup>
  import { isCancel } from 'axios';
import { ref,onMounted,watch } from 'vue';
import { VueDraggableNext } from 'vue-draggable-next';
import { useToast } from "primevue/usetoast";
import { useTask } from '~/stores/task';
import { useUser } from '~/stores/user';
const emit = defineEmits(['update:modelValue','updatePhase','updateProject','project']);
const props = defineProps(['modelValue','project']);
const modelData = ref(props.modelValue);
const selectedValue = ref(null);
const toast = useToast();
const isChange = ref(true);
const task = ref({});
const myUser = useUser().getUser();
const columns = ref([
    {
      id:"1",
      titleColor : 'contrast',
      title: 'Awaiting Approve',
      phaseName:'',
      tasks: []
    },
    {
      id:"2",
      titleColor : 'warning',
      title: 'In Progress',
      phaseName:'',
      tasks: []
    },
    {
      id:"4",
      titleColor : 'danger',
      title: 'Late',
      phaseName:'',
      tasks: []
    },
    {
      id:"3",
      titleColor : 'success',
      title: 'Done',
      phaseName:'',
      tasks: []
    },
    {
      id:"5",
      titleColor : 'danger',
      title: 'Cancel',
      phaseName:'',
      tasks: []
    }
   
  ]);
  watch(() => props.modelValue, (newValue) => {
      columns.value[0].tasks = [];
      columns.value[1].tasks = [];
      columns.value[2].tasks = [];
      columns.value[3].tasks = [];
      columns.value[4].tasks = [];
      modelData.value = props.modelValue;
      init(modelData.value);
      console.log(modelData.value);
  });
  watch(() => modelData.value, (newValue) => {
    columns.value[0].tasks = [];
      columns.value[1].tasks = [];
      columns.value[2].tasks = [];
      columns.value[3].tasks = [];
      columns.value[4].tasks = [];
      init(modelData.value);
      console.log(newValue);
  });
  watch(() => selectedValue.value, (newValue) => {
    var data = modelData.value.filter(x => x.id == newValue);
    if(newValue == null)  data = modelData.value;
    columns.value[0].tasks = [];
    columns.value[1].tasks = [];
    columns.value[2].tasks = [];
    columns.value[3].tasks = [];
    columns.value[4].tasks = [];
    init(data);
   
  });
  const init = (data) => {
    if(data != undefined){
      data.forEach(element => {
        var tasks = checkPermissionTask(element) ?element.tasks:element.tasks.filter(x => x.mainJoinBy == myUser.id|| x.subJoins.filter(p=>p.id == myUser.id).length > 0);
        if(tasks != undefined){
            tasks.forEach(task => {
              if(task.isApprove == false){
                columns.value[0].tasks.push(task);
                columns.value[0].phaseName = element.name;
              }
              else if(task.isProcess == true && !isLate(task.estimatedDate) && task.isCancel == false){
                columns.value[1].tasks.push(task);
                columns.value[1].phaseName = element.name;
              }
              else if(task.isComplete == true){
                columns.value[3].tasks.push(task);
                columns.value[3].phaseName = element.name;
              }
              else if(isLate(task.estimatedDate)){
                columns.value[2].tasks.push(task);
                columns.value[2].phaseName = element.name;
              }
              else if(task.isCancel == true){
                columns.value[4].tasks.push(task);
                columns.value[4].phaseName = element.name;
              }
            });
        }
      
    });
    
    }
  }
  const checkPermissionTask =(phase)=>{
    if(myUser.id == 1|| props.project.createdBy == myUser.id || (props.project.approvalIds != null && props.project.approvalIds.includes(myUser.id))|| props.project.mainManagerID == myUser.id || props.project.subManagers.filter(p=>p.id == myUser.id).length > 0|| phase.mainManagerID == myUser.id || phase.subManagers.filter(p=>p.id == myUser.id).length > 0){
      return true;
    }else return false;
  }
  onMounted(() => {
    modelData.value = props.modelValue;
    init( modelData.value);
  });
  const checkMove = (event) =>{
    if(event.from.id != event.to.id){
      if(event.from.id == 1 || event.from.id == 5 || event.to.id == 1 || event.to.id == 4){
         //toast.add({ severity: 'error', summary: 'Error Message', detail: "This state is not changed here!", life: 5000 });
       // event.preventDefault(); 
       //console.log('checkMove', event.draggedContext);
       isChange.value = false;
        return false;
        // console.log('Future index: ' + event.draggedContext.futureIndex)
      }
      else{
         isChange.value = true;
      }
    }
    };
    const onEnd = async(event) =>{
    
      if(isChange.value == false){
         toast.add({ severity: 'error', summary: 'Error Message', detail: "This state is not changed here!", life: 5000 });
       // event.preventDefault(); 
        isChange.value = true;
        
       //dis.value = true;
        return false;
      
        // console.log('Future index: ' + event.draggedContext.futureIndex)
      
    }
    else if(event.from.id != event.to.id){
      if(event.to.id == 2){
          task.value.process_Percent = 0;
          var data = await useTask().update(task.value);
          emit("updateProject",data.project);
          emit('updatePhase',data.phase);
      }else if(event.to.id == 3){
          task.value.process_Percent = 100;
          var data = await useTask().update(task.value);
          emit("updateProject",data.project);
          emit('updatePhase',data.phase);
      } 

      else if(event.to.id == 5){
        var data = await useTask().cancel(task.value);
        emit("updateProject",data.project);
        emit('updatePhase',data.phase);
      }
    }
  }
    const onChange = (event) =>{
    
      const {added, removed, moved} = event;
      if(added){
        // columns.value.find(x => x.id == event.to.id).tasks.find(x => x.id == added.id).process_Percent = 100;
        // modelData.value.find(x => x.id == added.id).process_Percent = 100;
          task.value = added.element;
       
      }
      //console.log('onChange', event);
    };
const updateTask = (task) =>{
  
  emit('updateTask',task);
}
const getSeverity = (status) => {
    switch (status) {
        case 0:
            return 'secondary';
        case 1:
            return 'warning';
            case 2:
            return 'success';
        case 3:
            return 'danger';
        case 4:
            return 'danger';
        default:
            return null;
    }
};
const updatePhase = (data) => {
  emit('updatePhase',data);

}
const updateProject = (data) => {
  emit('updateProject',data);
}
const isLate = (date)=>{
    let plantDate = new Date(date);
    let currentDate = new Date();
    if(plantDate < currentDate){
        return true;
    }else{
        return false;
    }
}
  </script>
  
  <style scoped>
  .column-width {
    min-width: 280px;
    width: 280px;
  }
  .ghost-card {
    opacity: 0.5;
    background: #f7fafc;
    border: 1px solid #4299e1;
  }
  </style>