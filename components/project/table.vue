<template>
    <div class="w-full h-full flex" id="divGrid" style="padding-bottom: 0 !important">
        <DataTable v-model:selection="selectedProject" v-model:editingRows="editingRows" selectionMode="single" dataKey="id" scrollable filterDisplay="menu"  @row-edit-save="onCellEditComplete"
          :globalFilterFields="['name', 'description']" class="text-xs h-[100%] w-full tbProject" :value="dataModel" stripedRows v-model:filters="filters" editMode="row" id="tbProject" @row-edit-cancel="onRowEditCancel">
      <template #header>
          <div class="flex justify-between items-center" :class="isOpenPhase ==true? 'flex-col' : ''">
                <div class="text-[20px] font-bold" :class="isOpenPhase ==true? 'pb-5 w-full flex justify-between' : ''">
                 <span>All Projects</span>
                 <i v-if="isOpenPhase ==true" class="pi pi-angle-left cursor-pointer text-[20px]" style="color: #4471ef;" @click="()=>{emit('closePhase'); isOpenPhase = false}"></i>
                </div>
              <div class="flex items-center justify-between" :class="isOpenPhase ==true? 'w-full' : ''">
                <Button v-if="myUser.canCreateProject && isOpenPhase == false" icon="pi pi-plus" class="mr-2 h-[2rem]" @click="onNewProject()"/>
            <IconField iconPosition="left">
                <InputIcon>
                    <i class="pi pi-search" />
                </InputIcon>
                <InputText placeholder="Keyword Search" class="py-[0.5rem] px-[0.75rem] pl-[2.5rem]" v-model="filters['global'].value" style="padding-left: 2rem !important"/>
            </IconField>
            </div>
          </div>
      </template>
      <template #empty> No found. </template>
      <template #loading> Loading data. Please wait. </template>
    <Column v-if="isOpenPhase == false" header=" " style="width: 1rem;z-index: 999" alignFrozen="left" :frozen="true">
        <template #body="{data}">
          <ProjectTableFileApprove v-model="dataModel" :project="data" @selectedProject="selectProject(data)" v-if="checkPermisionEdit(data)"/>
        </template>
    </Column>
    <Column v-if="isOpenPhase == false" header=" " style="width: 1rem;z-index: 999" alignFrozen="left" :frozen="true">
      <template #body="{data}">
          <i v-if="data.isApprove == false && checkPermisionEdit(data)" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="onDeleteProject(data.id)"></i>
          <i v-else-if="data.isCancel != true && data.isApprove == true && checkPermisionEdit(data)" class="pi pi-minus-circle cursor-pointer" style="color: #EF4444;" @click="onCancelProject(data)"></i>
          <i v-else-if="data.isCancel == true && checkPermisionEdit(data)" class="pi pi-refresh cursor-pointer" style="color: #EF4444;" @click="onRestoreProject(data)"></i>
      </template>
      <template #editor="{}">
          </template>
    </Column>
    <Column v-if="isOpenPhase == false" :rowEditor="true" style="width: 1rem;z-index: 999" bodyStyle="text-align:center" alignFrozen="left" :frozen="true">
          <template #body={data,editorInitCallback}>
              <i v-if="data.createdBy == myUser.id || myUser.id == 1 || data.approvalIds.includes(myUser.id)|| (myUser.id == data.mainManagerID || data.subManagers.filter(t=>t.id==myUser.id).length>0)" class="pi pi-file-edit cursor-pointer" style="color: #4471ef;" @click="editorInitCallback"></i>
          </template>
          <template #editor={editorSaveCallback,editorCancelCallback}>
              <i class="pi pi-check cursor-pointer" style="color: #20b92c;" @click="editorSaveCallback"></i>
              <i class="pi pi-times cursor-pointer" style="color: #ff4d4f;" @click="editorCancelCallback"></i>
          </template>
    </Column>
      <Column v-if="isOpenPhase == false" field="name" header="Name" style="min-width: 25rem;z-index: 999" alignFrozen="left" :frozen="true">
          <template #body="{data}">
            <NuxtLink style="text-decoration: none !important;">
                <div class="cursor-pointer" @click="selectProject(data)">
                    <span class="pr-1">{{data.name}}</span>
                    <Tag v-if = "data.isCancel" value="Cancel" :severity="getSeverity(4)" />
                    <Tag v-else-if = "data.isProcess == true && !isLate(data.estimatedDate)" value="In Process" :severity="getSeverity(1)" />
                  <Tag v-else-if = "data.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                  <Tag v-else-if = "data.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                  <Tag v-else-if = "data.isProcess == true && isLate(data.estimatedDate)" value="Late" :severity="getSeverity(3)" />
                </div>
            </NuxtLink>
          </template>
          <template #editor="{ data }">
              <Textarea autoResize v-model="data.name" class="p-column-filter py-[0.5rem] px-[0.75rem] w-full" placeholder="Search by name" rows="1"/>
          </template>
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
          </template>
      </Column>
      <Column v-if="isOpenPhase == true" field="name" header="Name">
        <template #body="{data}">
          <NuxtLink style="text-decoration: none !important;">
              <div class="cursor-pointer" @click="selectProject(data)">
                 <div class="flex justify-between">
                  <span class="text-gray-700 font-semibold font-sans tracking-wide text-sm">{{data.name}}
                    <Tag v-if = "data.isCancel" value="Cancel" :severity="getSeverity(4)" />
                  <Tag v-else-if = "data.isProcess == true && !isLate(data.estimatedDate)" value="In Process" :severity="getSeverity(1)" />
                  <Tag v-else-if = "data.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                  <Tag v-else-if = "data.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                  <Tag v-else-if = "data.isProcess == true && isLate(data.estimatedDate)" value="Late" :severity="getSeverity(3)" />
                  </span>
                  <div class="flex gap-2 ml-2">
                    <ProjectTableFileApprove v-model="dataModel" :project="data"/>
                    <i v-if="data.isApprove == false && (myUser.id==1 || data.createdBy == myUser.id || data.approvalIds.includes(myUser.id)||(myUser.id == data.mainManagerID || data.subManagers.filter(t=>t.id==myUser.id).length>0))" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="onDeleteProject(data.id)" title="delete"></i>
                    <i v-else-if="data.isCancel != true && data.isApprove == true && (myUser.id==1 || data.createdBy == myUser.id || data.approvalIds.includes(myUser.id)||(myUser.id == data.mainManagerID || data.subManagers.filter(t=>t.id==myUser.id).length>0))" class="pi pi-minus-circle cursor-pointer" style="color: #EF4444;" @click="onCancelProject(data)" title="cancel"></i>
                    <i v-else-if="data.isCancel == true && (myUser.id==1 || data.createdBy == myUser.id || data.approvalIds.includes(myUser.id)||(myUser.id == data.mainManagerID || data.subManagers.filter(t=>t.id==myUser.id).length>0))" class="pi pi-refresh cursor-pointer" style="color: #EF4444;" @click="onRestoreProject(data)"></i>
                  </div>
                  </div>
                    <span class="text-gray-700">{{data.description}}</span><br/>
                    <span class="text-gray-700 font-sans tracking-wide text-xs">{{ data.createdByName }}</span>
                    <span class="text-xs text-gray-600"> - {{data.startDate !=null? format(data.startDate, 'dd/MM/yyyy') :""}}</span>
                    <span class="text-xs text-gray-600"> -{{data.endDate !=null? format(data.endDate, 'dd/MM/yyyy') :""}}</span>
                  </div>
          </NuxtLink>
        </template>
      </Column>
      <Column v-if="isOpenPhase == false" field="description" header="Description" style="min-width: 22rem">
          <template #editor="{ data }">
              <Textarea autoResize v-model="data.description" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" rows="1"/>
          </template>
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem] w-full" placeholder="Search by name" />
          </template>
      </Column>
      <Column v-if="isOpenPhase == false" field="departmentID" header="Department" style="min-width: 15rem">
        <template #body="{data}">
            {{data.departmentName}}
        </template>
        <template #editor="{data}">
           <Dropdown showClear v-model="data.departmentID" :options="departments" optionLabel="name" optionValue="id" placeholder="Select a department" class="w-full"/>
        </template>
    </Column>
        <Column v-if="isOpenPhase == false" header="Process Percent" field="process_Percent" style="min-width: 10rem">
          <template #body="{data}">
            <a-progress :steps="5" :percent="data.process_Percent" class="pro_per"/>
          </template>
      </Column>
      <Column v-if="isOpenPhase == false" header="Unit" field="unitName" style="min-width: 12rem">
            <template #body="{data}">
                {{data.unitName }}
            </template>
            <template #editor="{data}">
                <Dropdown v-model="data.unitID" :options="units" optionLabel="name" optionValue="id" placeholder="Select a Unit" class="w-full" />
            </template>
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template>
      </Column>
      <Column v-if="isOpenPhase == false" field="mainManagerID" header="Manager" style="min-width: 8rem">
            <template #body="{data}">
                {{data.mainManagerName }}
            </template>
            <template #editor="{data}">
                <Dropdown v-model="data.mainManagerID" filter="true" :options="users" optionLabel="fullName" optionValue="id" placeholder="Select a Main Join" class="w-full" />
            </template>
        </Column>
        <Column v-if="isOpenPhase == false" field="subManagers" header="Sub Manager" style="min-width: 12rem">
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
      <Column v-if="isOpenPhase == false" header="Type" field="typeName" style="min-width: 9rem">
          <template #body="{data}">
            <span>{{data.typeName}}</span>
          </template>
          <template #editor="{data}">
              <Dropdown v-model="data.typeID" :options="types" optionLabel="name" optionValue="id" placeholder="Select a Type" @change="(e)=>onChangeType(data,e)" class="p-column-filter"/>
          </template>
      </Column>
        <Column v-if="isOpenPhase == false" header="Start Date" field="startDate" style="min-width: 8rem">
          <template #body="{ data }">
            <div>{{data.startDate !=null? format(data.startDate, 'dd/MM/yyyy') :""}}</div>
          </template>
          <template #editor="{ data }">
              <Calendar v-model="data.startDate" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="p-column-filter" @focus="formatStartDate(data)"/>
          </template>
            <template #filter="{ filterModel, filterCallback }">
              <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
            </template>
      </Column>
      <Column v-if="isOpenPhase == false" header="Expected Date" field="estimatedDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.estimatedDate !=null? format(data.estimatedDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          <template #editor="{ data }">
            <Calendar v-model="data.estimatedDate" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="p-column-filter" @focus="formatestimatedDate(data)"/>
          </template>
          <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template>
      </Column>
      <Column v-if="isOpenPhase == false" header="End Date" field="endDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.endDate !=null? format(data.endDate, 'dd/MM/yyyy') :""}}</div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
          <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
        </template>
      </Column>
      <Column v-if="isOpenPhase == false" header="Created By" field="createdByName" style="min-width: 8rem">
          <template #body="{data}">
              {{ data.createdByName }}
          </template>
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template>
      </Column>
      <Column v-if="isOpenPhase == false" header="Note" field="remark" style="min-width: 20rem">
          <template #editor="{ data }">
            <Textarea v-model="data.remark" autoResize  class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by remark"/> 
          </template>
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template>
      </Column>
      <Column v-if="isOpenPhase == false" header="Folder" field="folderName" style="min-width: 15rem">
          <template #editor="scrop">
            <ProjectDocumentSelectFolder v-model="scrop.data"/>
          </template>
      </Column>
      <Column v-if="isOpenPhase == false" header="Documents" style="min-width: 4rem; text-align: left">
          <template #body="scrop">
            <n-popover
              placement="bottom"
              trigger="click">
              <template #trigger>
                <i class="pi pi-book" />
              </template>
              <ProjectDocumentList v-model="scrop.data"/>
            </n-popover>
          </template><template #editor></template>
      </Column>
      <Column v-if="isOpenPhase == false" header="Chat" style="min-width: 4rem; text-align: center" alignFrozen="right" :frozen="true">
          <template #body="{ data }">
              <n-badge :value="statusChats.find(p=>p.objectID == data.id) ? statusChats.find(p=>p.objectID == data.id).totalUnRead:0" :max="15" @click="openChat(data)">
                <i class="pi pi-comment" />
    </n-badge>
          </template><template #editor></template>
      </Column>
      <template #footer> <div class="w-full text-end">In total there are {{ dataModel.length }} rows. </div></template>
      </DataTable>
      <n-modal v-model:show="showAttachWF" preset="dialog" title="Attach Workflow" style="width: 500px;">
            <ProjectWorkflowAttach v-model="showAttachWF" :project="projectSelect" @updateModel="updateModel"/>
      </n-modal>
      <n-modal v-model:show="showChat" preset="dialog" :title="projectSelect.name" style="width: 1300px;height: 100%;position: absolute;top: 0;left: 0;bottom: 0;right: 0;padding: 1rem;" content-style="height: 95%;" id="chat-modal">
          <ProjectChat v-model="projectSelect" @updateReadByProject="updateReadByProject"/>
      </n-modal>
      <Toast />
    </div>
  </template>
  <script setup>
