<template>
    <div class="flex flex-wrap w-full justify-center items-center" id="divGrid">
       <div class="w-full [px-1] h-full">
        <DataTable v-model:selection="selectedDocuments" paginator :rows="50" :selectAll="selectAll" v-model:filters="filters" scrollable class="text-xs" stripedRows editMode="cell" :value="documents" @select-all-change="onSelectAllChange"  @update:selection="onSelectionChange"  @cell-edit-complete="onCellEditComplete" @cell-edit-init="onCellEditInit" filterDisplay="row" :globalFilterFields="['object.name', 'object.description', 'object.revisionName', 'object.fromTo']" @filter="onFilter">
    <template #empty> No found. </template>
    <template #loading> Loading data. Please wait. </template>
    <Column selectionMode="multiple" headerStyle="width: 2rem" frozen>
    </Column>
    <Column style="min-width: 50px">
        <template #body="{data }">
            <i class="w-[16px] h-[16px] cursor-pointer pi pi-refresh" @click="onRestore(data.id,data.isFolder)" title="Restore"/>
        </template>
    </Column> 
    <Column style="min-width: 50px">
        <template #body="{data }">
            <i class="w-[16px] h-[16px] cursor-pointer pi pi-times" @click="onDelete(data.id,data.isFolder)" title="Delete"/>
        </template>
    </Column> 
    <Column style="min-width: 50px">
        <template #body="{data }">
            <i class="pi pi-folder cursor-pointer" v-if="data.isFolder"></i>
            <img v-else  :src="'/_nuxt/assets/'+data.fileExtensionIcon" class="w-[16px] h-[16px] cursor-pointer" />
        </template>
    </Column> 
    <Column header="Name" field="name"  style="min-width: 25rem">
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Description" field="title" style="min-width: 25rem" :rowEditor="false">
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Virual Path" field="vitualPath" style="min-width: 15rem">
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Date" field="lastUpdatedDate" style="min-width: 15rem">
        <template #body="{ data }">
            <div>{{data.lastUpdatedDate !=null? format(data.lastUpdatedDate, 'dd/MM/yyyy') :""}}</div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
        </template>
    </Column>
    <template #footer> <div class="w-full text-end">In total there are {{ countRows }} rows. </div></template>
</DataTable>
       </div>
       <!-- <div class="bg-[#3B82F6] text-[#ffffff] w-full h-[20px] flex items-center font-bold text-[17px] bottom-0 right-0 absolute p-5">
        <div class="w-full text-right">Total Row: {{ documents.length }}</div>
    </div> -->
<loading v-model:active="isLoading"
                 :is-full-page="true" color="#3B82F6"/>
<Toast /> 
    </div>
</template>
<script setup>
   import '../../assets/CSS/styleMain.css'
 import { ref, onMounted } from "vue";
 import {useBin} from '~/stores/bin';
 import { useToast } from "primevue/usetoast";
 import { FilterMatchMode,FilterOperator  } from 'primevue/api';
 import Loading from 'vue-loading-overlay';
 import { format } from 'date-fns';
 const documents = ref([]);
 const toast = useToast();
 const isLoading = ref(false);
 const countRows = ref(0);
 const filters = ref({
    global: { value: null, matchMode: FilterMatchMode.CONTAINS },
    'name': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'title': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'vitualPath': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'lastUpdatedDate': { value: null, matchMode: FilterMatchMode.CONTAINS }
});
 onMounted(async () => {
    isLoading.value = true;
    try{
        documents.value = await useBin().getAll();
    }
    catch(e){
        console.log(e);
        toast.add({ severity: 'error', detail: 'Load Fail!', summary: 'Error', life: 5000 });
    }
    finally{
        isLoading.value = false;
    }
 });
 const onDelete = async (id,isFolder) => {
    var ct = confirm("Are you sure you want to delete?");
    if (ct) {
        try{
            await useBin().delete(id,isFolder);
        documents.value = documents.value.filter(item => item.id != id);
        toast.add({ severity: 'success', detail: 'Delete Successfully', summary: 'Success', life: 5000 });
        }catch(e){
            toast.add({ severity: 'error', detail: 'Delete Fail!', summary: 'Error', life: 5000 });
        }
    }
 }
 const onRestore = async (id,isFolder) => {
    var ct = confirm("Are you sure you want to restore?");
    if (ct) {
        try{
            await useBin().restore(id,isFolder);
        documents.value = documents.value.filter(item => item.id != id);
        toast.add({ severity: 'success', detail: 'Restore Successfully', summary: 'Success', life: 5000 });
        }catch(e){
            toast.add({ severity: 'error', detail: 'Restore Fail!', summary: 'Error', life: 5000 });
        }
    }
 }
 const onFilter = (e) => {
    countRows.value = e.filteredValue.length;
 }
</script>
