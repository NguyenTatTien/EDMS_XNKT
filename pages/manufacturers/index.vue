<template>
     <div class="w-full h-full justify-center items-center" id="divGrid">
        <DataTable paginator :rows="50" dataKey="id" scrollable filterDisplay="row" v-model:selection="selectedManufacturers"
        :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" showGridlines stripedRows v-model:filters="filters" editMode="cell" :value="manufacturers" @cell-edit-complete="onCellEditComplete" @filter="onFilter">
    <template #header>
        <div class="flex justify-end">
            <div class="flex justify-between items-center">
            <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="visibleDialog = true"/>
            <Button icon="pi pi-cloud-download" class="mr-2 h-[2rem]" @click="exportManufacturer"/>
            <FileUpload mode="basic" name="demo[]" url="/api/upload" accept=".xls,.xlsx" :maxFileSize="1000000" chooseLabel=' ' chooseIcon="pi pi-cloud-upload" uploadIcon="pi pi-cloud-upload" class="mr-2 h-[2rem] flex justify-center" id="importHeader" @select="importManufacturer"/>
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
    <!-- <Column class="w-[50px]">
        <template #body="{ data }">
            <img src="/_nuxt/assets/images/delete.png" class="w-[16px] h-[16px] cursor-pointer" @click="deleteManufacturer(data.id)">
        </template>
    </Column> -->
    <Column header="" style="width: 2rem">
     <template #body="{ data }">
        <i v-if="user.roleId==1" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="deleteManufacturer(data.id)"></i>
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
    <template #footer> <div class="w-full text-end">In total there are {{ countRows }} rows. </div></template>
</DataTable>
<!-- <div class="bg-[#3B82F6] text-[#ffffff] w-full h-[20px] flex items-center font-bold text-[17px] bottom-0 right-0 absolute p-5">
        <div class="w-full text-right">Total Row: {{ manufacturers.length }}</div>
    </div> -->
<Dialog v-model:visible="visibleDialog" modal header="Create Manufacturer" :style="{ width: '30rem' }">
    <ManufacturerCreate v-model="visibleDialog" :manufacturers="manufacturers"/>
</Dialog>
<Toast />
<loading v-model:active="isLoading"
                 :is-full-page="true" color="#3B82F6"/>
    </div>

</template>

<script setup>
definePageMeta({
  layout: 'default'
})
    import '../../assets/CSS/grid.css';
    import '../../assets/CSS/styleMain.css';
    import { useManufacturer } from '~/stores/manufacturer';
    import {FilterMatchMode} from 'primevue/api';
    import { ref , onMounted } from 'vue';
    import { useToast } from "primevue/usetoast";
        import moment from 'moment';
        import loading from 'vue-loading-overlay';
        import {useUser} from '~/stores/user';
        const user = useUser().getUser();
        const isLoading = ref(false);
        const toast = useToast();
    const manufacturers = ref([]);
    const visibleDialog = ref(false);
    const selectedManufacturers = ref();
    const countRows = ref(0);
    const filters = ref({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
        name: { value: null, matchMode: FilterMatchMode.CONTAINS },
        description: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });
    onMounted(async ()=>{
        getListManufacturer();
    })
    const getListManufacturer = async () =>{
        isLoading.value = true;
        try{
            manufacturers.value = await useManufacturer().getAll();
        }catch(error){
            console.log("Error get list user:"+error);
        }finally{
            isLoading.value = false;
        }
    }
    const onCellEditComplete = async (event) => {
    let { data, newValue, field } = event;
    switch (field) {
        default:
            if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
            break;
    }
    await useManufacturer().update(data);
}
const deleteManufacturer = async (id) =>{
    try{
        var st = confirm("Do you want to delete this manufacturer?");
        if(st){
            await useManufacturer().delete(id);
            manufacturers.value = manufacturers.value.filter(item => item.id !== id);
        }
    }catch(error){
        console.log(error);
    }
}
const exportManufacturer = async() => {
    var response = await useManufacturer().export();
    const link = document.createElement('a');
    link.href = response;
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
   }
   const importManufacturer =async (e) => {
    isLoading.value = true;
      try{
        var file = e.files[0];
        var fromData = new FormData();
        fromData.append("formFile",file);
        await useManufacturer().import(fromData);
        await getListManufacturer();
        toast.add({ severity: 'success', detail: 'Import successfully!', summary: 'Success', life: 5000 });
      }catch(error){
        console.log(error);
      }finally{
        isLoading.value = false;
      }
   }
   const onFilter = (value) => {
    countRows.value = value.filteredValue.length;
}
</script>
<style>
   #importHeader{
    width: 40px !important;
    margin-right: 0.5rem;
 }
 #importHeader .p-fileupload-choose{
    width: 40px !important;
 }
 #importHeader .p-button-icon {
        margin-right: 0;
}
#importHeader .p-button-label{
    display: none;
}
</style>
