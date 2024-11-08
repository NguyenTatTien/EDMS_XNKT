<template>
    <div>
        <Card style="height: 46rem; overflow: hidden;box-shadow: none; border-radius: 5px;" id="cardTableTask" class="custom-scrollbar">
            <template #title>
                <div class="flex justify-between">
                    <div class="text-[1.15rem]">Summary</div>
                    <div>
                        <n-popselect
                            v-model:value="projectSelected"
                            :options="projects"
                            size="medium"
                            scrollable>
                            <n-button style="margin-right: 8px">
                            {{ projectLabelSelect || 'All Project' }}
                            </n-button>
                        </n-popselect>
                    </div>
                </div>
            </template>
            <template #content>
                <DataTable :value="taskShow"  class="text-xs h-[100%]" stripedRows id="tbTask" scrollable>
                <template #empty> No found. </template>
      <template #loading> Loading data. Please wait. </template>
      <Column field="name" header="Name" style="min-width: 10rem">
        <template #body="{data}">
            <div class="cursor-pointer">
                {{data.name}}
            </div>
        </template>
      </Column>
      <Column field="workHour" header="Work Hour" style="min-width: 6rem">
      </Column>
      <Column header="Process Percent" field="process_Percent" style="min-width: 6rem">
        <template #body="{data}">
            {{ data.process_Percent }}%
                <ProgressBar :value="data.process_Percent" class="pro_per"></ProgressBar>
        </template>
    </Column>
    <Column header="Status" field="status" style="min-width: 4rem">
        <template #body="{data}">
            <Badge v-if = "data.isProcess == true && !isLate(data.estimatedDate) && !data.isCancel" :severity="getSeverity(1)" class="bg-[#ff6632]" title="In-Process"/>
            <Badge v-else-if = "data.isComplete == true && !data.isCancel" :severity="getSeverity(2)" class="bg-[#12bf24]" title="Complete"/>
            <Badge v-else-if = "isLate(data.estimatedDate) && !data.isCancel" :severity="getSeverity(3)" class="bg-[#e72e7a]" title="Late"/>
            <Badge v-else-if = "data.isApprove == false" :severity="getSeverity(4)" class="bg-[#0ea5e9]" title="Await Approve"/>
            <Badge v-else :severity="getSeverity(4)" class="bg-[#eb3939]" title="Cancel"/>
        </template>
    </Column>
        </DataTable>
            </template>
        </Card>
    </div>
</template>
<script setup>
import { ref,onMounted,watch } from 'vue';
const emit = defineEmits(['update:modelValue','projects']);
const props = defineProps(['modelValue','projects']);
const projects = ref([
    {
        label: 'All Project',
        value: 0
    }
]);
const projectSelected = ref(null);
const projectLabelSelect = ref(null);
const tasks = ref(props.modelValue);
const taskShow = ref(props.modelValue);
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
const isLate = (date)=>{
    let plantDate = new Date(date);
    let currentDate = new Date();
    if(plantDate < currentDate){
        return true;
    }else{
        return false;
    }
}
onMounted(() => {
    props.projects.forEach(t=>{
        projects.value.push({
            label: t.name,
            value: t.id
        });
    });
});
watch(() => projectSelected.value, (value) => {
    projectLabelSelect.value = projects.value.find(x => x.value == value).label;
    if(value == 0){
        taskShow.value = tasks.value;
        return;
    }
    taskShow.value = tasks.value.filter(item => item.projectID == value);
});
</script>
<style>
  #tbTask .p-progressbar-label{
    display: none;
  }
  #tbTask .pro_per .p-progressbar-value{
    background-color: #0ea5e9 !important;
  }
  #tbTask .p-progressbar{
    height: 5px;
  }
  #tbTask td, #tbTask th {
    padding: 0.5rem 1rem;
}
#tbTask .p-datatable-wrapper{
    max-height: 95% !important;
}
#cardTableTask .p-card-content{
}
#tbTask .p-datatable-wrapper:hover::-webkit-scrollbar{
  width: 4px;
  height: 5px;
}
</style>
