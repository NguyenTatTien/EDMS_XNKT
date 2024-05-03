<template>

    <div class="w-full flex h-full" style="border-right: 1px solid #dee2e6;">
     <div class="flex w-[100%] h-full">
         <PanelMenu :model="items" class="w-full md:w-20rem h-full overflow-y-auto px-0" id="categoryDoc">
             <template #item="{ item }">
                 <a v-if="!item.treeFolder" v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparent" :target="item.target">
                     <span class="ml-2 text-[#5e6e82] font-medium text-sm" v-if="item.items != null && item.items.length > 0 && !item.items[0].treeFolder">{{ item.label }}</span>
                     <span class="ml-2 text-[#5e6e82] font-medium text-sm" v-else @click="loadFolders(item)">{{ item.label }}</span>
                     <span v-if="item.items && item.items.length > 0 && !item.items[0].treeFolder" class="pi pi-angle-down text-[#5e6e82] ml-auto " />
                 </a>
                 <a v-else v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparent" :target="item.target">
                     <!-- <i :class="item.icon"></i>
                     <span class="ml-2 text-[#5e6e82] font-medium text-sm">{{ item.label }}</span> -->
                     <Tree v-model:expandedKeys="selectedKeyNode" :value="item.treeFolder" class="w-full md:w-30rem" @nodeExpand="folder_onExpand" @nodeSelect="folder_onNodeSelect" selectionMode="single">
                        <template #default="slotProps">
                               <!-- <i :class="slotProps.icon"></i> -->
                                <span class="ml-2 text-[#5e6e82] text-xs whitespace-nowrap">{{ slotProps.node.label }}</span>
                        </template>
                    </Tree>
                 </a>
             </template>
         </PanelMenu>
     </div>
    </div>
</template>
<script setup>
import { ref,onMounted } from "vue";
import {cateogriesGetAllAPI} from '../../api/categoriesAPI.js';
import {folderGetNotParentByCategoryAPI,folderGetByParentAndCategoryAPI} from '../../api/folderAPI.js';

import '../assets/CSS/layout.css'
const items = ref([
 {
     key: "0",
     label: 'Document Group',
     items: [],
 },
]);
const emit = defineEmits(['onLoadFolderByDepartment','pushBreadcrumbItems']);
const expandedKeys = ref({});
const menu = ref();
const treeFolders = ref([]);
const selectedKeyNode = ref(null);
onMounted(() => {
 getCategories();
})

const loadFolders = async (itemDepartment) => {

 if(itemDepartment.id) {
    try{
         
         var data = await folderGetNotParentByCategoryAPI(itemDepartment.id);
         treeFolders.value = [];
         data.forEach(item => {
            var newitem = {
                key: item.id,
                label: item.name,
                icon: "pi pi-folder",
                data:item,
                children: null,
                parent:null,
            } ;
          
            treeFolders.value.push(newitem);
            treeFolders.value.forEach(item => {
             loadChildFolders(item);
            });
            
         });
         itemDepartment.items[0].treeFolder = treeFolders.value;
         emit('onLoadFolderByDepartment', {folders:data,categoryID:itemDepartment.id});
         
    }catch(error){
        console.log(error);
    }
 }
}
const loadChildFolders = async (node) => {
 try{
     var data = await folderGetByParentAndCategoryAPI(node.key,node.data.categoryID);
     node.children = [];
     data.forEach(item => {
         var newitem = {
             key: item.id,
             label: item.name,
             icon: "pi pi-folder",
             data:item,
             children: null,
             parent:node,
         };
       
         node.children.push(newitem);
         
     });
 }catch(error){
     console.log(error);
 }
}
const getCategories = async () => {
 try{
     const data = await cateogriesGetAllAPI();
     data.forEach(item => {
         var newitem = {
             id: item.id,
             label: item.name,
             icon: "pi pi-graduation-cap",
             items: [{treeFolder:{}}],
         };
         items.value[0].items.push(newitem);
     });
 }catch(error){
     console.log(error);
 }
}
const folder_onExpand = async (node) => {
 try{
    node.children.forEach(async(item) =>  {
        await loadChildFolders(item);
     });
    

 }catch(error){
     console.log(error);
 }
}
const folder_onNodeSelect = (event) => {
    var data = [];
    getParentNodeToChildNode(event,data);
    emit('pushBreadcrumbItems',data);
}
const getParentNodeToChildNode = (node,data)=>{
    data.unshift({label:node.label,data:{type:'folder',object:node.data}});
    if(node.parent){
        getParentNodeToChildNode(node.parent,data);
    }
}
const onRightClick = (event, data) => {
 menu.value.show(event);
}

</script>
<style>
.p-tree .p-treenode-children{
 padding: 0 0 0 1rem !important;
}
#categoryDoc .p-panelmenu-panel{
 padding-left: 0 !important;
 padding-right: 0 !important;
}
</style>