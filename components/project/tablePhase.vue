<template>
    <div  class="flex w-full" id="divGrid" style="padding-bottom: 0 !important">
      <DataTable v-model:editingRows="editingRows" v-model:expandedRows="expandedRows" selectionMode="single" :value="dataModel" dataKey="id" ref="tablePhase"
        class="text-xs h-[100%] w-full" scrollable filterDisplay="menu" stripedRows id="tbPhase" @row-edit-save="onCompletePhase" editMode="row" @row-edit-init="onEditInit" @row-edit-cancel="onRowEditCancel">
        <template #header>
            <div class="flex justify-end items-center">
              <div class="flex justify-end items-center">
                <Button v-if="checkPermissionCreate()" icon="pi pi-plus" class="mr-2 h-[2rem]"  @click="onNewPhase()"/>
                <IconField iconPosition="left">
                    <InputIcon>
                        <i class="pi pi-search" />
                    </InputIcon>
                    <InputText placeholder="Keyword Search" class="py-[0.5rem] px-[0.75rem] pl-[2.5rem]" v-model="filters['global'].value" style="padding-left: 2rem !important"/>
                </IconField>
            </div>
          </div>
 </template>
 <Column expander style="width: 1rem;z-index: 999;" alignFrozen="left" :frozen="true"/>
 
    <Column header=" " style="width: 1rem;z-index: 999" alignFrozen="left" :frozen="true">
        <template #body="{data}">
           <i v-if="data.isApprove == false && checkPermisionEdit(data)" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="deleteTask(data.id)"></i>
           <i v-else-if="data.isCancel != true && data.isApprove == true && checkPermisionEdit(data)" class="pi pi-minus-circle
