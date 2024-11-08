<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter folder information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="folder.object.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="folder.object.description" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="p-2 text-white" @click="savedocument"></Button>
    </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {DocumentView} from '../models/tableView/documentView.js';
import {Folder} from '../models/folder.js';
const emit = defineEmits(['modelValue', 'documents']);
const props = defineProps(['documents']);
var documents = props.documents;
onMounted(async ()=>{
})
const folder = ref(
    {
        type:"folder",
        object: new Folder(),
    }
);
const closeDialog = () => {
    emit('update:modelValue', false);
}
const savedocument = async () => {
    folder.value.type="folder";
    folder.value.object.createdDate=new Date("2020-04-09T11:10:25.247");
    documents.push(folder.value);
    emit('documents', documents);
    emit('update:modelValue', false);
}
</script>
<style scoped>
    .p-button{
        padding: 0.5rem 1rem !important;
    }
    .p-inputtext{
        padding: 7px 10px !important;
    }
</style>