<template>
  

<div class="w-full h-full ">
    <DataTable paginator :rows="10" dataKey="id" scrollable filterDisplay="menu"
        :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" showGridlines stripedRows v-model:filters="filters" v-model:selection="selectedDocuments" editMode="cell" :value="documents" @cell-edit-complete="onCellEditComplete">
    <template #header>
        <div class="flex justify-between">
            <div class="flex w-[300px]">
               
            </div>
            <IconField iconPosition="left">
                <InputIcon>
                    <i class="pi pi-search" />
                </InputIcon>
                <InputText placeholder="Keyword Search" class="py-[0.5rem] px-[0.75rem] pl-[2.5rem]" v-model="filters['global'].value"/>
            </IconField>
        </div>
    </template>
    <template #empty> No found. </template>
    <template #loading> Loading data. Please wait. </template>
    <Column selectionMode="multiple" headerStyle="width: 1rem"></Column>
    <Column style="min-width: 50px">
        <template #body="{ }">
            <i class="fa-solid fa-download fa-lg cursor-pointer" style="color: #25b187;"></i>
        </template>
    </Column>
    <Column style="min-width: 50px">
        <template #body="{data }">
            <img :src="'/_nuxt/assets/'+data.fileExtensionIcon" class="w-[16px] h-[16px] cursor-pointer" @click="openDocument(data)"/>
        </template>
    </Column>
    <Column field="name" header="Name" style="min-width: 20rem">
        <template #body="{ data }">
            <div @contextmenu="onRightClick" @click="openDocument(data)" class="cursor-pointer">{{ data.name }}</div>
        </template>
        <template #editor="{ data }">
            <InputText v-model="data.name" autofocus />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
        </template>
    </Column>
    <Column header="Description" field="description" style="min-width: 20rem">
        <template #editor="{ data }">
            <InputText v-model="data.description" autofocus />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
        </template>
    </Column>
    <Column header="Tag" field="tag" style="min-width: 12rem">
        <template #editor="{ data }">
            <Dropdown v-model="data.tag" editable :options="tabs" optionLabel="name" placeholder="Select group" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by tag" />
        </template>
    </Column>
    <Column header="Discipline" field="disciplineName" style="min-width: 12rem">
        <template #editor="{ data }">
            <Dropdown v-model="data.disciplineName" editable :options="disciplines" optionLabel="name" placeholder="Select group" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
        </template>
        <template #filter="{filterModel, filterCallback}">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by discipline" />
        </template>
    </Column>
    <Column header="Document Type" field="documentTypeName" style="min-width: 12rem">
        <template #editor="{ data }">
            <Dropdown v-model="data.documentTypeName" editable :options="documentTypes" optionLabel="name" placeholder="Select group" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
        </template>
        <template #filter="{filterModel, filterCallback}">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by document type" />
        </template>
    </Column>
    <Column header="Date" field="createdDate" style="min-width: 12rem">
        <template #editor="{ data }">
            <InputText v-model="data.createdDate" autofocus />
        </template>
        <template #filter="{filterModel, filterCallback}">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by date" />
        </template>
    </Column>
    <Column header="Contractor" field="contractor" style="min-width: 12rem">
        <template #editor="{ data }">
            <InputText v-model="data.contractor" autofocus />
        </template>
        <template #filter="{filterModel, filterCallback}">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by constructor" />
        </template>
    </Column>
</DataTable>
</div>
<Dialog v-model:visible="visibleDialog" modal header="Create Group" :style="{ width: '30rem' }">
<!-- <CreateGroup v-model="visibleDialog" :groups="groups"/> -->
</Dialog>
</template>
<script setup>
    definePageMeta({
    layout: 'system'
    })
    import '../../../assets/CSS/grid.css';
    import '../../../assets/CSS/styleMain.css';
    import {documentGetByTypeAPI } from '~/api/documentAPI';
    import {FilterMatchMode} from 'primevue/api';
    import { ref, onMounted } from 'vue';
    import {tabGetAllAPI} from '../../../api/tagAPI';
    import {documentTypeGetAllAPI} from '../../../api/documentTypeAPI';
    import {disciplinesGetAllAPI} from '../../../api/disciplinesAPI';
    const documents = ref([]);
    const selectedDocuments = ref();
    const visibleDialog = ref(false);
    const menu = ref();
    onMounted(() => {
        loadDocuments();
        loadAllTab();
        loadAllDocumentType();
        loadAllDiscriplines();
    });
    const loadAllTab = async () => {
        try{
            tabs.value = await tabGetAllAPI();
        }
        catch(error){
            console.log("Error get list tab:"+error);
        }
    }
    const loadAllDocumentType = async () => {
        try{
            documentTypes.value = await documentTypeGetAllAPI();
        }
        catch(error){
            console.log("Error get list document type:"+error);
        }
    }
    const loadAllDiscriplines = async () => {
        try{
            disciplines.value = await disciplinesGetAllAPI();
        }
        catch(error){
            console.log("Error get list disciplines:"+error);
        }
    }
    const filters = ref({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
        name: { value: null, matchMode: FilterMatchMode.CONTAINS },
        title: { value: null, matchMode: FilterMatchMode.CONTAINS },
        tag: { value: null, matchMode: FilterMatchMode.CONTAINS },
        disciplineName: { value: null, matchMode: FilterMatchMode.CONTAINS },
        documentTypeName: { value: null, matchMode: FilterMatchMode.CONTAINS },
        createdDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
        contractor: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });
    const loadDocuments = async () => {
        try{
            documents.value = await documentGetByTypeAPI(3);
        }
        catch(error){
            console.log("Error get list document:"+error);
        }
    }
    
   
    const onCellEditComplete = (event) => {
    let { data, newValue, field } = event;
    switch (field) {
        default:
            if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
            break;
    }
}
const onRightClick = (event) => {
    menu.value.show(event);
};
</script>
<style>
.drop-zone {
  max-width: 100%;
  height: 100% !important;
  padding: 25px;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  font-family: "Quicksand", sans-serif;
  font-weight: 500;
  font-size: 20px;
  cursor: pointer;
  color: #cccccc;
  border: 2px dashed #1976d2;
}
</style>
