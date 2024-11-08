<template>
    <div class="flex flex-1 flex-row relative">
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
                 <div class="flex">
                 <IconField iconPosition="left" class="mr-2 h-[2rem]">
                         <InputIcon class="pi pi-search" @click="onSearch"> </InputIcon>
                         <InputText v-model="search" placeholder="Search" class="h-[2rem]" @keyup.enter="onSearch"/>
                 </IconField>
                 <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="toggleAdd" />
                 <Button icon="pi pi-spin pi-cog" class="mr-2 h-[2rem] bg-[#4410b9]" @click="toggleConf" />
                 </div>
             </div>
            <div class="flex w-full flex-1 flex-row">
             <div id="content_grid" class="flex w-full flex-1">
                 <TabView v-model:activeIndex="active">
                 <TabPanel header="Header I">
                     <DocumentLibaryList :documents="documents" @nextbreadcrumbItems="nextbreadcrumbItems" @openDocument="openDocument" @toggle="toggle" v-model="multiDocuments"
                     :permissionParent="permission" :categoryID="categoryID"/>
                 </TabPanel>
                 <TabPanel header="Header II">
                     <DocumentLibaryGrid :documents="documents" @nextbreadcrumbItems="nextbreadcrumbItems" @openDocument="openDocument" @toggle="toggle"/>
                 </TabPanel>
             </TabView>
             </div>
             <div id="sidebarEdit" class="sidebarEdit">
                <FolderInfor :parentFolder = "parentFolder"/>
         <!-- <DocumentLibaryEdit v-if="selectDocument.type === 'document'" @closeNav="closeSidebarRight" :documents="documents" :selectDocument="selectDocument" :parentFolderID="parentFolderID"/>
         <FolderEdit v-else @closeNav="closeSidebarRight" :documents="documents" :selectDocument="selectDocument" :categoryID="categoryID" :parentFolderID="parentFolderID"/> -->
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
     <Dialog v-model:visible="visibleDialogUpload" modal header="Upload Document" :style="{ width: '50rem' }">
         <UploadDocument v-model="visibleDialogUpload" :parentFolderID="parentFolderID" :categoryID="categoryID" @openDocument="openDocument" :isLoading="isLoading"/>
     </Dialog>
     <Dialog v-model:visible="visibleDialogImport" modal header="Import data" :style="{ width: '50rem' }">
         <DocumentLibaryImport v-model="visibleDialogImport" :parentFolderID="parentFolderID" :categoryID="categoryID" @openDocument="openDocument"/>
     </Dialog>
     <Dialog v-model:visible="visibleDialogPermission" modal header="Change Permission" class="w-[70rem] max-h-[45rem] rounded-none">
         <DocumentLibaryPermision v-model="visibleDialogPermission" :selectDocument="selectDocument"/>
     </Dialog>
     <Dialog v-model:visible="visibleDialogSendMail" modal header="Send Mail" class="w-[60rem] max-h-[45rem] rounded-none">
        <DocumentLibarySendMail v-model="visibleDialogSendMail" :multiDocuments="multiDocuments" :typeSendMail="typeSendMail"/>
     </Dialog>
     <Dialog v-model:visible="visibleDialogSync" modal header="Sync Folder"  class="w-[80rem] max-h-[50rem]">
         <DocumentLibarySync v-model="visibleDialogSync" :folderID="selectDocument.object.id"/>
     </Dialog>
     <Dialog v-model:visible="visibleDialogDocEdit" id="dialogEditDoc" modal header="Create Document"  class="w-[500px] max-h-[45rem]">
         <DocumentLibaryEdit v-model="visibleDialogDocEdit" :documents="documents" :selectDocument="selectDocument" :parentFolderID="parentFolderID" :disciplines="disciplines" :models="models" :manufacturers="manufacturers" :documentTypes="documentTypes" :types="types" :tags="tags" />
     </Dialog>
     <Dialog v-model:visible="visibleDialogFolderEdit" modal header="Create Folder"  class="w-[500px] max-h-[40rem]">
         <FolderEdit v-model="visibleDialogFolderEdit" :documents="documents" :selectDocument="selectDocument" :categoryID="categoryID" :parentFolderID="parentFolderID"/>
     </Dialog>
     <Toast /> 
     <loading v-model:active="isLoading"
                 :is-full-page="true" color="#10b981"/>
    </div>
  </template>
  <script setup>
     definePageMeta({
     layout: 'default'
  })
  import {ref,onMounted} from 'vue';
  import ListDepartment from '~/components/department/list-department.vue';
  import {Folder} from '../../models/folder.js';
  import {Document} from '../../models/document.js';
  import '../../assets/css/sidebar.css';
  import { useToast } from "primevue/usetoast";
  import Loading from 'vue-loading-overlay';
  import {useCategories} from '~/stores/categories';
  //import document store
  import { useDocument } from '~/stores/document';
  import { useFolder } from '~/stores/folder';
  import { usePermissionFolder } from '~/stores/permissionFolder';
  import { storeToRefs } from 'pinia';
  import { useRoute } from 'vue-router';
