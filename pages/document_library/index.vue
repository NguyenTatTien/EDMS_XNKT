<template>
   <div class="h-full">
    <LayoutSidebar v-model="documents" :categoryID="categoryID" @onLoading="onLoading" :parentFolderID="parentFolderID"/>
     <div class="flex flex-1 flex-row relative pb-[40px] h-full">
     <div class="flex w-[300px] h-full flex-1 fixed pb-[40px]">
         <div class="w-[300px] h-full z-10 left-0 static ">
             <ListDepartment v-model="isLoading" :categoryID="categoryID"/>
         </div>
     </div>
     <div class="ml-[300px] flex flex-1 relative grow-1 w-0">
         <div class="bg-white p-2 flex w-full flex-col">
             <div class="flex justify-between w-full">
                 <Breadcrumb  :model="breadcrumbItems" :home="home" class="bg-transparent">
                 <template #item="{ item }">
                    <span :class="item.icon"></span>
                    <a class="cursor-pointer" @click="backBreadcrumbItems(item)">
                       {{item.label}}
                    </a>
                 </template>
                 </Breadcrumb>
         </div>
            <div class="flex w-full flex-1 flex-row pb-[40px] h-full">
             <div id="content_grid" class="flex w-full flex-1">
                <div class="block flex-1 w-0">
                    <DocumentLibaryList :documents="documents" @nextbreadcrumbItems="nextbreadcrumbItems" @openDocument="openDocument" @toggle="toggle" v-model="multiDocuments"
                    :permissionParent="permission" :categoryID="categoryID" :parentFolderID="parentFolderID" @contextmenu="onRightClick"/>
                </div>
             </div>
             <div id="sidebarEdit" class="sidebarEdit">
                <FolderInfor :parentFolder = "parentFolder"/>
             </div>
            </div>
         </div>
     </div>
     <Menu ref="menuFolder" id="overlay_menu" :model="folderMenus" :popup="true">
        <template #item="{ item, props }">
            <a v-ripple class="flex align-items-center" v-bind="props.action" v-if="item.visible">
                <span :class="item.icon" />
                <span class="ml-2">{{ item.label }}</span>
            </a>
        </template>
    </Menu>
    <Menu ref="menuFile" id="overlay_menu" :model="fileMenus" :popup="true">
        <template #item="{ item, props }">
            <a v-ripple class="flex align-items-center" v-bind="props.action" v-if="item.visible">
                <span :class="item.icon" />
                <span class="ml-2">{{ item.label }}</span>
            </a>
        </template>
    </Menu>
    <Menu ref="menuAdd" id="overlay_menu" :model="itemAddMenus" :popup="true">
        <template #item="{ item, props }">
            <a v-ripple class="flex align-items-center" v-bind="props.action" v-if="item.visible">
                <span :class="item.icon" />
                <span class="ml-2">{{ item.label }}</span>
            </a>
        </template>
    </Menu>
    <Menu ref="menuConf" id="overlay_menu" :model="itemConfMenus" :popup="true">
        <template #item="{ item, props }">
            <a v-ripple class="flex align-items-center" v-bind="props.action" v-if="item.visible">
                <span :class="item.icon" />
                <span class="ml-2">{{ item.label }}</span>
            </a>
        </template>
    </Menu>
    <ContextMenu ref="menuContent" :model="itemConfMenus">
        <template #item="{ item, props }">
            <a v-ripple class="flex align-items-center" v-bind="props.action">
                <span :class="item.icon" />
                <span class="ml-2">{{ item.label }}</span>
            </a>
        </template>
    </ContextMenu>
     <Dialog v-model:visible="visibleDialogUpload" modal header="Upload Document" :style="{ width: '50rem' }">
         <UploadDocument v-model="visibleDialogUpload" :parentFolderID="parentFolderID" :categoryID="categoryID" @openDocument="openDocument" :isLoading="isLoading"/>
     </Dialog>
     <Dialog v-model:visible="visibleDialogImport" modal header="Import data" :style="{ width: '50rem' }">
         <DocumentLibaryImport v-model="visibleDialogImport" :parentFolderID="parentFolderID" :categoryID="categoryID" @openDocument="openDocument"/>
     </Dialog>
     <n-modal v-model:show="visibleDialogSendMail" preset="card" size="huge" class="w-max max-h-[45rem]" title="Send Mail">
            <DocumentLibarySendMail v-model="visibleDialogSendMail" :multiDocuments="multiDocuments" :typeSendMail="typeSendMail"/>
     </n-modal>
     <Dialog v-model:visible="visibleDialogPermission" modal :header="selectDocument.name" class="w-[70rem] h-[70rem] rounded-none">
         <DocumentLibaryPermision v-model="visibleDialogPermission" :selectDocument="selectDocument"/>
     </Dialog>
     <!-- <Dialog v-model:visible="visibleDialogSendMail" modal header="Send Mail" class="w-[70rem] max-h-[45rem] rounded-none">
        <DocumentLibarySendMail v-model="visibleDialogSendMail" :multiDocuments="multiDocuments" :typeSendMail="typeSendMail"/>
     </Dialog> -->
     <Dialog v-model:visible="visibleDialogTask" modal header="Task" class="w-full max-h-[45rem] rounded-none">
        <DocumentLibaryTask v-model="visibleDialogTask" :document="selectDocument" />
     </Dialog>
     <Dialog v-model:visible="visibleDialogSync" modal :header="selectDocument.name"  class="w-[80rem] max-h-[50rem]">
         <DocumentLibarySync v-model="visibleDialogSync" :folderID="selectDocument.id"/>
     </Dialog>
     <Dialog v-model:visible="visibleDialogDocEdit" id="dialogEditDoc" modal header="Create Document"  class="w-[500px] max-h-[45rem]">
         <DocumentLibaryEdit v-model="visibleDialogDocEdit" :documents="documents" :selectDocument="selectDocument" :parentFolderID="parentFolderID" :categoryID="categoryID"/>
     </Dialog>
     <Dialog v-model:visible="visibleDialogFolderEdit" modal header="Create Folder"  class="w-[500px] max-h-[40rem]">
         <FolderEdit v-model="visibleDialogFolderEdit" :documents="documents" :selectDocument="selectDocument" :categoryID="categoryID" :parentFolderID="parentFolderID"/>
     </Dialog>
     <Toast /> 
     <loading v-model:active="isLoading"
                 :is-full-page="true" color="#3B82F6"/>
    </div>
   </div>
  </template>
  <script setup>
    definePageMeta({
    layout: 'document',
  })
  import {ref,onMounted} from 'vue';
  import ListDepartment from '~/components/department/list-department.vue';
  import {Folder} from '../../models/folder.js';
  import {Document} from '../../models/document.js';
  import '../../assets/css/sidebar.css';
  import { useToast } from "primevue/usetoast";
  import Loading from 'vue-loading-overlay';
  import {useCategories} from '~/stores/categories'
  import { useDocument } from '~/stores/document';
  import { useFolder } from '~/stores/folder';
  import { usePermissionFolder } from '~/stores/permissionFolder';
  import { useRoute } from 'vue-router';
  import { useUser } from '~/stores/user';
