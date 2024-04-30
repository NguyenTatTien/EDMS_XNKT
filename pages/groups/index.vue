<template>
        <!-- <div class="flex items-center p-5">
 
 <button class="p-button p-component topbar-menubutton p-link p-trigger" type="button" data-pc-name="button" data-pc-section="root" data-pd-ripple="true" fdprocessedid="v1mk1"><i class="pi pi-bars"></i><span role="presentation" aria-hidden="true" data-p-ink="true" data-p-ink-active="false" class="p-ink" data-pc-name="ripple" data-pc-section="root" style="height: 35px; width: 35px; top: 1px; left: 12.5px;"></span></button>
                 <div class="px-5"><ol style="display: flex; gap: 1rem;color: #6b7280;font-weight: 600;"><li>System</li><li>/</li><li>Groups</li></ol></div>
</div> -->
     <Card class="h-[80%] rounded-md" style="box-shadow: 0 7px 14px 0 rgba(65, 69, 88, 0.1), 0 3px 6px 0 rgba(0, 0, 0, 0.07);"> 
        <template #content>
    <div class="w-full h-full ">
        <DataTable paginator :rows="10" dataKey="id" scrollable filterDisplay="menu" v-model:selection="selectedGroups" @cell-edit-complete="onCellEditComplete"
        :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" :value="groups" showGridlines stripedRows v-model:filters="filters" editMode="cell">
    <template #header>
        <div class="flex justify-between">
            <div class="flex w-[300px]">
                <Button icon="pi pi-plus" label="Add New" class="border-[1px] border-solid border-[#3B82F6] text-[#1976d2]" @click="visibleDialog = true" style="padding: 0.65625rem 1.09375rem"/>
            </div>
            <IconField iconPosition="left">
                <InputIcon>
                    <i class="pi pi-search" />
                </InputIcon>
                <InputText placeholder="Keyword Search" class="py-[0.5rem] px-[0.75rem]" v-model="filters['global'].value" style="padding-left: 2rem !important"/>
            </IconField>
        </div>
    </template>
    <template #empty> No found. </template>
    <template #loading> Loading data. Please wait. </template>
    <Column selectionMode="multiple" headerStyle="width: 1rem"></Column>
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
    </div>
    </template>
    </Card>
    <Dialog v-model:visible="visibleDialog" modal header="Create Group" :style="{ width: '30rem' }">
    <GroupCreate v-model="visibleDialog" :groups="groups"/>
</Dialog>
</template>
<script setup>
definePageMeta({
  layout: 'default'
})
import { GroupCreate } from '#build/components';
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
    onMounted(async ()=>{
        getListGroup();
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
