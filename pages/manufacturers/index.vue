<template>
     <div class="w-full h-full">
        <DataTable paginator :rows="10" dataKey="id" scrollable filterDisplay="menu" v-model:selection="selectedManufacturers"
        :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" showGridlines stripedRows v-model:filters="filters" editMode="cell" :value="manufacturers" @cell-edit-complete="onCellEditComplete">
    <template #header>
        <div class="flex justify-between">
            <div class="flex w-[300px]">
                <!-- <Button icon="pi pi-plus" label="Add New" class="border-[1px] border-solid h-[2.5rem]" @click="visibleDialog = true" style="padding: 0.65625rem 1.09375rem"/> -->
                <!-- <Button icon="pi pi-plus" label="Add" class="bg-[#3B82F6] text-white px-4" @click="visibleDialog = true"/>
                <FileUpload mode="basic" accept="image/*" :maxFileSize="1000000" label="Import" chooseLabel="Import" class="inline-block text-[12px]" />
                <Button label="Export" icon="pi pi-upload" severity="help" class="bg-[#3B82F6] text-white px-4"/> -->
            </div>
            <div class="flex justify-between items-center">
            <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="visibleDialog = true"/>
            <Button icon="pi pi-cloud-download" class="mr-2 h-[2rem]"/>
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
    <!-- <Column class="w-[50px]">
        <template #body="{ data }">
            <img src="/_nuxt/assets/images/delete.png" class="w-[16px] h-[16px] cursor-pointer" @click="deleteManufacturer(data.id)">
        </template>
    </Column> -->
    <Column header="" style="width: 2rem">
     <template #body="{  }">
        <i class="pi pi-times cursor-pointer" style="color: #EF4444;"></i>
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
</DataTable>
<Dialog v-model:visible="visibleDialog" modal header="Create Manufacturer" :style="{ width: '30rem' }">
    <ManufacturerCreate v-model="visibleDialog" :manufacturers="manufacturers"/>
</Dialog>
    </div>

</template>

<script setup>
definePageMeta({
  layout: 'default'
})
    import '../../assets/CSS/grid.css';
    import '../../assets/CSS/styleMain.css';
    import {manufacturerGetAllAPI,updateManufacturerAPI,deleteManufacturerAPI} from '../api/manufacturerApi.js';
    import {FilterMatchMode} from 'primevue/api';
    import { ref , onMounted } from 'vue';
    const manufacturers = ref(null);
    const visibleDialog = ref(false);
    const selectedManufacturers = ref();
    const filters = ref({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
        name: { value: null, matchMode: FilterMatchMode.CONTAINS },
        description: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });
    onMounted(async ()=>{
        getListManufacturer();
    })
    const getListManufacturer = async () =>{
        try{
            manufacturers.value = await manufacturerGetAllAPI();
        }catch(error){
            console.log("Error get list user:"+error);
        }
    }
    const onCellEditComplete = async (event) => {
    let { data, newValue, field } = event;
    switch (field) {
        default:
            if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
            break;
    }
    await updateManufacturerAPI(data);
}
const deleteManufacturer = async (id) =>{
    try{
        var st = confirm("Do you want to delete this manufacturer?");
        if(st){
            await deleteManufacturerAPI(id);
            manufacturers.value = manufacturers.value.filter(item => item.id !== id);
        }
    }catch(error){
        console.log(error);
    }
}
</script>
