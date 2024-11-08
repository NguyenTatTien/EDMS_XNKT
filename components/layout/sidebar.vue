<template>
    <div class="card flex border-b">
        <Sidebar v-model:visible="visible">
            <template #container="{ closeCallback }">
                <div class="flex flex-col h-full">
                    <div class="flex items-center justify-between px-4 pt-3 shrink-0">
                        <span class="inline-flex items-center gap-2">
                            <img src="../../assets/Images/THEA_Logo_vn_Backup.png" alt="logo" height="100" class="mr-2" />
                        </span>
                        <span>
                            <Button type="button" @click="closeCallback" icon="pi pi-times" rounded outlined class="h-2rem w-2rem"></Button>
                        </span>
                    </div>
                    <div class="overflow-y-auto">
                        <PanelMenu :model="items" class="w-full md:w-20rem mt-10">
                            <template #item="{ item }">
                                <a v-if="item.items" v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparent" :href="item.url" :target="item.target">
                                    <i :class="item.icon" style="color: #3b82f6;"/>
                                    <span class="ml-2 text-black text-base">{{ item.label }}</span>
                                    <span v-if="item.items" class="pi pi-angle-down text-black ml-auto " />
                                </a>
                                <div v-else>
                                    <a v-if="item.label != 'Upload'" v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparent" :href="item.url" :target="item.target">
                                    <i :class="item.icon" style="color: #3b82f6;"/>
                                    <span class="ml-2 text-black text-base">{{ item.label }}</span>
                                    </a>
                                    <FileUpload v-else-if="user.roleId==1" name="demo[]" url="/api/upload" :multiple="false" :maxFileSize="100000000" class="flex items-center cursor-pointer px-3 py-2 bg-transparent" @select="onSelectedFiles">
                                        <template #header={chooseCallback}>
                                            <a v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparen hover:bg-[#f1f5f9] w-full" :target="item.target" @click="chooseCallback">
                                                <i :class="item.icon" style="color: #3b82f6;"/>
                                                <span class="ml-2 text-black text-base">{{ item.label }}</span>
                                            </a>
                                        </template>
                                    </FileUpload>
                                </div>
                            </template>
                        </PanelMenu>
                    </div>
                </div>
            </template>
        </Sidebar>
        <div class="flex justify-between w-full items-center">
            <div class="flex items-center">
                <div class="flex items-center w-[300px]">
                    <Button icon="pi pi-bars" class="p-button-rounded p-button-text" @click="visible = true" />
                </div>
                <IconField v-if="props.categoryID != null" iconPosition="left" class="ml-2 h-[2rem]">
                         <InputIcon class="pi pi-search"> </InputIcon>
                         <InputText v-model="search" placeholder="Search" class="h-[2rem] w-[400px] rounded-none" @keyup.enter="onSearch"/>
                </IconField>
            </div>
            <div class="px-5 flex items-center">
                <div class="flex gap-2 items-center cursor-pointer" @click="menuUser.toggle($event)"><div class="flex flex-col"><span class="font-semibold">{{ user.username }}</span><span class="text-sm">{{ user.fullName }}</span></div></div>
            </div>
        </div>
        <Menu ref="menuUser" id="overlay_menu" :model="itemMenu" :popup="true">
        <template #item="{ item, props }">
            <a v-ripple class="flex align-items-center" v-bind="props.action" v-if="item.visible">
                <span :class="item.icon" />
                <span class="ml-2">{{ item.label }}</span>
            </a>
        </template>
    </Menu>
    <Dialog v-model:visible="visibleDialog" modal header="Change Password"  class="w-[500px] max-h-[40rem]">
         <UserChangePassword v-model="visibleDialog" :userLogin="user"/>
    </Dialog>
    <Toast /> 
    </div>
</template>
<script setup>
import { ref,onMounted } from "vue";
import { userLogin } from "~/api/userAPI";
import {useUser} from '~/stores/user';
import { useMenu } from "~/stores/menu";
import { useCategories } from "~/stores/categories";
import { storeToRefs } from 'pinia';
import { useToast } from "primevue/usetoast";
import { useDomain } from "~/stores/domain";
import { useDocument } from "~/stores/document";
const {menu} = storeToRefs(useMenu());
const emit = defineEmits(["update:modelValue","onLoading",'categoryID','parentFolderID']);
const props = defineProps(["categoryID","parentFolderID"]);
const documents = ref([]); 
const toast = useToast();
const user = ref("");
const search = ref("");
const menuUser = ref();
const visibleDialog = ref(false);
const categoryID = ref(null);
const itemMenu = ref([
     {
         label: 'Change Password',
         icon: 'pi pi-key',
         visible: true,
         command: () => {
             visibleDialog.value = true;
         }
     },
     {
         label: 'Logout',
         icon: 'pi pi-sign-out',
         visible: true,
         command:async () => {
                await useUser().logOut();
                useUser().clearUser();
               useMenu().clearMenu();
               useCategories().clearCategories();
            window.location.href = "/login";
         }
     },
]);
onMounted(async() => {
    if(useUser().getUser()){
        user.value = useUser().getUser();
        if(user.value == null){
            window.location.href = "/login";
        }
    }else{
        window.location.href = "/login";
    }
    await getMenus();
})
const getMenus=async()=>{
    try{
       var menus = [];
        if(menu.value != null && menu.value.length > 0){
            menus =  menu.value;
        }
        else{
            menus =  await useMenu().getAllByUser();
        }
        for(var it of menus.filter(t=>t.parentId == null)){
            var item = {
                id:it.id,
                label: it.description,
                icon:it.icon_2,
                url:it.url_2,
                items: null,
            }
            getChildItem(item,menus);
            items.value.push(item);
        }
        items.value.push({
            label: 'Instructions documents',
            icon: 'pi pi-address-book',
            url: null,
            items: [
                {
                    label: 'Download',
                    icon: 'pi pi-download',
                    url: useDomain().url.server + "/document/HDSD-XNKT.docx",
                    items: null,
                },
                {
                    label: 'Upload',
                    icon: 'pi pi-upload',
                    url: '',
                    items: null,
                },
            ]
        });
    }catch(e){
        console.log(e);
    }
}
const getChildItem = (item,menus) =>{
    var childs = menus.filter(t=>t.parentId == item.id);
    if(childs.length>0){
        item.items = [];
        for(var child of childs){
            var childItem = {
                id:child.id,
                label: child.description,
                icon:child.icon_2,
                url:child.url_2,
                items: null,
            }
            item.items.push(childItem);
            getChildItem(childItem,menus);
        }
    }
}
const onSearch = async () => {
    emit("onLoading",true);
    try{
        if(search.value != ""){
            if(props.parentFolderID != null){
            documents.value = [];
            documents.value = await useDocument().searchDocumentAllChild(props.parentFolderID,search.value);
            emit("update:modelValue",documents.value);
            }else if(props.categoryID != null){
                documents.value = await useDocument().searchByCategory(search.value,props.categoryID);
                emit("update:modelValue",documents.value);
            }
        }else{
            window.location.reload();
        }
    }
    catch(error){
        console.log(error);
    }
    finally{
        emit("onLoading",false);
    }
}
const onSelectedFiles = async(event) => {
    if(event.files.length > 0){
        if(event.files[0].type != "application/vnd.openxmlformats-officedocument.wordprocessingml.document"|| event.files[0].type != "aapplication/msword"){
            var data = new FormData();
            data.append('formFile', event.files[0]);
            await useDocument().uploadInsDocument(data);
            toast.add({ severity: 'success', summary: 'Success', detail:'Upload file success!', life: 5000 });
        }else{
            toast.add({ severity: 'error', summary: 'Error', detail:'You are only allowed to upload word files!', life: 5000 });
            return false;
        }
    }
}
const visible = ref(false);
const items = ref([]);
</script>
<style>
.p-panelmenu-panel{
    border: none !important;
}
.p-panelmenu a{
    text-decoration: none;
}
.p-submenu-list .p-fileupload-buttonbar{
    padding: 0 !important;
    width: 100% !important;
    border: none !important;
}
.p-submenu-list .p-fileupload-content{
    display: none !important;
}
</style>