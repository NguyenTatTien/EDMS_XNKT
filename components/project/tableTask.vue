<template>
    <div class="flex justify-center">
      <DataTable v-model:editingRows="editingRows" v-model:expandedRows="expandedRows" :value="tasks" dataKey="id"
        class="text-xs h-[100%] w-full" filterDisplay="menu" scrollable stripedRows id="tbTask" editMode="row" @row-edit-save="onCellEditComplete" @row-edit-cancel="onRowEditCancel">
    <Column expander style="width: 3rem;z-index: 999;" bodyClass="fz" headerStyle="padding: 0;">
        <template #header>
            <div style="display: flex;height:100%; align-items: center;">
                <div class="flex items-center fixed w-[3rem] bg-white h-[40px]" style="z-index: 999;padding: 0.75rem 1rem;"></div>
            </div>
        </template>
        <template #rowtogglericon="{rowExpanded}">
            <div style="display: flex;height:100%; align-items: center;width: 100%;">
                <div class="flex items-center fixed w-[3rem] frozenCol h-[56px]" style="z-index: 999;padding: 0.75rem 1rem;">
                    <i class="pi" :class="rowExpanded ? 'pi-chevron-down' : 'pi-chevron-right'"></i>
                    </div>
            </div>
        </template>
        <!-- <template #body="{data,rowTogglerCallback}">
        <div style="display: flex;height:100%; align-items: center;">
            <div class="flex items-center fixed w-[3rem] frozenCol h-[56px]" style="z-index: 999;padding: 0.75rem 1rem;">
                <Button 
                    link
                    @click="()=>{data.isOpen = data.isOpen ? false : true;rowTogglerCallback()}"
                    :icon=" data.isOpen?'pi pi-angle-down':'pi pi-angle-right'"
                    style="color: #4471ef;"
                    type="button"/>
            </div>
        </div>
    </template> -->
    </Column>
    <Column header=" " style="width: 3rem" bodyClass="fz" headerStyle="padding: 0;">
        <template #header>
            <div style="display: flex;height:100%; align-items: center;">
                <div class="flex items-center fixed w-[3rem] bg-white h-[40px]" style="z-index: 999;padding: 0.75rem 1rem;"></div>
            </div>
        </template>
        <template #body="{data}">
            <div style="display: flex;height:100%; align-items: center;">
                <div class="flex items-center fixed w-[3rem] frozenCol h-[56px]" style="z-index: 999;padding: 0.75rem 1rem;">
           <i v-if="data.isApprove == false && checkPermissionEdit(data)" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="deleteSubTask(data.id)" title="Delete"></i>
           <i v-else-if="data.isApprove == true && data.isCancel != true && checkPermissionEdit(data)" class="pi pi-minus-circle
 cursor-pointer" style="color: #EF4444;" @click="onCancelProject(data)" title="Cancel"></i>
 <i v-else-if="phase.isCancel != true && data.isCancel == true && checkPermissionEdit(data)" class="pi pi-refresh
 cursor-pointer" style="color: #EF4444;" @click="onRestoreProject(data)" title="Restore"></i>
                </div>
            </div>
        </template>
        <template #editor="{}">
            <div style="display: flex;height:100%; align-items: center;">
                <div class="flex items-center fixed w-[3rem] frozenCol h-[56px]" style="z-index: 999;padding: 0.75rem 1rem;"></div>
            </div>
        </template>
    </Column>
    <Column :rowEditor="true" style="width: 3rem" bodyStyle="text-align:center" bodyClass="fz" headerStyle="padding: 0;">
        <template #header>
            <div style="display: flex;height:100%; align-items: center;">
                <div class="flex items-center fixed w-[3rem] bg-white h-[40px]" style="z-index: 999; padding: 0.75rem 1rem;">
            <i v-if="checkPermissionCreate()" class="pi pi-plus text-green-500 cursor-pointer" @click="onNewTask()" style="color: #4471ef;"/>
            </div>
            </div>
        </template>
        <template #body={data,editorInitCallback}>
            <div class="cursor-pointer" style="display: flex;height:100%; align-items: center; width: 100%;">
                <div class="flex items-center fixed w-[3rem] frozenCol" style="z-index: 999;padding: 0.75rem 1rem;"> <i v-if="checkPermissionEdit(data)" class="pi pi-file-edit cursor-pointer" style="color: #4471ef;" @click="editorInitCallback"></i>
            </div>
            </div>
          </template>
          <template #editor={editorSaveCallback,editorCancelCallback}>
            <div style="display: flex;height:100%; align-items: center;">
                <div class="flex items-center fixed w-[3rem] frozenCol h-[56px] flex-col" style="z-index: 9000;padding: 0.75rem 1rem;"> <i class="pi pi-check cursor-pointer" style="color: #20b92c;" @click="editorSaveCallback"></i>
              <i class="pi pi-times cursor-pointer" style="color: #ff4d4f;" @click="editorCancelCallback"></i>
            </div>
            </div>
          </template>
    </Column>
                <Column field="name" header="Name" style="width: 37rem;" bodyClass="fz" headerStyle="padding: 0;">
                    <template #header>
                        <div style="display: flex;height:100%; align-items: center;">
                            <div class="flex items-center fixed w-[37rem] bg-white h-[40px]" style="z-index: 999;padding: 0.75rem 1rem;">Name</div>
                        </div>
                    </template>
                    <template #body="{data}">
                        <div class="cursor-pointer" style="display: flex; align-items: center;" :style="getRowHeight(data,'12px')">
                            <div class="flex items-center fixed w-[37rem] frozenCol" style="padding: 0.75rem 1rem;">
                        <div class="cursor-pointer flex items-center">
                          <div v-html="data.name.replace(/\n/g, '<br>')" class="h-max"></div>
                            <Tag v-if="data.isCancel" value="Cancel" :severity="getSeverity(4)" />
                            <Tag v-else-if = "data.isProcess == true && !isLate(data.estimatedDate)" value="In Process" :severity="getSeverity(1)" />
                        <Tag v-else-if = "data.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                        <Tag v-else-if = "data.isProcess == true && isLate(data.estimatedDate)" value="Late" :severity="getSeverity(3)" />
                        <Tag v-else-if = "data.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                        </div>
                        </div>
                    </div>
                    </template>
                    <template #editor="{data}">
                        <div style="display: flex; align-items: center;" :style="getRowHeight(data,'14px')">
                            <div class="flex items-center fixed w-[37rem] frozenCol" style="z-index: 999;padding: 0.75rem 1rem;"> <Textarea autoResize v-model="data.name" class="w-full" rows="1"/>
                        </div>
                        </div>
                    </template>
                </Column>
        <Column header="Process Percent" field="process_Percent" style="width: 8rem">
                <template #body="{data}">
                    <a-progress :steps="5" :percent="data.process_Percent" class="pro_per"/>
                </template>
                <template #editor="{data}">
                    <InputNumber v-if="data.isProcess" v-model="data.process_Percent" class="w-[8rem]" inputClass="w-[8rem]" mode="decimal" :min="0" :max="100" />
                    <a-progress v-else :steps="5" :percent="data.process_Percent" class="pro_per"/>
                </template>
        </Column>
        <Column header="Process Weight" field="process_Weight" style="width: 8rem">
            <template #body="{data}">
                <a-progress :steps="5" :percent="data.process_Weight"/>
            </template>
            <template #editor="{data}">
                <InputNumber v-model="data.process_Weight" class="w-[8rem]" inputClass="w-[8rem]" mode="decimal" :min="0" :max="100" />
            </template>
        </Column>
        <Column field="mainJoinBy" header="Main Join" style="width: 12rem">
            <template #body="{data}">
                {{data.mainJoinByName }}
            </template>
            <template #editor="{data}">
                <Dropdown filter="true" v-model="data.mainJoinBy" :options="users" optionLabel="fullName" optionValue="id" placeholder="Select a Main Join" class="w-[12rem]" />
            </template>
        </Column>
        <Column field="subJoins" header="Sub Join" style="width: 16rem">
                    <template #body="{data}">
                        <a-tooltip v-if="data.subJoins != null" placement="bottom">
                                            <template #title>
                                                <div class="grid grid-cols-1 gap-3">
                                                    <span v-for="item in data.subJoins.map(p=>p.fullName)" :key="item.id"> 
                                                    {{item}}
                                                    </span>
                                                </div>  
                                            </template>
                                            {{ data.subJoins.map(p=>p.fullName).join(", ") }}
                                    <!-- <AvatarGroup class="mr-4">
                                        <Avatar v-for="item in data.subJoins.map(p=>p.fullName)" :label="item.charAt(0)" shape="circle" :key="item.id"/>
                                    </AvatarGroup> -->
                        </a-tooltip>
                    </template>
                    <template #editor="{data}">
                        <MultiSelect filter="true" v-model="data.subJoins" display="chip" :options="users" optionLabel="fullName" placeholder="Select Join" class="w-[16rem]" />
                    </template>
        </Column>
                <Column header="Work Hour" field="workHour" style="width: 7rem">
                    <template #editor="{data}">
                        <InputNumber v-model="data.workHour" class="w-[7rem]" inputClass="w-[7rem]" mode="decimal" :min="0" />
                    </template>
                </Column>
                <Column header="Start Date" field="startDate" style="width: 10rem">
                    <template #body="{data}">
                        {{data.startDate !=null? format(data.startDate, 'dd/MM/yyyy') :""}}
                    </template>
                    <template #editor="{data}">
                        <Calendar v-model="data.startDate" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="w-full" @focus="formatStartDate(data)"/>
                    </template>
                </Column>
                <Column header="Estimated Date" field="estimatedDate" style="width: 10rem">
                    <template #body="{data}">
                        {{data.estimatedDate !=null? format(data.estimatedDate, 'dd/MM/yyyy') :""}}
                    </template>
                    <template #editor="{data}">
                        <Calendar v-model="data.estimatedDate" class="w-full" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @focus="formatestimatedDate(data)"/>
                    </template>
                </Column>
                <Column field="endDate" header="End Date" style="width: 10rem">
                    <template #body="{data}">
                        {{data.endDate !=null? format(data.endDate, 'dd/MM/yyyy') :""}}
                    </template>
                </Column>
                <Column header="Created By" field="createdByName" style="width: 8rem">
                    <template #body="{data}">
                        {{ data.createdByName }}
                    </template>
                </Column>
                <Column field="remark" header="Note" style="min-width: 20rem">
                    <template #editor="{data}">
                        <Textarea autoResize v-model="data.remark" class="w-full" />
                    </template>
                </Column>
                <Column header="Folder" field="folderName" style="min-width: 15rem">
                    <template #editor="scrop">
                        <ProjectDocumentSelectFolder v-model="scrop.data"/>
                    </template>
                </Column>
                <Column header="Documents" style="width: 4rem; text-align: left">
          <template #body="scrops">
            <n-popover
              placement="bottom"
              trigger="click"
              >
              <template #trigger>
                <i class="pi pi-book" />
              </template>
              <ProjectDocumentList v-model="scrops.data"/>
            </n-popover>
          </template><template #editor></template>
    </Column>
    <template #expansion="{data}">
        <div>
            <ProjectTableSubTask v-model="props.modelValue" :parentID="data.id" :parentName="data.name" :project="project" :phase="phase" @updateProject="updateProject" @updatePhase="updatePhase"></ProjectTableSubTask>
        </div>
    </template>