cursor-pointer" style="color: #EF4444;" @click="onCancelPhase(data)"></i>
            <i v-else-if="project.isCancel != true && data.isCancel == true && data.isApprove == true && checkPermisionEdit(data)" class="pi pi-refresh
            cursor-pointer" style="color: #EF4444;" @click="onRestoreProject(data)"></i>
        </template>
        <template #editor="{}">
        </template>
    </Column>
    <Column :rowEditor="true" style="width: 1rem;z-index: 999" bodyStyle="text-align:center" alignFrozen="left" :frozen="true">
        <template #body={data,editorInitCallback}>
              <i v-if="checkPermisionEdit(data)" class="pi pi-file-edit cursor-pointer" style="color: #4471ef;" @click="editorInitCallback"></i>
          </template>
          <template #editor={editorSaveCallback,editorCancelCallback}>
              <i class="pi pi-check cursor-pointer" style="color: #20b92c;" @click="editorSaveCallback"></i>
              <i class="pi pi-times cursor-pointer" style="color: #ff4d4f;" @click="editorCancelCallback"></i>
          </template>
    </Column>
    <Column field="name" header="Name" style="min-width: 37rem;z-index: 999" alignFrozen="left" :frozen="true">
        <template #body="{data}">
                <div class="cursor-pointer text-black">
                {{data.name}}
                    <Tag v-if="data.isCancel" value="Cancel" :severity="getSeverity(5)" />
                    <Tag v-else-if = "data.isApprove == true && data.isProcess == false && data.isComplete == false" value="Approved" :severity="getSeverity(1)" />
                    <Tag v-else-if = "data.isProcess == true && !isLate(data.estimatedDate)" value="In Process" :severity="getSeverity(2)" />
                    <Tag v-else-if = "data.isComplete == true" value="Completed" :severity="getSeverity(3)" />
                    <Tag v-else-if = "data.isProcess == true && isLate(data.estimatedDate)" value="Late" :severity="getSeverity(4)" />
                    <Tag v-else-if = "data.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                </div>
        </template>
        <template #editor="{data}">
            <Textarea autoResize v-model="data.name" class="w-full" rows="1"/>
        </template>
    </Column>
    <!-- <Column field="description" header="Description" style="min-width: 20rem">
        <template #editor="{data}">
            <Textarea autoResize v-model="data.description" class="w-full" rows="1"/>
        </template>
    </Column> -->
    <Column field="departmentID" header="Department" style="min-width: 12rem">
        <template #body="{data}">
            {{data.departmentName}}
        </template>
        <template #editor="{data}">
           <Dropdown showClear filter="true" v-model="data.departmentID" :options="departments" optionLabel="name" optionValue="id" placeholder="Select a department" class="w-full"/>
        </template>
    </Column>
    <Column field="mainManagerID" header="Manager" style="min-width: 8rem">
            <template #body="{data}">
                {{data.mainManagerName }}
            </template>
            <template #editor="{data}">
                <Dropdown v-model="data.mainManagerID" :options="users" optionLabel="fullName" optionValue="id" placeholder="Select a Main Join" class="w-full" />
            </template>
        </Column>
        <Column field="subManagers" header="Sub Manager" style="min-width: 12rem">
                    <template #body="{data}">
                        <a-tooltip v-if="data.subManagers != null" placement="bottom">
                                            <template #title>
                                                <div class="grid grid-cols-1 gap-3">
                                                    <span v-for="item in data.subManagers.map(p=>p.fullName)" :key="item.id"> 
                                                    {{item}}
                                                    </span>
                                                </div>  
                                            </template>
                                            {{ data.subManagers.map(p=>p.fullName).join(", ") }}
                                    <!-- <AvatarGroup class="mr-4">
                                        <Avatar v-for="item in data.subManagers.map(p=>p.fullName)" :label="item.charAt(0)" shape="circle" :key="item.id"/>
                                    </AvatarGroup> -->
                        </a-tooltip>
                    </template>
                    <template #editor="{data}">
                        <MultiSelect filter="true" v-model="data.subManagers" display="chip" :options="users" optionLabel="fullName" placeholder="Select User" class="w-[20rem]" />
                    </template>
        </Column>
    <Column header="Process Percent" field="process_Percent" style="min-width: 8rem">
            <template #body="{data}">
                <a-progress :steps="5" :percent="data.process_Percent" class="pro_per"/>
            </template>
            <template #editor="{data}">
                <InputNumber v-if="data.isEditPercent" v-model="data.process_Percent" class="w-full" mode="decimal" :min="0" :max="100" />
                <a-progress v-else :steps="5" :percent="data.process_Percent" class="pro_per"/>
            </template>
    </Column>
    <Column header="Process Weight" field="process_Weight" style="min-width: 8rem">
        <template #body="{data}">
            <a-progress :steps="5" :percent="data.process_Weight"/>
        </template>
        <template #editor="{data}">
            <InputNumber v-model="data.process_Weight" class="w-full" mode="decimal" :min="0" :max="100" />
        </template>
    </Column>
    <Column header="Start Date" field="startDate" style="min-width: 8rem">
        <template #body="{data}">
            {{data.startDate !=null? format(data.startDate, 'dd/MM/yyyy') :""}}
        </template>
        <template #editor="{data}">
            <Calendar v-model="data.startDate" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="w-full" @focus="formatStartDate(data)"/>
        </template>
    </Column>
    <Column header="Estimated Date" field="estimatedDate" style="min-width: 8rem">
        <template #body="{data}">
            {{data.estimatedDate !=null? format(data.estimatedDate, 'dd/MM/yyyy') :""}}
        </template>
        <template #editor="{data}">
            <Calendar v-model="data.estimatedDate" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="w-full" @focus="formatestimatedDate(data)"/>
        </template>
    </Column>
    <Column field="endDate" header="End Date" style="min-width: 8rem">
        <template #body="{data}">
            {{data.endDate !=null? format(data.endDate, 'dd/MM/yyyy') :""}}
        </template>
    </Column>
    <Column header="Created By" field="createdByName" style="min-width: 8rem">
          <template #body="{data}">
              {{ data.createdByName }}
          </template>
    </Column>
    <Column field="remark" header="Note" style="min-width: 20rem">
        <template #editor="{data}">
            <Textarea v-model="data.remark" autoResize class="w-full"/>
        </template>
        </Column>
        <Column header="Folder" field="folderName" style="min-width: 15rem">
          <template #editor="scrop">
            <ProjectDocumentSelectFolder v-model="scrop.data"/>
          </template>
      </Column>
    <Column field="isEditPercent" header="Edit Percent" style="min-width: 6rem">
        <template #body="{data}">
            <Checkbox v-model="data.isEditPercent" :binary="true" readonly/>
        </template>
        <template #editor="{data}">
            <Checkbox v-model="data.isEditPercent" :binary="true" @change="onChangeHasTasks(data)"/>
        </template>
    </Column>
    <Column header="Documents" style="min-width: 4rem; text-align: left">
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
    <template #expansion="slotProps">
        <div>
            <ProjectTableTask v-model="slotProps.data.tasks" :project="project" :phase="slotProps.data" @updateProject="updateProject" @updatePhase="updatePhase"></ProjectTableTask>
        </div>
    </template>
    <template #footer> <div class="w-full text-end">In total there are {{ dataModel != null ? dataModel.length :0}} rows. </div></template>
