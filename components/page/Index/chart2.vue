
<template>
    <div class="card flex justify-content-center">
        <Chart type="polarArea" :data="chartData" :options="chartOptions" class="h-[25rem]" />
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { storeToRefs } from "pinia";
import { useStatic }  from '~/stores/static';
import Chart from 'primevue/chart';
const { documentsByCategory } = storeToRefs(useStatic());

onMounted(async () => {
    var jsonString = await documentsByCategory;
    chartData.value = convertJsonToChartData(jsonString);
    chartOptions.value = setChartOptions();
});
const chartData = ref();
const chartOptions = ref();
const convertJsonToChartData = (jsonData) => {
    const labels = jsonData.map(item => item.category.name);
    const data = jsonData.map(item => item.numberDoc);
    const backgroundColors = jsonData.map(() => getComputedStyle(document.documentElement).getPropertyValue('--pink-500')); // replace with your own logic for color
    return {
        datasets: [
            {
                data: data,
                backgroundColor: backgroundColors,
                label: 'My dataset'
            }
        ],
        labels: labels
    };
};

const setChartData = () => {
    const documentStyle = getComputedStyle(document.documentElement);
    return {
        datasets: [
            {
                data: [11, 16, 7, 3, 14],
                backgroundColor: [
                    documentStyle.getPropertyValue('--pink-500'),
                    documentStyle.getPropertyValue('--gray-500'),
                    documentStyle.getPropertyValue('--orange-500'),
                    documentStyle.getPropertyValue('--purple-500'),
                    documentStyle.getPropertyValue('--cyan-500')
                ],
                label: 'My dataset'
            }
        ],
        labels: ['Pink', 'Gray', 'Orange', 'Purple', 'Cyan']
    };
};
const setChartOptions = () => {
    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--text-color');
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
            r: {
                grid: {
                    color: surfaceBorder
                }
            }
        }
    };
}
</script>
