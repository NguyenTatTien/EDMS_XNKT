

<!-- <template>
  <div class="" id="widget">
    <Card style="height: 9rem; overflow: hidden;box-shadow: none; border-radius: 5px;">
            <template #content> 
              <div class="card text-white h-max" style="background-color:  #0ea5e9">
                <div class="card-body pb-0 flex justify-between align-items-start">
                  <div>
                    <div class="fs-4 fw-semibold">{{ dataModel.count ? dataModel.count[0] :0}}<span class="fs-6 fw-normal"></span>
                  </div>
                  <div>Project</div>
                </div>
                  </div>
                  <Chart type="line" :data="data1" :options="chartOptions1" class="mt-3 mx-3"
            style="height: 70px"
            ref="widgetChartRef1"/>
              </div>
            </template>
    </Card>
    
  </div>
</template>
<script setup>
import { onMounted, ref,watch } from 'vue'
import imgProject from '../../../assets/images/project-100.png'
import  Chart from 'primevue/chart'
import { c } from 'naive-ui';
const emit = defineEmits(['modelValue']);
const props = defineProps(['modelValue']);
const dataModel = ref(props.modelValue);
watch(() => props.modelValue, (value) => {
  dataModel.value = value;
    setData(dataModel.value);
});
const widgetChartRef1 = ref()
const widgetChartRef2 = ref()
const data1 = {
              labels: [ 'January',
                'February',
                'March',
                'April',
                'May',
                'June',
                'July',
                'August',
                'September',
                'October',
                'November',
                'December',],
              datasets: [
                {
                  label: 'Total',
                  backgroundColor: 'transparent',
                  borderColor: 'rgba(255,255,255,.55)',
                  pointBackgroundColor: '#0ea5e9',
                  data: [],
                },
              ],
            };

const chartOptions1 = ref({
              chart:{
                height: 70,
              },
              plugins: {
                legend: {
                  display: false,
                },
              },
              maintainAspectRatio: false,
              scales: {
                x: {
                  border: {
                    display: false,
                  },
                  grid: {
                    display: false,
                  },
                  ticks: {
                    display: false,
                  },
                },
                y: {
                  min: -1,
                  max:2,
                  display: false,
                  grid: {
                    display: false,
                  },
                  ticks: {
                    display: false,
                  },
                },
              },
              elements: {
                line: {
                  borderWidth: 1,
                  tension: 0.4,
                },
                point: {
                  radius: 4,
                  hitRadius: 10,
                  hoverRadius: 4,
                },
              },
            });
onMounted(() => {
  document.documentElement.addEventListener('ColorSchemeChange', () => {
    if (widgetChartRef1.value) {
      widgetChartRef1.value.chart.data.datasets[0].pointBackgroundColor = getStyle('--cui-primary')
      widgetChartRef1.value.chart.update()
    }
    if (widgetChartRef2.value) {
      widgetChartRef2.value.chart.data.datasets[0].pointBackgroundColor = getStyle('--cui-info')
      widgetChartRef2.value.chart.update()
    }
  });
  setData(dataModel.value);
})
const setData = (data) => {
  data1.datasets[0].data = data.countAllMonth.total;
  chartOptions1.value.scales.y.max = Math.max(...data.countAllMonth.total)+1;
}
</script> -->


<template>
  <div class="" id="widget">
    <Card style="height: 9rem; overflow: hidden; box-shadow: none; border-radius: 5px;">
      <template #content>
        <div class="card text-white h-max" style="background: #0ea5e9">
          <div class="card-body pb-0 flex justify-between align-items-start">
            <div>
              <div class="fs-4 fw-semibold">{{ dataModel.count ? dataModel.count[0] : 0 }}<span class="fs-6 fw-normal"></span></div>
              <div>Project</div>
            </div>
          </div>
          <apexchart
            type="area"
            height="70"
            :options="chartOptions"
            :series="series"
            class="mt-3"
              ref="widgetChartRef1"
          ></apexchart>
        </div>
      </template>
    </Card>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue';
import Card from 'primevue/card';

const props = defineProps(['modelValue']);
const dataModel = ref(props.modelValue);
const widgetChartRef1 = ref();
watch(() => props.modelValue, (value) => {
  dataModel.value = value;
  updateChartData(dataModel.value);
});

const series = ref([
  {
    name: 'Project',
    data: [31, 40, 28, 51, 42, 109, 100]
  }
]);

const chartOptions = ref({
  chart: {
    type: 'area',
    height: 70,
    sparkline: {
      enabled: true
    },
    toolbar: {
      show: false
    }
  },
  stroke: {
    curve: 'smooth',
    width: 2
  },
  fill: {
    type: 'gradient',
    gradient: {
      shadeIntensity: 1,
      opacityFrom: 0.7,
      opacityTo: 0.3,
      stops: [0, 90, 100]
    }
  },
  colors: ['#ffffff'],
  tooltip: {
    theme: 'dark',
  },
  yaxis: {
    min: -1,
    max: 120, // You can adjust this value as needed
  },
  xaxis: {
              categories: ['January',
                'February',
                'March',
                'April',
                'May',
                'June',
                'July',
                'August',
                'September',
                'October',
                'November',
                'December']
            },
});

