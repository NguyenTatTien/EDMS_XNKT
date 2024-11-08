<template>
    <div class="flex">
        <DataTable dataKey="id" scrollable filterDisplay="row" v-model:editingRows="editingRows"
          :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" :value="wfSteps" stripedRows editMode="row" id="tbWorkflow" @row-edit-save="onRowEditSave" @row-edit-cancel="onRowEditCancel">
            <template #header>
                <div class="flex justify-end">
                    <div class="flex justify-between items-center">
                        <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="onNewStep()"/>
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
        <Column :rowEditor="true" style="width: 1rem" bodyStyle="text-align:center">
            <template #roweditoriniticon>
              <i class="pi pi-file-edit cursor-pointer" style="color: #4471ef;"></i>
            </template>
        </Column>
        <Column field="name" header="Name" style="width: 20rem">
            <template #editor="{ data }">
                <InputText v-model="data.name" autofocus class="w-full"/>
            </template>
        </Column>
        <Column header="Description" field="description" style="width: 20rem">
            <template #editor="{ data }">
                <InputText v-model="data.description" autofocus class="w-full"/>
            </template>
        </Column>
        <Column header="Is First" field="isFirst" style="width: 17rem">
            <template #body="{data}">
                <Checkbox v-model="data.isFirst" :binary="true" readonly/>
            </template>
            <template #editor="{data}">
                <Checkbox v-model="data.isFirst" :binary="true"/>
            </template>
        </Column>
        <Column header="Can Reject" field="canReject" style="width: 17rem">
            <template #body="{data}">
                <Checkbox v-model="data.canReject" :binary="true" readonly/>
            </template>
            <template #editor="{data}">
                <Checkbox v-model="data.canReject" :binary="true"/>
            </template>
        </Column>
        <Column header="Not Change User" field="notChangeUser" style="width: 17rem">
            <template #body="{data}">
                <Checkbox v-model="data.notChangeUser" :binary="true" readonly/>
            </template>
            <template #editor="{data}">
                <Checkbox v-model="data.notChangeUser" :binary="true"/>
            </template>
        </Column>
        <template #footer><div class="w-full text-end">In total there are rows.</div></template>
  </DataTable>
  <Toast />
    </div>
</template>
<script setup>
    import { ref, onMounted } from 'vue';
    import { useWorkflowStep } from '~/stores/workflowStep';
    import { FilterMatchMode } from 'primevue/api';
    import { WorkflowStep } from '~/models/workflowStep';
    import { useToast } from "primevue/usetoast";
    const emit = defineEmits(['update:modelValue']);
    const props = defineProps(['modelValue']);
    const editingRows = ref([]);
    const wfSteps = ref([]);
    const toast = useToast();
    const filters = ref({
          global: { value: null, matchMode: FilterMatchMode.CONTAINS },
          name: { value: null, matchMode: FilterMatchMode.CONTAINS },
          description: { value: null, matchMode: FilterMatchMode.CONTAINS },
          createdBy: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });
    onMounted(async() => {
            wfSteps.value = await useWorkflowStep().getByWorkflow(props.modelValue.id);
        }
    );
    const onDelete = async (id) => {
        try{
            await useWorkflowStep().delete(id);
        wfSteps.value = wfSteps.value.filter(x => x.id != id);
        toast.add({ severity: 'success', detail: 'Delete successfully!', summary: 'Success', life: 5000 });
        }
        catch(e){
            toast.add({ severity: 'error', detail: 'Delete fail!', summary: 'Error', life: 5000 });
        }
    }
    const onNewStep = () => {
       var newStep = new WorkflowStep();
       wfSteps.value.push(newStep);
       editingRows.value = [newStep];
       //wfSteps.value = await useWorkflowStep().getByWorkflow(props.workflowID);
    }
    const onRowEditSave = async (e) => {
        const {newData, index} = e;
        if(e.data.id == 0){
            try{
                e.data.workflowID = props.modelValue.id;
                e.data.workflowName = props.modelValue.name;
                var data =await useWorkflowStep().create(newData);
                wfSteps.value = wfSteps.value.map(x => x.id == 0 ? data : x);
                toast.add({ severity: 'success', detail: 'Create successfully!', summary: 'Success', life: 5000 });
            }
            catch(e){
                toast.add({ severity: 'error', detail: 'Create fail!', summary: 'Error', life: 5000 });
            }
        }
        else{
            try{
                var data = await useWorkflowStep().update(newData);
                wfSteps.value = wfSteps.value.map(x => x.id == data.id ? data : x);
                toast.add({ severity: 'success', detail: 'Update successfully!', summary: 'Success', life: 5000 });
            }
            catch(e){
                toast.add({ severity: 'error', detail: 'Update fail!', summary: 'Error', life: 5000 });
            }
        }
    }
    const onRowEditCancel = (e) => {
        if(e.data.id == 0){
            wfSteps.value = wfSteps.value.filter(x => x.id != 0);
        }
    }
</script>
<style>

</style>
