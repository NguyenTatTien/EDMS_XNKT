<template>
    <div v-bind="getRootProps()">
      <div class="flex flex-wrap justify-between items-center flex-1 gap-2 p-2">
                    <div class="flex gap-2">
                      <FileUpload mode="basic" ref="fileSelects" name="demo[]" icon="pi pi-cloud-upload" multiple="true" :maxFileSize="1000000" chooseLabel=" " @select="onUpload" id="chooseFile"/>
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
                <img v-if="file.type == 'application/pdf'" alt="pdf" src="../../../assets/images/pdf-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'image/png' || file.type =='image/jpeg'" alt="pdf" src="../../../assets/images/image-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'" alt="pdf" src="../../../assets/images/excel-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'" alt="pdf" src="../../../assets/images/word-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/vnd.openxmlformats-officedocument.presentationml.presentation'" alt="pdf" src="../../../assets/images/pp-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'text/plain'" alt="pdf" src="../../../assets/images/document-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/x-compressed'" alt="pdf" src="../../../assets/images/rar-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/x-zip-compressed'" alt="pdf" src="../../../assets/images/zip-64.png" class="max-w-[5rem] ">
                <img v-else alt="pdf" src="../../../assets/images/file-64.png" class="max-w-[5rem] ">
              </div>
            </template>
            <template #footer>
               <div class="flex justify-center"><span class="whitespace-nowrap overflow-hidden text-ellipsis">{{ file.name }}</span></div>  
            </template>
        </Card>
        </div>
      </div>
      <Toast />
    </div>
  </template>
<script setup>
import { useDropzone } from "vue3-dropzone";
import { ref,onMounted } from "vue";
import {useTag} from '~/stores/tag';
import {Folder} from '../../../models/folder.js';
import { useToast } from "primevue/usetoast";
onMounted(() => {
   
});
const isLoading = ref(false);
const files = ref([]);
const onDrop = (acceptFiles, rejectReasons)=> {
   acceptFiles.forEach(file => {
      files.value.push(file);
   })
}
const toast = useToast();
const fileSelects = ref([]);
const dropzoneProps = useDropzone({ onDrop });
const getRootProps = dropzoneProps.getRootProps;
const getInputProps = dropzoneProps.getInputProps;
const rest = dropzoneProps;
const isDragActive = dropzoneProps.isDragActive;
const emit = defineEmits(['update:modelValue','getListTag']);
const removeFile = (file) => {
   files.value = files.value.filter(item => item !== file);
}
const uploadFiles = async() => {
   try{
        const formData = new FormData();
        for (let i = 0; i < files.value.length; i++) {
            formData.append('files', files.value[i]);
        }
        await useTag().importData(formData);
        emit('update:modelValue', false);
        emit('getListTag');
        toast.add({ severity: 'success', summary: 'Success Message', detail: 'Import data successfull!', life: 5000 });
   }catch(error){ 
        toast.add({ severity: 'error', summary: 'Error Message', detail: 'Import fail!', life: 5000 });
        console.log(error);
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
    height: 100%;
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
