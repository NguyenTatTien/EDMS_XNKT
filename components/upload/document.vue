<template>
    <div v-bind="getRootProps()">
      <div class="flex flex-wrap justify-between items-center flex-1 gap-2 p-2">
                    <div class="flex gap-2">
                        <FileUpload mode="basic" ref="fileSelects" name="demo[]" icon="pi pi-cloud-upload" multiple="true" :maxFileSize="1000000000" chooseLabel=" " @select="onUpload" id="chooseFile"/>
                        <Button icon="pi pi-cloud-upload" rounded outlined severity="success" :disabled="!files || files.length === 0" @click="uploadFiles"></Button>
                        <Button icon="pi pi-times" rounded outlined severity="danger" :disabled="!files || files.length === 0" @click="removeAllFiles"></Button>
                    </div>
      </div>
      <div v-if="files.length === 0" class="flex items-center justify-center flex-col" :class="isDragActive?'bg-green-100 border-dashed border border-green-500':''">
                    <i class="pi pi-cloud-upload border-2 border-circle p-5 text-8xl text-400 border-400" />
                    <p class="mt-4 mb-0">Drag and drop files to here to upload.</p>
      </div>
      <div v-else class="flex items-center justify-center flex-wrap" :class="isDragActive?'bg-green-100 border-dashed border border-green-500':''">
        <div v-for="file in files" :key="file" class="m-2">
          <Card style="width: 10rem; overflow: hidden;" class="fileDrop rounded-none" :title="file.path">
          <template #header>
              <div class="flex justify-end p-2">
                <i class="pi pi-times cursor-pointer text-[#EF4444]" @click="removeFile(file)"></i>
              </div>
          </template>
            <template #content>
              <div class="flex justify-center">
                <img v-if="file.type == 'application/pdf'" alt="pdf" src="../../assets/images/pdf-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'image/png' || file.type =='image/jpeg'" alt="pdf" src="../../assets/images/image-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'" alt="pdf" src="../../assets/images/excel-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'" alt="pdf" src="../../assets/images/word-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/vnd.openxmlformats-officedocument.presentationml.presentation'" alt="pdf" src="../../assets/images/pp-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'text/plain'" alt="pdf" src="../../assets/images/document-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/x-compressed'" alt="pdf" src="../../assets/images/rar-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/x-zip-compressed'" alt="pdf" src="../../assets/images/zip-64.png" class="max-w-[5rem] ">
                <img v-else alt="pdf" src="../../assets/images/file-64.png" class="max-w-[5rem] ">
              </div>
            </template>
            <template #footer>
               <div class="flex justify-center"><span class="whitespace-nowrap overflow-hidden text-ellipsis">{{ file.name }}</span></div>  
            </template>
        </Card>
        </div>
      </div>
      <Toast />
      <loading v-model:active="isLoading"
      :is-full-page="true" color="#3B82F6"/>
    </div>
  </template>
<script setup>
import { useDropzone } from "vue3-dropzone";
import { ref,onMounted } from "vue";
import {Folder} from '../../models/folder.js';
import {Document} from '../../models/document.js';
import { useToast } from "primevue/usetoast";
import Loading from 'vue-loading-overlay';
import { useDocument } from "~/stores/document";
import { useFolder } from "~/stores/folder";
const isLoading = ref(false);
onMounted(() => {   
    files.value = [];
});
const files = ref([]);
const fileSelects = ref([]);
const onDrop = (acceptFiles, rejectReasons)=> {
   acceptFiles.forEach(file => {
      files.value.push(file);
   })
}
const toast = useToast();
const dropzoneProps = useDropzone({ onDrop });
const getRootProps = dropzoneProps.getRootProps;
const getInputProps = dropzoneProps.getInputProps;
const rest = dropzoneProps;
const isDragActive = dropzoneProps.isDragActive;
const emit = defineEmits(['update:modelValue','parentFolderID','categoryID','openDocument','isLoading']);
 const props = defineProps(['parentFolderID','categoryID']);
 const parentID = ref(props.parentFolderID);
 const categoryID = ref(props.categoryID);
 watch(() => props.parentFolderID, (value) => {
   parentID.value = value;
 });
 watch(() => props.categoryID, (value) => {
   categoryID.value = value;
 });
const removeFile = (file) => {
   files.value = files.value.filter(item => item !== file);
}
const uploadFiles = async() => {
    isLoading.value = true;
   try{
        for (const file of files.value) {
        var praID = parentID.value;
        var folders = file.path.split("/").slice(1).slice(0, -1);
        for (const folder of folders) {
            try {
                const res = await useFolder().getByName(folder, praID, categoryID.value);
                if (!res) {
                    let newFolder = new Folder();
                    newFolder.name = folder;
                    newFolder.parentID = praID;
                    newFolder.categoryID = categoryID.value;
                    newFolder = await useFolder().create(newFolder);
                    // Cập nhật praID nếu cần
                    praID = newFolder.id;
                }else{ 
                    praID = res.id;
                }
            } catch (error) {
                console.error("Error:", error);
            }
        }
        var newFile = new Document();
                newFile.name = file.name;
                newFile.folderID = praID;
                newFile.categoryID = categoryID.value;
                newFile.fileExtension = file.name.split('.').pop();
                newFile.size = file.size;
                var formData = new FormData();
                formData.append('formFile', file);
                formData.append('jsonDocument', JSON.stringify(newFile));
                formData.append('folderID', praID);
               console.log(file);
               console.log(praID);
                var data = await useDocument().create(formData);
               
                if(typeof data === 'string'){
                    toast.add({ severity: 'warn', summary: 'Warn Message', detail: data, life: 5000 });
                }
        }
        var fd = {
            type:"folder",
            object:new Folder()
        }
        fd.object.id = parentID.value;
        fd.object.categoryID = categoryID.value;
        emit('openDocument',fd.object);
        useFolder().refreshFoldersByCategory(categoryID.value);
        emit('update:modelValue', false);
        toast.add({ severity: 'success', summary: 'Success Message', detail: 'Upload successfull!', life: 5000 });
   }catch(error){ 
        toast.add({ severity: 'error', summary: 'Error Message', detail: 'Upload fail!.', life: 5000 });
        console.log(error);
   }
   finally{
    isLoading.value = false;
   }
}
const removeAllFiles = () => {
   files.value = [];
}
const onUpload = (event) => {
    event.files.forEach(file => {
        file.path = file.name;
        files.value.push(file);
    });
}
</script>
<style>
  #map {
    height: 500px;
    width: 100%;
  }
  .fileDrop .p-card-body{
    padding: 0.5rem;
  }
  #chooseFile .p-button-label{
    display: none;

  }
  #chooseFile .p-fileupload-choose svg{
    margin: 0;
  }
  #chooseFile .p-fileupload-choose{
    width: 40px !important;
    height: 40px !important;
    border-radius: 500px;
    display: flex;
    justify-content: center;
    padding: 0;
    background: transparent;
    color: #3B82F6;
  }
  #chooseFile{
    width: 40px !important;
  }
</style>

