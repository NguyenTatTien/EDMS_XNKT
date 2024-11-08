<template>
    <div class="flex flex-col justify-between w-full px-[10px] h-[100%]">
      <div>
                <span class="p-text-secondary block mb-5">Enter folder information.</span>
            <div class="flex items-center gap-3 mb-3">
                <label class="font-semibold w-[6rem]">Name</label>
                <InputText v-if="documentEdit != null" v-model="documentEdit.name" id="userName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
            </div>
            <div class="flex items-center gap-3 mb-3">
                <label class="font-semibold w-[6rem]">Description</label>
                <InputText v-if="documentEdit != null" v-model="documentEdit.title" id="description" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
            </div>
            <div class="flex items-center gap-3 mb-3">
                <label class="font-semibold w-[6rem]">Is Private</label>
                <Checkbox v-if="documentEdit != null" v-model="documentEdit.isPrivate" :binary="true" />
            </div>
            <div class="flex justify-center gap-2">
                <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="onCloseDialog"></Button>
                <Button type="button" label="Save" class="p-2 text-white" @click="onSaveDocument"></Button>
            </div>
      </div>
    <!-- <div>
        <ul class="list-none p-0 m-0" data-v-446f85a0="">
            <li class="p-3 mb-3 flex items-center justify-between cursor-pointer rounded bg-indigo-50 text-indigo-900" data-v-446f85a0="">
            <div class="flex items-center" data-v-446f85a0="">
                <i class="pi pi-file-pdf text-xl mr-3" data-v-446f85a0=""></i><span class="text-sm font-medium" data-v-446f85a0="">Total</span>
            </div>
            <span class="text-sm font-bold" data-v-446f85a0="">{{ folders.length + files.length }}</span></li>
            <li class="p-3 mb-3 flex items-center justify-between cursor-pointer rounded bg-yellow-50 text-yellow-900" data-v-446f85a0="">
                <div class="flex items-center" data-v-446f85a0=""><i class="pi pi-folder text-xl mr-3" data-v-446f85a0="">
                </i><span class="text-sm font-medium" data-v-446f85a0="">Folder</span></div><span class="text-sm font-bold" data-v-446f85a0="">{{ folders.length }}</span></li>
                <li class="p-3 mb-3 flex items-center justify-between cursor-pointer rounded bg-red-50 text-red-900" data-v-446f85a0="">
                <div class="flex items-center" data-v-446f85a0=""><i class="pi pi-file text-xl mr-3" data-v-446f85a0="">
                </i><span class="text-sm font-medium" data-v-446f85a0="">Document</span></div><span class="text-sm font-bold" data-v-446f85a0="">{{ files.length }}</span></li>
                <li class="p-3 flex items-center justify-between cursor-pointer rounded bg-orange-50 text-orange-900" data-v-446f85a0="">
                    <div class="flex items-center" data-v-446f85a0=""><i class="pi pi-chart-pie text-xl mr-3" data-v-446f85a0="">
                    </i><span class="text-sm font-medium" data-v-446f85a0="">Size</span></div><span class="text-sm font-bold" data-v-446f85a0="">{{documentEdit!=null? (documentEdit.object.folderSize/1024).toFixed(3)+" KB":"" }}</span>
                </li>
            </ul>
    </div> -->
    <Toast />
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {Folder} from '../../models/folder.js';

import  {useFolder} from '~/stores/folder';

const emit = defineEmits(['modelValue','documents','selectDocument','categoryID','parentFolderID']);
const props = defineProps(['documents','selectDocument','categoryID','parentFolderID']);
import { useToast } from "primevue/usetoast";
const toast = useToast();
const documents = ref(props.documents);
const documentEdit = ref(null);
const categoryID = ref(props.categoryID);
const parentFolderID = ref(props.parentFolderID);
const folders = ref([]);
const files = ref([]);
onMounted(async ()=>{
    documentEdit.value = props.selectDocument;
    // /loadDataFolder();
});
const loadDataFolder = async () => {
    try{
        if(documentEdit.value != null){
          //  folders.value = await useFolder().getFolderByParentAndCategory(documentEdit.value.object.id,categoryID.value);
           // files.value = await documentGetByFolderAPI(documentEdit.value.object.id);
        }
    }
    catch(error){
        console.log(error);
    }
}
watch(() => props.selectDocument, (newValue) => {
    documentEdit.value = newValue;
    loadDataFolder();
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
    emit('update:modelValue',false);
}
const onSaveDocument = () => {
    try{
        if(documentEdit.value.id == 0){
        insertFolder();
    }else{
        updateFolder();
    }
    emit('update:documents', documents.value);
    emit('update:modelValue',false);
    }catch(error){
        console.log(error);
    }
}
const insertFolder = async () => {
   try{
        //documentEdit.value.categoryID = categoryID.value;
        //documentEdit.value.parentID = parentFolderID.value;
        var newFolder = new Folder();
        newFolder.name = documentEdit.value.name;
        newFolder.description = documentEdit.value.title;
        newFolder.categoryID = categoryID.value;
        newFolder.parentID = parentFolderID.value;
        newFolder.isPrivate = documentEdit.value.isPrivate;
        var folder = await useFolder().create(newFolder);
        documentEdit.value.id = folder.id;
        documentEdit.value.isFolder = true;
        documentEdit.value.vitualPath = folder.vitualPath;
        documentEdit.value.isHasFile = folder.isHasFolder;
        documents.value.push(documentEdit.value);
        
        useFolder().refreshFoldersByCategory(categoryID.value);
    
        toast.add({ severity: 'success', summary: 'Create folder successfully!', detail: 'Success', life: 5000 });

   }
   catch(error){
       console.log(error);
   }
}
const updateFolder = async () => {
   try{
        await useFolder().update(documentEdit.value);
       var folder = documents.value.map(item =>{
                if(item.id == documentEdit.value.id){
                return documentEdit.value;
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
.circle-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: max-content; /* Điều chỉnh chiều cao của hình tròn */
}

.circle {
  width: 80px; /* Điều chỉnh kích thước của hình tròn */
  height: 80px; /* Điều chỉnh kích thước của hình tròn */
  border-radius: 50%; /* Tạo hình tròn */
  background-color: transparent; /* Màu nền của hình tròn */
  display: flex;
  justify-content: center;
  align-items: center;
  border: 5px solid #1976d2;
}

.circle span {
  color: #1976d2; /* Màu văn bản */
  font-size: 24px; /* Kích thước văn bản */
}
</style>