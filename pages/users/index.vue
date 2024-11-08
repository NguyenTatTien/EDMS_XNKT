<template>


<div class="w-full h-full" id="divGrid">
        <DataTable paginator :rows="50" dataKey="id" scrollable filterDisplay="row" @cell-edit-complete="onCellEditComplete" v-model:selection="selectedUsers"
        :globalFilterFields="['username', 'fullName','role.name','email']" class="text-xs h-[100%]" :value="users" showGridlines stripedRows v-model:filters="filters" editMode="cell" @filter="onFilter">
    <template #header>
        <div class="flex justify-end">
            <div class="flex justify-between items-center">
            <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="visibleDialog = true"/>
            <Button icon="pi pi-cloud-download" class="mr-2 h-[2rem]" @click="exportUsers"/>
            <FileUpload mode="basic" name="demo[]" url="/api/upload" accept=".xls,.xlsx" :maxFileSize="1000000" chooseLabel=' ' chooseIcon="pi pi-cloud-upload" uploadIcon="pi pi-cloud-upload" class="mr-2 h-[2rem] flex justify-center" id="importUser" @select="importUsers"/>
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
    <Column header="" style="width: 2rem">
     <template #body="{ data }">
        <i v-if="user.roleId==1" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="deleteUser(data.id)"></i>
     </template>
 </Column>
 <Column header="" style="width: 2rem">
     <template #body="{ data }">
        <i v-if="user.roleId==1" class="pi pi-replay cursor-pointer" style="color: #3B82F6;" @click="resetPassword(data.id)"></i>
     </template>
 </Column>
    <Column field="username" header="User Name" style="min-width: 12rem">
        <template #editor="{ data }">
            <InputText v-model="data.username" autofocus />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
        </template>
    </Column>
    <Column header="Full Name" field="fullName" style="min-width: 12rem">
        <template #editor="{ data }">
            <InputText v-model="data.fullName" autofocus />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
        </template>
    </Column>
    <Column header="Group" field="role.name" style="min-width: 12rem">
        <template #editor="{ data }">
            <Dropdown v-model="data.role" editable :options="groups" optionLabel="name" placeholder="Select group" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by created" />
        </template>
    </Column>
    <Column header="Email" field="email" style="min-width: 12rem">
        <template #editor="{ data }">
            <InputText v-model="data.email" autofocus />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by date" />
        </template>
    </Column>
    <Column header="Organization" field="unitID" style="min-width: 12rem" >
        <template #body="{ data }">
            {{data.unitName}}
        </template>
        <template #editor="{ data }">
            <Dropdown v-model="data.unitID" editable :options="units" optionLabel="name" optionValue="id" placeholder="Select unit" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <Dropdown v-model="filterModel.value" editable :showClear="true" :options="units" @change="filterCallback()" optionLabel="name" optionValue="id" placeholder="Select unit" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
        </template>
    </Column>
    <Column header="Can Create Project" field="canCreateProject" style="min-width: 12rem" >
        <template #body="{ data }">
            <Checkbox v-model="data.canCreateProject" :binary="true" />
        </template>
        <template #editor="{ data }">
            <Checkbox v-model="data.canCreateProject" :binary="true" />
        </template>
    </Column>
    <template #footer> <div class="w-full text-end">In total there are {{ countRows }} rows. </div></template>
</DataTable>
<Dialog v-model:visible="visibleDialog" modal header="Create User" :style="{ width: '30rem' }">
    <UserCreate v-model="visibleDialog" :users="users"/>
</Dialog>
<Toast />
<loading v-model:active="isLoading"
:is-full-page="true" color="3B82F6"/>
    </div>