import { ref,toRaw,onMounted,watch } from 'vue';
import { storeToRefs } from 'pinia';
import '../../assets/css/styleMain.css';
import {FilterMatchMode } from 'primevue/api';
import { format, parse,formatISO   } from 'date-fns';
import {Project} from '~/models/project';
import { useToast } from "primevue/usetoast";
import {useUser} from '~/stores/user';
import { useGroup } from '~/stores/group';
import {useProject} from '~/stores/project';
import { useDomain } from '~/stores/domain';
import { useAttachDocument } from '~/stores/attachDocument';
import {useType} from '~/stores/type';
import { useChatStatus } from '~/stores/chatStatus';
import { useUnit } from '~/stores/unit';
const { listenToMessages, sendMessage } = useSignalR();
  //props from parent
  const emit = defineEmits(['update:modelValue','openPhase','closePhase']);
  const props = defineProps(['modelValue','closePhase']);
  //emit to parent
  const dataModel = ref(props.modelValue);
  const showChat = ref(false);
  const page = ref(1);
  const openAddModel = ref(new Project());
  const toast = useToast();
  const openModel = ref(false);
  const pageSize = ref(10)
  const total = ref(100)
  const users = ref([]);
  const units = ref([]);
  const myUser = useUser().getUser();
  const selectedProject = ref({});
  const projectSelect = ref({});
  const isOpenPhase = ref(false);
  const showAttachWF = ref(false);
  const departments = ref([]);
  const types = ref([]);
  const editingRows = ref([]);
  const statusChats  = ref([]);
  const documentsByProject = ref([]);
  const filters = ref({
          global: { value: null, matchMode: FilterMatchMode.CONTAINS },
          name: { value: null, matchMode: FilterMatchMode.CONTAINS },
          description: { value: null, matchMode: FilterMatchMode.CONTAINS },
          unitName: { value: null, matchMode: FilterMatchMode.CONTAINS },
          startDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
          estimatedDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
          endDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
          approvedBy: { value: null, matchMode: FilterMatchMode.CONTAINS },
          assistedBy: { value: null, matchMode: FilterMatchMode.CONTAINS },
          status: { value: null, matchMode: FilterMatchMode.CONTAINS },
          createdByName: { value: null, matchMode: FilterMatchMode.CONTAINS },
      });