const route = useRoute();
import 'vue-loading-overlay/dist/css/index.css';
import { tr } from 'date-fns/locale';
const isLoading = ref(false);
  const toast = useToast();
  const documents = ref([]);
  const visibleDialogUpload = ref(false);
  const visibleDialogPermission = ref(false);
  const visibleDialogSendMail = ref(false);
  const visibleDialogSync = ref(false);
  const visibleDialogDocEdit = ref(false);
  const visibleDialogFolderEdit = ref(false);
  const visibleDialogImport = ref(false);
  const visibleDialogTask = ref(false);
  const active = ref(0);
  const menuFolder = ref();
  const menuFile = ref();
  const menuAdd = ref();
  const menuConf = ref();     
  const multiDocuments = ref([]);
  const documentCopyOrMove = ref({});
  const selectDocument = ref({});
  const categoryID = ref(null);
  const parentFolderID = ref(null);
  const parentFolder = ref(null);
  const search = ref("");
  const typeSendMail = ref("0");
  const permission = ref(null);
  const myUser = ref(useUser().getUser());
  const menuContent = ref();
  const permissionFolderSelect = ref({
    isWrite: false,
    isRead: false,
    isDelete: false,
    isChangePer: false,
    isCreate: false,
});
const paramArray = ref([]);
onMounted (async() => {
   
  });
  const setParentFolder = (obj)=>{
    parentFolderID.value = obj.id;
    parentFolder.value = obj;
  }
  const reloadBreadcrumb=async (folderID)=>{
    try{
        var data = await useFolder().getListParentFolder(Number(folderID));
    for(var element of data){
        breadcrumbItems.value.push({ label: element.name,data:element});
    }
    return data[data.length - 1];
    }catch (error){
        console.log(error);
    }
  } 
  const getFolderByCategory = async()=>{
    try{
        if(categoryID.value != null){
            var data = await useFolder().getFolderNotParentByCategory(categoryID.value);
            loadFolderByDepartment(data);
        }
    }catch(error){
        console.log("Error get list document:"+error);
    }
  }
  const loadFolderByDepartment = (data) => {
         try{
         documents.value = [];
         data.forEach(item => {
         documents.value.push(item);
         });
         breadcrumbItems.value = [];
         }
         catch(error){
             console.log("Error get list document:"+error);
         }
     }
  const breadcrumbItems = ref([]);
  const folderMenus = ref([
    {
        label: 'Private',
        icon: 'pi pi-lock',
        visible: true,
        command: async() => {
            var st = confirm(`Do you want to private folder ${selectDocument.value.name}?`);
            if (st) {
            await useFolder().setPrivate(selectDocument.value.id,true);
            documents.value.find(x=>x.id == selectDocument.value.id).isPrivate = true;
            toast.add({ severity: 'success', summary: 'Success', detail: 'Private successfully!', life: 5000 });
            }
        }
    },
    {
        label: 'Public',
        icon: 'pi pi-lock-open',
        visible: true,
        command: async() => {
            var st = confirm(`Do you want to public folder ${selectDocument.value.name}?`);
            if (st) {
                await useFolder().setPrivate(selectDocument.value.id,false);
                documents.value.find(x=>x.id == selectDocument.value.id).isPrivate = false;
                toast.add({ severity: 'success', summary: 'Success', detail: 'Public successfully!', life: 5000 });
            }
        }
    },
    {
         label: 'Delete',
         icon: 'pi pi-trash',
         visible: true,
        command: () => {
            var st = confirm(`Do you want to delete folder ${selectDocument.value.name}?`);
            if (st) {
                deleteFolder(selectDocument.value.id);
            }
        }
    },
     {
         label: 'Download',
         icon: 'pi pi-download',
         visible: true,
         command: () => {
                downloadFolder();
         }
     },
     {
         label: 'Change Permision',
         icon: 'pi pi-lock-open',
         visible: true,
         command: () => {
             visibleDialogPermission.value = true;
         }
     },
     {
         label: 'Sync Folder',
         icon: 'pi pi-undo',
         visible: true,
         command: () => {
             visibleDialogSync.value = true;
         }
     }
  ]);
  const fileMenus = ref([
     {
        label: 'Delete',
        icon: 'pi pi-trash',
        visible: true,
        command: () => {
            var st = confirm(`Do you want to delete document ${selectDocument.value.name}?`);
            if (st) {
                deleteDocument(selectDocument.value.id);
            }
        }
     },
     {
         label: 'Download',
         icon: 'pi pi-download',
         visible: true,
         command: () => {
            multiDocuments.value[0] = selectDocument.value;
             downloadDocument();
         }
     },
     {
         label: 'Move',
         icon: 'pi pi-directions-alt',
         visible: true,
         command: () => {
             moveDocument([selectDocument.value]);
         }
     },
     {
         label: 'Copy',
         icon: 'pi pi-copypi pi-copy',
         visible: true,
         command: () => {
             copyDocument([selectDocument.value]);
         }
     },
     {
         label: 'Add To Task',
         icon: 'pi pi-plus',
         visible: true,
         command: () => {
             visibleDialogTask.value = true;
         }
     },
     
  ]);
  const itemAddMenus = ref([
     {
         label: 'Create Folder',
         icon: 'pi pi-folder-plus',
         visible: true,
        command: () => {
             selectDocument.value = new Document();
             visibleDialogFolderEdit.value = true;
        }
     },  
     {
         label: 'Create Document',
         icon: 'pi pi-file-plus',
         visible: true,
         command: () => {
             selectDocument.value = new Document();
             visibleDialogDocEdit.value = true;
         }
     },
  ]);
  const itemConfMenus = ref([
    {
        label: 'Create Folder',
        icon: 'pi pi-folder-plus',
        disabled: false,
        command: async() => {
            var perFolder = await usePermissionFolder().getJsonPermissionByFolder(parentFolder.value.id,categoryID.value);
            if(perFolder.isCreate == false){
                    toast.add({ severity: 'error', summary: 'Error', detail:'This folder not have permission!', life: 5000 });
                    return;
            }
            selectDocument.value = new Document();
            visibleDialogFolderEdit.value = true;
        }
     },  
     {
         label: 'Create Document',
         icon: 'pi pi-file-plus',
         disabled: false,
         command: async() => {
            var perFolder = await usePermissionFolder().getJsonPermissionByFolder(parentFolder.value.id,categoryID.value);
            console.log(perFolder);
            if(perFolder.isWrite == false){
                    toast.add({ severity: 'error', summary: 'Error', detail:'This folder not have permission!', life: 5000 });
                    return;
            }
             selectDocument.value = new Document();
             visibleDialogDocEdit.value = true;
         }
     },
    {
        separator: true
    },
    {
         label: 'Send mail with Attchment',
         icon: 'pi pi-envelope',
         disabled: false,
         command: async() => {
            if(multiDocuments.value == null || multiDocuments.value.length == 0){
                toast.add({ severity: 'error', summary: 'Error', detail: 'Please select document!', life: 5000 });
                return;
            }
            sendMail("0");
         }
    },
    {
         label: 'Send mail with Link System',
         icon: 'pi pi-envelope',
         disabled: false,
         command: () => {
            if(multiDocuments.value == null || multiDocuments.value.length == 0){
                toast.add({ severity: 'error', summary: 'Error', detail: 'Please select document!', life: 5000 });
                return;
            }
            sendMail("1");
         }
    },
    {
         label: 'Export data',
         icon: 'pi pi-file-export',
         disabled: false,
         command:() => {
            if(multiDocuments.value == null || multiDocuments.value.length == 0){
                toast.add({ severity: 'error', summary: 'Error', detail: 'Please select document!', life: 5000 });
                return;
            }
             exportDocument();
         }
    },
    {
         label: 'Import data',
         icon: 'pi pi-file-import',
         disabled: false,
         command: async() => {
            var perFolder = await usePermissionFolder().getJsonPermissionByFolder(parentFolder.value.id,categoryID.value);
            if(perFolder.isWrite == false){
                    toast.add({ severity: 'error', summary: 'Error', detail:'This folder not have permission!', life: 5000 });
                    return;
            }
            visibleDialogImport.value = true;
         }
    },{
        separator: true
    },
    {
         label: 'Delete',
         icon: 'pi pi-trash',
         disabled: false,
         command: async() => {
            
            if(multiDocuments.value == null || multiDocuments.value.length == 0){
                toast.add({ severity: 'error', summary: 'Error', detail: 'Please select document!', life: 5000 });
                return;
            }
            for(const document of multiDocuments.value){
            if(document.isFolder){
                var perFolder = await usePermissionFolder().getJsonPermissionByFolder(document.id,categoryID.value);
                if(perFolder.isDelete == false){
                    toast.add({ severity: 'error', summary: 'Error', detail: document.name +' not have permission!', life: 5000 });
                    return;
                }
            }
         }
         var conf = (multiDocuments.value!=null && multiDocuments.value.length == 1)?"Do you want to delete " + multiDocuments.value[0].name: "Do you want to delete this documents?";
            var st = confirm(conf);
            if (st) {
             await deleteMultiDocument();
            }
         }
    },
    {
         label: 'Copy',
         icon: 'pi pi-copypi pi-copy',
         disabled: false,
         command: () => {
            if(multiDocuments.value == null || multiDocuments.value.length == 0){
                toast.add({ severity: 'error', summary: 'Error', detail: 'Please select document!', life: 5000 });
                return;
            }
             copyDocument(multiDocuments.value);
         }
    },
    {
         label: 'Move',
         icon: 'pi pi-directions-alt',
         disabled: false,
         command: () => {
            if(multiDocuments.value == null || multiDocuments.value.length == 0){
                toast.add({ severity: 'error', summary: 'Error', detail: 'Please select document!', life: 5000 });
                return;
            }
             moveDocument(multiDocuments.value);
         }
    },
    {
         label: 'Paste',
         icon: 'pi pi-clone',
         visible: true,
         command: () => {
             pasteDocument();
         }
    },
    {
         label: 'Download',
         icon: 'pi pi-download',
         disabled: false,
         command: () => {
            if(multiDocuments.value == null || multiDocuments.value.length == 0){
                toast.add({ severity: 'error', summary: 'Error', detail: 'Please select document!', life: 5000 });
                return;
            }
            if(multiDocuments.value.length == 1){
                if(multiDocuments.value[0].isFolder){
                    downloadFolder();
                }else{
                    downloadDocument();
                }
            }else{
                downloadMultiDocument();
            }
         }
    },
    {
        separator: true
    },
    {
         label: 'Private',
         icon: 'pi pi-lock',
         disabled: false,
         command: async() => {
            selectDocument.value = parentFolder.value;
            var st = confirm(`Do you want to private folder ${selectDocument.value.name}?`);
            if (st) {
                await useFolder().setPrivate(selectDocument.value.id,true);
                documents.value.find(x=>x.id == selectDocument.value.id).isPrivate = true;
                toast.add({ severity: 'success', summary: 'Success', detail: 'Private successfully!', life: 5000 });
            }
         }
    },
    {
         label: 'Public',
         icon: 'pi pi-lock-open',
         disabled: false,
         command: async() => {
            selectDocument.value = parentFolder.value;
            var st = confirm(`Do you want to public folder ${selectDocument.value.name}?`);
            if (st) {
                await useFolder().setPrivate(selectDocument.value.id,false);
                documents.value.find(x=>x.id == selectDocument.value.id).isPrivate = false;
                toast.add({ severity: 'success', summary: 'Success', detail: 'Public successfully!', life: 5000 });
            }
         }
    },
    {
         label: 'Change Permission',
         icon: 'pi pi-lock-open',
         disabled: false,
         command: () => {
            selectDocument.value = parentFolder.value;
             visibleDialogPermission.value = true;
         }
    },
    {
         label: 'Sync Folder',
         icon: 'pi pi-undo',
         disabled: false,
         command: () => {
            selectDocument.value = parentFolder.value;
             visibleDialogSync.value = true;
         }
    }
  ]);
  const setMenuByPermission = () => {
            fileMenus.value.forEach(item => item.disabled = false);
      if(myUser.value != null){
        if(permission.value != null){
            if(permission.value.isWrite){
                fileMenus.value[2].disabled = false;
            }else{
                fileMenus.value[2].disabled = true;
            }
            if(permission.value.isDelete){
                fileMenus.value[0].disabled = false;
            }else{ 
                fileMenus.value[0].disabled = true;
            }
            if(permission.value.isRead){
                fileMenus.value[1].disabled = false;
            }else{
                fileMenus.value[1].disabled = true;
            }
        }else{
                fileMenus.value.forEach(item => item.disabled = true);
        }
      }else{
        console.log("setMenuByPermission");
        navigateTo('/login');
      }
  }
  const setMenuFolderByPermission = () => {
    folderMenus.value.forEach(item => item.disabled = true);
      if(myUser.value.id == 1){
        folderMenus.value[3].disabled = false;
      }
        if(permissionFolderSelect.value != null){
            if(permissionFolderSelect.value.isDelete){
            folderMenus.value[2].disabled = false;
            }else{ 
                folderMenus.value[2].disabled = true;
            }
            if(permissionFolderSelect.value.isWrite){
            folderMenus.value[0].disabled = false;   
            folderMenus.value[1].disabled = false;
            if(selectDocument.value.isPrivate == true){
                folderMenus.value[0].visible = false;
                folderMenus.value[1].visible = true;
            }else{
                folderMenus.value[1].visible = false;
                folderMenus.value[0].visible = true;
            }
            }else{ 
                folderMenus.value[0].disabled = true;
                folderMenus.value[1].disabled = true;
                if(selectDocument.value.isPrivate == true){
                folderMenus.value[0].visible = false;
                folderMenus.value[1].visible = true;
            }else{
                folderMenus.value[1].visible = false;
                folderMenus.value[0].visible = true;
            }
            }
            if(permissionFolderSelect.value.isRead){
                folderMenus.value[3].disabled = false;
            }else{
                folderMenus.value[3].disabled = true;
            }
            if(permissionFolderSelect.value.isChangePer){
                folderMenus.value[4].disabled = false;
            }else{
                folderMenus.value[4].disabled = true;
            }
        }else{
            folderMenus.value.forEach(item => item.disabled = false);
            if(selectDocument.value.isPrivate == true){
                folderMenus.value[0].visible = false;
                folderMenus.value[1].visible = true;
            }else{
                folderMenus.value[1].visible = false;
                folderMenus.value[0].visible = true;
            }
        }
  }
  const loadpermissionFolder = async () => {
      try{
          permission.value = await usePermissionFolder().getJsonPermissionByFolder(parentFolderID.value,categoryID.value);
          setMenuByPermission();
      }catch(error){
          console.log("Error get:"+error);
      }
  }
  const home = ref({ icon: 'pi pi-home' });
     const value = ref(null);
     const options = ref([
     { icon: 'pi pi-list', value: 'List' },
     { icon: 'pi pi-th-large', value: 'Grid' },
  ]);
  const toggle = async(data) => {
    selectDocument.value = data.data;
     if(breadcrumbItems.value.length > 0){
        if(data.data.isFolder){
         menuFolder.value.toggle(data.event);
            if(data.data.isFolder && categoryID.value != 0 && categoryID.value != null){
                permissionFolderSelect.value = await usePermissionFolder().getJsonPermissionByFolder(data.data.id,categoryID.value);
            }
            setMenuFolderByPermission();
     }else{
        menuFile.value.toggle(data.event);
     }
     }else{
        if(data.data.isFolder){
            menuFolder.value.toggle(data.event);
                permissionFolderSelect.value.isChangePer = true;
                setMenuFolderByPermission();
        }else{
            if(data.data.folderID != null && data.data.folderID != 0){
                menuFile.value.toggle(data.event);
                var per = await usePermissionFolder().getJsonPermissionByFolder(data.data.folderID,categoryID.value);
                if(per.isRead == true){
                    fileMenus.value = [
                        {
                            label: 'Go To Folder',
                            icon: 'pi pi-arrow-right',
                            visible: true,
                            command: () => {
                                window.open(`/document_library?category=${categoryID.value}&folder=${selectDocument.value.folderID}`);
                            }
                        },
                    ];
                }
                else{
                    fileMenus.value = [];
                }
            }
        }
     }
    
  };
  const downloadDocument = async () => {
    isLoading.value = true;
     try{
        var data = multiDocuments.value[0].filePath;
        var response = await useDocument().download(data);
         const link = document.createElement('a');
         let encodedURL = encodeURI(response.data);
         link.href = encodedURL; 
         document.body.appendChild(link);
         link.click();
         document.body.removeChild(link);
     }catch(error){
         console.log(error);
     }
     finally{
          isLoading.value = false;
      }
  }
  const downloadMultiDocument = async () => {
     isLoading.value = true;
      try{
        var docs = [];
        var folders = multiDocuments.value.filter(item => item.isFolder);
        for(const data of folders){
                var perFolder = await usePermissionFolder().getJsonPermissionByFolder(data.id,categoryID.value);
                    if(perFolder.isRead == false){
                        toast.add({ severity: 'error', summary: 'Error', detail: 'Folder ' + data.name +' not have permission!', life: 5000 });
                        return;
                    }
        };
        docs = JSON.parse(JSON.stringify(multiDocuments.value.filter(item => !item.isFolder)));
        var data = new FormData();
        data.append('folders',JSON.stringify(folders));
        data.append('documents',JSON.stringify(docs));
        var response = await useDocument().downloadMulti(data);
        const link = document.createElement('a');
        link.href = response.data;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      }catch(error){
          console.log(error);
      }
      finally{
          isLoading.value = false;
      }
  }
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
     breadcrumbItems.value.push({ label: value.name,data:value});
     parentFolderID.value = value.id;
     parentFolder.value = value;
     loadpermissionFolder();
  }
  const backBreadcrumbItems = (value)=>{
    navigateTo({path:`/document_library`,query:{category:categoryID.value,folder:value.data.id}},{external:true});
  }
  const openDocument = async (data) => {
    try{
        var folders = await useFolder().getFolderByParentAndCategoryNotPermission(data.id,data.categoryID);
        var files = await useDocument().getDocumentByFolder(data.id);
        documents.value = [];
        documents.value = folders.concat(files);
    }catch(error){
        console.log(error);
    }finally{
       
    }
  }
  const copyDocument = (documents) => {
     documentCopyOrMove.value = [];
     documents.forEach(item => {
         documentCopyOrMove.value.push({document:item,type:"copy"});
     });
     sessionStorage.setItem("documentCopyOrMove",JSON.stringify(documentCopyOrMove.value));
  }
  const pasteDocument = async () => {
    isLoading.value = true;
     try{
        var move = false;
        var copy = false;
        documentCopyOrMove.value = JSON.parse(sessionStorage.getItem("documentCopyOrMove"));
        if(documentCopyOrMove.value == null){
            toast.add({ severity: 'error', detail: 'Please select the copy document!', summary: 'Error', life: 5000 });
            return;
        }
        for(const document of documentCopyOrMove.value){
            if(document.document.isFolder){
                var perFolder = await usePermissionFolder().getJsonPermissionByFolder(document.document.id,categoryID.value);
                if(perFolder.isWrite == false){
                    toast.add({ severity: 'error', summary: 'Error', detail: 'You not have permission edit this folder!', life: 5000 });
                    return;
                }
            }
         }
        for(const document of documentCopyOrMove.value){
                if(document.type=="copy"){
                             if(document.document.isFolder){
                                 await useFolder().copyFolder(document.document.id,parentFolder.value.id);
                             }else{
                                 await useDocument().copyFile(document.document.id,parentFolder.value.id);
                             }
                             var fd = new Folder();
                            fd.id = parentFolderID.value;
                            fd.categoryID = categoryID.value;
                            openDocument(fd);
                             copy = true;  
                }
                else{
                     if(document.document.isFolder){
                         await useFolder().moveFolder(document.document.id,parentFolder.value.id);
                     }else{
                         await useDocument().moveFile(document.document.id,parentFolder.value.id);
                     }
                     var fd = new Folder();
                     fd.id = parentFolderID.value;
                     fd.categoryID = categoryID.value;
                     openDocument(fd);
                     move = true;
                }
            }
            if(move){
                sessionStorage.removeItem("documentCopyOrMove");
                var folders = documentCopyOrMove.value.filter(item => item.document.isFolder);
                if(folders != null && folders.length >0){
                    useFolder().refreshFoldersByCategory(categoryID.value);
                }
                toast.add({ severity: 'success', summary: 'Success', detail: 'Move successfully!', life: 5000 });
            }
            if(copy){
                sessionStorage.removeItem("documentCopyOrMove");
                var folders = documentCopyOrMove.value.filter(item => item.document.isFolder);
                if(folders != null && folders.length >0){
                    useFolder().refreshFoldersByCategory(categoryID.value);
                }
                toast.add({ severity: 'success', summary: 'Success', detail: 'Copy successfully!', life: 5000 });
            }
     }catch(err){
        toast.add({ severity: 'error', summary: 'Error', detail: err.response.data, life: 5000 });
     }
     finally{
         isLoading.value = false;
     }
  }
  const moveDocument = async(documents) => {
    var folders = documents.filter(item => item.isFolder);
    for(const data of folders){
        var perFolder = await usePermissionFolder().getJsonPermissionByFolder(data.id,categoryID.value);
        if(perFolder.isRead == false){
            toast.add({ severity: 'error', summary: 'Error', detail: 'Folder '+data.name +' not have permission!', life: 5000 });
            return;
        }
    };
     documentCopyOrMove.value = [];
     documents.forEach(item => {
         documentCopyOrMove.value.push({document:item,type:"move"});
     });
     sessionStorage.setItem("documentCopyOrMove",JSON.stringify(documentCopyOrMove.value));
  }
  const pushBreadcrumbItems=(data)=>{
    isLoading.value = true;
    try{
        breadcrumbItems.value = data;
        openDocument(data[data.length-1].data);
         parentFolderID.value = data[data.length-1].data.id;
         parentFolder.value = data[data.length-1].data;
        loadpermissionFolder();  
    }catch(error){
        console.log(error);
    }
    finally{
         isLoading.value = false;
    }
  }
  const deleteFolder = async (Id) =>{
    isLoading.value = true;
    try{
        await useFolder().delete(Id);
        documents.value = documents.value.filter(item => item.id !== Id);
        useFolder().refreshFoldersByCategory(categoryID.value);
        toast.add({ severity: 'success', summary: 'Deleted successfull!', detail: 'Success', life: 5000 });
    }catch(error){
        console.log(error);
    }
    finally{
        isLoading.value = false;
    }
  }
  const deleteDocument = async (Id) => {
    isLoading.value = true;
    try{
        await useDocument().delete(Id);
        documents.value = documents.value.filter(item => item.id !== Id);
        toast.add({ severity: 'success', summary: 'Deleted successfull!', detail: 'Success', life: 5000 });
    }catch(error){
        console.log(error);
    }
    finally{
        isLoading.value = false;
    }
  }
  const deleteMultiDocument = async () => {
    isLoading.value = true;
     try{
        var isDelete = false;
         for(const document of multiDocuments.value){
            if(document.isFolder){
                var perFolder = await usePermissionFolder().getJsonPermissionByFolder(document.id,categoryID.value);
                if(perFolder.isDelete == false){
                    toast.add({ severity: 'error', summary: 'Error', detail: 'Folder '+document.name +' not have permission!', life: 5000 });
                    return;
                }
            }
         }
         var multis = multiDocuments.value;
         var folders = multiDocuments.value.filter(item => item.isFolder).map(item => item.id);
         var document = multiDocuments.value.filter(item => !item.isFolder).map(item => item.id);
        if(folders.length > 0){
               await useFolder().deleteMulti(folders);
               await useFolder().refreshFoldersByCategory(categoryID.value);
               isDelete = true;
        }
        if(document.length > 0){
               await useDocument().deleteMulti(document);
               isDelete = true;
        }
        if(isDelete){
            documents.value = documents.value.filter(item => !multis.includes(item));
            multiDocuments.value = [];
            toast.add({ severity: 'success', summary: 'Deleted successfull!', detail: 'Success', life: 5000 });
        }
     }
     catch(error){
         document.value = await useDocument().getDocumentByFolder(parentFolderID.value);
         toast.add({ severity: 'error', summary: 'Error!', detail: 'Deleted fail!', life: 5000 });   
     }
     finally{
         isLoading.value = false;
     }
  }
  const downloadFolder=async ()=>{
    isLoading.value = true;
    try{
        var data = multiDocuments.value[0];
        var perFolder = await usePermissionFolder().getJsonPermissionByFolder(data.id,categoryID.value);
        if(perFolder.isDelete == false){
            toast.add({ severity: 'error', summary: 'Error', detail: 'Folder '+data.name +' not have permission!', life: 5000 });
            return;
        }
        var response = await useFolder().download(data.id,data.categoryID);
        const link = document.createElement('a');
        let encodedURL = encodeURI(response);
        link.href = encodedURL;
        document.body.appendChild(link);
        link.click();
        window.URL.revokeObjectURL(link.href);
        document.body.removeChild(link);
    }
    catch(error){
        console.log(error);
    }
    finally{
        isLoading.value = false;
    }
  }
  const onRightClick = async(event) => {
    var passItems = JSON.parse(sessionStorage.getItem("documentCopyOrMove"));
    if(myUser.value.id == 1){
                
        itemConfMenus.value[17].disabled = false;
    }else{
       
        itemConfMenus.value[17].disabled = true;
    }
    if(permission.value.isChangePer){
                itemConfMenus.value[16].disabled = false;
            }else{
                itemConfMenus.value[16].disabled = true;
            }
    if(multiDocuments.value.length == 0){
        itemConfMenus.value[3].disabled = true;
        itemConfMenus.value[4].disabled = true;
        itemConfMenus.value[5].disabled = true;
        itemConfMenus.value[8].disabled = true;
        itemConfMenus.value[9].disabled = true;
        itemConfMenus.value[10].disabled = true;
        itemConfMenus.value[12].disabled = true;
        if(permission.value.isWrite){
            itemConfMenus.value[15].disabled = false;
            itemConfMenus.value[14].disabled = false;
        }else{
            itemConfMenus.value[15].disabled = true;
            itemConfMenus.value[14].disabled = true;
        }
        if(parentFolder.value != null){
                   
                   if(parentFolder.value.isPrivate == true){
                       itemConfMenus.value[14].visible = false;
                       itemConfMenus.value[15].visible = true;
                   }else{
                       itemConfMenus.value[15].visible = false;
                       itemConfMenus.value[14].visible = true;
                   }
               }else{
                   itemConfMenus.value[15].visible = false;
                   itemConfMenus.value[14].visible = false;
               }
    }else{
        itemConfMenus.value[3].disabled = false;
        itemConfMenus.value[4].disabled = false;
        itemConfMenus.value[5].disabled = false;
        itemConfMenus.value[8].disabled = false;
        itemConfMenus.value[9].disabled = false;
        itemConfMenus.value[10].disabled = false;
        itemConfMenus.value[12].disabled = false;
        if(permission.value != null){
           
            if(permission.value.isCreate){
                itemConfMenus.value[0].disabled = false;
            }else{
                itemConfMenus.value[0].disabled = true;
            }
            if(permission.value.isWrite){
                itemConfMenus.value[1].disabled = false;
                itemConfMenus.value[3].disabled = false;
                itemConfMenus.value[4].disabled = false;
                itemConfMenus.value[11].disabled = false;
                itemConfMenus.value[9].disabled = false;
                itemConfMenus.value[10].disabled = false;
                itemConfMenus.value[6].disabled = false;
                itemConfMenus.value[5].disabled = false;
                itemConfMenus.value[14].disabled = false;
                itemConfMenus.value[15].disabled = false;
                
                if(parentFolder.value != null){
                   
                    if(parentFolder.value.isPrivate == true){
                        itemConfMenus.value[14].visible = false;
                        itemConfMenus.value[15].visible = true;
                    }else{
                        itemConfMenus.value[15].visible = false;
                        itemConfMenus.value[14].visible = true;
                    }
                }else{
                    itemConfMenus.value[15].visible = false;
                    itemConfMenus.value[14].visible = false;
                }
            }else{
                itemConfMenus.value[1].disabled = true;
                itemConfMenus.value[3].disabled = true;
                itemConfMenus.value[4].disabled = true;
                itemConfMenus.value[11].disabled = true;
                itemConfMenus.value[9].disabled = true;
                itemConfMenus.value[10].disabled = true;
                itemConfMenus.value[6].disabled = true;
                itemConfMenus.value[5].disabled = true;
                itemConfMenus.value[14].disabled = true;
                itemConfMenus.value[15].disabled = true;
                if(parentFolder.value != null){
                   
                   if(parentFolder.value.isPrivate == true){
                       itemConfMenus.value[14].visible = true;
                       itemConfMenus.value[15].visible = false;
                   }else{
                       itemConfMenus.value[15].visible = true;
                       itemConfMenus.value[14].visible = false;
                   }
               }else{
                   itemConfMenus.value[15].visible = false;
                   itemConfMenus.value[14].visible = false;
               }
            }
            if(permission.value.isDelete){
                itemConfMenus.value[8].disabled = false;
            }else{ 
                itemConfMenus.value[8].disabled = true;
            }
            if(permission.value.isRead){
                itemConfMenus.value[12].disabled = false;
            }else{
                itemConfMenus.value[12].disabled = true;
            }
            
        }else{
                itemConfMenus.value.forEach(item => item.disabled = true);  
        }
    }
    if(passItems == null || passItems.length == 0){
        itemConfMenus.value[11].disabled = true;
    }else{
        itemConfMenus.value[11].disabled = false;
    }
    
    menuContent.value.show(event);
  }
  const exportDocument =async ()=>{
    isLoading.value = true;
            try{
                if(multiDocuments.value == undefined || multiDocuments.value.length == 0){ 
                    toast.add({ severity: 'error', summary: 'Error', detail: 'Please select document!', life: 5000 });
                    return;
                }
                if(categoryID.value == null){
                    toast.add({ severity: 'error', summary: 'Error', detail: 'Please select department!', life: 5000 });
                    return;
                }
                var nameFolder = breadcrumbItems.value[breadcrumbItems.value.length-1].data.name;
                if(multiDocuments.value && multiDocuments.value.length > 0){
                            var docs = multiDocuments.value.filter(d=> !d.isFolder);
                            var folders = multiDocuments.value.filter(d=> d.isFolder);
                            for(const data of folders){
                                var perFolder = await usePermissionFolder().getJsonPermissionByFolder(data.id,categoryID.value);
                                    if(perFolder.isWrite == false){
                                        toast.add({ severity: 'error', summary: 'Error', detail: data.name +' not have permission!', life: 5000 });
                                        return;
                                    }
                            };
                            var data = {documents:docs,folders:folders,categoryID:categoryID.value};
                            var response = await useDocument().export(data);
                                const link = document.createElement('a');
                                link.href = response;
                                document.body.appendChild(link);
                                link.click();
                                document.body.removeChild(link);
                }
                else{
                    toast.add({ severity: 'error', summary: 'Error', detail: 'This folder is empty!', life: 5000 });
                }
            }
            catch(error){
                console.log(error);
            }
            finally{
                isLoading.value = false;
            }
  }
  const upIsLoading = (value) => {
     isLoading.value = value;
  }
