

<template>
  <div class="" id="widget">
    
   <Card style="height: 9rem; overflow: hidden;box-shadow: none; border-radius: 5px;">
           <!--#e55353  -->
           <template #content> 
             <div class="card text-white h-max" style="background-color: #eb3939;">
               <div class="card-body pb-0 flex justify-between items-start">
                 <div><div class="fs-4 fw-semibold">{{ dataModel.count ? dataModel.count[3] :0  }}<span class="fs-6 fw-normal"></span>
                 </div><div>Work Hour</div></div>
               
                 </div>
                 <Chart
            type="bar"
            class="mt-3 mx-3"
            style="height: 70px"
            :data="data4"
            :options="{
              maintainAspectRatio: false,
              plugins: {
                legend: {
                  display: false,
                },
              },
              scales: {
                x: {
                  grid: {
                    display: false,
                    drawTicks: false,
                  },
                  ticks: {
                    display: false,
                  },
                },
                y: {
                  border: {
                    display: false,
                  },
                  grid: {
                    display: false,
                    drawTicks: false,
                  },
                  ticks: {
                    display: false,
                  },
                },
              },
            }"
          />
             </div>
            
              
            
           
           </template>
   </Card>
  </div>
</template>
<script setup>
import { onMounted, ref,watch } from 'vue'
import  Chart from 'primevue/chart'
import imgProject from '../../../assets/images/clock-100.png'
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

const data4 = {
              labels: [
                'January',
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
                'December',
              ],
              datasets: [
                {
                  // #f87979
                  label: 'Work Hour',
                  backgroundColor: '#e16b6b',
                  borderColor: 'rgba(255,255,255,.55)',
                  data: [],
                  barPercentage: 0.6,
                },
              ],
            };

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
  data4.datasets[0].data = data.countAllMonth.workHour
}
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