<template>
    <div class="flex flex-wrap w-full justify-center items-center" id="divGrid">
        <div class="w-full h-full">
            <DataTable paginator :rows="50" dataKey="id" scrollable filterDisplay="row"
            :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" showGridlines stripedRows v-model:filters="filters" v-model:selection="selectedDocuments" :value="documents">
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
            <template #filter="{ filterModel }">
                <InputText type="text" v-model="filterModel.value" @keydown="onSearchName(e)" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Description" field="title" style="min-width: 20rem">
            <template #filter="{ filterModel, filterCallback }">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Tag" field="tagName" style="min-width: 12rem">
            <template #filter="{ filterModel, filterCallback }">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Discipline" field="disciplineName" style="min-width: 12rem">
            <template #filter="{filterModel, filterCallback}">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Document Type" field="typeName" style="min-width: 12rem">
            <template #filter="{filterModel, filterCallback}">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Revision" field="revisionName" style="min-width: 12rem">
           <template #filter="{filterModel, filterCallback}">
               <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
           </template>
       </Column>
       <Column header="From/To" field="fromTo" style="min-width: 12rem">
           
           <template #filter="{filterModel, filterCallback}">
               <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
           </template>
       </Column>
       <Column header="PlatForm" field="platForm" style="min-width: 12rem">
           <template #filter="{filterModel, filterCallback}">
               <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
           </template>
       </Column>
        <Column header="Date" field="createdDate" style="min-width: 12rem">
            <template #filter="{filterModel, filterCallback}">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Tag" field="tagSystemPlant" style="min-width: 12rem">
            <template #filter="{filterModel, filterCallback}">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Sub Type" field="typeName" style="min-width: 12rem">
            <template #filter="{filterModel, filterCallback}">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Model" field="modelName" style="min-width: 12rem">
            <template #filter="{filterModel, filterCallback}">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Contractor" field="contractor" style="min-width: 12rem">
            <template #editor="{ data }">
                <InputText v-model="data.contractor" autofocus />
            </template>
            <template #filter="{filterModel, filterCallback}">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
            </template>
        </Column>
        <Column header="Virual Path" field="vitualPath" style="min-width: 15rem">
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <template #footer> <div class="w-full text-end">In total there are {{ count }} rows. </div></template>
    </DataTable>
           </div>
           <!-- <div class="bg-[#3B82F6] text-[#ffffff] w-full h-[20px] flex items-center font-bold text-[17px] bottom-0 right-0 absolute p-5">
        <div class="w-full text-right">Total Row: {{ documents.length }}</div>
    </div> -->
    <loading v-model:active="isLoading"
    :is-full-page="true" color="#3B82F6"/>
    </div>
    </template>
    <script setup>
        definePageMeta({
        layout: 'default'
        })
        import '../../../assets/CSS/grid.css';
        import '../../assets/CSS/styleMain.css';
        import Loading from 'vue-loading-overlay';
        import { useDocument } from '~/stores/document';
        import {FilterMatchMode} from 'primevue/api';
        import { useDocumentType } from '~/stores/documentType';
        import { useDisciplines } from '~/stores/disciplines';
        import { ref, onMounted } from 'vue';
        const documents = ref([]);
        const count = ref(0);
        const selectedDocuments = ref();
        const visibleDialog = ref(false);
        const menu = ref();
        const tabs = ref([]);
        const isLoading = ref(false);
        const documentTypes = ref([]);
        const disciplines = ref([]);
        onMounted(() => {
            loadDocuments();
            
            //loadAllTab();
            //loadAllDocumentType();
            //loadAllDiscriplines();
        });
        // const loadAllTab = async () => {
        //     try{
        //        // tabs.value = await tabGetAllAPI();
        //     }
        //     catch(error){
        //         console.log("Error get list tab:"+error);
        //     }
        // }
        // const loadAllDocumentType = async () => {
        //     try{
        //         documentTypes.value = await useDocumentType().getAll();
        //     }
        //     catch(error){
        //         console.log("Error get list document type:"+error);
        //     }
        // }
        // const loadAllDiscriplines = async () => {
        //     try{
        //         disciplines.value = await useDisciplines().getAll();
        //     }
        //     catch(error){
        //         console.log("Error get list disciplines:"+error);
        //     }
        // }
        const filters = ref({
            global: { value: null, matchMode: FilterMatchMode.CONTAINS },
            name: { value: null, matchMode: FilterMatchMode.CONTAINS },
            title: { value: null, matchMode: FilterMatchMode.CONTAINS },
            tagName: { value: null, matchMode: FilterMatchMode.CONTAINS },
            disciplineName: { value: null, matchMode: FilterMatchMode.CONTAINS },
            typeName: { value: null, matchMode: FilterMatchMode.CONTAINS },
            fromTo: { value: null, matchMode: FilterMatchMode.CONTAINS },
            revisionName: { value: null, matchMode: FilterMatchMode.CONTAINS },
            platForm    : { value: null, matchMode: FilterMatchMode.CONTAINS },
            createdDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
            contractor: { value: null, matchMode: FilterMatchMode.CONTAINS },
            tagSystemPlant: { value: null, matchMode: FilterMatchMode.CONTAINS },
            typeName: { value: null, matchMode: FilterMatchMode.CONTAINS },
            modelName: { value: null, matchMode: FilterMatchMode.CONTAINS },
            vitualPath: { value: null, matchMode: FilterMatchMode.CONTAINS },
        });
        const loadDocuments = async () => {
            isLoading.value = true;
            try{
                documents.value = await useDocument().get500Items();
                count.value = await useDocument().getCountDocuments();
            }
            catch(error){
                console.log("Error get list document:"+error);
            }finally{
                isLoading.value = false;
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
    const onSearchName=(e)=>{
        console.log(e);
    }
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
    