</DataTable>
        <a-modal v-model:open="openModel" width="80vw" style="top: 60px" :destroyOnClose="true">
            <template #footer>
            </template>
            <ProjectEditPhase v-model="openModel" :parentID="project.id" :data="openAddModel" @update="updateModel"></ProjectEditPhase>
        </a-modal>
    <Toast />
    </div>
  </template>
  <script setup>
  import {ref,onMounted ,watch} from 'vue'
  import { format, parse,formatISO   } from 'date-fns';
  import { Task } from '~/models/task';
  import { useTask } from '~/stores/task';
  import { useToast } from "primevue/usetoast";
    import {FilterMatchMode } from 'primevue/api';
    import {useUser} from '~/stores/user';
    import { useGroup } from '~/stores/group';
    import { useAttachDocument } from '~/stores/attachDocument';
import { Phase } from '~/models/phase';
import { useRoute } from 'vue-router';
const users = ref([]);
  const emit = defineEmits(['update:modelValue','project','openTask','closePhase','selectPhase','updateProject','updatePhase']);
  const props = defineProps(['modelValue','project','selectPhase']);
  const route = useRoute();
  const selectTaskID = ref(route.params.id);
  const openModel = ref(false);
  const isTask = ref(false);
  const openAddModel = ref(new Task());
  const toast = useToast();
  const dataModel = ref(props.modelValue);
  const project = ref(props.project);
  const myDiv = ref(null);
  const myUser = useUser().getUser();
  const departments = ref([]);
  const documentsByPhase = ref([]);
  const isView = ref(false);
  const editingRows = ref([]);
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
const tablePhase = ref(null);

