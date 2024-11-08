<template>
    <div class="px-2 overflow-y-auto overflow-x-hidden bg-[#f7f8fa] h-full">
    <div class="pt-2 grid sm:grid-cols-2 xl:grid-cols-4 gap-4">
        <ProjectDasdbroadWidgetsStarts1 v-model="dataWidget"/>
        <ProjectDasdbroadWidgetsStarts2 v-model="dataWidget"/>
        <ProjectDasdbroadWidgetsStarts3 v-model="dataWidget"/>
        <ProjectDasdbroadWidgetsStarts4 v-model="dataWidget"/>
    </div>
    <div class="grid grid-cols-12 w-full mt-2 gap-2">
       <div class="col-span-4">
            <div class="w-full">
                <div class=" grid gird-cols-1 gap-2">
                        <div class="grid grid-cols-2 gap-2">
                        <!-- <ProjectDasdbroadCard v-model="countProject" :text="'Project'" :color="'text-blue-500'"/>
                        <ProjectDasdbroadCard v-model="countPhase" :text="'Phase'" :color="'text-green-500'"/>
                        <ProjectDasdbroadCard v-model="countTask" :text="'Task'" :color="'text-orange-500'"/>
                        <ProjectDasdbroadCard v-model="countWorkHour" :text="'Work Hour'" :color="'text-red-500'"/> -->
                        <ProjectDasdbroadCard v-model="countProject" :text="'Project'" :color="'text-[#0ea5e9]'"/>
                        <ProjectDasdbroadCard v-model="countPhase" :text="'Phase'" :color="'text-[#ff6632]'"/>
                        <ProjectDasdbroadCard v-model="countTask" :text="'Task'" :color="'text-[#12bf24]'"/>
                        <ProjectDasdbroadCard v-model="countWorkHour" :text="'Work Hour'" :color="'text-[#eb3939]'"/>
                        </div>
                        <div class="w-full">
                            <ProjectDasdbroadTableTask v-model="tasks" :projects="projects"/>
                        </div>
                </div>
            </div>
       </div>
       <div class="col-span-5">
        <div class="w-full">
            <div class=" grid-cols-1 grid gap-2">
                <ProjectDasdbroadChartProject v-model="workLoads"/>
                <ProjectDasdbroadChartTask2 v-model="dataCreateorComplete" />
            </div>
        </div>
    </div>
    <div class="col-span-3">
        <div class="w-full">
            <div class="grid gird-cols-1 gap-2">
                <ProjectDasdbroadChartTask v-model="tasks"/>
                <ProjectDasdbroadTableLog  v-model="tableUserTask"/>
            </div>
        </div>
    </div>
    </div>
    </div>
