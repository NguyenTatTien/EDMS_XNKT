<template>
    <div class="card">
        <Chart type="bar" :data="chartData" :options="chartOptions" class="h-[30rem]"/>
    </div>
</template>

<script setup>
import { ref, onMounted,watch } from "vue";
import { storeToRefs } from "pinia";
import { useStatic }  from '~/stores/static';
import Chart from 'primevue/chart';
const { documentsByCategory } = storeToRefs(useStatic());
onMounted(() => {
    // const jsonData = [ { "month": 1, "numberDoc": 0 }, { "month": 2, "numberDoc": 0 }, { "month": 3, "numberDoc": 0 }, { "month": 4, "numberDoc": 0 }, { "month": 5, "numberDoc": 0 }, { "month": 6, "numberDoc": 4 }, { "month": 7, "numberDoc": 0 }, { "month": 8, "numberDoc": 0 }, { "month": 9, "numberDoc": 0 }, { "month": 10, "numberDoc": 0 }, { "month": 11, "numberDoc": 0 }, { "month": 12, "numberDoc": 0 } ];
    // chartData.value = setChartData(jsonData);
    // chartOptions.value = setChartOptions();
    chartData.value = convertJsonToChartData(documentsByCategory.value);
    chartOptions.value = setChartOptions();
});
watch(documentsByCategory, async (newVal) => {
    chartData.value = convertJsonToChartData(newVal);
    chartOptions.value = setChartOptions();
});
const convertJsonToChartData = (jsonData) => {
    const labels = jsonData.map(item => item.category.name);
    const data = jsonData.map(item => item.numberDoc);
    const backgroundColors = jsonData.map(() => getComputedStyle(document.documentElement).getPropertyValue('--pink-500')); // replace with your own logic for color
    return {
        datasets: [
            {
                data: data,
                backgroundColor: backgroundColors,
                label: 'Documents'
            }
        ],
        labels: labels
    };
};
const chartData = ref();
const chartOptions = ref();

const setChartData = () => {
    const documentStyle = getComputedStyle(document.documentElement);

    return {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [
            {
                label: 'My First dataset',
                backgroundColor: documentStyle.getPropertyValue('--cyan-500'),
                borderColor: documentStyle.getPropertyValue('--cyan-500'),
                data: [65, 59, 80, 81, 56, 55, 40]
            },
            {
                label: 'My Second dataset',
                backgroundColor: documentStyle.getPropertyValue('--gray-500'),
                borderColor: documentStyle.getPropertyValue('--gray-500'),
                data: [28, 48, 40, 19, 86, 27, 90]
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
        indexAxis: 'y',
        maintainAspectRatio: false,
        aspectRatio: 0.8,
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
                    color: textColorSecondary,
                    font: {
                        weight: 500
                    }
                },
                grid: {
                    display: false,
                    drawBorder: false
                }
            },
            y: {
                ticks: {
                    color: textColorSecondary
                },
                grid: {
                    color: surfaceBorder,
                    drawBorder: false
                }
            }
        }
    };
}
</script>: any[](: { category: { name: any; }; })(: { numberDoc: any; })