const expandedRows = ref([]);
onMounted(async() => {
    dataModel.value = props.modelValue;
    project.value = props.project;
    dataModel.value.forEach(p=>{
        p.startDate = p.startDate != null ? new Date(p.startDate) : null;
        p.estimatedDate = p.estimatedDate != null ? new Date(p.estimatedDate) : null;
    });
    isView.value = true;
    await getUsers();
    await getCatergories();
});
const handleScroll = (event) => {
    console.log(event);
}
watch(() => props.modelValue, (newValue) => {
    dataModel.value = newValue;
    dataModel.value.forEach(p=>{
        p.startDate = p.startDate != null ? new Date(p.startDate) : null;
        p.estimatedDate = p.estimatedDate != null ? new Date(p.estimatedDate) : null;
    });
});
watch(() => props.project, (newValue) => {
    project.value = newValue;
});
watch(() => props.sizePhase, (newValue) => {
    if(newValue >50){
        isView.value = true;
    }else{
        isView.value = false;
    }
});
const getCatergories = async () => {
    try {
      const data = await useGroup().getAll();
      departments.value = data;
    } catch (error) {
      console.log(error);
    }
}
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
            return 'info';
        case 2:
            return 'warning';
        case 3:
            return 'success';
        case 4:
            return 'danger';
        case 5:
            return 'danger';
        default:
            return null;
    }
};
const editTask =(data,itask) => {
  openAddModel.value =  JSON.parse(JSON.stringify(data));
    isTask.value = itask;
    openModel.value = true;
}
const onNewTask = (data) => {
    selectTaskID.value =data.id;
    openAddModel.value = new Task();
    openModel.value = true;
}
const updateModel = (isCreate,data) => {
    if(isCreate){
        dataModel.value.push(data);
    }
    else{
        dataModel.value = dataModel.value.map(p=>p.id == data.id? data : p);
    }
}
const onEditInit = (event) => {
}
const deleteTask = async(id) => {
    try{
       var st = confirm("Are you sure you want to delete this phase?");
         if(st == false){
              return;
         }
        var data = await usePhase().delete(id);
        if(typeof data == "string" && data != ""){
            toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
            return;
        }
    dataModel.value = dataModel.value.filter(p=>p.id != id);
    toast.add({ severity: 'success', summary: 'Success Message', detail: "Delete successfully!", life: 5000 });
    }catch(e){
        console.log(e);
        toast.add({ severity: 'error', summary: 'Error Message', detail: "Delete fail!", life: 5000 });
    }
}
const onNewPhase = () => {
    if(editingRows.value.length > 0){
        toast.add({ severity: 'error', summary: 'Error Message', detail: "Please save the current phase before creating a new one!", life: 5000 });
        return;
    }
    openAddModel.value = new Phase();
    dataModel.value.push(openAddModel.value);
    editingRows.value = [openAddModel.value];
}
const onChangeHasTasks = async(data) => {
    // if(!data.isHasTasks){
    //     if(data.tasks != null && data.tasks.length > 0){
    //         data.isHasTasks = true;
    //         toast.add({ severity: 'error', summary: 'Error Message', detail: "This phase has tasks, you can't uncheck this field!", life: 5000 });
    //         return;
    //     }
    // }
    // if(data.isHasTasks){
    //     if(data.tasks != null && data.tasks.length > 0){
    //         data.isHasTasks = false;
    //         toast.add({ severity: 'error', summary: 'Error Message', detail: "This phase has tasks, you can't check this field!", life: 5000 });
    //         return;
    //     }
    // }
    await usePhase().update(data);
}
const onCompletePhase = async(event) => {
    let { newData, index } = event;
    if(newData.estimatedDate){
    var expDate = new Date(newData.estimatedDate);
    var startDate = new Date(newData.startDate);
    var projectDate = new Date(project.value.estimatedDate);
    if(expDate < startDate){
      toast.add({ severity: 'error', summary: 'Error Message', detail: "Estimated date must be greater than start date!", life: 5000 });
      editingRows.value = [newData];
      return;
    }
    if(expDate > projectDate){
      toast.add({ severity: 'error', summary: 'Error Message', detail: "Estimated date must be less than project estimated date!", life: 5000 });
      editingRows.value = [newData];
      return;
    }
    }else{
        toast.add({ severity: 'error', summary: 'Error Message', detail: "Please select estimated date!", life: 5000 });
        editingRows.value = [newData];
        return;
    }
    if(newData.departmentID != null && newData.departmentID != 0){
        var category = departments.value.filter(p=>p.id == newData.departmentID)[0];
        newData.departmentName = category.name;
    }
    if(newData.mainManagerID != null && newData.mainManagerID != 0){
        var user = users.value.filter(p=>p.id == newData.mainManagerID)[0];
        newData.mainManagerName = user.fullName;
  }
  var uss = newData.subManagers;
  if(uss != null){
    newData.subManagerIds =  uss.map(t=>t.id).join(';'); 
    newData.subManagerNames = uss.map(t=>t.fullName).join(';');
  }
  
    if(newData.id == 0){
        try{
            newData.projectID = project.value.id;
            var data =  await usePhase().create(newData);
            if(typeof data == "string" && data != ""){
                toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
                editingRows.value = [newData];
                return;
            }
            dataModel.value[index] = data;
            toast.add({ severity: 'success', summary: 'Success Message', detail: "Create successfully!", life: 5000 });
        }catch(e){
            console.log(e);
            toast.add({ severity: 'error', summary: 'Error Message', detail: "Create fail!", life: 5000 });
            dataModel.value = dataModel.value.filter(p=>p.id != 0);
            return;
        }
    }else{
        try{
            var data =  await usePhase().update(newData);
            if(typeof data == "string" && data != ""){
                toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
                return;
            }
            emit("updateProject",data.project);
            emit("updatePhase",data.phase);
            toast.add({ severity: 'success', summary: 'Success Message', detail: "Update successfully!", life: 5000 });
        }catch(e){
            console.log(e);
            toast.add({ severity: 'error', summary: 'Error Message', detail: "Update fail!", life: 5000 });
            return;
        }
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
    dataModel.value = dataModel.value.filter(p=>p.id != 0);
  }
}
const updateProject = (data)=>{
    emit("updateProject",data)
}
const updatePhase = (data)=>{
    emit("updatePhase",data)
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
const onCancelPhase = async(phase)=>{
    try{
        var st = confirm("Are you sure you want to cancel this phase?");
        if(st == false){
            return;
        }
        var data = await usePhase().cancel(phase);
        if(typeof data == "string" && data != ""){
            toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
            return;
        }
        emit("updateProject",data.project);
        emit("updatePhase",data.phase);
        toast.add({ severity: 'success', summary: 'Success Message', detail: "Cancel successfully!", life: 5000 });
    }catch(e){
        console.log(e);
    }
}
const onRestoreProject = async(phase)=>{
    try{
        var st = confirm("Are you sure you want to restore this phase?");
        if(st == false){
            return;
        }
        var data = await usePhase().restore(phase);
        if(typeof data == "string" && data != ""){
            toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
            return;
        }
        emit("updateProject",data.project);
        emit("updatePhase",data.phase);
        toast.add({ severity: 'success', summary: 'Success Message', detail: "Restore successfully!", life: 5000 });
    }catch(e){
        console.log(e);
    }
}
const checkPermisionEdit = (data)=>{
    if((data.createdBy == myUser.id|| myUser.id == 1 || (project.value.approvalIds != null && project.value.approvalIds.includes(myUser.id))||(myUser.id == project.value.mainManagerID || project.value.subManagers && project.value.subManagers.filter(t=>t.id==myUser.id).length>0)||(myUser.id == data.mainManagerID || (data.subManagers && data.subManagers.filter(t=>t.id==myUser.id).length>0))))return true;
    else return false;
}
const checkPermissionCreate = ()=>{
    if(project.value.isApprove ==false && (project.value.createdBy == myUser.id||myUser.id == 1 || (project.value.approvalIds != null && project.value.approvalIds.includes(myUser.id)||(myUser.id == project.value.mainManagerID || (project.value.subManagers && project.value.subManagers.filter(t=>t.id==myUser.id).length>0))))) return true;
    else return false;
}
const handleUpdateShow = async(show,data)=>{
  if(show){
      documentsByPhase.value = await useAttachDocument().getDocumentAttachToPhase(data.id);
  }
}
  </script>
<style>
#tbPhase .p-progressbar-label{
  display: none;
}
#tbPhase .pro_per .ant-progress-steps-item-active{
  background-color: #1b9e3e !important;
}
#tbPhase .p-progressbar{
  height: 5px;
}
#tbPhase .p-datatable-wrapper:hover::-webkit-scrollbar{
  width: 4px;
  height: 9px;
}
#tbPhase [data-pc-section="rowexpansioncell"]{
  padding-left: 0 !important;
  padding-right: 0 !important;
}
</style>