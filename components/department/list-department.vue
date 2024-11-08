<template>

    <div class="w-full flex h-full" style="border-right: 1px solid #dee2e6;">
     <div class="flex w-[100%] h-full flex-col">
        <Dropdown v-model="selectedDepartment" filter scrollHeight="350px" :options="itemsDepartment" optionLabel="label" placeholder="Select a department" class="w-full md:w-14rem rounded-none" @change="onSelect"/>
        <Tree v-model:expandedKeys="selectedKeyNode" :value="treeFolders" class="w-full md:w-30rem px-0 overflow-auto" @nodeExpand="folder_onExpand" @nodeSelect="folder_onNodeSelect" selectionMode="single" @node-expand="onNodedExpand">
                        <template #default="slotProps">
                               <!-- <i :class="slotProps.icon"></i> -->
                                <span class="ml-2 text-blue-800 text-xs w-[80%]"  style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" :title="slotProps.node.label">{{ slotProps.node.label }}</span>
                                <i v-if="!slotProps.node.isHasFolder" class="pi pi-exclamation-triangle text-[#ff9900] w-[20%]" title="Folder Not Found"/>
                        </template>
                        <template #nodeicon="slotProps">
                            <img :src="slotProps.node.icon" class="w-[18px] h-[18px] cursor-pointer" @click="viewFile(data)"/>
                            <!-- <i :class="slotProps.node.icon" class="mr-[0.2rem]" style="color: #3B82F6"></i> -->
                        </template>
        </Tree>
         <!-- <PanelMenu v-model:expandedKeys="expandedKeys" :model="items" class="w-full md:w-20rem h-full overflow-y-auto px-0" id="categoryDoc">
             <template #item="{ item }">
                 <a v-if="!item.treeFolder" v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparent" :target="item.target">
                     <span class="ml-2 text-[#5e6e82] font-medium text-sm" v-if="item.items != null && item.items.length > 0 && !item.items[0].treeFolder">{{ item.label }}</span>
                     <span class="ml-2 text-[#5e6e82] font-medium text-sm" v-else @click="loadFolders(item)">{{ item.label }}</span>
                     <span v-if="item.items && item.items.length > 0 && !item.items[0].treeFolder" class="pi pi-angle-down text-[#5e6e82] ml-auto " />
                 </a>
                 <a v-else v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparent" :target="item.target">
             
                     <Tree v-model:expandedKeys="selectedKeyNode" :value="item.treeFolder" class="w-full md:w-30rem" @nodeExpand="folder_onExpand" @nodeSelect="folder_onNodeSelect" selectionMode="single">
                        <template #default="slotProps">
                                <span class="ml-2 text-[#5e6e82] text-xs whitespace-nowrap">{{ slotProps.node.label }}</span>
                        </template>
                    </Tree>
                 </a>
             </template>
         </PanelMenu> -->
     </div>
     <Toast />
    </div>
</template>
<script setup>
import { ref,onMounted,watch } from "vue";
import {useFolder} from '~/stores/folder';
import {useCategories} from '~/stores/categories';
import { storeToRefs } from 'pinia';
import { useExpandedFolder } from "~/stores/expandFolder";
import { usePermissionFolder } from "~/stores/permissionFolder";
import { useToast } from "primevue/usetoast";
const toast = useToast();
const {categoriesStore} = storeToRefs(useCategories());
const { foldersStore } = storeToRefs(useFolder());
const { expanFolder} = storeToRefs(useExpandedFolder());
import '../assets/CSS/layout.css'
const emit = defineEmits(["modelValue","categoryID"]);
const props = defineProps(["categoryID"]);
const categoryID = ref(props.categoryID);
const itemsDepartment = ref([]);
const expandedKeys = ref({});
const menu = ref();
const treeFolders = ref([]);
const selectedDepartment = ref(null);
const selectedKeyNode = ref({});
watch(() => props.categoryID, (value) =>{
        categoryID.value = value;
});
onMounted(async() => {
 await getCategories();
 if(itemsDepartment.value.length>0){
    if(categoryID.value != null){
        selectedDepartment.value = itemsDepartment.value.find(item => item.id === categoryID.value);
        await loadFolders(selectedDepartment.value);
    }
 }
 expandedKeys.value[0] = true;
 if(expanFolder.value != null){
    selectedKeyNode.value = expanFolder.value;
 }else{
    expandAll();
    expanFolder.value = selectedKeyNode.value;
 }
});
watch(() => foldersStore.value, async (value) => {
    if(selectedDepartment.value != null){
        await loadFolders(selectedDepartment.value);
    }
});
const getCategories = async () => {
 try{
        var data = [];
        if(categoriesStore.value != null && categoriesStore.value.length > 0){
            data = categoriesStore.value;
        }else{
            data =  await useCategories().getAllByPermission();
        }
     data.forEach(item => {
         var newitem = {
             id:  item.id,
             label: item.name,
         };
         itemsDepartment.value.push(newitem);
     });
 }catch(error){
     console.log(error);
 }
}
const expandAll = () => {
   
    for (let node of treeFolders.value) {
        expandNode(node);
    }
   
    selectedKeyNode.value = { ...selectedKeyNode.value };

};
const expandNode = (node) => {
    if (node.children && node.children.length) {
        selectedKeyNode.value[node.key] = true;
        // for (let child of node.children) {
        //     if (child.children && child.children.length) {
        //     selectedKeyNode.value[child.key] = true;
        //     }
        //    // expandNode(child);
        // }
    }
};
// const loadFolders = async (itemDepartment) => {

