<template>
    <div>
        <Card style="height: 33rem; overflow: hidden;box-shadow: none; border-radius: 5px;">
            <template #title><div class="text-[1.15rem]">Workload</div></template>
            <template #content>
                <apexchart type="bar" :options="chartOptions" :series="series" @dataPointSelection="handleDirectionSelection"></apexchart>
            </template>
        </Card>
        <n-modal v-model:show="showTask" preset="dialog" :title="projectName" style="width:100%;min-height:300px ;">
            <ProjectDasdbroadTableDetailTask v-model="showTask" :tasks="taskSelects"/>
      </n-modal>
    </div>
</template><script setup>
import { ref, onMounted,watch } from "vue";
import Chart from 'primevue/chart';
const emit = defineEmits(['update:modelValue']);
const props = defineProps(['modelValue']);
const modelData = ref([]);
const projects = ref([]);
const taskSelects = ref([]);
const showTask = ref(false);
const projectName = ref('');
onMounted(() => {
    modelData.value = props.modelValue;
    projects.value = modelData.value.map(item => item.project);
    series.value[0].data = modelData.value.map(item => item.wait.length);
    series.value[1].data = modelData.value.map(item => item.process.length);
    series.value[2].data = modelData.value.map(item => item.complete.length);
    series.value[3].data = modelData.value.map(item => item.late.length);
    series.value[4].data = modelData.value.map(item => item.cancel.length);
    chartOptions.value.xaxis.categories = modelData.value.map(item => item.project);
    chartOptions.value.xaxis.ids = modelData.value.map(item => item.id);
});
watch(() => props.modelValue, (value) => {
    modelData.value = value;
    projects.value = modelData.value.map(item => item.project);
    series.value[0].data = modelData.value.map(item => item.wait.length);
    series.value[1].data = modelData.value.map(item => item.process.length);
    series.value[2].data = modelData.value.map(item => item.complete.length);
    series.value[3].data = modelData.value.map(item => item.late.length);
    series.value[4].data = modelData.value.map(item => item.cancel.length);
    chartOptions.value.xaxis.categories = modelData.value.map(item => item.project);
    chartOptions.value.xaxis.ids = modelData.value.map(item => item.id);
});
const series = ref([{
            name: 'Wait Approve',
            data: []
          }, {
            name: 'In-Process',
            data: []
          }, {
            name: 'Complete',
            data: []
          }, {
            name: 'Late',
            data: []
          }, {
            name: 'Cancel',
            data: []
          }]);
const chartOptions= ref({
            chart: {
              type: 'bar',
              height: 350,
              stacked: true,
              
            },
            plotOptions: {
              bar: {
                horizontal: true,
                dataLabels: {
                  total: {
                    enabled: true,
                    offsetX: 0,
                    style: {
                      fontSize: '13px',
                      fontWeight: 900
                    }
                  }
                }
              },
            },  
            // colors: ['#d3d3d3', '#f9b115', '#1b9e3e', '#e55353', '#ff0000'],
            colors: ['#0ea5e9',  '#ff6632', '#12bf24', '#e72e7a', '#eb3939'],
            stroke: {
              width: 1,
              colors: ['#fff']
            },
            title: {
              text: ''
            },
            xaxis: {
              ids:[],
              categories: [],
              labels: {
                formatter: function (val) {
                  return val + " tasks"
                }
              }
            },
            yaxis: {
              title: {
                text: undefined
              },
            },
            tooltip: {
              intersect: true,
              shared: false,  
              y: {
                formatter: function (val) {
                  return val + " tasks"
                }
              }
            },
            fill: {
              opacity: 1
            },
            legend: {
              position: 'top',
              horizontalAlign: 'left',
              offsetX: 40
            }
          });
          const handleDirectionSelection = (event, chartContext, config) => {
            const dataPointIndex = config.dataPointIndex;
            const seriesIndex = config.seriesIndex; 
            const projectID = chartOptions.value.xaxis.ids[dataPointIndex]; 
            projectName.value  = chartOptions.value.xaxis.categories[dataPointIndex]; 
            const seriesName = series.value[seriesIndex].name.toLowerCase().replace('in-','');
        
            
            taskSelects.value = modelData.value.filter(t => t.id == projectID).map(t => t[seriesName])[0];
            showTask.value = true;
          
          }
</script>