</DataTable>
      <a-modal v-model:open="openModel" width="80vw" style="top: 60px" :destroyOnClose="true">
        <template #footer>
        </template>
        <ProjectEditTask v-model="openModel" :parentID="phase.id" :data="openAddModel" @update="updateModel"></ProjectEditTask>
      </a-modal>
    <Toast />
    </div>
  </template>
  <script setup>
  import {ref,onMounted ,watch} from 'vue'
  import { format, parse,formatISO   } from 'date-fns';
  import { Task } from '~/models/task';
  import { useTask } from '~/stores/task';
  import { usePhase } from '~/stores/phase';
  import {useProject} from '~/stores/project';
  import { useUser } from '~/stores/user';
  import { useToast } from "primevue/usetoast";
  import {FilterMatchMode } from 'primevue/api';
  import { useRoute } from 'vue-router';
  import { useAttachDocument } from '~/stores/attachDocument';
import { c } from 'naive-ui';
  const emit = defineEmits(['update:modelValue','project','phase','updateProject','updatePhase']);
  const props = defineProps(['modelValue','project','phase']);
  const myUser = useUser().getUser();
  const route = useRoute();
  const parentID = route.params.id;
  const openModel = ref(false);
  const isTask = ref(false);
  const users = ref([]);
  const openAddModel = ref(new Task());
  const editingRows = ref([]);
  const toast = useToast();
  const phase = ref(props.phase);
  const tasks = ref(props.modelValue);
  const documentsByTask = ref([]);
  const project = ref(props.project);
  const filters = ref({
          global: { value: null, matchMode: FilterMatchMode.CONTAINS },
          name: { value: null, matchMode: FilterMatchMode.CONTAINS },
          description: { value: null, matchMode: FilterMatchMode.CONTAINS },
          startDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
          estimatedDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
          endDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
          approvedBy: { value: null, matchMode: FilterMatchMode.CONTAINS },
          status: { value: null, matchMode: FilterMatchMode.CONTAINS },
          createdByName: { value: null, matchMode: FilterMatchMode.CONTAINS },
      });