const onLoad=async()=>{   
     isLoading.value = true;
    try{
        paramArray.value = route.query;
        if(paramArray.value.category == 0 || paramArray.value.category == ""|| paramArray.value.category == null){
            useCategories().clearCategories();
            useFolder().clearFolders();
            useExpandedFolder().reset();
            var categories = await useCategories().getAllByPermission();
            if(categories.length > 0){
                categoryID.value = categories[0].id;
                navigateTo({path:`/document_library`,query:{category:categoryID.value}},{external:true});
            }
            else{
                permission.value = null;
                setMenuByPermission();
            }
        }
        else{
            categoryID.value = Number(paramArray.value.category);
            if(paramArray.value.folder != null && paramArray.value.folder != "" && paramArray.value.folder != undefined){
                const folderCurrent = await reloadBreadcrumb(paramArray.value.folder);
                await openDocument(folderCurrent);
                setParentFolder(folderCurrent);
                loadpermissionFolder();   
            }
            else{
                getFolderByCategory();
                parentFolderID.value = null;
                parentFolder.value = null;
                permission.value = null;
                setMenuByPermission();
            }
        }
    }catch(error){
        console.log("Error get list document:"+error);
    }finally{
        isLoading.value = false;
    }
}
const sendMail = async(type) => {
        var folders = multiDocuments.value.filter(item => item.isFolder);
        for(const data of folders){
            var perFolder = await usePermissionFolder().getJsonPermissionByFolder(data.id,categoryID.value);
            if(perFolder.isRead == false){
                    toast.add({ severity: 'error', summary: 'Error', detail: 'Folder '+data.name +' not have permission!', life: 5000 });
                    return;
            }
        };
        typeSendMail.value = type;
        visibleDialogSendMail.value = true;
}
const onLoading = (value) => {
    isLoading.value = value;
}
await onLoad();
</script>
<style>
.p-toast{
    z-index: 999999 !important;
}
#dialogEditDoc .p-dialog-content{
    overflow: hidden;
}
.p-dialog-mask{
    overflow-y: auto;
}
.disabled {
  pointer-events: none;
  color: gray;
  text-decoration: none;
  cursor: not-allowed;
}
.p-breadcrumb{
    padding: 0 !important;
}
</style>