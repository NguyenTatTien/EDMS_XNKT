<template>
    <div>
    <div>
        <div class="w-[300px] h-[35rem] fixed z-10 left-0">
            <div class="w-full flex h-full" style="border-right: 1px solid #dee2e6;">
                <div class="flex w-[100%] h-full">
                    <PanelMenu v-model:expandedKeys="expandedKeys" :model="items" class="w-full md:w-20rem h-full overflow-y-auto px-0" id="categoryDoc">
                        <template #item="{ item }">
                            <a  v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparent" :target="item.target">
                                <span class="ml-2 text-[#5e6e82] font-medium text-sm" v-if="item.items != null && item.items.length > 0">{{ item.label }}</span>
                                    <span class="ml-2 text-[#5e6e82] font-medium text-sm" v-else @click="loadFolders(item)">{{ item.label }}</span>
                                <span v-if="item.items && item.items.length > 0" class="pi pi-angle-down text-[#5e6e82] ml-auto" />
                            </a>
                        </template>
                    </PanelMenu>
                </div>
                </div>
        </div>
    </div>
    <div class="ml-[300px]">
        <div class="bg-white p-2">
            <div class="flex justify-between">
                <Breadcrumb  :model="breadcrumbItems" :home="home" class="bg-transparent">
                <template #item="{ item }">
                    <span :class="item.icon"></span>
                    <a class="cursor-pointer" @click="backBreadcrumbItems(item)">
                      {{item.label}}
                    </a>
                </template>
                </Breadcrumb>
                <div class="flex">
                <IconField iconPosition="left" class="mr-2 h-[2rem]">
                        <InputIcon class="pi pi-search" @click="onSearch"> </InputIcon>
                        <InputText v-model="search" placeholder="Search" class="h-[2rem]"/>
                </IconField>
                </div>
            </div>
            <div>
<DataTable scrollable scrollHeight="30rem" class="text-xs h-[100%]" stripedRows editMode="cell" :value="documents">
    <template #empty> No found. </template>
    <template #loading> Loading data. Please wait. </template>
    <Column style="min-width: 50px">
        <template #body="{data }">
            <i class="pi pi-folder cursor-pointer" v-if="data.type == 'folder'" @click="openDocument(data)"></i>
            <img  :src="'/_nuxt/assets/'+data.object.fileExtensionIcon" v-else class="w-[16px] h-[16px] cursor-pointer"/>
        </template>
    </Column>
    <Column header="Name" field="object.name"  style="min-width: 30rem">
    </Column>
    <Column header="Description" field="object.description" style="min-width: 30rem">
        <template #body="{ data }">
            <div v-if="data.type == 'folder'">{{ data.object.description }}</div>
            <div v-else>{{ data.object.title }}</div>
        </template>
    </Column>
    <Column header="Revision" field="object.revisionName" style="min-width: 15rem">
    </Column>
    <Column header="From/To" field="object.fromTo" style="min-width: 15rem">
    </Column>
    <Column header="Platform" field="object.platform" style="min-width: 15rem">
    </Column>
    <Column header="Contractor" field="object.contractor" style="min-width: 15rem">
    </Column>
    <Column header="Document Type" field="object.documentTypeName" style="min-width: 20rem">
    </Column>
    <Column header="Tag" field="object.tagName" style="min-width: 20rem">
    </Column>
    <Column header="Discipline" field="object.disciplineName" style="min-width: 20rem">
    </Column>
    <Column header="Type" field="object.typeName" style="min-width: 20rem">
    </Column>
    <Column header="Remarks" field="object.remark" style="min-width: 20rem">
    </Column>
    <Column header="Create By Name" field="object.createBy" style="min-width: 15rem">
    </Column>
    <Column header="Date" field="object.createdDate" style="min-width: 15rem">
    </Column>
