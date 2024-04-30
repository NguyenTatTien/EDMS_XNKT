<template>
<div class="h-full" id="content">
    <!-- <div>
        <Dropdown v-model="data.systemName" :options="systems" optionLabel="name" placeholder="Select group" class="border border-solid text-ellipsis w-[250px]" />
        <Dropdown v-model="data.disciplinesName" :options="discriplines" optionLabel="name" placeholder="Select group" class="border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
    </div> -->
     <DataTable paginator :rows="10" dataKey="id" scrollable filterDisplay="menu" v-model:selection="selectedManufacturers"
     :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" showGridlines stripedRows v-model:filters="filters" editMode="cell" :value="tabs" @cell-edit-complete="onCellEditComplete">
 <template #header>
     <div class="flex justify-between">
         <div class="flex w-[300px]">
            <Button icon="pi pi-plus" outlined label="Add New" class="border-[1px] border-solid" @click="visibleDialog = true" style="padding: 0.65625rem 1.09375rem"/>
         </div>
         <div>
            <Dropdown :options="systems" optionLabel="name" placeholder="Select system" class="border border-solid text-ellipsis w-[300px] h-[40px] mr-2" />
            <Dropdown :options="plants" optionLabel="name" placeholder="Select plant" class="border-[#cbd5e1] border border-solid text-ellipsis w-[300px] h-[40px]" />
         </div>
         <IconField iconPosition="left">
             <InputIcon>
                 <i class="pi pi-search" />
             </InputIcon>
             <InputText placeholder="Keyword Search" class="py-[0.5rem] px-[0.75rem] pl-[2.5rem]" v-model="filters['global'].value" style="padding-left: 2rem !important"/>
         </IconField>
     </div>
 </template>
 <template #empty> No found. </template>
 <template #loading> Loading data. Please wait. </template>
 <Column header="" style="min-width: 2rem">
     <template #body="{  }">
        <i class="pi pi-eye" style="color: #74C0FC;" @click="openSidebarRight('400px')"></i>
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
 </div>
 <div id="sidebarEdit" class="sidebarEdit"><TabTreeview/></div>
 <Dialog v-model:visible="visibleDialog" modal header="Create Tab" :style="{ width: '30rem' }">
 <TabCreate v-model="visibleDialog" :tabs="tabs"/>
</Dialog>
<Dialog v-model:visible="visibleInforMap" modal header="Infor Map" :style="{ width: '100rem' , height: '100rem' }">
    <InforMap/>
</Dialog>
</template>
<script setup>
//setlayout to system
 definePageMeta({
 layout: 'default'
 })
 import '../../assets/CSS/grid.css';
 import '../../assets/CSS/styleMain.css';
 import {tabGetAllAPI} from '../../api/tabAPI.js';
 import {FilterMatchMode} from 'primevue/api';
 import {plantGetAllAPI} from "../../api/plantAPI.js";
 import {systemGetAllAPI} from "../../api/systemAPI.js";
 import {openSidebarRight,closeSidebarRight} from '../../assets/js/sidebar.js';
 import '../../assets/css/sidebar.css';
 import { ref, onMounted } from 'vue';
 const tabs = ref(null);
 const visibleDialog = ref(false);
 const visibleInforMap = ref(false);
 const filters = ref({
     global: { value: null, matchMode: FilterMatchMode.CONTAINS },
     name: { value: null, matchMode: FilterMatchMode.CONTAINS },
     description: { value: null, matchMode: FilterMatchMode.CONTAINS },
     'manufacturer.name': { value: null, matchMode: FilterMatchMode.CONTAINS },
 });
 const plants = ref([]);
 const systems = ref([]);
 onMounted(async ()=>{
     try{
        getListTab();
        getPlants();
        getSystems();
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
 const getListTab = async () =>{
     try{
        tabs.value = await tabGetAllAPI();

     }catch(error){
         console.log("Error get list user:"+error);
     }
 }
 const onCellEditComplete = async (event) => {
 let { data, newValue, field,newData } = event;
 switch (field) {
     case "manufacturer.name":
          if (newData.manufacturer.name !=null && newData.manufacturer.name.trim().length > 0) {
             data["manufacturer"] = newData.manufacturer;
             data["manufacturerId"] = newData.manufacturer.id;
         }
         else event.preventDefault();
         break;
     default:
         if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
         break;
 }
 await updateModelAPI(data);
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
</script>
<style >
 .p-dialog-content{
    height: 100%;
 }
</style>
