<template>
    <table id="tbPermisstion">
        <tr>
            <td class="w-[450px]">
                <TabView>
                    <TabPanel header="Groups">
                        <Listbox :options="groups" filter optionLabel="data.name" class="w-full md:w-14rem h-[300px] overflow-y-auto">
                            <template #option="slotProps">
                                <div class="flex align-items-center">
                                    <Checkbox v-model="slotProps.option.checked" :binary="true"/>
                                    <div class="ml-2">{{ slotProps.option.data.name }}</div>
                                </div>
                            </template>
                        </Listbox>
                    </TabPanel> 
                    <TabPanel header="Users">
                        <Listbox :options="users" filter optionLabel="data.fullName" class="w-full w-14rem h-[300px] overflow-y-auto">
                            <template #option="slotProps">
                                <div class="flex align-items-center">
                                    <Checkbox v-model="slotProps.option.checked" :binary="true"/>
                                    <div class="ml-2">{{ slotProps.option.data.fullName }}</div>
                                </div>
                            </template>
                        </Listbox>
                    </TabPanel>
                </TabView>
            </td>
            <td>
                <div>
                    <div class="flex align-items-center pt-3">
                        <Checkbox v-model="checkApply" :binary="true"/>
                        <label for="check" class="ml-2">Apply for all subfolder</label>
                    </div>
                    <span>Permissions</span>
                    <div class="flex align-items-center pt-3">
                        <Checkbox v-model="checkeds[0]" :binary="true" @change="checkeds = checkeds.map(()=>checkeds[0])"/>
                        <label for="ingredient0" class="ml-2"> Full Control </label>
                    </div>
                    <div class="flex align-items-center pt-3">
                        <Checkbox v-model="checkeds[1]" :binary="true" />
                        <label for="ingredient1" class="ml-2"> Change Permission </label>
                    </div>
                    <div class="flex align-items-center pt-3">
                        <Checkbox v-model="checkeds[2]" :binary="true" />
                        <label for="ingredient2" class="ml-2"> Create SubFolder </label>
                    </div>
                    <div class="flex align-items-center pt-3">
                        <Checkbox v-model="checkeds[3]" :binary="true" />
                        <label for="ingredient3" class="ml-2"> Delete </label>
                    </div>
                    <div class="flex align-items-center pt-3">
                        <Checkbox v-model="checkeds[4]" :binary="true" />
                        <label for="ingredient4" class="ml-2"> Read </label>
                    </div>
                    <div class="flex align-items-center pt-3">
                        <Checkbox v-model="checkeds[5]" :binary="true" @change="()=>{if(checkeds[5]) checkeds[4] = checkeds[5]}"/>
                        <label for="ingredient4" class="ml-2"> Write </label>
                    </div>
                    <div class="flex align-items-center pt-3">
                        <Button label="Add Permission" icon="pi pi-check" @click="onCreateFolderPermission"/>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <div>
        <DataTable dataKey="id" :value="folderPermissions" scrollable scrollHeight="350px" v-model:filters="filters" filterDisplay="row" class="text-xs h-[100%]" stripedRows editMode="cell" id="tbPermissionFolder" @cell-edit-complete="onCellEditComplete">
    <template #empty> No found. </template>
    <template #loading> Loading data. Please wait. </template>
    <Column style="min-width: 3rem;text-align: center;">
        <template #body="{ data }">
            <i class="pi pi-times text-[red] text-[17px] cursor-pointer" @click="onDeleteFolderPermission(data.id)"/>
        </template>
    </Column>
    <Column field="objectIdName" header="Groups/Users" style="min-width: 15rem">
        <template #filter="{ filterModel,filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Full Control" field="folder_IsFullPermission" style="min-width: 7rem;text-align: center;">
        <template #body="{ data }">
            <i v-if="data.folder_IsFullPermission" class="pi pi-check text-[#10b981] text-[17px]"/>
        </template>
        <template #editor="{ data }">
            <Checkbox v-model="data.folder_IsFullPermission" :binary="true" />
        </template>
    </Column>
    <Column header="Change Permission" field="folder_ChangePermission" style="min-width: 7rem;text-align: center;">
        <template #body="{ data }">
            <i v-if="data.folder_ChangePermission" class="pi pi-check text-[#10b981] text-[17px]"/>
        </template>
        <template #editor="{ data }">
            <Checkbox v-model="data.folder_ChangePermission" :binary="true" />
        </template>
    </Column>
    <Column header="Create SubFolder" field="folder_CreateSubFolder" style="min-width: 7rem;text-align: center;">
        <template #body="{ data }">
            <i v-if="data.folder_CreateSubFolder" class="pi pi-check text-[#10b981] text-[17px]"/>
        </template>
        <template #editor="{ data }">
            <Checkbox v-model="data.folder_CreateSubFolder" :binary="true" />
        </template>
    </Column>
    <Column header="Delete" field="folder_Delete" style="min-width: 7rem;text-align: center;">
        <template #body="{ data }">
            <i v-if="data.folder_Delete" class="pi pi-check text-[#10b981] text-[17px]"/>
        </template>
        <template #editor="{ data }">
            <Checkbox v-model="data.folder_Delete" :binary="true" />
        </template>
    </Column>
    <Column header="Read" field="folder_Read" style="min-width: 7rem;text-align: center;">
        <template #body="{ data }">
            <i v-if="data.folder_Read" class="pi pi-check text-[#10b981] text-[17px]"/>
        </template>
        <template #editor="{ data }">
             <Checkbox v-model="data.folder_Read" :binary="true" />
        </template>
    </Column>
    <Column header="Write" field="folder_Write" style="min-width: 7rem;text-align: center;">
        <template #body="{ data }">
            <i v-if="data.folder_Write" class="pi pi-check text-[#10b981] text-[17px]"/>
        </template>
        <template #editor="{ data }">
            <Checkbox v-model="data.folder_Write" :binary="true" />
        </template>
    </Column>
