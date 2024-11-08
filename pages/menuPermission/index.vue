<template>
    <div class="flex flex-1 h-full pb-[40px] w-full">
        <div class="flex flex-col w-full">
            <dl class="accordion w-full">
            <dt style="width: 100%;">
                <span>Config menu permission</span>
            </dt>
        </dl>
      <div class="flex h-full pb-[55px]">
        <div class="w-[400px] h-full">
            <PanelMenu :model="lableGroup" v-model:expandedKeys="selectedItem" class="h-full" id="pnGroup">
    <template #item="{ item  }">
        <a v-if="item.items == null"  v-ripple class="flex items-center cursor-pointer text-surface-700 dark:text-surface-0 px-4 py-2">
            <Listbox v-model="selectedGroup" :options="groups" optionLabel="name" optionValue="id"
             class="w-full md:w-full" listStyle="max-height:100%" @change="onGroupSelect"/>
        </a>
        <a v-else v-ripple class="flex items-center cursor-pointer text-surface-700 dark:text-surface-0 px-4 py-2">
            <span class="ml-2">{{ item.label }}</span>
            <span v-if="item.items" class="pi pi-angle-down text-primary ml-auto" />
        </a>
    </template>
</PanelMenu>
        </div>
        <div class="h-full" style="overflow-y: auto;overflow-x: hidden">
            <Tree v-model:selectionKeys="selectedKey" v-model:expandedKeys="expandedKeys" :value="items" selectionMode="checkbox" class="w-full md:w-[30rem]" @node-select="onNodeSelect" @node-unselect="onNodeUnselect"></Tree>
        </div>
      </div>
        </div>
    </div>
</template>
<script setup>
import { ref,onMounted } from 'vue';
import {useGroup} from '~/stores/group';
import {useMenu} from '~/stores/menu';
const items = ref([]);
const selectedKey = ref([]);
const selectedItem = ref({});
const expandedKeys = ref({});
const selectedGroup = ref({});
const lableGroup = ref([
    {
                key:'0',
                label: "Group",
                items: [
                ],
    }
]);
const groups = ref([
]);
onMounted(async()=>{
    await getMenus();
    await getGroups();
    selectedItem.value[0] =true;
    selectedGroup.value = groups.value[0].id;
    expandAll();
    onGroupSelect();
})
const getGroups = async()=>{
    try{
        var data = await useGroup().getAll();
        data.forEach(element => {
            groups.value.push(element);
        });
        lableGroup.value[0].items.push({label: ""});
      // selectedGroup.value = groups.value[0]; 
    }catch(e){
        console.log(e);
    }
}
const expandAll = () => {
    for (let node of items.value) {
        expandNode(node);
    }
    expandedKeys.value = { ...expandedKeys.value };
};

const expandNode = (node) => {
    if (node.children && node.children.length) {
        expandedKeys.value[node.key] = true;

        for (let child of node.children) {
            expandNode(child);
        }
    }
};
const getMenus=async()=>{
    try{
       var menus = await useMenu().getAll();
        for(var it of menus.filter(t=>t.parentId == null)){
            var item = {
                id:it.id,
                key:''+it.id,
                label: it.description,
                icon:it.icon_2,
                url:it.url_2,
                children: null,
            }
            getChildItem(item,menus);
            items.value.push(item);
        }
      
    }catch(e){
        console.log(e);
    }
}
const getChildItem = (item,menus) =>{
    var childs = menus.filter(t=>t.parentId == item.id);
    if(childs.length>0){
        item.children = [];
        for(var child of childs){
            var childItem = {
                id:child.id,
                key:''+child.id,
                label: child.description,
                icon:child.icon_2,
                url:child.url_2,
                children: null,
            }
            item.children.push(childItem);
            getChildItem(childItem,menus);
        }
    }
}
const onNodeSelect=(e)=>{

    InsertMenu(e);
}
const InsertMenu = async (node) =>{
   
    if(node.children){
        for(var child of node.children){
            InsertMenu(child);
        }
    }else{
        await useMenu().create(selectedGroup.value,node.id);
    }
}
const onNodeUnselect=(e)=>{
   DeleteMenu(e);
}
const DeleteMenu = async (node) =>{
 
    await useMenu().delete(selectedGroup.value,node.id);
    if(node.children){
        for(var child of node.children){
            DeleteMenu(child);
        }
    }
}
const onGroupSelect=async ()=>{
    
     selectedKey.value = [];
    var data = await useMenu().getAllByRole(selectedGroup.value);
    data.forEach(element => {
        
       
            selectedKey.value[element.id] = {checked: true,};
        
            
          
        
    });
}
</script>
<style>
#pnGroup .p-panelmenu-panel{
    height: 100%;
    padding-bottom: 40px;
   
}
#pnGroup .p-toggleable-content{
    height: 100%;
    overflow: auto;
    padding-bottom: 35px;
}
.accordion dt span {
    color: #085B8F;
    border-bottom: 2px solid #46A3D3;
    font-size: 1.5em;
    font-weight: bold;
    letter-spacing: -0.03em;
    line-height: 1.2;
    padding: 0;
    text-align: left;
    text-decoration: none;
    display: block;
}
</style>