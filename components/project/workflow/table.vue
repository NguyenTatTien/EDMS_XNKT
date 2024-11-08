<template>
    <div class="w-full h-full justify-center items-center" id="divGrid">
    <DataTable paginator :rows="50" dataKey="id" v-model:selection="selectedWorkflow" selectionMode="single" scrollable filterDisplay="row" v-model:editingRows="editingRows" @row-edit-save="onRowEditSave"
          :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" :value="workflows" stripedRows v-model:filters="filters" editMode="row" id="tbWorkflow" @row-select="onRowSelect">
        <template #empty> No found. </template>
        <template #loading> Loading data. Please wait. </template>
        <template #header>
            <div class="flex justify-end items-center">
              <div class="flex justify-end items-center">
                <Button icon="pi pi-plus" class="mr-2 h-[2rem]"  @click="onAddWorkflow()"/>
                <IconField iconPosition="left">
                    <InputIcon>
                        <i class="pi pi-search" />
                    </InputIcon>
                    <InputText placeholder="Keyword Search" class="py-[0.5rem] px-[0.75rem] pl-[2.5rem]" v-model="filters['global'].value" style="padding-left: 2rem !important"/>
                </IconField>
            </div>
          </div>
        </template>
        <Column header="" style="width: 1rem" bodyStyle="text-align:center">
            <template #body="{data}">
                <i v-if="user.roleId==1" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="deleteWorkflow(data.id)"></i>
            </template>
        </Column>
        <Column header="" style="width: 1rem" bodyStyle="text-align:center">
            <template #body="{data}">
                <i class="pi pi-sitemap cursor-pointer" style="color: #4471ef;" @click="openWorkflowDetail(data)" title="Workflow Detail"></i>
            </template>
        </Column>
        <Column :rowEditor="true" style="width: 1rem" bodyStyle="text-align:center">
          <template #roweditoriniticon>
              <i class="pi pi-file-edit cursor-pointer" style="color: #4471ef;"></i>
          </template>
        </Column>
        <Column field="name" header="Name" style="width: 20rem">
            <template #editor="{ data }">
                <InputText v-model="data.name" autofocus class="w-full"/>
            </template>
            <template #filter="{ filterModel, filterCallback }">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
            </template>
        </Column>
        <Column header="Description" field="description" style="width: 20rem">
            <template #editor="{ data }">
                <InputText v-model="data.description" autofocus class="w-full"/>
            </template>
            <template #filter="{ filterModel, filterCallback }">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
            </template>
        </Column>
        <Column header="Created By" field="createdBy" style="width: 17rem">
            <template #body="{data}">
                {{ data.createdByName }}
            </template>
            <template #filter="{ filterModel, filterCallback }">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by created by" />
            </template>
        </Column>
        <template #footer><div class="w-full text-end">In total there are {{ countRows }} rows.</div></template>
    </DataTable>
    <a-modal v-model:open="visibleDialog" width="80vw" style="top: 60px;min-height: 40rem;" :destroyOnClose="true">
        <template #footer>
        </template>
        <ProjectWorkflowDetail v-model="visibleDialog" :workflow="workflow"/>
    </a-modal>
    <n-modal v-model:show="visibleDialogAttach" preset="dialog" title="Attach Workflow" style="width: 80vw;height: 40rem;">
        <template #header>
            <div class="flex justify-end w-full gap-2">
                <!-- <Button label="Save" icon="pi pi-save" class="text-[14px] px-[14px] py-1" iconClass="text-[14px]" @click="saveCustomize"/> -->
                <Button label="Attach" severity="info" class="text-[14px] px-[14px] py-1" iconClass="text-[14px]" @click="attachWorkflow">
                    <template #icon>
                        <img src="../../../assets/images/attachwf.png" class="w-[16px] h-[16px] mr-2"/>
                    </template>
                </Button>
            </div>
        </template>
        <ProjectWorkflowCustomizeDetails v-model="visibleDialogAttach" :workflow="workflow" :projectID="project.id" @updateCustomize="updateCustomize"/>
    </n-modal>
  <Toast />
  <loading v-model:active="isLoading"
  :is-full-page="true" color="#3B82F6"/>
      </div>
  </template>
  <script setup>
  definePageMeta({
    layout: 'default'
  })