const expandedRows = ref([]);
  onMounted(() => {
    tasks.value = props.modelValue.filter(p=>p.parentID == null);
    tasks.value.forEach(p=>{
        p.startDate = new Date(p.startDate)
        p.estimatedDate = new Date(p.estimatedDate)});
    getUsers();
  });
  watch(() => props.modelValue, (newValue) => {
    tasks.value = props.modelValue.filter(p=>p.parentID == null);
    tasks.value.forEach(p=>{
        p.startDate = new Date(p.startDate)
        p.estimatedDate = new Date(p.estimatedDate)});
});
watch(() => props.project, (newValue) => {
    project.value = newValue;
});
const getUsers = async () => {
    try {
      const data = await useUser().getAll();
      users.value = data;
    } catch (error) {
      console.log(error);
    }
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
const editTask =(data,itask) => {
  openAddModel.value =  JSON.parse(JSON.stringify(data));
    openModel.value = true;
}
const updateModel = (isCreate,data) => {
    if(isCreate){
        dataModel.value.push(data);
        emit('update:modelValue', dataModel.value);
    }
    else{
      //  dataModel.value = dataModel.value.map(p=>p.id == data.id? data : p);
        emit('updateTask', data);
    }
}
const onNewTask = () => {
    if(editingRows.value.length > 0){
      toast.add({ severity: 'error', summary: 'Error Message', detail: "Please save the current task before creating a new one!", life: 5000 });
      return;
    }
    openAddModel.value = new Task();
    tasks.value.push(openAddModel.value);
    editingRows.value = [openAddModel.value];
    //add button to edit task
}
const onCellEditComplete = async(event) => {
    let { newData, index } = event;

    if(newData.estimatedDate){
    var expDate = new Date(newData.estimatedDate);
    var startDate = new Date(newData.startDate);
    var phaseDate = new Date(phase.value.estimatedDate);
    if(expDate < startDate){
      toast.add({ severity: 'error', summary: 'Error Message', detail: "Estimated date must be greater than start date!", life: 5000 });
      editingRows.value = [newData];
      return;
    }if(expDate > phaseDate){
      toast.add({ severity: 'error', summary: 'Error Message', detail: "Estimated date must be less than phase estimated date!", life: 5000 });
      editingRows.value = [newData];
      return;
    }
    }else{
        toast.add({ severity: 'error', summary: 'Error Message', detail: "Please select estimated date!", life: 5000 });
        editingRows.value = [newData];
        return;
    }
    var user = users.value.filter(p=>p.id == newData.mainJoinBy);
    newData.mainJoinByName = user.length > 0 ? user[0].fullName : "";
    var uss = newData.subJoins;
  newData.subJoinByIds =  uss.map(t=>t.id).join(';'); 
  newData.subJoinByNames = uss.map(t=>t.fullName).join(';');
    if(newData.id == 0){
        try{
            newData.projectID = project.value.id;
            newData.phaseID = phase.value.id;
            var data =  await useTask().create(newData);
            if(typeof data == "string" && data != ""){
                toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
                editingRows.value = [newData];
                return;
            }
            tasks.value[index] = data;
            toast.add({ severity: 'success', summary: 'Success Message', detail: "Create successfully!", life: 5000 });
        }catch(e){
            console.log(e);
            toast.add({ severity: 'error', summary: 'Error Message', detail: "Create fail!", life: 5000 });
            tasks.value = tasks.value.filter(p=>p.id != 0);
            return;
        }
    }else{
        try{
            var data =  await useTask().update(newData);
            if(typeof data == "string" && data != ""){
                toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
                return;
            }
            emit('updateProject',data.project);
            emit('updatePhase',data.phase);
            toast.add({ severity: 'success', summary: 'Success Message', detail: "Update successfully!", life: 5000 });
        }catch(e){
            console.log(e);
            toast.add({ severity: 'error', summary: 'Error Message', detail: "Update fail!", life: 5000 });
            return;
        }
       
    }
};
const deleteSubTask = async(Id,taskId)=>{
        try{
            var st = confirm("Are you sure you want to delete this task?");
            if(st == false){
                return;
            }
            var data = await useTask().delete(Id);
            if(typeof data == "string" && data != ""){
                toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
                return;
            }
            tasks.value = tasks.value.filter(p=>p.id != Id);
            toast.add({ severity: 'success', summary: 'Success Message', detail: "Delete successfully!", life: 5000 });
        }catch(e){
            toast.add({ severity: 'error', summary: 'Error Message', detail: "Delete fail!", life: 5000 });
        }
}
const formatStartDate = (data)=>{
    if (data.startDate) {
        data.startDate = parse(format(data.startDate, 'dd/MM/yyyy'), 'dd/MM/yyyy', new Date());
    }
}
const formatestimatedDate = (data)=>{
    if (data.estimatedDate) {
        data.estimatedDate = parse(format(data.estimatedDate, 'dd/MM/yyyy'), 'dd/MM/yyyy', new Date());
    }
}
const onRowEditCancel = (event) => {
    if(event.data.id == 0){
        tasks.value = tasks.value.filter(p=>p.id != 0);
    }
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
const onCancelProject = async(task)=>{
    try{
        var st = confirm("Are you sure you want to cancel this task?");
        if(st == false){
            return;
        }
        var data = await useTask().cancel(task);
        if(typeof data == "string" && data != ""){
            toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
            return;
        }
        emit('updateProject',data.project);
        emit('updatePhase',data.phase);
        toast.add({ severity: 'success', summary: 'Success Message', detail: "Cancel successfully!", life: 5000 });
    }catch(e){
        console.log(e);
    }
}
const onRestoreProject = async(task)=>{
    try{
        var st = confirm("Are you sure you want to restore this task?");
        if(st == false){
            return;
        }
        var data = await useTask().restore(task);
        if(typeof data == "string" && data != ""){
            toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
            return;
        }
        emit('updateProject',data.project);
        emit('updatePhase',data.phase);
        toast.add({ severity: 'success', summary: 'Success Message', detail: "Restore successfully!", life: 5000 });
    }catch(e){
        console.log(e);
    }
}
const checkPermissionCreate = ()=>{
    if(project.value.isApprove ==false && (phase.value.createdBy == myUser.id || myUser.id == 1|| (myUser.id == project.value.mainManagerID || (project.value.subManagers && project.value.subManagers.filter(t=>t.id==myUser.id).length>0)) || (project.value.approvalIds != null && project.value.approvalIds.includes(myUser.id))||(myUser.id == phase.value.mainManagerID ||(phase.value.subManagers && phase.value.subManagers.filter(t=>t.id==myUser.id).length>0)))) return true;
    else return false;
}
const checkPermissionEdit = (data) =>{
    if((phase.value.createdBy == myUser.id || myUser.id == 1|| (myUser.id == project.value.mainManagerID || (project.value.subManagers && project.value.subManagers.filter(t=>t.id==myUser.id).length>0)) || (project.value.approvalIds != null && project.value.approvalIds.includes(myUser.id))||(myUser.id == phase.value.mainManagerID || (phase.value.subManagers && phase.value.subManagers.filter(t=>t.id==myUser.id).length>0)) || data.mainJoinBy == myUser.id || data.subJoins && data.subJoins.filter(t=>t.id == myUser.id).length >0)) return true;
    else return false;
}
const handleUpdateShow = async(show,data)=>{
  if(show){
      documentsByTask.value = await useAttachDocument().getDocumentAttachToPhase(data.id);
  }
}
const getRowHeight = (data,size) => {
    const div = document.createElement('div');
    div.style.width = '37rem';
    div.style.visibility = 'hidden';
    // div.style.position = 'fixed';
    div.style.padding = '0.75rem 1rem'; 
    div.style.fontSize = size;
    div.style.height = 'max-content';
// match your actual padding // match your actual font size
    div.style.lineHeight = 'unset'; // match your actual line height
    div.innerHTML = data.name.replace(/\n/g, '<br>');
    document.body.appendChild(div);
    const height = div.offsetHeight;
    document.body.removeChild(div);
// Add some padding to the calculated height
    const minHeight = 60; // minimum height
    const finalHeight = Math.max(height, minHeight); // add padding and ensure minimum height
    return {
        height: `${finalHeight}px`
    };
}
const filteredTasks = (parentID) => {
    return tasks.value.filter(t => t.id === parentID);
}
const updateProject = (data) => {
    emit('updateProject',data);
}
const updatePhase = (data) => {
    emit('updatePhase',data);
}
</script>
<style>
  #tbTask .p-progressbar-label{
    display: none;
  }
  #tbTask .pro_per .ant-progress-steps-item-active{
    background-color: #1b9e3e !important;
  }
  #tbTask .p-progressbar{
    height: 5px;
  }
  #tbTask .p-row-odd .frozenCol{
    background-color: #f8fafc;
    z-index: 999;
  }
  #tbTask .p-row-even .frozenCol{
    background-color: #ffffff;
    z-index: 999;
  }
  #tbTask .fz{
    padding: 0;
  }
  #tbTask th{
    color: #007ff7;
  }

</style>