const router = useRoute();
const { data: files_store } = storeToRefs(useDocument());
const { data: folders_store } = storeToRefs(useFolder());
  //end document store
    import 'vue-loading-overlay/dist/css/index.css';
import { elements } from 'chart.js';
    const isLoading = ref(false)
  const toast = useToast();
  const documents = ref([]);
  const visibleDialogUpload = ref(false);
  const visibleDialogPermission = ref(false);
  const visibleDialogSendMail = ref(false);
  const visibleDialogSync = ref(false);
  const visibleDialogDocEdit = ref(false);
  const visibleDialogFolderEdit = ref(false);
  const visibleDialogImport = ref(false);
  const active = ref(0);
  const menuFolder = ref();
  const menuFile = ref();
  const menuAdd = ref();
  const menuConf = ref();     
  const multiDocuments = ref();
  const documentCopyOrMove = ref({});
  const selectDocument = ref({type:'',object:{}});
  const categoryID = ref(null);
  const parentFolderID = ref(null);
  const parentFolder = ref(null);
  const search = ref("");
  const typeSendMail = ref("0");
  const myUser = ref(null);
  const permission = ref(null);
  const permissionFolderSelect = ref({
    isWrite: false,
    isRead: false,
    isDelete: false,
    isChangePer: false,
    isCreate: false,
});
const paramArray = ref([]);
onMounted (async() => {
    paramArray.value = router.params.id;
    myUser.value = JSON.parse(sessionStorage.getItem("userLogin"));
   
    if(paramArray.value.length == 0 || paramArray.value == ""|| paramArray.value == null){
       var data = await getCategories();
      
       if(data.length>0){
           categoryID.value = data[0].id;
           window.location.href = `/documentTest/${categoryID.value}`;
       }
    }
    else{
        categoryID.value = Number(paramArray.value[0]);
        if(paramArray.value.length>1){
            const folderCurrent =await reloadBreadcrumb(paramArray.value[paramArray.value.length-1]);
            openDocument(folderCurrent);
            setParentFolder(folderCurrent);
            loadpermissionFolder();   
            
        }else{
            getFolderByCategory();
            parentFolderID.value = null;
            parentFolder.value = null;
            permission.value = null;
            setMenuByPermission();
        }
    }
  });
  const setParentFolder = (obj)=>{
    parentFolderID.value = obj.id;
    parentFolder.value = obj;
  }
  const getCategories = async () => {
 try{
    
    if(myUser.value != null){
        const data = await useCategories().getAllByPermission(myUser.value.id);
        return data;
    }else{
        navigateTo('/login');
    }
     
 }catch(error){
     console.log(error);
 }
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
         var document = [];
         document.type = "folder";
         document.object = item;
         documents.value.push(document);
         });
         breadcrumbItems.value = [];
        
         }
         catch(error){
             console.log("Error get list document:"+error);
         }
     }
     const breadcrumbItems = ref([
     ]);
     const folderMenus = ref([
     {
         label: 'Delete',
         icon: 'pi pi-trash',
         visible: true,
         command: () => {
            var st = confirm("Do you want to delete this folder?");
            if (st) {
             deleteFolder(selectDocument.value.object.id);
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
         label: 'Paste',
         icon: 'pi pi-clone',
         visible: true,
         command: () => {
             pasteDocument();
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
            var st = confirm("Do you want to delete this document?");
            if (st) {
                deleteDocument(selectDocument.value.object.id);
            }
             
         }
     },
     {
         label: 'Downlaod',
         icon: 'pi pi-download',
         visible: true,
         command: () => {
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
     
  ]);
  const itemAddMenus = ref([
     {
         label: 'Create Folder',
         icon: 'pi pi-folder-plus',
         visible: true,
         command: () => {
             selectDocument.value = {type:'folder', object: new Folder()};
             if(breadcrumbItems.value.length>0){
                 parentFolderID.value = breadcrumbItems.value[breadcrumbItems.value.length-1].data.object.id;
                 parentFolder.value = breadcrumbItems.value[breadcrumbItems.value.length-1].data.object;
             }
             visibleDialogFolderEdit.value = true;
         }
     },  
     
     {
         label: 'Create Document',
         icon: 'pi pi-file-plus',
         visible: true,
         command: () => {
             selectDocument.value = {type:'document', object: new Document()};
             if(breadcrumbItems.value.length>0){
                 parentFolderID.value = breadcrumbItems.value[breadcrumbItems.value.length-1].data.object.id;
                 parentFolder.value = breadcrumbItems.value[breadcrumbItems.value.length-1].data.object;
             }
             visibleDialogDocEdit.value = true;
         }
     },
    
     {
         label: 'Upload',
         icon: 'pi pi-upload',
         visible: true,
         command: () => {
             visibleDialogUpload.value = true;
         }
     },
  ]);
  const itemConfMenus = ref([
     {
         label: 'Send mail with Attchment',
         icon: 'pi pi-envelope',
         visible: true,
         command: () => {
             typeSendMail.value = "0";
             visibleDialogSendMail.value = true;
         }
     },
    
     {
         label: 'Send mail with Link System',
         icon: 'pi pi-envelope',
         visible: true,
         command: () => {
             typeSendMail.value = "1";
             visibleDialogSendMail.value = true;
         }
     },
    
     {
         label: 'Export data',
         icon: 'pi pi-file-export',
         visible: true,
         command:() => {
             exportDocument();
         }
     },
     
     {
         label: 'Import data',
         icon: 'pi pi-file-import',
         visible: true,
         command: () => {
             visibleDialogImport.value = true;
         }
     },
    
     {
         label: 'Delete multi documents',
         icon: 'pi pi-trash',
         visible: true,
         command: () => {
            var st = confirm("Do you want to delete this documents?");
            if (st) {
             deleteMultiDocument();
            }
         }
     },
     {
         label: 'Copy multi documents',
         icon: 'pi pi-copypi pi-copy',
         visible: true,
         command: () => {
             copyDocument(multiDocuments.value);
         }
     },
    
     {
         label: 'Move multi documents',
         icon: 'pi pi-directions-alt',
         visible: true,
         command: () => {
             moveDocument(multiDocuments.value);
         }
     },
     {
         label: 'Download multi documents',
         icon: 'pi pi-download',
         visible: true,
         command: () => {
            downloadMultiDocument();
         }
     },
  ]);
  const setMenuByPermission = () => {
 
    itemAddMenus.value.forEach(item => item.visible = true);
            itemConfMenus.value.forEach(item => item.visible = true);
            fileMenus.value.forEach(item => item.visible = true);
       
      if(myUser.value != null){
            if(myUser.value.id != 1){
            folderMenus.value[6].visible = false;
        }
        if(permission.value != null){
            if(permission.value.isCreate){
                itemAddMenus.value[0].visible = true;
            }else{
                itemAddMenus.value[0].visible = false;
            }
            if(permission.value.isDelete){
                itemConfMenus.value[4].visible = true;
                fileMenus.value[0].visible = true;
            // folderMenus.value[0].visible = true;
            }else{ 
                itemConfMenus.value[4].visible = false;
                fileMenus.value[0].visible = false;
                //folderMenus.value[0].visible = false;
            }
            if(permission.value.isWrite){
                itemConfMenus.value[0].visible = true;
                itemConfMenus.value[1].visible = true;
                itemConfMenus.value[2].visible = true;
                itemConfMenus.value[3].visible = true;
                itemConfMenus.value[4].visible = true;
                itemConfMenus.value[5].visible = true;
                itemConfMenus.value[6].visible = true;
                itemAddMenus.value[1].visible = true;
                itemAddMenus.value[2].visible = true;
                fileMenus.value[2].visible = true;
            }else{
                itemConfMenus.value[0].visible = false;
                itemConfMenus.value[1].visible = false;
                itemConfMenus.value[2].visible = false;
                itemConfMenus.value[3].visible = false;
                itemConfMenus.value[4].visible = false;
                itemConfMenus.value[5].visible = false;
                itemConfMenus.value[6].visible = false;
                itemAddMenus.value.forEach(item => item.visible = false);
                fileMenus.value[2].visible = false;
            }
            if(permission.value.isRead){
                itemConfMenus.value[7].visible = true;
                
                fileMenus.value[1].visible = true;
            }else{
                itemConfMenus.value[7].visible = false;
                fileMenus.value[1].visible = false;
            }
            // if(permission.value.isChangePer){
            //     folderMenus.value[2].visible = true;
            // }else{
            //     folderMenus.value[2].visible = false;
            // }
        }else{
                itemAddMenus.value.forEach(item => item.visible = false);
                itemConfMenus.value.forEach(item => item.visible = false);
                fileMenus.value.forEach(item => item.visible = false);
        }
      }else{
        console.log("setMenuByPermission");
        navigateTo('/login');
      }
  }
  const setMenuFolderByPermission = () => {
    folderMenus.value.forEach(item => item.visible = false);
   
      if(myUser.value.id != 1){
        folderMenus.value[6].visible = false;
      }
        if(permissionFolderSelect.value != null){
            if(permissionFolderSelect.value.isDelete){
            folderMenus.value[0].visible = true;
            }else{ 
                folderMenus.value[0].visible = false;
            }
            if(permissionFolderSelect.value.isWrite){
                folderMenus.value[3].visible = true;
                folderMenus.value[5].visible = true;
                folderMenus.value[4].visible = true;
            }else{
                folderMenus.value[3].visible = false;
                folderMenus.value[5].visible = false;
                folderMenus.value[4].visible = true;
            }
            if(permissionFolderSelect.value.isRead){
                folderMenus.value[1].visible = true;
            }else{
                folderMenus.value[1].visible = false;
            }
            if(permissionFolderSelect.value.isChangePer){
                folderMenus.value[2].visible = true;
            }else{
                folderMenus.value[2].visible = false;
            }
      }else{
            folderMenus.value.forEach(item => item.visible = true);
      }
  }
  const loadpermissionFolder = async () => {
      try{
          permission.value = await usePermissionFolder().getJsonPermissionByFolder(parentFolderID.value,categoryID.value,myUser.value.id);
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
     if(data.data.type==="folder"){
         menuFolder.value.toggle(data.event);
            if(data.data.type == "folder" && categoryID.value != 0 && categoryID.value != null){
                permissionFolderSelect.value = await usePermissionFolder().getJsonPermissionByFolder(data.data.object.id,categoryID.value,myUser.value.id);
            }
            setMenuFolderByPermission();
     }else{
         menuFile.value.toggle(data.event);
     }
     selectDocument.value = data.data;
  };
  const downloadDocument = async () => {
    isLoading.value = true;
     try{
        var data = selectDocument.value.object.filePath;
       
        var response = await useDocument().download(data);
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
  const downloadMultiDocument = async () => {
     isLoading.value = true;
      try{
        var data = [];
        data = JSON.parse(JSON.stringify(multiDocuments.value.filter(item => item.type === 'document').map(item => item.object)));
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
     breadcrumbItems.value.push({ label: value.object.name,data:value});
     parentFolderID.value = value.object.id;
     parentFolder.value = value.object;
     loadpermissionFolder();
  }
  const backBreadcrumbItems = (value)=>{
      window.location.href = `/documentTest/${categoryID.value}/${value.data.id}`;
  }
  const openDocument = async (data) => {
    isLoading.value = true;
    try{
        
        if(myUser.value != null){
   
    var folders = await useFolder().getFolderByParentAndCategory(data.id,data.categoryID,myUser.value.id);
     var files = await useDocument().getDocumentByFolder(data.id);
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
        else{
          
            navigateTo('/login');
         }
     
    }catch(error){
        console.log(error);
    }finally{
        isLoading.value = false;
    }
  }
  
  const copyDocument = (documents) => {
     documentCopyOrMove.value = [];
     documents.forEach(item => {
         documentCopyOrMove.value.push({document:item,type:"copy"});
     })
  }
  const pasteDocument = async () => {
    isLoading.value = true;
     try{
        var move = false;
        var copy = false;
         for(const document of documentCopyOrMove.value){
                 if(document.type=="copy"){
                             if(document.document.type=="folder"){
                                 
                                 await useFolder().copyFolder(document.document.object.id,selectDocument.value.object.id);
                             }else{
                                 await useDocument().copyFile(document.document.object.id,selectDocument.value.object.id,myUser.value.id);
                             }
                             copy = true;  
                 }
                 else{
                     if(document.document.type=="folder"){
                         await useFolder().moveFolder(document.document.object.id,selectDocument.value.object.id);
                     }else{
                         await useDocument().moveFile(document.document.object.id,selectDocument.value.object.id,myUser.value.id);
                     }
                     var fd = new Folder();
                     fd.id = parentFolderID.value;
                     fd.categoryID = categoryID.value;
                     var data = { object:fd,type:"folder"};
                     openDocument(data);
                     move = true;
                 }
             }
             if(move){
                 toast.add({ severity: 'success', summary: 'Move successfully!', detail: 'Success', life: 5000 });
             }
             if(copy){
                 toast.add({ severity: 'success', summary: 'Copy successfully!', detail: 'Success', life: 5000 });
             }
     }catch(err){
         console.log(err);
     }
     finally{
         isLoading.value = false;
     }
  }
  const moveDocument = (documents) => {
     documentCopyOrMove.value = [];
     documents.forEach(item => {
         documentCopyOrMove.value.push({document:item,type:"move"});
     })
  }
  const pushBreadcrumbItems=(data)=>{
    isLoading.value = true;
    try{
        breadcrumbItems.value = data;
        openDocument(data[data.length-1].data);
         parentFolderID.value = data[data.length-1].data.object.id;
         parentFolder.value = data[data.length-1].data.object;
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
         documents.value = documents.value.filter(item => item.object.id !== Id);
          toast.add({ severity: 'success', summary: 'Deleted successfull!', detail: 'Success', life: 5000 });
     }catch(error){
         console.log(error);
     }
     finally{
         isLoading.value = false;
     }
  }
  const deleteDocument = async (Id) =>{
    isLoading.value = true;
     try{
         await useDocument().delete(Id);
         documents.value = documents.value.filter(item => item.object.id !== Id);
         toast.add({ severity: 'success', summary: 'Deleted successfull!', detail: 'Success', life: 5000 });
     }catch(error){
         console.log(error);
     }
     finally{
         isLoading.value = false;
     }
  }
  const onSearch = async () => {
    isLoading.value = true;
     try{
        if(categoryID.value != null){
            documents.value = [];
            var folders = await useFolder().searchByCategory(search.value,categoryID.value);
            var files = await useDocument().searchByCategory(search.value,categoryID.value);
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
        }else{
           documents.value = [];
        var folders = await useFolder().search(search.value);
        var files = await useDocument().search(search.value);
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
        }
        breadcrumbItems.value = [];
     }
     catch(error){
         console.log(error);
     }
     finally{
         isLoading.value = false;
     }
  }
  const deleteMultiDocument = async () => {
    isLoading.value = true;
     try{
        
         for(const document of multiDocuments.value){
             if(document.type=="folder"){
                 await useFolder().delete(document.object.id);
             }else{
                 await useDocument().delete(document.object.id);
             }
             documents.value = documents.value.filter(item => item != document);
         }
         toast.add({ severity: 'success', summary: 'Deleted successfull!', detail: 'Success', life: 5000 });
     }catch(error){
         toast.add({ severity: 'error', summary: 'Error!', detail: 'Deleted fail!', life: 5000 });   
     }
     finally{
         isLoading.value = false;
     }
  }
  const downloadFolder=async ()=>{
    isLoading.value = true;
     try{
        var data = selectDocument.value.object;
        var response = await useFolder().download(data.id,data.categoryID);
        const link = document.createElement('a');
            link.href = response;
            document.body.appendChild(link);
            link.click();
            window.URL.revokeObjectURL(link.href);
            document.body.removeChild(link);
     }catch(error){
         console.log(error);
     }
     finally{
         isLoading.value = false;
     }
  }
  const exportDocument =async ()=>{
    isLoading.value = true;
            try{
                if(multiDocuments.value == undefined || multiDocuments.value.length == 0){ 
               multiDocuments.value = documents.value;
            }
            if(categoryID.value == null){
                toast.add({ severity: 'error', summary: 'Error', detail: 'Please select department!', life: 5000 });
                return;
            }
            var nameFolder = breadcrumbItems.value[breadcrumbItems.value.length-1].data.object.name;
            if(multiDocuments.value && multiDocuments.value.length > 0){
                    var docs = multiDocuments.value.filter(d=> d.type =="document").map(d=>d.object);
                    var folders = multiDocuments.value.filter(d=> d.type =="folder").map(d=>d.object);
                    var data = {documents:docs,folders:folders,categoryID:categoryID.value};
                    var response = await useDocument().export(data);
                        const link = document.createElement('a');
                        link.href = response;
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link);
               
            }else{
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
  </script>
  <style>
  .p-tabview-nav-container{
     display: none;
  }
  .p-tabview{
      display: block;
      flex: 1 1 auto;
      width: 0;
  }
  .p-dialog{
    border-radius: 0;
  }
  #dialogEditDoc .p-dialog-content{
    overflow: hidden;

  }
  </style>