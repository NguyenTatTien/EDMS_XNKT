<template>
    <div class="w-[400px] px-[10px]">
        <span class="p-text-secondary block mb-5">Enter doucment information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Name</label>
        <InputText  v-model="tabEdit.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Description</label>
        <InputText  v-model="tabEdit.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">System</label>
        <Dropdown  v-model="tabEdit.systemID" editable :options="systems" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Plant</label>
        <Dropdown  v-model="tabEdit.plantID" editable :options="plants" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex justify-center gap-2">
        <Button type="button" label="Cancel" severity="secondary" icon="pi pi-times" class="bg-[#f1f5f9] p-2 text-black"></Button>
        <Button type="button" label="Save" icon="pi pi-save" class="p-2 text-white"></Button>
    </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {plantGetAllAPI} from "../../api/plantAPI.js";
import {systemGetAllAPI} from "../../api/systemAPI.js";
import {Tab} from "../../models/tab.js";
const emit = defineEmits(['update:modelValue', 'tabs']);
const props = defineProps(['tabs']);
const plants = ref([]);
const systems = ref([]);
const tabs = ref(props.tabs);
const tabEdit = ref(new Tab());
onMounted(async ()=>{
    loadAllPlants();
    loadAllSystems();
});
const loadAllPlants = async ()=>{
    try{
        const response = await plantGetAllAPI();
        plants.value = response.data;
    }catch(error){
        console.log(error);
    }
}
const loadAllSystems = async ()=>{
    try{
        const response = await systemGetAllAPI();
        systems.value = response.data;
    }catch(error){
        console.log(error);
    }
}
</script>
<style>
    .p-fileupload-buttonbar .p-button[aria-label="Upload"],.p-fileupload-buttonbar .p-button[aria-label="Cancel"]{
        display: none !important;
    }
    .p-fileupload-choose{
        width: max-content !important;
    }
    .p-fileupload{
        width: 100% !important;
    }
</style>