</template>
<script setup>  
import {ref,onMounted} from 'vue';
import  {useProject} from '~/stores/project';
import {useTask} from '~/stores/task';
const countProject = ref(0);
const countTask = ref(0);
const countPhase = ref(0);
const countWorkHour = ref(0);
const projects = ref([]);
const dataWidget = ref([]);
const workLoads = ref([]);
const tasks = ref([]);
const dataCreateorComplete = ref([]);
const tableTask = ref([]); 
const tableUserTask = ref([]);
const getData = async () => {
   projects.value = await useProject().getAllTask();
    getWorkload();
   getAllTask();
    getDataWidget();
   getDataCard();
   onDataCreatedOrComplete();
   getUserTask();
}
const getDataWidget = async() => {
    var project = projects.value.filter(t=>new Date(t.createdDate).getFullYear() == new Date().getFullYear());
    var complete = projects.value.filter(t=>new Date(t.createdDate).getFullYear() == new Date().getFullYear() && t.isComplete == true);
    var process = projects.value.filter(t=>new Date(t.createdDate).getFullYear() == new Date().getFullYear() && t.isProcess == true);
    var workHour = tasks.value.map(t=>t.workHour).reduce((a,b)=>a+b,0);
    var projectPerMonth = onProjecPerMonth();
    var workHourPerMonth = onWorkHourPerMonth();
    dataWidget.value ={
        count:[
        project.length,
       complete.length,
        process.length,
        workHour
        ],
        countAllMonth: {
            total:projectPerMonth.map(t=>t.length),
            complete:projectPerMonth.map(t=>t.filter(t=>t.isComplete == true).length),
            process:projectPerMonth.map(t=>t.filter(t=>t.isProcess == true).length),
            workHour:workHourPerMonth
        }
    };
}
const onWorkHourPerMonth = () => {
    var data = [];
    for(var i = 1 ;i<=12;i++){
        var taskInMonth = tasks.value.filter(t=>new Date(t.createdDate).getMonth() == i);
        data.push(taskInMonth.map(t=>t.workHour).reduce((a,b)=>a+b,0));
    }
    return data;
}
const onProjecPerMonth = ()=>{
    var data = [];
    for(var i = 1 ;i<=12;i++){
        data.push(projects.value.filter(t=>new Date(t.createdDate).getMonth() == i));
    }
    return data;
}
const getDataCard = () => {
    countProject.value += projects.value.length;
    projects.value.forEach(t=>{
        if(t.phases != null){
            countPhase.value += t.phases.length;
            t.phases.forEach(p=>{
                if(p.tasks != null){
                    countTask.value += p.tasks.length;
                    p.tasks.forEach(task=>{
                        countWorkHour.value += task.workHour;
                    });
                }
            });
        }
    });
}
const getWorkload = () =>{
    var model = [];
    projects.value.forEach(t => {
        var data = {
            id:t.id,
            project: t.name,
            wait: [],
            process: [],
            complete: [],
            late: [],
            cancel: []
        }
        if (t.phases != null) {
            t.phases.forEach(p => {
                if (p.tasks != null) {
                    p.tasks.forEach(task => {
                        if (!task.isApprove) data.wait.push(task);
                        else if (task.isProcess && !task.isComplete && !isLate(task.estimatedDate) && !task.isCancel) data.process.push(task);
                        else if (task.isComplete && !task.isCancel) data.complete.push(task);
                        else if (task.isProcess && !task.isComplete && isLate(task.estimatedDate) && !task.isCancel) data.late.push(task);
                        else if (task.isCancel) data.cancel.push(task);
                    });
                }
            });
        }
        model.push(data);
    });
    workLoads.value = model;
}
const getAllTask = ()=>{
    projects.value.forEach(t=>{
        if(t.phases != null){
            t.phases.forEach(p=>{
                if(p.tasks != null){
                    p.tasks.forEach(task=>{
                        tasks.value.push(task);
                    });
                }
            });
        }
    });
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
const onDataCreatedOrComplete = () => {
    var data =
        {
            created:[],
            complete:[]
        }
    for(var i = 1 ;i<=12;i++){
        var taskInMonth = tasks.value.filter(t=>new Date(t.createdDate).getMonth() == i);
        var taskCompleteInMonth = tasks.value.filter(t=>new Date(t.createdDate).getMonth() == i && t.isCompleted == true);
        data.created.push(taskInMonth.length);
        data.complete.push(taskCompleteInMonth.length);
    }
    dataCreateorComplete.value = data;
}
const getUserTask = (id) => {
   tasks.value.forEach(t=>{
       if(tableUserTask.value.filter(k=>k.id == t.mainJoinBy).length == 0){
           tableUserTask.value.push({
                id:t.mainJoinBy,
                userName:t.mainJoinByName,
                workHour:t.workHour,
                task:1
           });
       }else{
              var index = tableUserTask.value.findIndex(k=>k.id == t.mainJoinBy);
              tableUserTask.value[index].workHour += t.workHour;
              tableUserTask.value[index].task += 1;
       }
       t.subJoins.forEach(h=>{
           if(tableUserTask.value.filter(k=>k.id == h.id).length == 0){
               tableUserTask.value.push({
                    id:h.id,
                    userName:h.fullName,
                    workHour:t.workHour,
                    task:1
               });
           }else{
                  var index = tableUserTask.value.findIndex(k=>k.id == h.id);
                  tableUserTask.value[index].workHour += t.workHour;
                  tableUserTask.value[index].task += 1;
           }
       });
   });
   console.log(tableUserTask.value);
}
await getData();
</script>
