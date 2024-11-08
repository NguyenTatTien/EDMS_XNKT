<template>
    <div>
        <div class="flex w-full justify-center flex-wrap">
            <div class="w-full text-center mb-2">
                <span class="w-[100px] inline-block">Category:</span>
                <Dropdown v-model="selectCategory" :options="categories" optionLabel="name" placeholder="Select a Category" class="w-[300px]" @change="onSelect"/>
            </div>
            <div class="w-full text-center mb-2">
                <span class="w-[100px] inline-block">To Folder:</span>
                <TreeSelect v-model="selectFolder" :options="folders" placeholder="Select Folder" class="w-[300px]"/>
            </div>
            <div class="w-full text-center mb-2">
                <Button label="Save" icon="pi pi-save" @click="onSave"/>

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
        <Toast />
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';

import { useSyncFolder } from '~/stores/syncFolder';

import { useCategories } from '~/stores/categories';

import { useFolder } from '~/stores/folder';

import { useToast } from "primevue/usetoast";
const toast = useToast();
const emit = defineEmits(['update:modelValue','folderID']);
const props = defineProps(['folderID']);
const syncFolders = ref([]);
const categories = ref([]);
const selectCategory = ref(null);
const folders = ref([]);
const selectFolder = ref(null);
const folderID = ref(props.folderID);
onMounted(async ()=>{
    await loadSyncFolders();
    await loadCategories();
});
watch(() => props.folderID, (newValue) => {
    folderID.value = newValue;
})
const loadCategories = async ()=>{
    try{
         categories.value = await useCategories().getAll();
    }catch(err){
        console.log(err);
    }
}
const loadSyncFolders = async ()=>{
    try{
         syncFolders.value = await useSyncFolder().getAll();
    }catch(err){
        console.log(err);
    }
}
const onSelect = async (e) => {
    var data = await useFolder().getFolderNotParentByCategory(selectCategory.value.id);
    folders.value = [];
    data.forEach(item => {
        var node = {label:item.name,key:`${item.id}`,data:item,children:null,icon:'pi pi-folder'}
        folders.value.push(node);
        loadFolderChild(node);
    })
}
const loadFolderChild = async (node)=>{
    var data = await useFolder().getFolderByParentAndCategory(node.data.id,node.data.categoryID);
        if(data.length > 0){
            node.children = [];
            data.forEach(item => {
            var newnode = {label:item.name,key:`${item.id}`,data:item,children:null,icon:'pi pi-folder'}
            node.children.push(newnode);
            loadFolderChild(newnode);
        })
    }
}
const onSave = async ()=>{
    try{
        var id = 0;
        Object.keys(selectFolder.value).forEach(key => {
              id = key;
        });
        if(selectFolder.value != null && id != 0){
            await useSyncFolder().syncFolder(folderID.value,id);
            await loadSyncFolders();
            toast.add({ severity: 'success', summary: 'Sync successfull!', detail: 'Success', life: 5000 });
        }
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