
<template>
    <div class="card">
        <Chart type="bar" :data="chartData" :options="chartOptions" class="h-[30rem] flex justify-center"/>
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { storeToRefs } from "pinia";
import { useStatic }  from '~/stores/static';
import Chart from 'primevue/chart';
const { documentsByTimestamp :documentsByTimestampData } = storeToRefs(useStatic());

onMounted(async () => {
    const jsonData = await documentsByTimestampData.value;
    chartData.value = setChartData(jsonData);
    chartOptions.value = setChartOptions();
});

//watch documentsByTimestampData.value
watch(documentsByTimestampData, async (newVal) => {
    const jsonData = await newVal;
    chartData.value = setChartData(jsonData);
    chartOptions.value = setChartOptions();
});

const chartData = ref();
const chartOptions = ref();

const setChartData = (jsonData) => {
    const labels = jsonData.map(item => `Tháng ${item.month}`);
    const data = jsonData.map(item => item.numberDoc);

    return {
        labels: labels,
        datasets: [
            {
                label: 'Documents',
                data: data,
                backgroundColor: ['rgba(249, 115, 22, 0.2)'],
                borderColor: ['rgb(249, 115, 22)'],
                borderWidth: 1
            }
        ]
    };
};
const setChartOptions = () => {
    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--text-color');
    const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
    const surfaceBorder = documentStyle.getPropertyValue('--surface-border');
    return {
        plugins: {
            legend: {
                labels: {
                    color: textColor
                }
            }
        },
        scales: {
            x: {
                ticks: {
                    color: textColorSecondary
                },
                grid: {
                    color: surfaceBorder
                }
            },
            y: {
                beginAtZero: true,
                ticks: {
                    color: textColorSecondary
                },
                grid: {
                    color: surfaceBorder
                }
            }
        }
    };
}
</script>
