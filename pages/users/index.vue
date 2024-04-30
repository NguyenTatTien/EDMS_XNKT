<template>


     <Card class="h-[80%] rounded-md" style="box-shadow: 0 7px 14px 0 rgba(65, 69, 88, 0.1), 0 3px 6px 0 rgba(0, 0, 0, 0.07);"> 
        <template #content>
    <div class="w-full h-full">
        <DataTable paginator :rows="10" dataKey="id" scrollable filterDisplay="menu" @cell-edit-complete="onCellEditComplete" v-model:selection="selectedUsers"
        :globalFilterFields="['username', 'fullName','role.name','email']" class="text-xs h-[100%]" :value="users" showGridlines stripedRows v-model:filters="filters" editMode="cell">
    <template #header>
        <div class="flex justify-between">
            <div class="flex w-[300px]">
                <Button icon="pi pi-plus" label="Add New" class="border-[1px] border-solid border-[#3B82F6] text-[#1976d2]" @click="visibleDialog = true" style="padding: 0.65625rem 1.09375rem"/>
                <!-- <Button icon="pi pi-plus" label="Add" class="bg-[#3B82F6] text-white px-4" @click="visibleDialog = true"/>
                <FileUpload mode="basic" accept="image/*" :maxFileSize="1000000" label="Import" chooseLabel="Import" class="inline-block text-[12px]" />
                <Button label="Export" icon="pi pi-upload" severity="help" class="bg-[#3B82F6] text-white px-4"/> -->
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
    <!-- <Column class="w-[50px]">
        <template #body="{ data }">
            <img src="/_nuxt/assets/images/delete.png" class="w-[16px] h-[16px] cursor-pointer" @click="deleteUser(data.id)">
        </template>
    </Column> -->
    <Column selectionMode="multiple" headerStyle="width: 1rem"></Column>
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
            <!-- <InputText v-model="data.role.name" autofocus /> -->
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
</DataTable>

    </div>
    </template>
     </Card>
     <Dialog v-model:visible="visibleDialog" modal header="Create User" :style="{ width: '30rem' }">
    <UserCreate v-model="visibleDialog" :users="users"/>
</Dialog>
</template>
<script setup>
    definePageMeta({
    layout: 'default',
    })
    import '../../assets/CSS/grid.css'
    import {userGetAllAPI,userUpdateAPI,userDeleteAPI} from '../api/userApi.js';
    import {groupGetAllAPI} from '../api/groupApi.js';
    import '../../assets/CSS/styleMain.css';
    import {ref, onMounted} from 'vue';
    import { FilterMatchMode } from 'primevue/api';
    const users = ref(null);
    const groups = ref(null);
    const visibleDialog = ref(false);
    const selectedUsers = ref();
    const filters = ref({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
        username: { value: null, matchMode: FilterMatchMode.CONTAINS },
        fullName: { value: null, matchMode: FilterMatchMode.CONTAINS },
        'role.name': { value: null, matchMode: FilterMatchMode.CONTAINS },
        email: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });
    const getListUser = async () =>{
        try{
            users.value = await userGetAllAPI();
        }catch(error){
            console.log("Error get list user:"+error);
        }
    }
    const getListGroup = async () =>{
        try{
            groups.value = await groupGetAllAPI();
        }catch(error){
            console.log("Error get list user:"+error);
        }
    }
    const onCellEditComplete = async (event) => {
    try{
        let {data, newValue, field,newData } = event;
    switch (field) {
        case "role.name":
            if (newData.role.name != null && newData.role.name.trim().length > 0) {
                data["role"] = newData.role;
                data["roleId"] = newData.role.id;
            }
            break;
        default:
            if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
            break;
    }
    await userUpdateAPI(data);
    }catch(error){
        console.log(error);
    }
};
const deleteUser = async (id)=>{
    try{
        var st = confirm("Do you want to delete this user?");
            if (st) {
                await userDeleteAPI(id);
                users.value = users.value.filter(item => item.id !== id);
            }
    }catch(error){
        console.log(error);
    }
}
onMounted(async ()=>{
    await getListUser();
    await getListGroup();
})

</script>
