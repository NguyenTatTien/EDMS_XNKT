<template>
<div class="flex flex-wrap w-full justify-center items-center" id="divGrid">
 <div class="flex w-full h-full">
    <div class="flex-1 flex flex-row">
    <DataTable paginator v-model:selection="selectedTags" :rows="50" dataKey="id" scrollable filterDisplay="row" id="tbTags"
     :globalFilterFields="['name', 'description','assetCode','plantName','systemName']" class="text-xs h-[100%]" showGridlines stripedRows v-model:filters="filters" editMode="cell" :value="tags" @cell-edit-complete="onCellEditComplete" @filter="onFilter">
 <template #header>
     <div class="flex justify-end">
         <div>
            <!-- <Dropdown :options="systems" v-model="selectSystem" optionLabel="name" placeholder="Select system" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px] mx-2" @change="onSelectSystem"/>
            <Dropdown :options="plants" v-model="selectPlant" optionLabel="name" placeholder="Select plant" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px] mx-2" @change="onSelectPlant"/> -->
         </div>
        <div class="flex justify-between items-center">
            <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="visibleDialog = true"/>
            <Button icon="pi pi-cloud-download" class="mr-2 h-[2rem]" @click="exportExcel"/>
          
            <!-- <Button icon="pi pi-cloud-upload" class="mr-2 h-[2rem]"/> -->
            <FileUpload mode="basic" name="demo[]" url="/api/upload" accept=".xls,.xlsx" :maxFileSize="1000000" chooseLabel=' ' chooseIcon="pi pi-cloud-upload" uploadIcon="pi pi-cloud-upload" class="mr-2 h-[2rem] flex justify-center" id="importTag" @select="importTag"/>
            <Button icon="pi pi-spin pi-cog" class="mr-2 h-[2rem] bg-[#4410b9]" @click="toggleConf" />
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
 <Column selectionMode="multiple" headerStyle="width: 2rem" frozen>
    </Column>
 <Column header="" style="min-width: 1rem">
     <template #body="{ data }">
        <i v-if="user.roleId==1" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="onDeleteTag(data.id)"></i>
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
         <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by asset" />
     </template>
 </Column>
 <Column header="System" field="systemID" style="min-width: 12rem">
        <template #body="{ data }">
            <div>{{ data.systemName }}</div>
        </template>
     <template #editor="{ data }">
        <Dropdown v-model="data.systemID" editable showClear :options="systems" optionLabel="name" optionValue="id" placeholder="Select system" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
     <template #filter="{ filterModel, filterCallback }">
        <Dropdown v-model="filterModel.value" editable :showClear="true"  @change="()=>filterCallback()" :options="systems" optionLabel="name" optionValue="id" placeholder="Select system" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
 </Column>
 <Column header="PlatForm" field="plantID" style="min-width: 12rem">
    <template #body="{ data }">
            <div>{{ data.plantName }}</div>
    </template>
     <template #editor="{ data }">
        <Dropdown v-model="data.plantID" showClear editable :options="plants" optionLabel="name" optionValue="id" placeholder="Select platform" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
     <template #filter="{ filterModel, filterCallback }">
        <Dropdown v-model="filterModel.value" editable :showClear="true" :options="plants" @change="()=>{console.log(filterModel.value); filterCallback()}" optionLabel="name" optionValue="id" placeholder="Select platform" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
 </Column>
 <template #footer> <div class="w-full text-end">In total there are {{ countRows }} rows. </div></template>
</DataTable>
<div id="sidebarEdit" class="sidebarEdit" style="width: 300px;"><ClientOnly><TagTreeview :selectTag="selectTag"/></ClientOnly></div>
   </div>
 </div>
 <Dialog v-model:visible="visibleDialog" modal header="Create Tag" :style="{ width: '30rem' }">
 <TagCreate v-model="visibleDialog" :tags="tags"/>
</Dialog>
<Dialog v-model:visible="visibleDialogImport" modal header="Import Tag" :style="{ width: '50rem' }">
 <TagImport v-model="visibleDialogImport" @getListTag="getListTag"/>
</Dialog>
<Toast />
<Menu ref="menuConf" id="overlay_menu" :model="itemConfMenus" :popup="true">
        <template #item="{ item, props }">
            <a v-ripple class="flex align-items-center" v-bind="props.action" v-if="item.visible">
                <span :class="item.icon" />
                <span class="ml-2">{{ item.label }}</span>
            </a>
        </template>
</Menu>
<loading v-model:active="isLoading"
                 :is-full-page="true" color="#3B82F6"/>
 </div>
