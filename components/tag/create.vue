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
        <label class="font-semibold w-[6rem]">Asset</label>
        <InputText  v-model="tagEdit.assetCode" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">System</label>
        <Dropdown  v-model="selectSystem" editagle :options="systems" optionLabel="name" placeholder="Select system" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">PlatForm</label>
        <Dropdown  v-model="selectPlant" editagle :options="plants" optionLabel="name" placeholder="Select platform" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex justify-center gap-2">
        <Button type="button" label="Cancel" severity="secondary" icon="pi pi-times" class="bg-[#f1f5f9] p-2 text-black" @click="$emit('update:modelValue', false)"></Button>
        <Button type="button" label="Save" icon="pi pi-save" class="p-2 text-white" @click="onCreateTag"></Button>
    </div>
    <Toast />
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {usePlatForm} from "~/stores/platForm";
import {useSystem} from "~/stores/system";
import { useToast } from "primevue/usetoast";
import {Tag} from "../../models/tag.js";
import {useTag} from "~/stores/tag";
const toast = useToast();
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
        const data = await usePlatForm().getAll();
        plants.value = data;
    }catch(error){
        console.log(error);
    }
}
const loadAllSystems = async ()=>{
    try{
        const data = await useSystem().getAll();
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
        const data = await useTag().create(tagEdit.value);
        tags.value.push(data);
        emit('update:tags', tags.value);
        emit('update:modelValue', false);
        toast.add({ severity: 'success', detail: 'Create successfully!', summary: 'Success Message', life: 5000 });
    }catch(error){
        toast.add({ severity: 'error', detail: 'Create fail!', summary: 'Error Message', life: 5000 });
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