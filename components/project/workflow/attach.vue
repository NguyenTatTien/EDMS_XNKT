<template>
    <div>
        <div class="flex justify-between flex-col">
            <n-select v-model:value="value" :options="options" class="pb-5" label-field="name" value-field="id"/>
            <div class="flex gap-2 justify-center">
                <n-button strong secondary @click="editWorkflow">
                    <template #icon>
                        <i class="pi pi-cog"></i>
                    </template>
                    Edit Step Workflow
                </n-button>
                <n-button strong secondary type="info" @click="attachWorkflow">
                    <template #icon>
                        <img src="../../../assets/images/attachwf.png" class="w-[16px] h-[16px]"/>
                    </template>
                    Attach Workflow
                </n-button>
            </div>
        </div>
        <n-modal v-model:show="showAttachWF" preset="dialog" title="Attach Workflow" style="width: 80vw;height: 40rem;">
            <template #header>
                <div class="flex justify-end w-full">
                    <Button label="Save" severity="info" icon="pi pi-save" class="text-[14px] px-[14px] py-1" iconClass="text-[14px]" @click="saveCustomize"/>
                </div>
            </template>
            <ProjectWorkflowCustomizeDetails v-model="showAttachWF" :workflow="workflow" :projectID="project.id" @updateCustomize="updateCustomize"/>
        </n-modal>
        <Toast />
        <loading v-model:active="isLoading"
      :is-full-page="true" color="#3B82F6"/>
    </div>
</template>
<script setup>
import { ref,onMounted,watch} from 'vue';
import { useWorkflow } from '~/stores/workflow';
import { useCustomizeWorkflowDetails } from '~/stores/customizeWorkflowDetails';
import { useToast } from "primevue/usetoast";
import Loading from 'vue-loading-overlay';
const isLoading = ref(false);
const value = ref(0);
const options = ref([]);
const emit = defineEmits(['update:modelValue','project','updateModel']);
const props = defineProps(['project']);
const project = ref({});
const showAttachWF = ref(false);
const toast = useToast();
const customizes = ref([]);
const workflow = ref(null);
watch(() => props.project, (newVal) => {
    project.value = newVal;
});
onMounted(async()=>{
    project.value = props.project;
    options.value = await useWorkflow().getAll();
    if(options.value.length > 0){
        value.value = options.value[0].id;
    }
});
const editWorkflow = () => {
    if(value.value > 0){
       workflow.value = options.value.find(item => item.id === value.value);
       showAttachWF.value = true;
    }
};
const attachWorkflow = async() => {
    try{
        isLoading.value = true;
        workflow.value = options.value.find(item => item.id === value.value);
        await saveCustomize();
        var data =  await useCustomizeWorkflowDetails().getByWorkflowAndProject(workflow.value.id,project.value.id);
        await useWorkflow().attachWorkflow(data,project.value.id);
        project.value.workflowId = workflow.value.id;
        project.value.isHasWorkflow = true;
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
const updateCustomize = async(data) => {
    customizes.value = data;
}
const saveCustomize = async() => {
    try {
        await useCustomizeWorkflowDetails().updateAllByProject(customizes.value,project.value.id,workflow.value.id);
        toast.add({ severity: 'success', summary: 'Success', detail: 'Save successfully!', life: 3000 });
    } catch (error) {
        console.log(error);
        toast.add({ severity: 'error', summary: 'Error', detail: 'Save failed!', life: 3000 });
    }
}

</script>
