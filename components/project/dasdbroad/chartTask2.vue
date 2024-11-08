<template>
    <div>
        <Card style="height: 32rem; overflow: hidden;box-shadow: none; border-radius: 5px;">
            <template #title><div class="text-[1.15rem]">Created And Completed</div></template>
            <template #content>
              <Chart type="line" :data="series" :options="chartOptions" class="h-[25rem]"/>
                <!-- <apexchart type="bar" height="400" :options="chartOptions" :series="series"></apexchart> -->
            </template>
        </Card>
    </div>
</template>
<script setup>
import  Chart from 'primevue/chart'
const emit = defineEmits(['update:modelValue']);
const props = defineProps(['modelValue']);
const series = {
              labels: ['January',
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
                  label: 'Created',
                  // borderColor: '#3399ff',
                  // backgroundColor: '#3399ff',
                  // pointBackgroundColor: '#3399ff',
                  borderColor: '#0ea5e9',
                  backgroundColor: '#0ea5e9',
                  pointBackgroundColor: '#0ea5e9',
                  data: props.modelValue.created,
                },
                {
                  label: 'Completed',
                  // borderColor: '#1b9e3e',
                  // backgroundColor: '#1b9e3e',
                  // pointBackgroundColor: '#1b9e3e',
                  borderColor: '#12bf24',
                  backgroundColor: '#12bf24',
                  pointBackgroundColor: '#12bf24',
                  data: props.modelValue.completed,
                },
              ],
            };
const chartOptions=  {
              plugins: {
                legend: {
                  
                },
              },
              maintainAspectRatio: false,
              scales: {
                x: {
                  border: {
                    display: true,
                  },
                  grid: {
                    display: true,
                  },
                  ticks: {
                    display: true,
                  },
                },
                y: {
                
                  display: true,
                  grid: {
                    display: true,
                  },
                  ticks: {
                    display: true,
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
            };
    
</script>
