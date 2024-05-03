<template>
    <div class="w-[400px] px-[10px]">
        <span class="p-text-secondary block mb-5">Enter doucment information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Name</label>
        <InputText  v-model="tagEdit.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Description</label>
        <InputText  v-model="tagEdit.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">System</label>
        <Dropdown  v-model="selectSystem" editagle :options="systems" optionLabel="name" placeholder="Select system" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Plant</label>
        <Dropdown  v-model="selectPlant" editagle :options="plants" optionLabel="name" placeholder="Select plant" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex justify-center gap-2">
        <Button type="button" label="Cancel" severity="secondary" icon="pi pi-times" class="bg-[#f1f5f9] p-2 text-black" @click="$emit('update:modelValue', false)"></Button>
        <Button type="button" label="Save" icon="pi pi-save" class="p-2 text-white" @click="onCreateTag"></Button>
    </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {plantGetAllAPI} from "../../api/plantAPI.js";
import {systemGetAllAPI} from "../../api/systemAPI.js";
import {Tag} from "../../models/tag.js";
import {createTagAPI} from "../../api/tagAPI.js";
const emit = defineEmits(['update:modelValue', 'tags']);
const props = defineProps(['tags']);
const plants = ref([]);
const systems = ref([]);
const tags = ref(props.tags);
const tagEdit = ref(new Tag());
const selectSystem = ref(null);
const selectPlant = ref(null);
onMounted(async ()=>{
    loadAllPlants();
    loadAllSystems();
});
const loadAllPlants = async ()=>{
    try{
        const data = await plantGetAllAPI();
        plants.value = data;
    }catch(error){
        console.log(error);
    }
}
const loadAllSystems = async ()=>{
    try{
        const data = await systemGetAllAPI();
        systems.value = data;
    }catch(error){
        console.log(error);
    }
}
const onCreateTag = async ()=>{
    try{
        tagEdit.value.plantID = selectPlant.value.id;
        tagEdit.value.plantName = selectPlant.value.name;
        tagEdit.value.systemID = selectSystem.value.id;
        tagEdit.value.systemName = selectSystem.value.name;
        const data = await createTagAPI(tagEdit.value);
        tags.value.push(data);
        emit('update:tags', tags.value);
        emit('update:modelValue', false);
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