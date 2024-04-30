<template>
   <div id="content">
    <div>
        <div class="w-[300px] h-full fixed z-10 left-0 pb-[40px]">
             <!-- <div class="text-center h-15 p-5">
                <Button icon="pi pi-plus" label="Add New" class="border-[1px] border-solid border-[#3B82F6] text-[#1976d2]" @click="visibleDialog = true" style="padding: 0.65625rem 1.09375rem"/>
             </div> -->
            <ListDepartment @onLoadFolderByDepartment="loadFolderByDepartment" @pushBreadcrumbItems="pushBreadcrumbItems" />
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
                <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="toggleAdd" />
                <Button icon="pi pi-spin pi-cog" class="mr-2 h-[2rem] bg-[#4410b9]" @click="toggleConf" />
                <SelectButton v-model="value" :options="options" optionLabel="value" dataKey="value" aria-labelledby="custom" class="mr-5">
                    <template #option="slotProps">
                        <i :class="slotProps.option.icon" @click="changeListGrid(slotProps.option.value)"></i>
                    </template>
                </SelectButton>
                </div>
            </div>
            <div>
                <TabView v-model:activeIndex="active">
                <TabPanel header="Header I">
                    <DocumentLibaryList :documents="documents" @nextbreadcrumbItems="nextbreadcrumbItems" @openDocument="openDocument" @toggle="toggle"/>
                </TabPanel>
                <TabPanel header="Header II">
                    <DocumentLibaryGrid :documents="documents" @nextbreadcrumbItems="nextbreadcrumbItems" @openDocument="openDocument" @toggle="toggle"/>
                </TabPanel>
            </TabView>
            </div>
        </div>
    </div>
   </div>
    <div id="sidebarEdit" class="sidebarEdit">
        <DocumentLibaryEdit v-if="documentEdit.type === 'document'" @closeNav="closeSidebarRight" :documents="documents" :documentEdit="documentEdit" :parentFolderID="parentFolderID"/>
        <FolderEdit v-else @closeNav="closeSidebarRight" :documents="documents" :documentEdit="documentEdit" :categoryID="categoryID" :parentFolderID="parentFolderID"/>
    </div>
    <Menu ref="menuFolder" id="overlay_menu" :model="folderMenus" :popup="true" />
    <Menu ref="menuFile" id="overlay_menu" :model="fileMenus" :popup="true" />
    <Menu ref="menuAdd" id="overlay_menu" :model="itemAddMenus" :popup="true" />
    <Menu ref="menuConf" id="overlay_menu" :model="itemConfMenus" :popup="true" />
    <Dialog v-model:visible="visibleDialogUpload" modal header="Create Folder" :style="{ width: '50rem' }">
        <UploadDocument v-model="visibleDialogUpload"/>
    </Dialog>
    <Dialog v-model:visible="visibleDialogPermission" modal header="Change Permission" class="w-[70rem] max-h-[45rem] rounded-none">
        <DocumentLibaryPermision v-model="visibleDialogPermission" :selectedDocuments="selectedDocuments"/>
    </Dialog>
    <Dialog v-model:visible="visibleDialogSendMail" modal header="Send Mail" class="w-[60rem] max-h-[45rem] rounded-none">
       <DocumentLibarySendMail v-model="visibleDialogSendMail" :selectedDocuments="selectedDocuments"/>
    </Dialog>
    <Dialog v-model:visible="visibleDialogSync" modal header="Sync Folder"  class="w-[80rem] max-h-[45rem]">
        <DocumentLibarySync v-model="visibleDialogSync"/>
    </Dialog>