//  if(itemDepartment.id) {
//     emit('update:modelValue', true);
//     try{
//          var data = await useFolder().getFolderNotParentByCategory(itemDepartment.id);
      
//          treeFolders.value = [];
//          data.forEach(item => {
//             var newitem = {
//                 key: item.id,
//                 label: item.name,
//                 icon: "pi pi-folder",
//                 data:item,
//                 children: null,
//                 parent:null,
//             } ;
//             treeFolders.value.push(newitem);
//             treeFolders.value.forEach(item => {
//              loadChildFolders(item);
//             });
            
//          });
//          itemDepartment.items[0].treeFolder = treeFolders.value;
//          emit('onLoadFolderByDepartment', {folders:data,categoryID:itemDepartment.id});
        
         
//     }catch(error){
//         console.log(error);
//     }
//     finally{
//         emit('update:modelValue', false);
//     }
//  }
// }
// const loadChildFolders = async (node) => {
//  try{
//      var userId = sessionStorage.getItem("userId");
//      var data = await useFolder().getFolderByParentAndCategory(node.key,node.data.categoryID,userId);
//      node.children = [];
//      data.forEach(item => {
//          var newitem = {
//              key: item.id,
//              label: item.name,
//              icon: "pi pi-folder",
//              data:item,
//              children: null,
//              parent:node,
//          };
       
//          node.children.push(newitem);
         
//      });
//  }catch(error){
//      console.log(error);
//  }
// }
// const getCategories = async () => {
//  try{
//     var userId = sessionStorage.getItem("userId");
//     if(userId != null){
//         const data = await useCategories().getAllByPermission(userId);
//      data.forEach(item => {
//          var newitem = {
//              id:  item.id,
//              key: '' +item.id,
//              label: item.name,
//              icon: "pi pi-graduation-cap",
//              items: [{key:item.id+"_"+1,label:item.name+"_"+1,treeFolder:{}}],
//          };
//          items.value[0].items.push(newitem);
//      });
//     }else{
//         navigateTo('/login');
//     }
     
//  }catch(error){
//      console.log(error);
//  }
// }
const folder_onExpand = async (node) => {
 try{
    // node.children.forEach(async(item) =>  {
    //     await loadChildFolders(item);
    //  });
 }catch(error){
     console.log(error);
 }
}
const folder_onNodeSelect = async (event) => {
    var permission = await usePermissionFolder().getJsonPermissionByFolder(event.data.id,categoryID.value);
    if(permission.isRead != true){
        toast.add({ severity: 'error', summary: 'Error Message', detail: 'Access denied Folder!', life: 5000 });
        return;
    }
    //navigateTo(`/document_library/${categoryID.value}/${event.data.id}`);
    navigateTo({path:`/document_library`,query:{category:categoryID.value,folder:event.data.id}},{external:true});
    
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
const onSelect = (e) => {
    var data = e.value;
    useFolder().clearFolders();
    useExpandedFolder().reset();
    //navigateTo(`/document_library/${data.id}`);
   navigateTo({path:`/document_library`,query:{category:data.id}},{external:true});
   
   
}
const loadFolders = async (itemDepartment) => {
 if(itemDepartment.id) {
    emit('update:modelValue', true);
    try{
         var data = [];
         if(foldersStore.value != null && foldersStore.value.length > 0){
             data = foldersStore.value;
         }else{
             data =
         await useFolder().getAllFolderByCategory(itemDepartment.id);
         }
         var folderParent = data.filter(item => item.parentID == null);
         treeFolders.value = [];
         folderParent.forEach(item => {
            var newitem = {
                key: item.id,
                label: item.name,
                icon: "/_nuxt/assets/images/folder_2.png",
                data:item,
                children: null,
                parent:null,
                isHasFolder:item.isHasFolder,
            } ;
            treeFolders.value.push(newitem);
            treeFolders.value.forEach(item => {
             loadChildFolders(item,data);
            });
            
         });
        
         emit('onLoadFolderByDepartment', {folders:folderParent,categoryID:itemDepartment.id});
        
         
    }catch(error){
        console.log(error);
    }
    finally{
        emit('update:modelValue', false);
    }
 }
}
const loadChildFolders = async (node,folders) => {
 try{
     var data = folders.filter(item => item.parentID == node.key);
     node.children = [];
     data.forEach(item => {
         var newitem = {
             key: item.id,
             label: item.name,
             icon:  "/_nuxt/assets/images/folder_2.png",
             data:item,
             children: null,
             parent:node,
             isHasFolder:item.isHasFolder,
         };
         loadChildFolders(newitem,folders);
         node.children.push(newitem);
         
     });
     
 }catch(error){
     console.log(error);
 }
}
const onNodedExpand = (event) => {
    expanFolder.value = selectedKeyNode.value;
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
.p-tree-container{
    overflow-x: hidden;
    
}
.p-treenode-label{
    
    width: 80%;
    display: flex;
}
</style>