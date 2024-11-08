<template>
   <div class="w-full h-full justify-center items-center" id="divGrid">
        <DataTable paginator :rows="50" dataKey="id" scrollable filterDisplay="row" v-model:selection="selectedManufacturers"
        :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" showGridlines stripedRows v-model:filters="filters" editMode="cell" :value="models" @cell-edit-complete="onCellEditComplete" @filter="onFilter">
    <template #header>
        <div class="flex justify-end">
            
            <div class="flex justify-between items-center">
            <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="visibleDialog = true"/>
            <Button icon="pi pi-cloud-download" class="mr-2 h-[2rem]" @click="exportModels"/>
            <FileUpload mode="basic" name="demo[]" url="/api/upload" accept=".xls,.xlsx" :maxFileSize="1000000" chooseLabel=' ' chooseIcon="pi pi-cloud-upload" uploadIcon="pi pi-cloud-upload" class="mr-2 h-[2rem] flex justify-center" id="importHeader" @select="importModels"/>
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
     <template #body="{data}">
        <i v-if="user.roleId ==1" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="deleteModel(data.id)"></i>
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
    <Column header="Manufacturer" field="manufacturer.name" style="min-width: 12rem">
        <template #editor="{ data }">
            <Dropdown v-model="data.manufacturer" editable :options="manufacturers" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
            <!-- <InputText v-model="data.role.name" autofocus /> -->
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by created" />
        </template>
    </Column>
    <template #footer> <div class="w-full text-end">In total there are {{ countRows }} rows. </div></template>
</DataTable>
<!-- <div class="bg-[#3B82F6] text-[#ffffff] w-full h-[20px] flex items-center font-bold text-[17px] bottom-0 right-0 absolute p-5">
        <div class="w-full text-right">Total Row: {{ models.length }}</div>
    </div> -->
<Dialog v-model:visible="visibleDialog" modal header="Create Model" :style="{ width: '30rem' }">
    <ModelCreate v-model="visibleDialog" :models="models"/>
</Dialog>
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
    import {useModel} from '~/stores/model';
    import { useManufacturer } from '~/stores/manufacturer';
    import {FilterMatchMode} from 'primevue/api';
    import { ref, onMounted } from 'vue';
    import { useToast } from "primevue/usetoast";
        import moment from 'moment';
        import loading from 'vue-loading-overlay';
        import {useUser} from '~/stores/user';
        const user = useUser().getUser();
        const isLoading = ref(false);
        const toast = useToast();
        const countRows = ref(0);
    const models = ref([]);
    const visibleDialog = ref(false);
    const selectedModels = ref();
    const filters = ref({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
        name: { value: null, matchMode: FilterMatchMode.CONTAINS },
        description: { value: null, matchMode: FilterMatchMode.CONTAINS },
        'manufacturer.name': { value: null, matchMode: FilterMatchMode.CONTAINS },
    });
    const manufacturers = ref();
    onMounted(async ()=>{
        isLoading.value = true;
        try{
            await getListModel();
            manufacturers.value = await useManufacturer().getAll();
        }catch(error){
            console.log("Error get list manufacturer:"+error);
        }
        finally{
            isLoading.value = false;
        }
    });
    const getListModel = async () =>{
        try{
            models.value = await useModel().getAll();

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
    await useModel().update(data);
}
const deleteModel = async (id) => {
    try{
        var st = confirm("Do you want to delete this model?");
            if (st) {
                await useModel().delete(id);
                models.value = models.value.filter(item => item.id !== id);
                toast.add({ severity: 'success', detail: 'Delete successfully!', summary: 'Success', life: 5000 });
            }
    }catch(error){
        console.log(error);
        toast.add({ severity: 'error', detail: 'Delete fail!', summary: 'Success', life: 5000 });
    }
}
const exportModels = async() => {
    var response = await useModel().export();
    const link = document.createElement('a');
    link.href = response;
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
   }
   const importModels =async (e) => {
    isLoading.value = true; 
        try{
            var file = e.files[0];
        var fromData = new FormData();
        fromData.append("formFile",file);
        await useModel().import(fromData);
        await getListModel();
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