<template>
  <div class="w-full h-full ">
        <DataTable paginator :rows="10" dataKey="id" scrollable filterDisplay="menu" v-model:selection="selectedGroups" @cell-edit-complete="onCellEditComplete"
        :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" :value="groups" showGridlines stripedRows v-model:filters="filters" editMode="cell">
    <template #header>
        <div class="flex justify-between">
            <div class="flex w-[300px]">
                <!-- <Button icon="pi pi-plus" label="Add New" class="border-[1px] border-solid h-[2.5rem]" @click="visibleDialog = true" style="padding: 0.65625rem 1.09375rem"/> -->
            </div>
            <div class="flex justify-between items-center">
            <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="visibleDialog = true"/>
            <Button icon="pi pi-cloud-download" class="mr-2 h-[2rem]"/>
            <Button icon="pi pi-cloud-upload" class="mr-2 h-[2rem]"/>
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
     <template #body="{  }">
        <i class="pi pi-times cursor-pointer" style="color: #EF4444;"></i>
     </template>
 </Column>
    <Column field="name" header="Name" style="min-width: 12rem">
        <template #editor="{ data }">
            <InputText v-model="data.name" autofocus />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
        </template>
    </Column>
    <Column header="Description" field="description" style="min-width: 12rem">
        <template #editor="{ data }">
            <InputText v-model="data.description" autofocus />
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
        </template>
    </Column>
</DataTable>
<Dialog v-model:visible="visibleDialog" modal header="Create Group" :style="{ width: '30rem' }">
    <GroupCreate v-model="visibleDialog" :groups="groups"/>
</Dialog>
    </div>

</template>
<script setup>
definePageMeta({
  layout: 'default'
})
    import '../../assets/CSS/grid.css'
    import '../../assets/CSS/styleMain.css'
    import {groupGetAllAPI,updateGroupAPI,deleteGroupAPI} from '../api/groupAPI.js';
    import { FilterMatchMode } from 'primevue/api';
    import { ref, onMounted } from 'vue';
    const visibleDialog = ref(false);
    const selectedGroups = ref();
    const groups = ref(null);
    const filters = ref({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
        name: { value: null, matchMode: FilterMatchMode.CONTAINS },
        description: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });
    onMounted(async()=>{
       await getListGroup();
    })
    const getListGroup = async () =>{
        try{
            groups.value = await groupGetAllAPI();
        }catch(error){
            console.log("Error get list group:"+error);
        }
    }
    const onCellEditComplete = async (event) => {
    let { data, newValue, field,newData } = event;
    switch (field) {
        default:
            if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
            break;
    }
    await updateGroupAPI(data);
};
const deleteGroup = async (id) => {
    try{
        var st = confirm("Do you want to delete this group?");
            if (st) {
                await deleteGroupAPI(id);
                groups.value = groups.value.filter(item => item.id !== id);
            }
    }catch(error){
        console.log(error);
    }
}
</script>
