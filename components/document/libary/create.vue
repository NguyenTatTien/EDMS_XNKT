<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter doucment information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="document.object.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="document.object.title" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Tab</label>
        <Dropdown v-model="document.object.tabID" :options="tabs" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[324px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Document Type</label>
        <Dropdown v-model="document.object.documentTypeID" :options="documentTypes" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[324px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Discipline</label>
        <Dropdown v-model="document.object.disciplineID" :options="disciplines" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[324px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Model</label>
        <Dropdown v-model="document.object.modelID" :options=" models" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[324px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Contractor</label>
        <InputText v-model="document.object.contractor" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Form To</label>
        <InputText v-model="document.object.fromTo" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <FileUpload name="demo[]" :multiple="false" :maxFileSize="1000000" class="w-full">
            <template #empty>
            </template>
        </FileUpload>
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="p-2 text-white" @click="savedocument"></Button>
    </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
// import {createDocumentAPI} from '../api/documentAPI.js';
import {modelGetAllAPI} from "../../../api/modelAPI.js";

import {disciplinesGetAllAPI} from "../../../api/disciplinesAPI.js";
import {Document} from '../../../models/document.js';
const emit = defineEmits(['update:modelValue', 'documents']);
const props = defineProps(['documents']);
const models = ref([]);
const tabs = ref([]);
const documentTypes = ref([]);
const disciplines = ref([]);
const documents = props.documents;
onMounted(async ()=>{
    await getModels();
    await getDisciplines();
})
const document = ref(
    {
        type:"folder",
        object: new Document(),
    }
);
const closeDialog = () => {
    emit('update:modelValue', false);
}
const getModels = async () => {
    try{
        models.value = await modelGetAllAPI();
        }
        catch(error){
            console.log("Error get list model:"+error);
    }
}
const getDisciplines = async () => {
    try{
            disciplines.value = await disciplinesGetAllAPI();
        }
        catch(error){
            console.log("Error get list model:"+error);
    }
}
const savedocument = async () => {
    // var data = await createDocumentAPI(document.value);
    document.value.type="folder";
    document.value.object.createdDate=new Date("2020-04-09T11:10:25.247");
    document.value.object.fileExtensionIcon = "/images/folderdir16.png";
    documents.push(document.value);
    emit('update:modelValue', false);
    // documents.push(data);
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