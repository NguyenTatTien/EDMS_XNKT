<template>
    <div class="w-full h-full">
        <div class="w-[300px] h-full fixed z-10 right-0 bg-white"><SidebarLeftDoc @onLoadFolderByDepartment="loadFolderByDepartment"/></div>
        <div class="h-full mr-[300px] px-2">
            <div class="flex items-center">
                 <div><Breadcrumb :home="home" :model="items" class="bg-transparent"/></div>
        </div>
        <div class="mb-2"><DocumentDetail/></div>
        <div class="mb-2">
            <div class="w-full h-full">
                    <div class="drop-zone flex flex-wrap">
                        <i class="pi pi-upload text-xl mr-3" data-v-446f85a0=""></i>
                        <span class="drop-zone__prompt">Drop file here</span>    
                    </div>
        </div>
        </div>
        <div class="mb-2">
            <div>
                <Card class="rounded-md bg-[#ffffff]" style="box-shadow: 0 7px 14px 0 rgba(65, 69, 88, 0.1), 0 3px 6px 0 rgba(0, 0, 0, 0.07);"> 
        <template #content>
    <div class="w-full h-[100%]">
        <DataTable paginator :rows="10" dataKey="id" scrollable filterDisplay="menu"
        :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" showGridlines stripedRows v-model:filters="filters" v-model:selection="selectedDocuments" editMode="cell" :value="documents" @cell-edit-complete="onCellEditComplete">
    <template #header>
        <div class="flex justify-between">
            <div class="flex w-[300px]">
                <Button icon="pi pi-plus" label="Add New" class="border-[1px] border-solid border-[#3B82F6] text-[#1976d2]" @click="visibleDialog = true" style="padding: 0.65625rem 1.09375rem"/>
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
            <InputText v-model="data.tag" autofocus />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by tag" />
        </template>
    </Column>
    <Column header="Discipline" field="disciplineName" style="min-width: 12rem">
        <template #editor="{ data }">
            <InputText v-model="data.disciplineName" autofocus />
        </template>
        <template #filter="{filterModel, filterCallback}">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by discipline" />
        </template>
    </Column>
    <Column header="Document Type" field="documentTypeName" style="min-width: 12rem">
        <template #editor="{ data }">
            <InputText v-model="data.documentTypeName" autofocus />
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
    </template>
    </Card>
            </div>
        </div>
      
        </div>
       </div>
       <ContextMenu ref="menu" :model="itemMenus">
                <template #item="{ item, props }">
                <a v-ripple class="flex align-items-center" v-bind="props.action">
                    <img :src="item.icon"/>
                    <span class="ml-2">{{ item.label }}</span>
                </a>
            </template>
            </ContextMenu>
</template>
<script setup>
    definePageMeta({
    layout: 'system'
    })
    import '../../assets/CSS/grid.css';
    import '../../assets/CSS/styleMain.css';
    import { documentGetAllAPI, documentGetByFolderAPI } from '~/api/documentAPI';
    import {folderGetNotParentByCategory,folderGetByParentAndCategory} from '../api/folderAPI.js';
    import {FilterMatchMode} from 'primevue/api';
    import { ref, onMounted } from 'vue';
    import {documentTable} from '../models/tableView/documentTable.js';
    const documents = ref([]);
    const selectedDocuments = ref();
    const visibleDialog = ref(false);
    const menu = ref();
    const home = ref({
    icon: 'pi pi-home'
    });
    const items = ref([
        { label: '01. Ban Giám Đốc' }, 
        { label: '01. ПЛАНЫ, ОТМ ПДНГ' }, 
        { label: '01.01. 2019' }, 
       
    ]);
    const itemMenus = ref([
    {
        label: 'Create New',
        icon: '/_nuxt/assets/Images/addfolder.png',
    },
    {
        separator: true
    },
    {
        label: 'Rename',
        icon: '/_nuxt/assets/Images/rename.png',
    },
    {
        separator: true
    },
    {
        label: 'Delete',
        icon: '/_nuxt/assets/Images/deletefolder.png',
        
    },
    {
        separator: true
    },
    {
        label: 'Change Permision',
        icon: '/_nuxt/assets/Images/iconfinder_folder_block.png',
    },
    {
        separator: true
    },
    {
        label: 'Move Folder',
        icon: '/_nuxt/assets/Images/iconfinder_Open.png',
        
    },
    {
        separator: true
    },
    {
        label: 'Download Folder',
        icon: '/_nuxt/assets/Images/folders-downloads.png',
        
    },
    {
        separator: true
    },
    {
        label: 'Copy Folder',
        icon: '/_nuxt/assets/Images/edit-copy-icon.png',
    },
    {
        separator: true
    },
    {
        label: 'Sync Folder',
        icon: '/_nuxt/assets/Images/Microsoft-Sync-icon.png',
    }
]);
    onMounted(() => {
        //loadDocuments();
    });
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
            documents.value = await documentGetAllAPI();
        }
        catch(error){
            console.log("Error get list document:"+error);
        }
    }
    const loadFolderByDepartment = (folders) => {
        try{
        documents.value = [];
        folders.forEach(item => {
        var document = new documentTable();
        document.id = item.id;
        document.name = item.name;
        document.description = item.description;
        document.createdDate = item.createdDate;
        document.categoryID = item.categoryID;
        document.fileExtensionIcon = "/images/folderdir16.png";
        document.type = "folder";
        documents.value.push(document);
        });
            
        }
        catch(error){
            console.log("Error get list document:"+error);
        }
    }
    const openDocument = async (data) => {
    if(data.type=="folder"){
        
        var folders = await folderGetByParentAndCategory(data.id,data.categoryID);
   
    var files = await documentGetByFolderAPI(data.id);
    documents.value = [];
    if(folders.length > 0){
        folders.forEach(item => {
        var document = new documentTable();
        document.id = item.id;
        document.name = item.name;
        document.description = item.description;
        document.createdDate = item.createdDate;
        document.categoryID = item.categoryID;
        document.fileExtensionIcon = "/images/folderdir16.png";
        document.type = "folder";
        documents.value.push(document);
    });
    }
    if(files.length > 0){
        files.forEach(item => {
        var document = new documentTable();
        document.id = item.id;
        document.name = item.name;
        document.description = item.description;
        document.createdDate = item.createdDate;
        document.tag = item.tag;
        document.type = "document";
        document.disciplineName =item.disciplineName;
        document.disciplineId = item.disciplineId;
        document.documentTypeId = item.documentTypeId;
        document.documentTypeName = item.documentTypeName;
        document.createdDate = item.createdDate;
        document.contractor = item.contractor;
        document.fileExtensionIcon = item.fileExtensionIcon;
        documents.value.push(document);
    });
    }
    console.log(documents.value);
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
