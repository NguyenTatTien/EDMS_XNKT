<template>
    <div class="w-[400px] px-[10px]">
        <span class="p-text-secondary block mb-5">Enter folder information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Name</label>
        <InputText v-if="documentEdit != null" v-model="documentEdit.object.name" id="userName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Description</label>
        <InputText v-if="documentEdit != null" v-model="documentEdit.object.description" id="description" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex justify-center gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="onCloseDialog"></Button>
        <Button type="button" label="Save" class="p-2 text-white" @click="onSaveDocument"></Button>
    </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {Folder} from '../../models/folder.js';
import {createFolderAPI,updateFolderAPI} from '../../api/folderAPI.js';
const emit = defineEmits(['closeNav','documents','documentEdit','categoryID','parentFolderID']);
const props = defineProps(['documents','documentEdit','categoryID','parentFolderID']);
const documents = ref(props.documents);
const documentEdit = ref(null);
const categoryID = ref(props.categoryID);
const parentFolderID = ref(props.parentFolderID);
onMounted(async ()=>{
    documentEdit.value = props.documentEdit;
});
watch(() => props.documentEdit, (newValue) => {
    documentEdit.value = newValue;
});
watch(() => props.documents, (newValue) => {
    documents.value = newValue;
});
watch(() => props.categoryID, (newValue) => {
    categoryID.value = newValue;
});
watch(() => props.parentFolderID, (newValue) => {
    parentFolderID.value = newValue;
});
const folder = ref(
    {
        type:"folder",
        object: new Folder(),
    }
);
const onCloseDialog = () => {
    emit('closeNav');
}
const onSaveDocument = () => {
    if(documentEdit.value.object.id == 0){
        insertFolder();
    }else{
        updateFolder();
    }
    emit('update:documents', documents.value);
    emit('closeNav');
}
const insertFolder = async () => {
   try{
       console.log(categoryID.value);

        documentEdit.value.object.categoryID = categoryID.value;
        documentEdit.value.object.parentID = parentFolderID.value;
        var folder = await createFolderAPI(documentEdit.value.object);
        console.log(folder);
        documents.value.push({type:'folder',object: folder});
   }
   catch(error){
       console.log(error);
   }
}
const updateFolder = async () => {
   try{
        await updateFolderAPI(documentEdit.value.object);
       var folder = documents.value.object.map(item =>{
                if(item.id == documentEdit.value.object.id){
                return documentEdit.value.object;
            }else{
                return item;
            }
        });
   }
   catch(error){
       console.log(error);
   }
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