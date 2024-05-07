<template>
    <div v-bind="getRootProps()">
      <div class="flex flex-wrap justify-between items-center flex-1 gap-2 p-2">
                    <div class="flex gap-2">
                        <Button icon="pi pi-images" rounded outlined></Button>
                        <Button icon="pi pi-cloud-upload" rounded outlined severity="success" :disabled="!files || files.length === 0"></Button>
                        <Button icon="pi pi-times" rounded outlined severity="danger" :disabled="!files || files.length === 0"></Button>
                    </div>
      </div>
      <div v-if="files.length === 0" class="flex items-center justify-center flex-col" :class="isDragActive?'bg-blue-100':''">
                    <i class="pi pi-cloud-upload border-2 border-circle p-5 text-8xl text-400 border-400" />
                    <p class="mt-4 mb-0">Drag and drop files to here to upload.</p>
      </div>
      <div v-else class="flex items-center justify-center flex-wrap" :class="isDragActive?'bg-blue-100':''">
        <div v-for="file in files" :key="file" class="m-2">
          <Card style="width: 10rem; overflow: hidden;" class="fileDrop rounded-none">
          <template #header>
              <div class="flex justify-end p-2">
                <i class="pi pi-times cursor-pointer text-[#EF4444]"></i>
              </div>
          </template>
            <template #content>
              <div class="flex justify-center">
                <img v-if="file.type == 'application/pdf'" alt="pdf" src="../assets/images/pdf-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'image/png' || file.type =='image/jpeg'" alt="pdf" src="../assets/images/image-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'" alt="pdf" src="../assets/images/excel-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'" alt="pdf" src="../assets/images/word-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/vnd.openxmlformats-officedocument.presentationml.presentation'" alt="pdf" src="../assets/images/pp-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'text/plain'" alt="pdf" src="../assets/images/document-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/x-compressed'" alt="pdf" src="../assets/images/rar-64.png" class="max-w-[5rem] ">
                <img v-else-if="file.type == 'application/x-zip-compressed'" alt="pdf" src="../assets/images/zip-64.png" class="max-w-[5rem] ">
                <img v-else alt="pdf" src="../assets/images/file-64.png" class="max-w-[5rem] ">
              </div>
            </template>
            <template #footer>
               <div class="flex justify-center"><span class="whitespace-nowrap overflow-hidden text-ellipsis">{{ file.name }}</span></div>  
            </template>
        </Card>
        </div>
      </div>
    </div>
  </template>
<script setup>

import { useDropzone } from "vue3-dropzone";
import { ref,onMounted } from "vue";
onMounted(() => {

});
const files = ref([]);
const onDrop = (acceptFiles, rejectReasons)=> {
   acceptFiles.forEach(file => {
      files.value.push(file);
   })
   console.log(files.value)
}
const dropzoneProps = useDropzone({ onDrop });
const getRootProps = dropzoneProps.getRootProps;
const getInputProps = dropzoneProps.getInputProps;
const rest = dropzoneProps;
const isDragActive = dropzoneProps.isDragActive;
</script>
<style>
  #map {
    height: 500px;
    width: 100%;
  }
  .fileDrop .p-card-body{
    padding: 0.5rem;
  }
</style>
