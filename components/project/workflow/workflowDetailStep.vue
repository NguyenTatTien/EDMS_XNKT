<template>
    <div>
        <DataTable dataKey="id" scrollable filterDisplay="row"
          :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" :value="wfDetails" stripedRows editMode="cell" id="tbWorkflow" @cell-edit-complete="onCellEditComplete">
            <template #header>
                <div class="flex justify-end">
                   
                </div>
            </template>
        <template #empty> No found. </template>
        <template #loading> Loading data. Please wait. </template>
        <Column field="currentWorkflowStepName" header="Current Step Name" style="width: 20rem">
        </Column>
        <Column header="Duration" field="duration" style="width: 17rem">
            <template #editor="{data}">
                <InputNumber v-model="data.duration" />
            </template>
        </Column>
        <Column header="Next Step Name" field="nextWorkflowStepID" style="width: 17rem">
            <template #body="{data}">
                {{ data.nextWorkflowStepName }}
            </template>
            <template #editor="{data}">
                <Dropdown showClear v-model="data.nextWorkflowStepID" :options="wfSteps.filter(t=>t.id != data.currentWorkflowStepID)" optionLabel="name" optionValue="id" placeholder="Select" class="w-full"/>
            </template>
        </Column>
        <Column header="Reject Step Name" field="rejectWorkflowStepID" style="width: 17rem">
            <template #body="{data}">
                {{ data.rejectWorkflowStepName }}
            </template>
            <template #editor="{data}">
                <Dropdown showClear v-model="data.rejectWorkflowStepID" :options="wfSteps.filter(t=>t.id != data.currentWorkflowStepID)" optionLabel="name" optionValue="id" placeholder="Select" class="w-full"/>
            </template>
        </Column>
        <Column header="Approve User" field="approveUserIdsCV" style="width: 17rem">
            <template #body="{data}">
                {{ data.approveUserNames }}
            </template>
            <template #editor="{data}">
                <MultiSelect showClear v-model="data.approveUserIdsCV" display="chip" :options="users" optionLabel="fullName" optionValue="id" placeholder="Select" class="w-full"/>
            </template>
        </Column>
        <template #footer><div class="w-full text-end">In total there are rows.</div></template>
  </DataTable>
  <Toast />
    </div>
</template>
<script setup>
    import { ref, onMounted } from 'vue';
    import { useWorkflowDetail } from '~/stores/workflowDetail';
    import { FilterMatchMode } from 'primevue/api';
    import { useToast } from "primevue/usetoast";
    import{useUser} from '~/stores/user';
    const emit = defineEmits(['update:modelValue']);
    const props = defineProps(['modelValue']);
    const wfSteps = ref([]);
    const wfDetails = ref([]);
    const users = ref([]);
    const toast = useToast();
    onMounted(async() => 
        {
            wfDetails.value = await useWorkflowDetail().getByWorkflow(props.modelValue.id);
            wfSteps.value = await useWorkflowStep().getByWorkflow(props.modelValue.id);
            users.value = await useUser().getAll();
        }
    );
const onCellEditComplete = async (e) => {
        let { data, newValue, field,newData } = e;
        switch (field) {
            case 'duration':
                    if (newValue != null && newValue > 0) data[field] = newValue;
                    break;
            case 'nextWorkflowStepID':
                    var nextStep = wfSteps.value.find(x => x.id == newValue);
                    if (nextStep != null) {
                        data.nextWorkflowStepName = nextStep.name;
                        data[field] = newValue;
                    }
                    break;
            case 'rejectWorkflowStepID':
                    var rejectStep = wfSteps.value.find(x => x.id == newValue);
                    if (rejectStep != null) {
                        data.rejectWorkflowStepName = rejectStep.name;
                        data[field] = newValue;
                    }
                    break;
            case 'approveUserIdsCV':
                    var approveUsers = users.value.filter(x => newValue.includes(x.id));
                    if (approveUsers != null) {
                        data.approveUserNames = approveUsers.map(x => x.fullName).join(';');
                        data.approveUserIds = approveUsers.map(x => x.id).join(';');
                        data.approveUserIdsCV = newValue;
                    }
                    break;
            default:
                if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
                break;
        }
        await useWorkflowDetail().update(data);
    }

</script>
<style>

</style>