</DataTable>
    </div>
    <Toast />
</template>
<script setup>
import { ref, onMounted,watch } from 'vue';
import {groupGetAllAPI} from '../../../api/groupAPI';
import {userGetAllAPI} from '../../../api/userAPI';
import {getPermissionByFolderAPI,createFolderPermissionAPI,deleteFolderPermissionAPI,updateFolderPermissionAPI} from '../../../api/permissionFolderAPI.js';
import { useUser } from "~/stores/user";
import { useGroup } from "~/stores/group";
import { usePermissionFolder } from "~/stores/permissionFolder";
import {FolderPermission} from '../../../models/folderPermission.js';
import { FilterMatchMode,FilterOperator  } from 'primevue/api';
import { useToast } from "primevue/usetoast";
const toast = useToast();
const groups = ref([]);
const users = ref([]);
const folderPermissions = ref([]);
const checkeds = ref([false,false,false,false,false,false]);
const emit = defineEmits(['update:modelValue', 'selectDocument']);
const props = defineProps(['selectDocument']);
const selectDocument = ref(props.selectDocument);
const checkApply = ref(true);
const filters = ref({
    'objectIdName': { value: null, matchMode: FilterMatchMode.CONTAINS },
});
onMounted(async()=>{
    await loadPermissionByFolder();
    await loadAllGroups();
    await loadAllUsers();
    selectDocument.value = props.selectDocument;
});
watch(() => props.selectDocument, (newValue) => {
   
    selectDocument.value = newValue;
})
const loadPermissionByFolder = async () => {
    try{
        folderPermissions.value = await usePermissionFolder().getPermissionByFolder(selectDocument.value.id);
    }catch(error){
        console.log(error);
    }
}
const loadAllGroups = async () =>{
    try{
        groups.value = [];
        const grs = await groupGetAllAPI();
        grs.forEach((item)=>{
            groups.value.push({data:item,checked:false});
        });
        const exitGroups = folderPermissions.value.filter(p => p.typeID == 1).map(p => p.objectId);
        groups.value = groups.value.filter(g => !exitGroups.includes(g.data.id));
    }catch(error){
        console.log("Error get list groups:"+error);
    }
}
const loadAllUsers = async () =>{
    try{
        users.value = [];
        const us = await useUser().getAll();
        us.forEach((item)=>{
            users.value.push({data:item,checked:false});
        });
        const exitUsers = folderPermissions.value.filter(p => p.typeID == 2).map(p => p.objectId);
        users.value = users.value.filter(g => !exitUsers.includes(g.data.id));
    }catch(error){
        console.log("Error get list groups:"+error);
    }
}
const onCreateFolderPermission = async () =>{
    const CheckGroups = groups.value.filter(g => g.checked);
    const CheckUsers = users.value.filter(g => g.checked);
    try{
        if(CheckGroups.length > 0 || CheckUsers.length > 0){
        if(CheckGroups.length > 0 ){
            for(var item of CheckGroups){
                const newPermission = new FolderPermission();
                newPermission.objectId = item.data.id;
                newPermission.objectIdName = item.data.name;
                newPermission.folderId = selectDocument.value.id;
                newPermission.categoryId = selectDocument.value.categoryID;
                newPermission.typeID= 1;
                newPermission.typeName= "Group";
                newPermission.folder_IsFullPermission= checkeds.value[0];
                newPermission.folder_ChangePermission=  checkeds.value[1];
                newPermission.folder_CreateSubFolder=  checkeds.value[2];
                newPermission.folder_Delete=  checkeds.value[3];
                newPermission.folder_Read=  checkeds.value[4];
                newPermission.folder_Write=  checkeds.value[5];
                const data =  await usePermissionFolder().create(newPermission,checkApply.value);
                folderPermissions.value.push(data);
            }
            groups.value = groups.value.filter(g => !CheckGroups.includes(g));
        }
        if(CheckUsers.length > 0){
            for(var item of CheckUsers){
                const newPermission = new FolderPermission();
                newPermission.objectId = item.data.id;
                newPermission.objectIdName = item.data.username + " - " + item.data.fullName;
                newPermission.folderId = selectDocument.value.id;
                newPermission.categoryId = selectDocument.value.categoryID;
                newPermission.typeID= 2;
                newPermission.typeName= "User";
                newPermission.folder_IsFullPermission= checkeds.value[0];
                newPermission.folder_ChangePermission=  checkeds.value[1];
                newPermission.folder_CreateSubFolder=  checkeds.value[2];
                newPermission.folder_Delete=  checkeds.value[3];
                newPermission.folder_Read=  checkeds.value[4];
                newPermission.folder_Write=  checkeds.value[5];
                const data =  await usePermissionFolder().create(newPermission,checkApply.value);
            }
            users.value = users.value.filter(g => !CheckUsers.includes(g));
        }
         await loadPermissionByFolder();
        checkeds.value = ref([false,false,false,false,false,false]); 
        toast.add({ severity: 'success', summary: 'Success Message', detail: 'Success Created!', life: 5000 });
    }else{
        toast.add({ severity: 'error', summary: 'Error Message', detail: "You don't selected a group or user!", life: 5000 });
    }
    }
    catch(error){
        toast.add({ severity: 'error', summary: 'Error Message', detail: "Insert premission fail!", life: 5000 });
    }
}
const onDeleteFolderPermission = async (id) =>{
    try{
        var st =  confirm("Do you want to delete this item?");
        if(st){
            await usePermissionFolder().delete(id);
            folderPermissions.value = folderPermissions.value.filter(f => f.id != id);
            loadAllGroups();
            loadAllUsers();
            toast.add({ severity: 'success', summary: 'Success Message', detail: 'Success Delete!', life: 5000 });
        }
    }catch(error){

    }
}
const onCellEditComplete = async (event) => {
    let { data, newValue, field,newData } = event;
    switch (field) {
        case "folder_IsFullPermission":
        data[field] = newValue;
        data["folder_ChangePermission"] = newValue;
        data["folder_Read"] = newValue;
        data["folder_CreateSubFolder"] = newValue;
        data["folder_Delete"] = newValue;
        data["folder_Write"] = newValue;
        break;
        case "folder_Write":
            data["folder_Write"] = newValue;
            if(newValue){
                data["folder_Read"] = newValue;
            }
            if(data["folder_ChangePermission"] && data["folder_CreateSubFolder"]&& data["folder_Delete"] && data["folder_Write"]&& data["folder_Read"]){
                data["folder_IsFullPermission"] = true;
            }else{
                data["folder_IsFullPermission"] = false;
            }
            break;
        default:
            data[field] = newValue;
            if(data["folder_ChangePermission"] && data["folder_CreateSubFolder"]&& data["folder_Delete"] && data["folder_Write"]&& data["folder_Read"]){
                data["folder_IsFullPermission"] = true;
            }else{
                data["folder_IsFullPermission"] = false;
            }
            break;
    }
    await usePermissionFolder().update(data);
};
</script>
<style>
#tbPermisstion .p-tabview-nav-container{
    display: inline !important;
}
#tbPermissionFolder .p-column-header-content{
    display: block;
}
#tbPermisstion .p-tabview{
    width: 100%;
}
</style>


