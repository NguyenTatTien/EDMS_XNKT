<template>
  <div id="divGrid" style="padding-bottom: 0 !important;" v-bind="getRootProps()" class="flex items-center justify-center">
 <DataTable dataKey="id" scrollable 
            class="text-xs h-[100%]" showGridlines stripedRows :value="dataModel">
        
        <template #empty> No found. </template>
        <template #loading> Loading data. Please wait. </template>
        <Column style="min-width: 50px">
            <template #body="{data }">
                <img :src="'/_nuxt/assets/'+data.fileExtensionIcon" class="w-[16px] h-[16px] cursor-pointer" @click="openDocument(data)"/>
            </template>
        </Column>
        <Column field="name" header="Name" style="width: 17rem">
          <template #body="{ data }">
            <span class="no-underline text-gray-700" :title="data.vitualPath + '/' + data.name"><div>{{ data.name }} <img v-if="data.isNewFile"  src="../../../assets/images/new.png"/> <i v-if="!data.isHasFile" class="pi pi-exclamation-triangle text-[#ff9900]" title="File Not Found"/></div></span>
        </template>
        </Column>
        <Column header="Description" field="title" style="width: 20rem">
        </Column>
        <Column header="Create By Name" field="createdByName" style="width: 10rem">
    </Column> 
        <Column header="Date" field="createdDate" style="width: 10rem">
        </Column>
        <Column header="Virual Path" field="vitualPath" style="width: 17rem">
          <template #body="{ data }">
          <span class="no-underline text-gray-700"><div>{{data.vitualPath + '/' + data.name }}</div></span>
          </template>
    </Column>
    <template #footer> <div class="w-full text-end">In total there are {{ dataModel != undefined? dataModel.length:0 }} rows. </div></template>
    </DataTable>
    <Dialog v-model:visible="visibleViewFile" modal header=" " class="w-full h-full max-h-full" id="viewFile">
    <viewDocument :Id="ViewId" v-model="visibleViewFile"/>
</Dialog>
<loading v-model:active="isLoading"
                 :is-full-page="true" color="#3B82F6"/>
                 <Toast />
    </div>
  </template>
  <script setup>
  import {ref,onMounted,watch } from 'vue';
  import { useDocument } from '~/stores/document';
  import { useDropzone } from "vue3-dropzone";
  import { useFolder } from '~/stores/folder';
  import Loading from 'vue-loading-overlay';
  import Toast from 'primevue/toast';
  const emit = defineEmits(['update:modelValue']);
  const props = defineProps(['modelValue']);
  const object = ref(props.modelValue);
  const isLoading = ref(false);
  const dataModel = ref([]);
  const toast = useToast();
  const visibleViewFile = ref(false);
  const ViewId = ref("");
  const onDrop = (acceptFiles, rejectReasons)=> {
    uploadFiles(acceptFiles);
 }
 const uploadFiles = async(files) => {
    isLoading.value = true;
   try{
    var folder = await useFolder().getFolderById(object.value.folderID);
        for (const file of files) {
       
        var newFile = new Document();
                newFile.name = file.name;
                newFile.folderID = folder.id;
                newFile.categoryID = folder.categoryID;
                newFile.fileExtension = file.name.split('.').pop();
                newFile.size = file.size;
                var formData = new FormData();
                formData.append('formFile', file);
                formData.append('jsonDocument', JSON.stringify(newFile));
                formData.append('folderID', folder.id);
                var data = await useDocument().create(formData);
                if(typeof data === 'string'){
                    toast.add({ severity: 'warn', summary: 'Warn Message', detail: data, life: 5000 });
                }
        }
        getAllDocument();
        toast.add({ severity: 'success', summary: 'Success Message', detail: 'Upload successfull!', life: 5000 });
   }catch(error){ 
        toast.add({ severity: 'error', summary: 'Error Message', detail: 'Upload fail!.', life: 5000 });
        console.log(error);
   }
   finally{
    isLoading.value = false;
   }
}
 const dropzoneProps = useDropzone({ onDrop });
 const getRootProps = dropzoneProps.getRootProps;
 const getInputProps = dropzoneProps.getInputProps;
 const rest = dropzoneProps;
 onMounted(() => {
  object.value = props.modelValue;
  getAllDocument();
  });
  watch(() => props.modelValue, (value) => {
    object.value = value;
    getAllDocument();
  });
  const getAllDocument = async () => {
    dataModel.value = await useDocument().getDocumentByFolder(object.value.folderID);
  } 
  const openDocument = (data) => {
   
    if(data.isHasFile){
   
        ViewId.value = data.id;
        visibleViewFile.value = true;
   }else{
    toast.add({ severity: 'error', summary: 'Error Message', detail: "File Not Found!", life: 5000 });
   }
    
  }
  </script>
  <style>
  .editable-row-operations a {
    margin-right: 8px;
  }
  </style>