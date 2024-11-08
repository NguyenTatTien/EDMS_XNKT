<template>
    <div>
        <Card style="height: 22rem; overflow: hidden;box-shadow: none; border-radius: 5px;">
            <template #title><div class="text-[1.15rem]">Task</div></template>
            <template #content>
                <apexchart type="donut" :options="chartOptions" :series="series" @dataPointSelection="handleDirectionSelection"></apexchart>
            </template>
        </Card>
        <n-modal v-model:show="showTask" preset="dialog" title="Tasks" style="width:100%;min-height:300px ;">
            <ProjectDasdbroadTableDetailTask v-model="showTask" :tasks="taskSelects"/>
      </n-modal>
    </div>
</template>
<script setup>
import { ref, onMounted,watch } from "vue";
const emit = defineEmits(['update:modelValue']);
const props = defineProps(['modelValue']);
const series = ref([]);
const taskSelects = ref([]);
const tasks = ref(props.modelValue);
const showTask = ref(false);
const projectName = ref('');
const data = ref([]);
onMounted(() => {
  tasks.value = props.modelValue;
  data.value.push({lable:'Wait Approve',value:tasks.value.filter(item => item.isApprove != true)});
  data.value.push({lable:'In-Process',value:tasks.value.filter(item => item.isProcess == true && item.isComplete != true && item.isCancel != true && !isLate(item.estimatedDate))});
  data.value.push({lable:'Complete',value:tasks.value.filter(item => item.isComplete == true && item.isCancel != true)});
  data.value.push({lable:'Late',value:tasks.value.filter(item => isLate(item.estimatedDate) && item.isCancel != true && item.isComplete != true)});
  data.value.push({lable:'Cancel',value:tasks.value.filter(item => item.isCancel == true)});
  series.value =data.value.map(t=>t.value.length);
});
watch(() => props.modelValue, (value) => {
  tasks.value = props.modelValue;
  data.value.push({lable:'Wait Approve',value:tasks.value.filter(item => item.isApprove != true)});
  data.value.push({lable:'In-Process',value:tasks.value.filter(item => item.isProcess == true && item.isComplete != true && item.isCancel != true && !isLate(item.estimatedDate))});
  data.value.push({lable:'Complete',value:tasks.value.filter(item => item.isComplete == true && item.isCancel != true)});
  data.value.push({lable:'Late',value:tasks.value.filter(item => isLate(item.estimatedDate) && item.isCancel != true && item.isComplete != true)});
  data.value.push({lable:'Cancel',value:tasks.value.filter(item => item.isCancel == true)});
  series.value =data.value.map(t=>t.value.length);
});
const chartOptions= {
            chart: {
              type: 'donut',
            },
            colors: ['#0ea5e9',  '#ff6632', '#12bf24', '#e72e7a', '#eb3939'], 
            labels: ['Await', 'In-Process', 'Completed', 'Late','Cancel'],
            responsive: [{
              breakpoint: 480,
              options: {
                chart: {
                  width: 100,
                },
                legend: {
                  position: 'bottom'
                }
              }
            }]
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
const handleDirectionSelection = (event, chartContext, config) => {
            const dataPointIndex = config.dataPointIndex;
            const seriesIndex = config.seriesIndex; 
            taskSelects.value = data.value[dataPointIndex].value;
            showTask.value = true;
}
</script>
