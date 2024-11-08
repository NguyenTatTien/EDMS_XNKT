<template>
    <div class="h-full flex flex-col">
        <div class="flex gap-3 p-2">
            <n-select
                v-model:value="selectedWorkflow"
                filterable
                placeholder="Please select a song"
                :options="workflows"
                value-field="id"
                label-field="name"
                class="w-[250px]"/>
                <n-button type="success" @click="showCreateWF = true">
                    Add
                </n-button>
                <n-button type="error" @click="onDeleteWF">
                    Delete
                </n-button>
                <n-button type="info" @click="onAttachWF" :disabled="(project.isApprove || workflowSelected == null)">
                    Attached
                </n-button>
        </div>
        <hr class="m-0" style="line-height: 0; border-color: #f8fafc !important; border-style: solid; "/>
        <div class="h-full bg-[#f8fafc] overflow-auto" id="customizeWF">
            <ProjectWorkflowCustomize v-model="workflowDetails" :workflow="workflowSelected"/>
        </div>
        <n-modal v-model:show="showCreateWF" preset="dialog" title="Create workflow">
            <ProjectWorkflowCreate v-model="workflows" @updateStatus ="(value)=>{showCreateWF = value}" @selectNewWorfklow="selectNewWorfklow"/>
        </n-modal>
        <Toast />
        <loading v-model:active="isLoading"
        :is-full-page="true" color="#3B82F6" class="left-[50%] top-[50%]"/>
    </div>
</template>
<script setup>
import { ref,onMounted,watch } from 'vue'
import { useWorkflow } from '~/stores/workflow';
import {Workflow} from '~/models/workflow';
import { useWorkflowDetail } from '~/stores/workflowDetail';
import { useToast } from "primevue/usetoast";
import {useUser} from '~/stores/user';
import Loading from 'vue-loading-overlay';

const emit = defineEmits(['update:modelValue','refreshWF','updateProject']);
const props = defineProps(["modelValue"]);
const project = ref(props.modelValue);
const selectedWorkflow = ref(null);
const toast = useToast();
const myUser = useUser().getUser();
const workflows = ref([]);
const isLoading = ref(false);
const workflowSelected = ref(null);
const workflowDetails = ref([]);
const showCreateWF = ref(false);
watch(() => selectedWorkflow.value, async(newValue) => {
    workflowDetails.value = await useWorkflowDetail().getByWorkflow(newValue);
    workflowSelected.value = workflows.value.find(t=>t.id == newValue);
});
onMounted(async()=>{
    workflows.value = await useWorkflow().getAll();
    if(workflows.value.length > 0){
        selectedWorkflow.value = workflows.value[0].id;
        workflowDetails.value = await useWorkflowDetail().getByWorkflow(workflows.value[0].id);
        workflowSelected.value = workflows.value[0];
    }
});
const onDeleteWF = async() => {
    try{
        var st = confirm("Are you sure to delete this workflow?");
        if(!st) return;
        await useWorkflow().delete(selectedWorkflow.value);
        workflows.value = workflows.value.filter(t=>t.id != selectedWorkflow.value);
        selectedWorkflow.value = workflows.value.length > 0 ? workflows.value[0].id : null;
        workflowSelected.value = workflows.value.length > 0 ? workflows.value[0] : null;
        toast.add({severity:'success',summary:'Success',detail:'Delete successfully!',life:5000});
    }catch(e){
        console.log(e);
        toast.add({severity:'error',summary:'Error',detail:'Delete failed!',life:5000});
    }
}
const onAttachWF = async() => {
    try{
        var st  = confirm("Are you sure to attach this workflow?");
        if(!st) return;
        isLoading.value = true;
        var data = await useWorkflow().attachWorkflow(selectedWorkflow.value,project.value.id);
        if(typeof data == 'string' && data != ''){
            toast.add({ severity: 'error', summary: 'Error', detail: data, life: 5000 });
        }
        project.value.workflowId = selectedWorkflow.value;
        project.value.isHasWorkflow = true;
        console.log(project.value);
        emit('refreshWF');
        toast.add({ severity: 'success', summary: 'Success', detail: 'Attach workflow successfully!', life: 5000 });
    }catch(error){
        console.log(error);
        toast.add({ severity: 'error', summary: 'Error', detail: 'Attach workflow failed!', life: 5000 });
    }finally{
        isLoading.value = false;
    }
}
const checkPermisionEdit = (data)=>{
    if((myUser.id==1 || data.createdBy == myUser.id || data.approvalIds.includes(myUser.id)||(myUser.id == data.mainManagerID || data.subManagers.filter(t=>t.id==myUser.id).length>0)))return true;
    else return false;
}
const selectNewWorfklow=(data)=>{
    workflows.value.push(data);
    workflowSelected.value = data;
    selectedWorkflow.value = data.id;
}
</script>
<style>
#customizeWF:hover::-webkit-scrollbar{
  width: 4px;
  height: 9px;
}
#customizeWF{   
    margin-bottom: 2px;
}
</style>