</template>
<script setup>
    definePageMeta({
    layout: 'default',
    })
    import '../../assets/CSS/grid.css'
    import {useUser} from '~/stores/user';
    import { useUnit } from '~/stores/unit';
    import {useGroup} from '~/stores/group';
    import '../../assets/CSS/styleMain.css';
    import {ref, onMounted} from 'vue';
    import { FilterMatchMode } from 'primevue/api';
    import Loading from 'vue-loading-overlay';
    import { useToast } from "primevue/usetoast";
    import moment from 'moment';
    const user = useUser().getUser();
    const users = ref([]);
    const isLoading = ref(false)
    const groups = ref(null);
    const units = ref(null);
    const visibleDialog = ref(false);
    const selectedUsers = ref();
    const toast = useToast();
    const countRows = ref(0);
    const filters = ref({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
        username: { value: null, matchMode: FilterMatchMode.CONTAINS },
        fullName: { value: null, matchMode: FilterMatchMode.CONTAINS },
        'role.name': { value: null, matchMode: FilterMatchMode.CONTAINS },
        email: { value: null, matchMode: FilterMatchMode.CONTAINS },
        unitID: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });
    const getListUser = async () =>{
        isLoading.value = true
        try{
            users.value = await useUser().getAll();
        }catch(error){
            console.log("Error get list user:"+error);
        }finally{
            isLoading.value = false
        }
    }
    const getListUnit = async () =>{
        try{
            units.value = await useUnit().getAll();
        }catch(error){
            console.log("Error get list user:"+error);
        }
    }
    const getListGroup = async () =>{
        try{
            groups.value = await useGroup().getAll();
        }catch(error){
            console.log("Error get list user:"+error);
        }
    }
    const onCellEditComplete = async (event) => {
    try{
        let {data, newValue, field,newData } = event;
    switch (field) {
        case "unitID":
            var unit = units.value.filter(x => x.id == newValue)[0];
            data.unitID = unit.id;
            data.unitName = unit.name;
            break; 
        case "role.name":
            if (newData.role.name != null && newData.role.name.trim().length > 0) {
                data["role"] = newData.role;
                data["roleId"] = newData.role.id;
            }
            break;
        case "canCreateProject":
            data[field] = newValue;
            break;
        default:
            if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
            break;
    }
    await useUser().update(data);
    }catch(error){
        console.log(error);
    }
};
const deleteUser = async (id)=>{
    isLoading.value = true
    try{
        var st = confirm("Do you want to delete this user?");
            if (st) {
                await useUser().delete(id);
                users.value = users.value.filter(item => item.id !== id);
                toast.add({severity:'success', summary: 'Success Message', detail: 'Delete successfully!', life: 3000});
            }
    }catch(error){
        console.log(error);
        toast.add({severity:'error', summary: 'Error Message', detail: 'Delete failed!', life: 3000});
    }
    finally{
        isLoading.value = false
    }
}
const exportUsers = async() => {
    var response = await useUser().export();
    const link = document.createElement('a');
    link.href = response;
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
    
}
const importUsers =async (e) => {
    isLoading.value = true;
    try{
        var file = e.files[0];
        var fromData = new FormData();
        fromData.append("formFile",file);
        await useUser().import(fromData);
        await getListUser();
        toast.add({ severity: 'success', summary: 'Import successfully!', detail: 'Success Message', life: 5000 });
    }catch(error){
        toast.add({ severity: 'error', summary: 'Import fail!', detail: 'Error Message', life: 5000 });
    }finally{
        isLoading.value = false;
    }
}
const resetPassword = async (id) => {
    isLoading.value = true;
    try{
        var st = confirm("Do you want to reset password this user?");
            if (st) {
                await useUser().resetPassword(id);
                toast.add({severity:'success', summary: 'Success Message', detail: 'Reset password successfully!', life: 3000});
                
            }
    }catch(error){
        console.log(error);
        toast.add({severity:'error', summary: 'Error Message', detail: 'Reset password failed!', life: 3000});
    }
    finally{
        isLoading.value = false;
    }
}
const onFilter = (value) => {
    countRows.value = value.filteredValue.length;
}
onMounted(async ()=>{
    await getListUser();
    await getListGroup();
    await getListUnit();
});
</script>
<style>
#importUser {
    width: 40px !important;
    margin-right: 0.5rem;
 }
 #importUser .p-fileupload-choose{
    width: 40px !important;
 }
 #importUser .p-button-icon {
        margin-right: 0;
}
#importUser .p-button-label{
    display: none;
}
.p-fileupload{
    width: 40px !important;
}
</style>