</template>
<script setup>
//setlayout to system
 definePageMeta({
 layout: 'default'
 })
 import '../../assets/CSS/grid.css';
 import '../../assets/CSS/styleMain.css';
 import {useTag} from '~/stores/tag';
 import {FilterMatchMode} from 'primevue/api';
 import { usePlatForm } from '~/stores/platForm';
 import { useSystem } from '~/stores/system';
 import {openSidebarRight,closeSidebarRight} from '../../assets/js/sidebar.js';
 import Loading from 'vue-loading-overlay';
 import '../../assets/css/sidebar.css';
 import { useToast } from "primevue/usetoast";
 import { ref, onMounted } from 'vue';
 import moment from 'moment';
 import {useUser} from '~/stores/user';
 const user = useUser().getUser();
 const isLoading = ref(false);
 const toast = useToast();
 const tags = ref([]);
 const tags_temp = ref(null);
 const selectedTags = ref([]);
 const visibleDialog = ref(false);
 const visibleInforMap = ref(false);
 const visibleDialogImport = ref(false);
 const selectTag = ref(null);
 const countRows = ref(0);
 const filters = ref({
     global: { value: null, matchMode: FilterMatchMode.CONTAINS },
     name: { value: null, matchMode: FilterMatchMode.CONTAINS },
     description: { value: null, matchMode: FilterMatchMode.CONTAINS },
     assetCode: { value: null, matchMode: FilterMatchMode.CONTAINS },
     plantID: { value: null, matchMode: FilterMatchMode.EQUALS },
     systemID: { value: null, matchMode: FilterMatchMode.EQUALS },
 });
 const plants = ref([]);
 const systems = ref([]);
 const selectPlant = ref();
 const selectSystem = ref();
 const itemConfMenus = ref([
     {
         label: 'Export data',
         icon: 'pi pi-file-export',
         visible: true,
         command:() => {
              exportDataTag()
           //  exportDocument();
         }
     },
     {
         label: 'Import data',
         icon: 'pi pi-file-import',
         visible: true,
         command: () => {
             
             visibleDialogImport.value = true;
         }
     },
  ]);
  const menuConf = ref();    
 onMounted(async ()=>{
    isLoading.value = true;
     try{
        closeSidebarRight();
        await getListTag();
        await getPlants();
        await getSystems();
        tags_temp.value = tags.value;
     }catch(error){
         console.log("Error get list manufacturer:"+error);
     }finally{
         isLoading.value = false;
     }
 });
 const getPlants = async () =>{
     try{
        plants.value = await usePlatForm().getAll();
    
     }catch(error){
         console.log("Error get list discriplines:"+error);
     }
 }
 const getSystems = async () =>{
     try{
        systems.value = await useSystem().getAll();
     }catch(error){
         console.log("Error get list systems:"+error);
     }
 }
 const getListTag = async () =>{
     try{
        tags.value = await useTag().getAll();
     }catch(error){
         console.log("Error get list user:"+error);
     }
 }
 const onCellEditComplete = async (event) => {
 let { data, newValue, field,newData } = event;
 switch (field) {
     case "systemID":
            var system = systems.value.filter(x => x.id == newValue)[0];
            data.systemID = system.id;
            data.systemName = system.name;
         break;
    case "plantID":
            var plant = plants.value.filter(x => x.id == newValue)[0];
            data.plantID = plant.id;
            data.plantName = plant.name;
         break;
     default:
         if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
         break;
 }
 await useTag().update(data);
}
const onOpenTag = (data) => {
    console.log(data);
    selectTag.value = data;
    openSidebarRight('400px');
}
const onDeleteTag = async (id) => {
    try{
        var st = confirm("Do you want to delete this tag?");
            if (st) {
                await useTag().delete(id);
                tags.value = tags.value.filter(item => item.id !== id);
                toast.add({ severity: 'success', summary: 'Delete successfully!', detail: 'Success', life: 5000 });
            }
    }catch(error){
        toast.add({ severity: 'error', summary: 'Delete fail!', detail: 'Error', life: 5000 });
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
    var response = await useTag().export();
    const link = document.createElement('a');
    link.href = response;
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
    
}
const toggleConf = (event) => {
     menuConf.value.toggle(event);
};
const importTag= async(e)=>{
   isLoading.value = true;
    try{
        var file = e.files[0];
   var fromData = new FormData();
   fromData.append("formFile",file);
   await useTag().import(fromData);
   await getListTag();
   toast.add({ severity: 'success', summary: 'Import successfully!', detail: 'Success', life: 5000 });
    }catch(error){
        
    }finally{
        isLoading.value = false;
    }
}
const exportDataTag = async()=>{
    if(selectedTags.value.length==0){
        toast.add({ severity: 'error', summary: 'Error', detail: 'Please select tag!', life: 5000 });
        return;
    }
    var response = await useTag().exportData(selectedTags.value);
    const link = document.createElement('a');
    link.href = response;
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
}
const onFilter = async (value) => {
   countRows.value = value.filteredValue.length;
}
</script>
<style>
 .p-dialog-content{
    height: 100%;
 }
 .p-icon-field{
    height: fit-content;
 }
 #tbTabs{
    width: 100%;
    flex: 1 1 auto;
 }
 #importTag {
    width: 40px !important;
    margin-right: 0.5rem;
 }
 #importTag .p-fileupload-choose{
    width: 40px !important;
 }
 #importTag .p-button-icon {
        margin-right: 0;
}
#importTag .p-button-label{
    display: none;
}
#tbTags{
    width: 0 !important;
    flex: 1 1 0% !important;

}
.p-fileupload{
    width: 40px !important;
}
</style>