</DataTable>
            </div>
        </div>
    </div>
    <div class="flex justify-end gap-2 absolute bottom-0 right-0 p-2">
        <Button type="button" label="Paste Here" class="p-2 text-white"></Button>
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black"></Button>
    </div>
    </div>
</template>
<script setup>
import {cateogriesGetAllAPI} from '../../../api/categoriesAPI.js';
import { useCategories } from '~/stores/categories';
import { ref, onMounted } from 'vue';
import {folderGetNotParentByCategoryAPI,folderGetByParentAndCategoryAPI} from '../../../api/folderAPI.js';
import { useFolder } from '~/stores/folder';
import {documentGetByFolderAPI} from '../../../api/documentAPI';
import { useDocument } from '~/stores/document';
const documents = ref([]);
const search = ref("");
const categoryID = ref(null);
const parentFolderID = ref(null);
    const breadcrumbItems = ref([
    ]);
    const expandedKeys = ref({});
    const home = ref({ icon: 'pi pi-home' });
    const items = ref([
 {
     key: "0",
     label: 'Document Group',
     items: [],
 },
]);
    onMounted(async() => {
        await getCategories()
    })
    const getCategories = async () => {
 try{
     const data = await useCategories().getAll();
     data.forEach(item => {
         var newitem = {
             id:  item.id,
             key: '' +item.id,
             label: item.name,
             icon: "pi pi-graduation-cap",
             items:null,
         };
         items.value[0].items.push(newitem);
     });
 }catch(error){
     console.log(error);
 }
}
const backBreadcrumbItems = (value)=>{
    if(breadcrumbItems.value.indexOf(value)!==breadcrumbItems.value.length - 1){
        openDocument(value.data);
        breadcrumbItems.value = breadcrumbItems.value.slice(0, breadcrumbItems.value.indexOf(value) + 1);
        parentFolderID.value = value.data.object.id;
    }
}
const openDocument = async (data) => {
    if(data.type=="folder"){
        var folders = await folderGetByParentAndCategoryAPI(data.object.id,data.object.categoryID);
        var files = await documentGetByFolderAPI(data.object.id);
        documents.value = [];
        if(folders.length > 0){
            folders.forEach(item => {
            var document = {};
            document.type = "folder";
            document.object = item;
            documents.value.push(document);
        });
        }
        if(files.length > 0){
            files.forEach(item => {
            var document = {};
            document.type = "document";
            document.object = item;
            documents.value.push(document);
        });
        }
        nextbreadcrumbItems(data);
    }
}
const nextbreadcrumbItems = (value) => {
    breadcrumbItems.value.push({ label: value.object.name,data:value});
    parentFolderID.value = value.object.id;
}
const onSearch = async () => {
    documents.value = [];
    var folders = await searchFolderAPI(search.value);
    var files = await searchDocumentAPI(search.value);
    folders.forEach(item => {
        var document = {};
        document.type = "folder";
        document.object = item;
        documents.value.push(document);
    });
    files.forEach(item => {
        var document = {};
        document.type = "document";
        document.object = item;
        documents.value.push(document);
    });
    breadcrumbItems.value = [];
}
const loadFolders = async (itemDepartment) => {
if(itemDepartment.id) {
   try{
        var data = await folderGetNotParentByCategoryAPI(itemDepartment.id);
        data.forEach(item => {
           var newitem = {
               key: item.id,
               label: item.name,
               icon: "pi pi-folder",
               data:item,
               children: null,
               parent:null,
           } ;
        });
       loadFolderByDepartment({folders:data,categoryID:itemDepartment.id});
   }catch(error){
       console.log(error);
   }
}
}
const loadFolderByDepartment = (data) => {
        try{
        documents.value = [];
        data.folders.forEach(item => {
        var document = [];
        document.type = "folder";
        document.object = item;
        documents.value.push(document);
        });
        breadcrumbItems.value = [];
        categoryID.value = data.categoryID;
        parentFolderID.value = null;
        }
        catch(error){
            console.log("Error get list document:"+error);
        }
    }
</script>
