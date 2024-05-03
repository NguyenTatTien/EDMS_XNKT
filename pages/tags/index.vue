<template>
<div class="h-full">
    <!-- <div>
        <Dropdown v-model="data.systemName" :options="systems" optionLabel="name" placeholder="Select group" class="border border-solid text-ellipsis w-[250px]" />
        <Dropdown v-model="data.disciplinesName" :options="discriplines" optionLabel="name" placeholder="Select group" class="border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
    </div> -->
     <DataTable paginator :rows="10" dataKey="id" scrollable filterDisplay="menu"
     :globalFilterFields="['name', 'description','assetCode','plantName','systemName']" class="text-xs h-[100%]" showGridlines stripedRows v-model:filters="filters" editMode="cell" :value="tags" @cell-edit-complete="onCellEditComplete">
 <template #header>
     <div class="flex justify-between">
         <div class="flex w-[300px]">
            <!-- <Button icon="pi pi-" outlined label="Add New" class="border-[1px] border-solid h-[2.5rem]" style="padding: 0.65625rem 1.09375rem"/> -->
         </div>
         <div>
            <Dropdown :options="systems" v-model="selectSystem" optionLabel="name" placeholder="Select system" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px] mx-2" @change="onSelectSystem"/>
            <Dropdown :options="plants" v-model="selectPlant" optionLabel="name" placeholder="Select plant" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px] mx-2" @change="onSelectPlant"/>
         </div>
        <div class="flex justify-between items-center">
            <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="visibleDialog = true"/>
            <Button icon="pi pi-cloud-download" class="mr-2 h-[2rem]" @click="exportExcel"/>
            <Button icon="pi pi-cloud-upload" class="mr-2 h-[2rem]"/>
            <IconField iconPosition="left">
                <InputIcon>
                    <i class="pi pi-search" />
                </InputIcon>
                <InputText placeholder="Keyword Search" class="py-[0.5rem] px-[0.75rem] pl-[2.5rem]" v-model="filters['global'].value" style="padding-left: 2rem !important"/>
            </IconField>
         </div>
     </div>
 </template>
 <template #empty> No found. </template>
 <template #loading> Loading data. Please wait. </template>
 <Column header="" style="min-width: 1rem">
     <template #body="{ data }">
        <i class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="onDeleteTag(data.id)"></i>
     </template>
 </Column>
 <Column header="" style="min-width: 1rem">
     <template #body="{ data }">
        <i class="pi pi-eye cursor-pointer" style="color: #74C0FC;" @click="onOpenTag(data)"></i>
     </template>
 </Column>
 <Column field="name" header="Name" style="min-width: 12rem">
     <template #editor="{ data }">
         <InputText v-model="data.name" autofocus />
     </template>
     <template #filter="{ filterModel, filterCallback }">
         <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
     </template>
 </Column>
 <Column header="Description" field="description" style="min-width: 12rem">
     <template #editor="{ data }">
         <InputText v-model="data.description" autofocus />
     </template>
     <template #filter="{ filterModel, filterCallback }">
         <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
     </template>
 </Column>
 <Column header="Asset" field="assetCode" style="min-width: 12rem">
     <template #editor="{ data }">
         <InputText v-model="data.assetCode" autofocus />
     </template>
     <template #filter="{ filterModel, filterCallback }">
         <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
     </template>
 </Column>
 <Column header="System" field="systemName" style="min-width: 12rem">
     <template #editor="{ data }">
        <Dropdown v-model="data.systemName" editable :options="systems" optionLabel="name" placeholder="Select system" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
     <template #filter="{ filterModel, filterCallback }">
         <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
     </template>
 </Column>
 <Column header="Plant" field="plantName" style="min-width: 12rem">
     <template #editor="{ data }">
        <Dropdown v-model="data.plantName" editable :options="plants" optionLabel="name" placeholder="Select descipline" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
     <template #filter="{ filterModel, filterCallback }">
         <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
     </template>
 </Column>
</DataTable>
<div id="sidebarEdit" class="sidebarEdit"><TagTreeview :treeTag="treeTag"/></div>
 <Dialog v-model:visible="visibleDialog" modal header="Create Tag" :style="{ width: '30rem' }">
 <TagCreate v-model="visibleDialog" :tags="tags"/>
</Dialog>
 </div>

