<template>
    <div>
        <div class="w-full grid grid-cols-5 mt-3 gap-3">
            <span class="p-0 rounded-lg">
                <MultiSelect v-model="selectedCities" :options="cities" optionLabel="name" placeholder="Select Cities"
                :maxSelectedLabels="3" class="w-full md:w-20rem" />
            </span>
            <span class="p-0 rounded-lg">
                <MultiSelect v-model="selectedCities" :options="cities" optionLabel="name" placeholder="Select Cities"
                :maxSelectedLabels="3" class="w-full md:w-20rem" />
            </span>
            <span class="p-0 rounded-lg">
                <MultiSelect v-model="selectedCities" :options="cities" optionLabel="name" placeholder="Select Cities"
                :maxSelectedLabels="3" class="w-full md:w-20rem" />
            </span>
            <span class="p-0 rounded-lg col-span-2">
                <IconField iconPosition="left" class="w-full">
                    <InputIcon class="pi pi-search"> </InputIcon>
                    <InputText v-model="value1" placeholder="Search" class="w-full"/>
                </IconField>
            </span>
        </div>
    </div>
</template>

<script setup>
import { ref } from "vue";

const selectedCities = ref();
const cities = ref([
    { name: 'New York', code: 'NY' },
    { name: 'Rome', code: 'RM' },
    { name: 'London', code: 'LDN' },
    { name: 'Istanbul', code: 'IST' },
    { name: 'Paris', code: 'PRS' }
]);

const value1 = ref(null);
const value2 = ref(null);
</script>