import '../../assets/CSS/styleMain.css'
import { useWorkflow } from '~/stores/workflow';
import { FilterMatchMode } from 'primevue/api';
import { ref, onMounted,watch } from 'vue';
import { useToast } from "primevue/usetoast";
import Loading from 'vue-loading-overlay';
import {useUser} from '~/stores/user';
import {Workflow} from '~/models/workflow';
import { useRoute } from 'vue-router';
const emit = defineEmits(['update:modelValue','refreshWF','updateProject']);
const props = defineProps(["modelValue"]);
const project = ref(props.modelValue);
const user = useUser().getUser();
const toast = useToast();
const visibleDialog = ref(false);
const visibleDialogAttach = ref(false);
const isAllowAttach = ref(true);
const workflows = ref([]);
const isLoading = ref(false);
const countRows = ref(0);
const editingRows = ref([]);
const selectedWorkflow = ref({});
const customizes = ref([]);
const workflow = ref(null);
const filters = ref({
          global: { value: null, matchMode: FilterMatchMode.CONTAINS },
          name: { value: null, matchMode: FilterMatchMode.CONTAINS },
          description: { value: null, matchMode: FilterMatchMode.CONTAINS },
          createdBy: { value: null, matchMode: FilterMatchMode.CONTAINS },
      });
onMounted(async()=>{
await getListWorkflow();
});
watch(visibleDialogAttach, (val) => {
    emit('updateObjectUser');
});
      const getListWorkflow = async () =>{
        isLoading.value = true;
          try{
              workflows.value = await useWorkflow().getAll();console.log(workflows.value);
          }catch(error){
              console.log("Error get list unit:"+error);
          }finally{
              isLoading.value = false;
          }
      }
const deleteWorkflow = async (id) => {
    try{
        var st = confirm("Do you want to delete this unit?");
        if (st) {
            await useWorkflow().delete(id);
            workflows.value = workflows.value.filter(item => item.id !== id);
            toast.add({ severity: 'success', detail: 'Delete successfully!', summary: 'Success', life: 5000 });
        }
    }catch(error){
        toast.add({ severity: 'error', detail: 'Delete fail!', summary: 'Error', life: 5000 });
        console.log(error);
    }
}
const onAddWorkflow = () => {
    workflows.value.push(new Workflow());
    editingRows.value = [workflows.value[workflows.value.length - 1]];
}
const onRowEditSave = async (event) => {
    if(event.newData.id == 0){
        try{
            var data = await useWorkflow().create(event.newData);
            workflows.value = workflows.value.map(item => item.id == 0 ? data : item);
            toast.add({ severity: 'success', detail: 'Create successfully!', summary: 'Success', life: 5000 });
        }
        catch(error){
            toast.add({ severity: 'error', detail: 'Create fail!', summary: 'Error', life: 5000 });
        }
    }
    else{
        try{
            var data = await useWorkflow().update(event.newData);
            workflows.value[event.index] = data;
            toast.add({ severity: 'success', detail: 'Update successfully!', summary: 'Success', life: 5000 });
        }catch(error){
            toast.add({ severity: 'error', detail: 'Update fail!', summary: 'Error', life: 5000 });
        }
    }
}
const openWorkflowDetail = (data) => {
    workflow.value = data;
    visibleDialog.value = true;
}
const openattachWorkflow = (data) => {
    workflow.value = data;
    visibleDialogAttach.value = true;
}
const onRowSelect = (event) => {
    if(isAllowAttach.value && project.value.isApprove != true){
        openattachWorkflow(event.data);
    }
}
const attachWorkflow = async() => {
    try{
        isLoading.value = true;
        await useCustomizeWorkflowDetails().updateAllByProject(customizes.value,project.value.id,workflow.value.id);
        var data =  await useCustomizeWorkflowDetails().getByWorkflowAndProject(workflow.value.id,project.value.id);
        await useWorkflow().attachWorkflow(data,project.value.id);
        project.value.workflowId = workflow.value.id;
        project.value.isHasWorkflow = true;
        emit('refreshWF');
        emit('updateModel',false,project.value);
        toast.add({ severity: 'success', summary: 'Success', detail: 'Attach workflow successfully!', life: 5000 });
        emit('update:modelValue',false);
    }catch(error){
        console.log(error);
        toast.add({ severity: 'error', summary: 'Error', detail: 'Attach workflow failed!', life: 5000 });
    }finally{
        isLoading.value = false;
    }
}
const saveCustomize = async() => {
    try {
        await useCustomizeWorkflowDetails().updateAllByProject(customizes.value,project.value.id,workflow.value.id);
        //toast.add({ severity: 'success', summary: 'Success', detail: 'Save successfully!', life: 3000 });
    } catch (error) {
        console.log(error);
        toast.add({ severity: 'error', summary: 'Error', detail: 'Save failed!', life: 3000 });
    }
}
const updateCustomize = async(data) => {
    customizes.value = data;
}
  </script>
<style>
   #importHeader{
    width: 40px !important;
    margin-right: 0.5rem;
 }
 #importHeader .p-fileupload-choose{
    width: 40px !important;
 }
 #importHeader .p-button-icon {
        margin-right: 0;
}
#importHeader .p-button-label{
    display: none;
} 
.p-row-editor-save-icon{
  color: #20b92c;
}
.p-row-editor-cancel-icon{
  color: #ff4d4f;
}
</style>