</template>
<script setup>
//setlayout to system
 definePageMeta({
 layout: 'default'
 })
 import '../../assets/CSS/grid.css';
 import '../../assets/CSS/styleMain.css';
 import {tagGetAllAPI,updateTagAPI,deleteTagAPI} from '../../api/tagAPI.js';
 import {getDocumentByTagAPI} from '../../api/documentAPI.js';
 import {FilterMatchMode} from 'primevue/api';
 import {plantGetAllAPI} from "../../api/plantAPI.js";
 import {systemGetAllAPI} from "../../api/systemAPI.js";
 import {openSidebarRight,closeSidebarRight} from '../../assets/js/sidebar.js';
 import '../../assets/css/sidebar.css';
 import { ref, onMounted } from 'vue';
 const tags = ref(null);
 const tags_temp = ref(null);
 const visibleDialog = ref(false);
 const visibleInforMap = ref(false);
 const treeTag = ref(null);
 const filters = ref({
     global: { value: null, matchMode: FilterMatchMode.CONTAINS },
     name: { value: null, matchMode: FilterMatchMode.CONTAINS },
     description: { value: null, matchMode: FilterMatchMode.CONTAINS },
     plantName: { value: null, matchMode: FilterMatchMode.CONTAINS },
     systemName: { value: null, matchMode: FilterMatchMode.CONTAINS },
 });
 const plants = ref([]);
 const systems = ref([]);
 const documents = ref([]);
 const selectPlant = ref();
 const selectSystem = ref();
 onMounted(async ()=>{
     try{
        await getListTag();
        await getPlants();
        await getSystems();
        tags_temp.value = tags.value;
     }catch(error){
         console.log("Error get list manufacturer:"+error);
     }
 });
 const getPlants = async () =>{
     try{
        plants.value = await plantGetAllAPI();
     }catch(error){
         console.log("Error get list discriplines:"+error);
     }
 }
 const getSystems = async () =>{
     try{
        systems.value = await systemGetAllAPI();
     }catch(error){
         console.log("Error get list systems:"+error);
     }
 }
 const getListTag = async () =>{
     try{
        tags.value = await tagGetAllAPI();

     }catch(error){
         console.log("Error get list user:"+error);
     }
 }
 const onCellEditComplete = async (event) => {
 let { data, newValue, field,newData } = event;
 switch (field) {
     case "systemName":
          if (newValue !=null && newValue) {
             data["systemName"] = newValue.name;
             data["systemID"] = newValue.id;
         }
         else event.preventDefault();
         break;
    case "plantName":
          if (newValue !=null && newValue) {
             data["plantName"] = newValue.name;
             data["plantID"] = newValue.id;
         }
         else event.preventDefault();
         break;
     default:
         if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
         break;
 }
 await updateTagAPI(data);
}
const deleteModel = async (id) => {
 try{
     var st = confirm("Do you want to delete this model?");
         if (st) {
             await deleteModelAPI(id);
             models.value = models.value.filter(item => item.id !== id);
         }
 }catch(error){
     console.log(error);
 }
}
const onOpenTag = async (data) => {
    var menu = [
    {
        label: data.plantName,
        icon: 'pi pi-graduation-cap',
        items: [
            {
                label: data.name,
                icon: 'pi pi-graduation-cap',
                type: '',
                items: [
                    {
                        label: 'Design Document',
                        icon: 'pi pi-file',
                        type: '',
                        items:null
                    },
                    {
                        label: 'Vendor Document',
                        icon: 'pi pi-file',
                        type: '',
                        items:null
                    },
                    
                    {
                        label: 'O&M Document',
                        icon: 'pi pi-file',
                        type: '',
                        items:null
                    }
                ]
            },
            
        ]
    }
    ];
    await getDocumentByTag(data.id,menu);
    treeTag.value = menu;
    
    openSidebarRight('400px');
}
const getDocumentByTag = async (id,items) =>{
    try{
        documents.value = await getDocumentByTagAPI(id);
        if(documents.value.filter(p => p.documentTypeID == 1).length>0){
            items[0].items[0].items[0].items = [];
            documents.value.filter(p => p.documentTypeID == 1).forEach(element => {
          
            items[0].items[0].items[0].items.push({
                label: element.name,
                icon: element.fileExtensionIcon,
                type:"document",
            });
        });
        }
        
        if(documents.value.filter(p => p.documentTypeID == 2).length>0){
            items[0].items[0].items[1].items = [];
            documents.value.filter(p => p.documentTypeID == 2).forEach(element => {
           
            items[0].items[0].items[1].items.push({
                label: element.name,
                icon: element.fileExtensionIcon,type:"document",});
        });
        }
        if(documents.value.filter(p => p.documentTypeID == 3).length>0){
            items[0].items[0].items[2].items = [];
            documents.value.filter(p => p.documentTypeID == 3).forEach(element => {
            items[0].items[0].items[2].items.push({
                label: element.name,
                icon: element.fileExtensionIcon,type:"document",items:null});
        });
        }
      
       
    }catch(error){
        console.log(error);
    }
}
const onDeleteTag = async (id) => {
    try{
        var st = confirm("Do you want to delete this tag?");
            if (st) {
                await deleteTagAPI(id);
                tags.value = tags.value.filter(item => item.id !== id);
            }
    }catch(error){
        console.log(error);
    }
}
const onSelectPlant = async (data) => {
    tags.value = tags_temp.value.filter(p => p.plantId == selectPlant.value.id);
}
const onSelectSystem = async (data) => {
    tags.value = tags_temp.value.filter(p => p.systemId == selectSystem.value.id);
}
const exportExcel = async () => {
    var a = document.createElement('A');
    a.href = '_nuxt/assets/Export/exportDocument.xls';
    a.download = 'exportDocument.xls';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}
</script>
<style >
 .p-dialog-content{
    height: 100%;
 }
 .p-icon-field{
    height: fit-content;
 }
</style>