const updateChartData = (data) => {
  // Update chart data here if needed
  series.value[0].data = data.countAllMonth.total;
  chartOptions.value.yaxis.max = Math.max(...data.countAllMonth.total);
};

onMounted(() => {
  updateChartData(dataModel.value);
});
</script>
<style>
.chartjs-tooltip-header th , .chartjs-tooltip-body td {
  color: black !important;
}
#widget .p-card-body{
  padding: 0 !important;
  height: max-content !important;
}
#widget .p-card-content{
  height: max-content !important;
}
#widget .p-card{
  height: max-content !important;
}
#widget .card{
  --cui-card-spacer-y: 1rem;
    --cui-card-spacer-x: 1rem;
    --cui-card-title-spacer-y: 0.5rem;
    --cui-card-title-color: ;
    --cui-card-subtitle-color: ;
    --cui-card-border-width: var(1px);
    --cui-card-border-color: var(rgba(8, 10, 12, 0.175));
    --cui-card-border-radius: var(0.375rem);
    --cui-card-box-shadow: ;
    --cui-card-inner-border-radius: calc(var(0.375rem) -(var(1px)));
    --cui-card-cap-padding-y: 0.5rem;
    --cui-card-cap-padding-x: 1rem;
    --cui-card-cap-bg: rgba(var(37,43,54), 0.03);
    --cui-card-cap-color: ;
    --cui-card-height: ;
    --cui-card-color: ;
    --cui-card-bg: var(#fff);
    --cui-card-img-overlay-padding: 1rem;
    --cui-card-group-margin: 0.75rem;
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    height: var(--cui-card-height);
    color: var(rgba(37, 43, 54, 0.95));
    word-wrap: break-word;
    background-color: var(--cui-card-bg);
    background-clip: border-box;
    border: var(--cui-card-border-width) solid var(--cui-card-border-color);
    border-radius: var(--cui-card-border-radius);
}
#widget .card-body{
    flex: 1 1 auto;
    padding: var(--cui-card-spacer-y) var(--cui-card-spacer-x);
    color: var(--cui-card-color);
}
#widget .fs-4 {
  font-size: calc(1.275rem + .3vw) !important;
}
#widget .fw-semibold {
  font-weight: 600 !important;
}
#widget .fs-6 {
  font-size: 1rem !important;
}
#widget .fw-normal {
  font-weight: 400 !important;
}
</style>
<style>
.chartjs-tooltip-header th , .chartjs-tooltip-body td {
  color: black !important;
}
#widget .p-card-body{
  padding: 0 !important;
  height: max-content !important;
}
#widget .p-card-content{
  height: max-content !important;
}
#widget .p-card{
  height: max-content !important;
}
#widget .card{
  --cui-card-spacer-y: 1rem;
    --cui-card-spacer-x: 1rem;
    --cui-card-title-spacer-y: 0.5rem;
    --cui-card-title-color: ;
    --cui-card-subtitle-color: ;
    --cui-card-border-width: var(1px);
    --cui-card-border-color: var(rgba(8, 10, 12, 0.175));
    --cui-card-border-radius: var(0.375rem);
    --cui-card-box-shadow: ;
    --cui-card-inner-border-radius: calc(var(0.375rem) -(var(1px)));
    --cui-card-cap-padding-y: 0.5rem;
    --cui-card-cap-padding-x: 1rem;
    --cui-card-cap-bg: rgba(var(37,43,54), 0.03);
    --cui-card-cap-color: ;
    --cui-card-height: ;
    --cui-card-color: ;
    --cui-card-bg: var(#fff);
    --cui-card-img-overlay-padding: 1rem;
    --cui-card-group-margin: 0.75rem;
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    height: var(--cui-card-height);
    color: var(rgba(37, 43, 54, 0.95));
    word-wrap: break-word;
    background-color: var(--cui-card-bg);
    background-clip: border-box;
    border: var(--cui-card-border-width) solid var(--cui-card-border-color);
    border-radius: var(--cui-card-border-radius);
}
#widget .card-body{
    flex: 1 1 auto;
    padding: var(--cui-card-spacer-y) var(--cui-card-spacer-x);
    color: var(--cui-card-color);
}
#widget .fs-4 {
  font-size: calc(1.275rem + .3vw) !important;
}
#widget .fw-semibold {
  font-weight: 600 !important;
}
#widget .fs-6 {
  font-size: 1rem !important;
}
#widget .fw-normal {
  font-weight: 400 !important;
}
</style>