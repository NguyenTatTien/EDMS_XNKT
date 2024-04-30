<template>
    <div>
        <div class="flex w-full justify-center flex-wrap">
            <div class="w-full text-center mb-2">
                <span class="w-[100px] inline-block">Category:</span>
                <Dropdown optionLabel="name" placeholder="Select a Category" class="w-[300px]" />
            </div>
            <div class="w-full text-center mb-2">
                <span class="w-[100px] inline-block">To Folder:</span>
                <TreeSelect placeholder="Select Folder" class="w-[300px]"/>

            </div>
            <div class="w-full text-center mb-2">
                <Button label="Save" icon="pi pi-save"/>

            </div>
        </div>
        <div>
            <DataTable :value="syncFolders" id="tbSync">
            <ColumnGroup type="header">
                <Row>
                    <Column header=" " :rowspan="2" />
                    <Column header="From folder" :colspan="2" />
                    <Column header="To folder" :colspan="2" />
                    <Column header="Created" :rowspan="2" />
                </Row>
                <Row>
                    <Column header="Name" sortable field="from_FolderName" />
                    <Column header="Path" sortable field="from_FolderVitualPath" />
                    <Column header="Name" sortable field="to_FolderName" />
                    <Column header="Path" sortable field="to_FolderVitualPath" />
                </Row>
            </ColumnGroup>
            <Column>
                <template #body=""> 
                    <i class="pi pi-times"></i>
                </template>
            </Column>
            <Column field="from_FolderName">
            </Column>
            <Column field="from_FolderVitualPath">
            </Column>
            <Column field="to_FolderName">
            </Column>
            <Column field="to_FolderVitualPath">
            </Column>
            <Column field="createDate">
            </Column>
        </DataTable>
        </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {syncFolderGetAllAPI} from '../../../api/syncFolderAPI.js';
const syncFolders = ref([]);
onMounted(async ()=>{
    loadSyncFolders();
});
const loadSyncFolders = async ()=>{
    try{
         syncFolders.value = await syncFolderGetAllAPI();
    }catch(err){
        console.log(err);
    }
}
</script>

<style>
#tbSync .p-column-header-content{
    display: block;
    text-align: center;
}
</style>