</template>
<script setup>
    definePageMeta({
    layout: 'default'
})
import {DocumentView} from '../models/tableView/documentView.js';
import {folderGetByParentAndCategory,deleteFolderAPI} from '../api/folderAPI.js';
import {documentGetByFolderAPI,deleteDocumentAPI} from '../api/documentAPI';
import {copyFileToFolder,moveFileToFolder} from '../api/documentAPI.js';
import {moveFolderToFolder} from '../api/folderAPI.js';
import {openSidebarRight,closeSidebarRight} from '../../assets/js/sidebar.js';
import ListDepartment from '~/components/department/list-department.vue';
import {Folder} from '../../models/folder.js';
import {Document} from '../../models/document.js';
import '../../assets/css/sidebar.css';
const documents = ref([]);
const visibleDialogUpload = ref(false);
const visibleDialogCreateDoc = ref(false);
const visibleDialogPermission = ref(false);
const visibleDialogSendMail = ref(false);
const visibleDialogSync = ref(false);
const active = ref(0);
const menuFolder = ref();
const menuFile = ref();
const menuAdd = ref();
const menuConf = ref();     
const selectedDocuments = ref();
const documentCopyOrMove = ref({});
const documentEdit = ref({type:'',object:{}});
const categoryID = ref(null);
const parentFolderID = ref(null);
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
        }
        catch(error){
            console.log("Error get list document:"+error);
        }
    }
    const breadcrumbItems = ref([
    ]);
    const folderMenus = ref([
    {
        label: 'Edit',
        icon: 'pi pi-pencil',
        command: () => {
           // visibleDialogEdit.value = true;
           documentEdit.value = selectedDocuments.value;
           openSidebarRight("400px");
        }
    },
    {
        separator: true
    },
    {
        label: 'Delete',
        icon: 'pi pi-trash',
        command: () => {
            deleteFolder(selectedDocuments.value.object.id);
            
        }
    },
    {
        separator: true
    },
    {
        label: 'Downlaod',
        icon: 'pi pi-download',
        command: () => {
            var data = selectedDocuments.value;
            if(data.type=="folder"){
                var a = document.createElement('A');
                a.href = '_nuxt/assets/Import/download.rar';
                a.download = 'download.rar';
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            }else{
                var a = document.createElement('A');
                a.href = '_nuxt/assets/Import/file.pdf';
                a.download = 'file.pdf';
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            }
        }
    },
    {
        separator: true
    },
    {
        label: 'Change Permision',
        icon: 'pi pi-lock-open',
        command: () => {
            visibleDialogPermission.value = true;
        }
    },
    {
        separator: true
    },
    {
        label: 'Move',
        icon: 'pi pi-directions-alt',
        command: () => {
            moveDocument();
        }
    },
    {
        separator: true
    },
    {
        label: 'Copy',
        icon: 'pi pi-copypi pi-copy',
        command: () => {
            copyDocument();
        }
    },
    {
        separator: true
    },
    {
        label: 'Paste',
        icon: 'pi pi-clone',
        command: () => {
            pasteDocument();
        }
    },
    {
        separator: true
    },
    {
        label: 'Sync Folder',
        icon: 'pi pi-undo',
        command: () => {
            visibleDialogSync.value = true;
        }
    }
]);
const fileMenus = ref([
    {
        label: 'Edit',
        icon: 'pi pi-pencil',
        command: () => {
           // visibleDialogEdit.value = true;
           documentEdit.value = selectedDocuments.value;
           openSidebarRight("400px");
        }
    },
    {
        separator: true
    },
    {
        label: 'Delete',
        icon: 'pi pi-trash',
        command: () => {
            deleteDocument(selectedDocuments.value.object.id);
            
        }
    },
    {
        separator: true
    },
    {
        label: 'Downlaod',
        icon: 'pi pi-download',
        command: () => {
            var data = selectedDocuments.value;
            if(data.type=="folder"){
                var a = document.createElement('A');
                a.href = '_nuxt/assets/Import/download.rar';
                a.download = 'download.rar';
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            }else{
                var a = document.createElement('A');
                a.href = '_nuxt/assets/Import/file.pdf';
                a.download = 'file.pdf';
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            }
        }
    },
    
    {
        separator: true
    },
    {
        label: 'Move',
        icon: 'pi pi-directions-alt',
        command: () => {
            moveDocument();
        }
    },
    {
        separator: true
    },
    {
        label: 'Copy',
        icon: 'pi pi-copypi pi-copy',
        command: () => {
            copyDocument();
        }
    },
    {
        separator: true
    },
    {
        label: 'Paste',
        icon: 'pi pi-clone',
        command: () => {
            pasteDocument();
        }
    },
]);
const itemAddMenus = ref([
    {
        label: 'Create Folder',
        icon: 'pi pi-folder-plus',
        command: () => {
            documentEdit.value = {type:'folder', object: new Folder()};
            if(breadcrumbItems.value.length>0){
                parentFolderID.value = breadcrumbItems.value[breadcrumbItems.value.length-1].data.object.id;
            }
           openSidebarRight("400px");
        }
    },  
    {
        separator: true
    },
    {
        label: 'Create Document',
        icon: 'pi pi-file-plus',
        command: () => {
            documentEdit.value = {type:'document', object: new Document()};
            if(breadcrumbItems.value.length>0){
                parentFolderID.value = breadcrumbItems.value[breadcrumbItems.value.length-1].data.object.id;
            }
            openSidebarRight("400px");
        }
    },
    {
        separator: true
    },
    {
        label: 'Upload Folder',
        icon: 'pi pi-upload',
        command: () => {
            visibleDialogUpload.value = true;
        }
    },
    {
        separator: true
    },
    {
        label: 'Upload Document',
        icon: 'pi pi-upload',
        command: () => {
            visibleDialogUpload.value = true;
        }
    },
]);
const itemConfMenus = ref([
    {
        label: 'Send mail with Attchment',
        icon: 'pi pi-envelope',
        command: () => {
            visibleDialogSendMail.value = true;
        }
    },
    {
        separator: true
    },
    {
        label: 'Send mail with Link System',
        icon: 'pi pi-envelope',
        command: () => {
            visibleDialogSendMail.value = true;
        }
    },
    {
        separator: true
    },
    {
        label: 'Export data',
        icon: 'pi pi-file-export',
        command: () => {
            
        }
    },
    {
        separator: true
    },
    {
        label: 'Import data',
        icon: 'pi pi-file-import',
        command: () => {
            
        }
        
    },
    {
        separator: true
    },
    {
        label: 'Download multi documents',
        icon: 'pi pi-download',
        command: () => {
            
        }
    },
    {
        separator: true
    },
    {
        label: 'Export tree folder',
        icon: 'pi pi-file-export',
        command: () => {
            
        }
        
    },
    {
        separator: true
    },
    {
        label: 'Export document',
        icon: 'pi pi-file-export',
        command: () => {
            
        }
        
    },
]);
const home = ref({ icon: 'pi pi-home' });
    const value = ref(null);
    const options = ref([
    { icon: 'pi pi-list', value: 'List' },
    { icon: 'pi pi-th-large', value: 'Grid' },
]);
const toggle = (data) => {
    if(data.data.type==="folder"){
        menuFolder.value.toggle(data.event);
    }else{
        menuFile.value.toggle(data.event);
    }
    
    selectedDocuments.value = data.data;
  
};
const toggleAdd = (event) => {
    menuAdd.value.toggle(event);
    
};
const toggleConf = (event) => {
    menuConf.value.toggle(event);
    
};
const changeListGrid=(value)=>{
    if(value == 'List'){
        active.value = 0;
    }else{
        active.value = 1;
    }
}
const nextbreadcrumbItems = (value) => {
    breadcrumbItems.value.push({ label: value.object.name,data:value});
}
const backBreadcrumbItems = (value)=>{
    if(breadcrumbItems.value.indexOf(value)!==breadcrumbItems.value.length - 1){
        openDocument(value.data);
        breadcrumbItems.value = breadcrumbItems.value.slice(0, breadcrumbItems.value.indexOf(value) + 1);
    }
}
const openDocument = async (data) => {
    if(data.type=="folder"){
        var folders = await folderGetByParentAndCategory(data.object.id,data.object.categoryID);
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
    }
}
const copyDocument = () => {
    documentCopyOrMove.value = {document:selectedDocuments.value,type:"copy"};
}
const pasteDocument = async () => {
    try{
            if(documentCopyOrMove.value.type=="copy"){
            if(documentCopyOrMove.value.document.type=="folder"){
                
            }else{
                await copyFileToFolder(documentCopyOrMove.value.document.id,selectedDocuments.value.id);
            }
        }
        else{
            if(documentCopyOrMove.value.document.type=="folder"){
                await moveFolderToFolder(documentCopyOrMove.value.document.id,selectedDocuments.value.id);
            }else{
                await moveFileToFolder(documentCopyOrMove.value.document.id,selectedDocuments.value.id);
            }
        }
    }catch(err){
        console.log(err);
    }
}
const moveDocument = () => {
    documentCopyOrMove.value = {document:selectedDocuments.value,type:"move"};
}
const pushBreadcrumbItems=(data)=>{
    breadcrumbItems.value = data;
    openDocument(data[data.length-1].data);
}
const deleteFolder = async (Id) =>{
    try{
        await deleteFolderAPI(Id);
        documents.value = documents.value.filter(item => item !== selectedDocuments.value);
    }catch(error){
        console.log(error);
    }
}
const deleteDocument = async (Id) =>{
    try{
        await deleteDocumentAPI(Id);
        documents.value = documents.value.filter(item => item !== selectedDocuments.value);
    }catch(error){
        console.log(error);
    }
}
</script>
<style>
.p-tabview-nav-container{
    display: none;
}

</style>