onMounted(async() => {
    dataModel.value = props.modelValue;
    dataModel.value.forEach(p=>{
      p.startDate = p.startDate? new Date(p.startDate):null;
      p.estimatedDate = p.estimatedDate? new Date(p.estimatedDate):null;
    });
    await getUsers();
    await getUnits();
    await getCatergories();
    await getType();
    await getChatStatus();
    listenToMessages((data) => {
      if(data.userID != myUser.id){
        if(statusChats.value.filter(p=>p.objectID == data.objectID).length > 0){
          statusChats.value = statusChats.value.map(p=>p.objectID == data.objectID? {...p,totalUnRead:p.totalUnRead+1} : p);
        }
        else{
          statusChats.value.push({objectID:data.objectID,userID:myUser.id,totalUnRead:1});
        }
      }
    });
});
watch(() => props.modelValue, (newValue) => {
    dataModel.value = newValue;
});
const getType = async() =>{
    try{
      types.value = await useType().getAll();
    }catch(ex){
      console.log(error);
    }
}
const getChatStatus = async() =>{
  try{
    statusChats.value = await useChatStatus().getUnRead();
  }catch(ex){
    console.log(ex);
  }
}
const getCatergories = async () => {
    try {
      const data = await useGroup().getAll();
      departments.value = data;
    } catch (error) {
      console.log(error);
    }
}
const getUnits = async() => {
  try {
    units.value = await useUnit().getAll();
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
const editProject =(data) => {
  openAddModel.value =  JSON.parse(JSON.stringify(data));
  openModel.value = true;
}
const onNewProject = () => {
  if(editingRows.value.length > 0){
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Please save the current project before creating a new one!", life: 5000 });
    return;
  }
    openAddModel.value = new Project();
    dataModel.value.push(openAddModel.value);
    editingRows.value =  [dataModel.value[dataModel.value.length - 1]];
}
const onDeleteProject = async(id) => {
  try{
      var st = confirm("Are you sure you want to delete?");
      if(st == false) return;
      var data = await useProject().delete(id);
      if(typeof data == "string" && data != ""){
          toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
          return;
      }
      dataModel.value = dataModel.value.filter(p=>p.id != id);
      toast.add({ severity: 'success', summary: 'Success Message', detail: "Delete Successfully", life: 5000 });
  }
  catch(e){
      toast.add({ severity: 'error', summary: 'Error Message', detail: "Delete Failed", life: 5000 });
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
const updateModel = (isCreate,data) => {
    if(isCreate){
        dataModel.value.push(data);
    }
    else{
        dataModel.value = dataModel.value.map(p=>p.id == data.id? data : p);
    }
}
const report = async(data) => {
  try{
    var response = await useProject().report(data);
    const link = document.createElement('a');
    let encodedURL = encodeURI(response);
    link.href = encodedURL;
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
  }
  catch(e){
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Report Failed!", life: 5000 });
  }
}
const onDownloadFileApprove = (data)=>{
    var urldownload = useDomain().url.server + data.fileApprove;
    const link = document.createElement('a');
    link.href = urldownload;
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
}
const onpenPhase = (id) => {
}
const deleteWorkflow = async(id) => {
  try{
    var st = confirm("Are you sure to delete this workflow?");
    if(!st){
      return;
    }
    await useWorkflow().deleteWorkflow(id);
    var project = dataModel.value.find(p=>p.id == id);
    project.workflowId = null;
    project.isHasWorkflow = false;
    dataModel.value = dataModel.value.map(p=>p.id == id? project : p);
    toast.add({severity: 'success', summary: 'Success', detail: 'Delete successfully!', life: 5000});
  }catch(error){
    toast.add({severity: 'error', summary: 'Error', detail: 'Delete failed!', life: 5000});
  }
}
const onCellEditComplete = async(event) => {
  let { newData, index } = event;
  console.log(newData);
  if(newData.estimatedDate){
    var expDate = new Date(newData.estimatedDate);
    var startDate = new Date(newData.startDate);
    if(expDate < startDate){
      toast.add({ severity: 'error', summary: 'Error Message', detail: "Estimated date must be greater than start date!", life: 5000 });
      editingRows.value =  [newData];
      return;
    }
  }else{
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Please select estimated date!", life: 5000 });
    editingRows.value =  [newData];
    return;
  }
  if(newData.departmentID != null && newData.departmentID != 0){
        var category = departments.value.filter(p=>p.id == newData.departmentID)[0];
        newData.departmentName = category.name;
  }else{
    newData.departmentName = null;
    newData.departmentID = null;
  }
  if(newData.unitID != null && newData.unitID != 0){
        var unit = units.value.filter(p=>p.id == newData.unitID)[0];
        newData.unitName = unit.name;
  }else{
    newData.unitName = null;
    newData.unitID = null;
  }
  if(newData.mainManagerID != null && newData.mainManagerID != 0){
        var user = users.value.filter(p=>p.id == newData.mainManagerID)[0];
        newData.mainManagerName = user.fullName;
  }else{
    newData.mainManagerName = null;
    newData.mainManagerID = null;
  }
  if(newData.typeID != null && newData.typeID != 0){
        var type = types.value.filter(p=>p.id == newData.typeID)[0];
        newData.typeName = type.name;
  }else{
    newData.typeName = null
    newData.typeID = null;
  }

  var uss = newData.subManagers;
  newData.subManagerIds =  uss.map(t=>t.id).join(';'); 
  newData.subManagerNames = uss.map(t=>t.fullName).join(';');
  
  if(newData.id == 0){
    try{
      
      var data = await useProject().create(newData);
      dataModel.value[index] = data;
      toast.add({ severity: 'success', summary: 'Success Message', detail: "Create Successfully!", life: 5000 });
    }
    catch(e){
      dataModel.value.splice(index,1);
      toast.add({ severity: 'error', summary: 'Error Message', detail: "Create Failed!", life: 5000 });
    }
  }else{
    try{
      var data = await useProject().update(newData);
      dataModel.value[index] = data;
      toast.add({ severity: 'success', summary: 'Success Message', detail: "Update Successfully!", life: 5000 });
    }
    catch(e){
      toast.add({ severity: 'error', summary: 'Error Message', detail: "Update Failed!", life: 5000 });
    }
  }
}
const onChangeType = (data,e) => {
    data.typeName = types.value.filter(p=>p.id == e.value)[0].name;
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
const attachWorkflow = (data) => {
  projectSelect.value = data;
  showAttachWF.value = true;
}
const selectProject = (data) => {
  selectedProject.value = data;
  emit('openPhase',data.id);
  isOpenPhase.value = true;
}
const onSelectedFiles = async(e,data)=>{
  try{
    var form = new FormData();
  form.append("file",e.files[0]);
  form.append("jsonProject",JSON.stringify(data));
  var reponse = await useProject().upFileApprove(form);
  dataModel.value = dataModel.value.map(p=>p.id == reponse.id? reponse : p);
  emit("update:modelValue",dataModel.value);
  console.log(dataModel.value);
  toast.add({ severity: 'success', summary: 'Success Message', detail: "Upload Successfully!", life: 5000 });
  }catch(e){
    console.log(e);
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Upload fail!", life: 5000 });
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
const onCancelProject = async(data) => {
  try{
    var st = confirm("Are you sure you want to cancel?");
    if(st == false) return;
    var data = await useProject().cancel(data);
    dataModel.value = dataModel.value.map(p=>p.id == data.id? data : p);
    emit("update:modelValue",dataModel.value);
    toast.add({ severity: 'success', summary: 'Success Message', detail: "Cancel Successfully", life: 5000 });
  }
  catch(e){
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Cancel Failed", life: 5000 });
  }
}
const onRestoreProject = async(data) => {
  try{
    var st = confirm("Are you sure you want to restore?");
    if(st == false) return;
    var data = await useProject().restore(data);
    dataModel.value = dataModel.value.map(p=>p.id == data.id? data : p);
    emit("update:modelValue",dataModel.value);
    toast.add({ severity: 'success', summary: 'Success Message', detail: "Restore Successfully", life: 5000 });
  }
  catch(e){
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Restore Failed", life: 5000 });
    console.log(e);
  }
}
const checkPermissionCreate= ()=>{
  
}
const checkPermisionEdit = (data)=>{
    if((myUser.id==1 || data.createdBy == myUser.id || data.approvalIds.includes(myUser.id)||(myUser.id == data.mainManagerID || data.subManagers.filter(t=>t.id==myUser.id).length>0)))return true;
    else return false;
}
// const handleUpdateShow = async(show,data)=>{
//   if(show){
//       documentsByProject.value = await useAttachDocument().getDocumentAttachToProject(data.id);
//   }
// }
const updateReadByProject = async(projectID)=>{
  if(statusChats.value.filter(p=>p.objectID == projectID).length > 0){
  await useChatStatus().updateReadByProject(projectID);
  statusChats.value = statusChats.value.filter(p=>p.objectID != projectID);
  }
}
const openChat = async(data)=>{
  projectSelect.value = data;
  showChat.value = true;
}
  </script>
  <style>
.ant-btn {
  @apply flex items-center
}
#tbProject .p-progressbar-label{
  display: none;
}
#tbProject .pro_per .ant-progress-steps-item-active{
  background-color: #1b9e3e !important;
}
#tbProject .p-progressbar{
  height: 5px;
}
.p-row-editor-save-icon{
  color: #20b92c;
}
.p-row-editor-cancel-icon{
  color: #ff4d4f;
}
.upFileApprove{
  width: max-content !important;
}
.upFileApprove .p-fileupload-content{
  display: none !important;
}
.upFileApprove .p-fileupload-buttonbar{
  padding: 0 !important;
  border: none !important;
  background: transparent;
}
#tbProject .p-datatable-wrapper:hover::-webkit-scrollbar{
  width: 4px;
  height: 9px;
}
#chat-modal .n-dialog__content{
  border-top: 1px solid #e0e0e0;
}
  </style>