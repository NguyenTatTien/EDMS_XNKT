<template>
     <div class="px-2 mb-10"><i class="pi pi-times cursor-pointer text-[1.4rem]" @click="closeSidebarRight"></i></div>  
    <div class="px-2">
        <Button label="Infor Map" icon="pi pi-map flex px-2" outlined  @click="visibleInforMap = true"/>
        <PanelMenu v-model:expandedKeys="expandedKeys" :model="items" multiple>
            <template #item="{ item }">
                <a v-ripple class="flex align-items-center py-2 cursor-pointer">
                    <img v-if="item.type == 'document'" :src="'/_nuxt/assets/' + item.icon" class="h-[16px] w-[16px]" />
                    <span v-else :class="item.icon" />
                    <span :class="['ml-5']">{{ item.label }}</span>
                    <span v-if="item.items != null && item.items.length > 0" class="pi pi-angle-down text-primary ml-auto" />
                </a>
 </template>
        </PanelMenu>
    </div>
    <Dialog v-model:visible="visibleInforMap" modal header="Infor Map" class="w-full h-full rounded-none max-h-[100%]">
    <TagInforMap v-model="visibleInforMap" :nodeData="nodeData" :selectTag="selectTag"/>
</Dialog>
</template>
<script setup>      
import { ref,onMounted } from 'vue';
import { closeSidebarRight } from '../../assets/js/sidebar.js';
import { useDocumentType } from '~/stores/documentType';
import { useManufacturer } from '~/stores/manufacturer';
import { useModel } from '~/stores/model';
import { useDocument } from '~/stores/document';
import {useDomain} from '~/stores/domain';
import {useTypeFile} from "~/stores/typeFile";
import { storeToRefs } from 'pinia';
const {image} = storeToRefs(useTypeFile());
const {video} = storeToRefs(useTypeFile());
const {autoCard} = storeToRefs(useTypeFile());
const {url} = storeToRefs(useDomain());
const emit = defineEmits(['selectTag']);
const props = defineProps(['selectTag']); 
const visibleInforMap = ref(false);
const expandedKeys = ref({});
const items = ref([]);
const nodeData = ref([]);
const documents = ref([]);
const selectTag = ref(null);
const documentTypes = ref(null);
onMounted(() => {
});
watch(() => props.selectTag, (newValue) => {
    selectTag.value = newValue;
    nodeData.value = [];
    onOpenTag();
});
const expandAll = () => {
    for (let node of items.value) {
        expandNode(node);
    }
    expandedKeys.value = {...expandedKeys.value};
};
const expandNode = (node) => {
    if (node.items && node.items.length) {
        expandedKeys.value[node.key] = true;
        for (let child of node.items) {
            expandNode(child);
        }
    }
};
const createNode = (id,lable,_image,fileExtension,filePath,parent) => {
    var objParent = null;
    if(parent != null){
        objParent = {
            id:''+parent.key,
            topic: parent.label,
            expanded: true,
            direction:0,
        };
    }
   if(filePath != ''){
    var urlView = url.value.local+"view?Id="+id;

                var item = { 
                            id:''+id,
                            topic: lable,
                            expanded: true,
                            direction:0,
                            children: [],
                            hyperLink:urlView, 
                            image: {
                                url: '/_nuxt/assets/'+_image, // required
                                                            // you need to query the height and width of the image and calculate the appropriate value to display the image
                                                            height: 16, // required
                                                            width: 16,       
                            },
                            parent:objParent,
        }
        return item;
   }else{
    var item = { 
                            id:''+id,
                            topic: lable,
                            expanded: true,
                            direction:0,
                            children: [],
                            parent:objParent,
        }
        return item;
   }
}
const createItem = (id,lable,type,icon,parent) => {
    var objParent = null;
    if(parent != null){
        objParent = {
            key:''+parent.key,
            label: parent.label,
            icon: parent.icon,
            id:parent.id,
            type:parent.type,
        };
    }
    var item = { 
                            key:parent.key+'_'+id,
                            label: lable,
                            icon: icon,
                            type:type,
                            items: [],
                            parent:objParent,
                            id:id,
                }
    return item;
}
const getDocumentManufacturerByTag = async (id,items) =>{
    try{
        var iddocTypeVendor = documentTypes.value.filter(p=>p.isVendorDocument)[0].id;
        documents.value = await useDocument().getDocumentByTag(id);
        for(var element of documents.value.filter(p=>p.documentTypeID==iddocTypeVendor)){
            
                        var docType = documentTypes.value.filter(x => x.id == element.documentTypeID);
                        var type = documentTypes.value.filter(p=>p.refId==element.modelID);
                        if(items[0].items[0].items.length > 0){
                            if(element.documentTypeID!=null){
                                if(items[0].items[0].items.filter(p=>p.id==element.documentTypeID)==0){
                                if(docType.length>0){
                                    var item = createItem(element.documentTypeID,docType[0].name,"","pi pi-graduation-cap",items[0].items[0]);
                                    var node = createNode(element.documentTypeID,docType[0].name,'',"",'',items[0].items[0]);
                                    if(type.length > 0 && type[0].refId!=null && element.modelID!=null){
                                      
                                            var model = await useModel().getById(type[0].refId);
                                            var manufacturer = await useManufacturer().getById(model.manufacturerID);
                                            var childManufacturer =createItem(manufacturer.id,manufacturer.name,"","pi pi-graduation-cap",item);
                                            var nodeManufacturer =createNode(manufacturer.id,manufacturer.name,'','','',item);
                                            var childItem =createItem(element.modelID,model.name,"","pi pi-graduation-cap",childManufacturer);
                                            var childNode =createNode(element.modelID,model.name,'',"",'',item);
                                            var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem); 
                                            var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                            childItem.items.push(docItem);
                                            childNode.children.push(docNode);
                                            childManufacturer.items.push(childItem);
                                            nodeManufacturer.children.push(childNode);
                                       
                                            item.items.push(childManufacturer);
                                            node.children.push(nodeManufacturer);
                                            items[0].items[0].items.push(item);
                                            nodeData.value.push(node);
                                    }else{
                                        var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,item); 
                                        var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,node);
                                        item.items.push(docItem);
                                        node.children.push(docNode);
                                        items[0].items[0].items.push(item);
                                        nodeData.value.push(node);
                                    }
                                }else{
                                    var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,items[0].items[0]); 
                                    var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,items[0].items[0]); 
                                    items[0].items[0].items.push(docItem);
                                    nodeData.value.push(docNode);
                                }
                            }
                            else{   
                                var item = items[0].items[0].items.filter(p=>p.id==element.documentTypeID)[0];
                                var node = nodeData.value.filter(p=>p.id==String(element.documentTypeID))[0];
                                if(type.length > 0 && type[0].refId!=null && element.modelID!=null){
                                    var model = await useModel().getById(type[0].refId);
                                 
                                    if(item.items.filter(p=>p.id==model.manufacturerID).length == 0){
                                    
                                        var manufacturer = await useManufacturer().getById(model.manufacturerID);
                                        var childManufacturer =createItem(manufacturer.id,manufacturer.name,"","pi pi-graduation-cap",item);
                                        var nodeManufacturer =createNode(manufacturer.id,manufacturer.name,'','','',item);
                                        var childItem =createItem(element.modelID,model.name,"","pi pi-graduation-cap",childManufacturer);
                                        var childNode =createNode(element.modelID,model.name,'','','',childManufacturer);
                                        var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem);
                                        var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                        childItem.items.push(docItem);
                                        childNode.children.push(docNode);
                                        childManufacturer.items.push(childItem);
                                        nodeManufacturer.children.push(childNode);
                                      
                                        item.items.push(childManufacturer);
                                        node.children.push(nodeManufacturer);
                                    }else{
                                        var childManufacturer = item.items.filter(p=>p.id==model.manufacturerID)[0];
                                        if(childManufacturer.items.filter(p=>p.id==element.modelID).length == 0){
                                            var childItem =createItem(element.modelID,model.name,"","pi pi-graduation-cap",childManufacturer);
                                            var childNode =createNode(element.modelID,model.name,'','','',childManufacturer);
                                            var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem);
                                            var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                            childItem.items.push(docItem);
                                        childNode.children.push(docNode);
                                        childManufacturer.items.push(childItem);
                                        nodeManufacturer.children.push(childNode);
                                        }
                                        else{
                                            var childItem = childManufacturer.items.filter(p=>p.id==element.modelID)[0];
                                            var childNode = nodeManufacturer.children.filter(p=>p.id==String(element.modelID))[0];
                                            var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem); 
                                            var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                        childItem.items.push(docItem);
                                        childNode.children.push(docNode);
                                        }
                                    }
                                }
                                else{
                                    var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,item); 
                                    var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,item); 
                                    item.items.push(docItem);
                                    node.children.push(docNode);
                                }
                                }
                                }
                                else{
                                    var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,items[0].items[0]); 
                                    var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,items[0].items[0]); 
                                    items[0].items[0].items.push(docItem);
                                    nodeData.value.push(docNode);
                                }
                            }else{
                                if(docType.length>0){
                                    var item = createItem(element.documentTypeID,docType[0].name,"","pi pi-graduation-cap",items[0].items[0]);
                                    var node = createNode(element.documentTypeID,docType[0].name,'','','',items[0].items[0]);
                                    if(type.length > 0 && type[0].refId!=null && element.modelID!=null){
                                       
                                                        var model = await useModel().getById(type[0].refId);
                                                        var manufacturer = await useManufacturer().getById(model.manufacturerID);
                                                        var childManufacturer =createItem(manufacturer.id,manufacturer.name,"","pi pi-graduation-cap",item);
                                                        var nodeManufacturer =createNode(manufacturer.id,manufacturer.name,'','','',item);
                                                        var childItem =createItem(element.modelID,model.name,"","pi pi-graduation-cap",childManufacturer);
                                                        var childNode =createNode(element.modelID,model.name,'','','',item);
                                                        var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem); 
                                                        var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                                        childItem.items.push(docItem);
                                                        childNode.children.push(docNode);
                                                        childManufacturer.items.push(childItem);
                                                        nodeManufacturer.children.push(childNode);
                                                     
                                                        item.items.push(childManufacturer);
                                                        node.children.push(nodeManufacturer);
                                                        items[0].items[0].items.push(item);
                                                        nodeData.value.push(node);
                                    }
                                    else{
                                        var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,item); 
                                        var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,item); 
                                        item.items.push(docItem);
                                        node.children.push(docNode);
                                        items[0].items[0].items.push(item);
                                        nodeData.value.push(node);
                                    }
                                }else{
                                    var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,items[0].items[0]); 
                                    var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,items[0].items[0]); 
                                    items[0].items[0].items.push(docItem);
                                    nodeData.value.push(docNode);
                                }
                            }
        };
        console.log(items[0].items[0].items);
    }catch(error){
        console.log(error);
    }
}
const getDocumentByTag = async (id,items) =>{
    try{
        var iddocTypeVendor = documentTypes.value.filter(p=>p.isVendorDocument)[0].id;
        documents.value = await useDocument().getDocumentByTag(id);
        for(var element of documents.value.filter(p=>p.documentTypeID!=iddocTypeVendor)){
            var docType = documentTypes.value.filter(x => x.id == element.documentTypeID);
            var type = documentTypes.value.filter(p=>p.id==element.typeID);
            if(items[0].items[0].items.length > 0){
                if(element.documentTypeID!=null){
                    if(items[0].items[0].items.filter(p=>p.id==element.documentTypeID)==0){
                    if(docType.length>0){
                            var item = createItem(element.documentTypeID,docType[0].name,"","pi pi-graduation-cap",items[0].items[0]);
                            var node = createNode(element.documentTypeID,docType[0].name,'','','',items[0].items[0]);
                            if(type.length > 0){
                                    var childItem =createItem(element.typeID,type[0].name,"","pi pi-graduation-cap",item);
                                    var childNode =createNode(element.typeID,type[0].name,'','','',item);
                                    var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem); 
                                    var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                    childItem.items.push(docItem);
                                    childNode.children.push(docNode);
                                    item.items.push(childItem);
                                    node.children.push(childNode);
                                    items[0].items[0].items.push(item);
                                    nodeData.value.push(node);
                            }else{
                                var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,item); 
                                var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,item); 
                                item.items.push(docItem);
                                node.children.push(docNode);
                                items[0].items[0].items.push(item);
                                nodeData.value.push(node);
                            }
                        }else{
                                    var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,items[0].items[0]); 
                                    var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,items[0].items[0]); 
                                    items[0].items[0].items.push(docItem);
                                    nodeData.value.push(docNode);
                        }
                    }
                    else{
                        var item = items[0].items[0].items.filter(p=>p.id==element.documentTypeID)[0];
                            var node = nodeData.value.filter(p=>p.id==String(element.documentTypeID))[0];
                        if(type.length > 0){
                            if(item.items.filter(p=>p.id==element.typeID).length == 0){
                                var childItem =createItem(element.typeID,type[0].name,"","pi pi-graduation-cap",item);
                                var childNode =createNode(element.typeID,type[0].name,'','','',item);
                                var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem);
                                var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                childItem.items.push(docItem);
                                childNode.children.push(docNode);
                                item.items.push(childItem);
                                node.children.push(childNode);
                            }else{
                                var childItem = item.items.filter(p=>p.id==element.typeID)[0];
                                var childNode = node.children.filter(p=>p.id==String(element.typeID))[0];
                                var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem); 
                                var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                childItem.items.push(docItem);
                                childNode.children.push(docNode);
                            }
                        }else{
                            var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,item); 
                            var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,item); 
                            item.items.push(docItem);
                            node.children.push(docNode);
                        }
                    }
                }else{
                    var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,items[0].items[0]); 
                    var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,items[0].items[0]); 
                    items[0].items[0].items.push(docItem);
                    nodeData.value.push(docNode);
                }
            }else{
                if(docType.length>0){
                    var item = createItem(element.documentTypeID,docType[0].name,"","pi pi-graduation-cap",items[0].items[0]);
                    var node = createNode(element.documentTypeID,docType[0].name,'','','',items[0].items[0]);
               if(type.length > 0){
                                var childItem =createItem(element.typeID,type[0].name,"","pi pi-graduation-cap",item);
                                var childNode =createNode(element.typeID,type[0].name,'','','',item);
                                var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem); 
                                var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                childItem.items.push(docItem);
                                childNode.children.push(docNode);
                                item.items.push(childItem);
                                node.children.push(childNode);
                                items[0].items[0].items.push(item);
                                nodeData.value.push(node);   
               }else{
                                        var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,item); 
                                        var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,item); 
                                        item.items.push(docItem);
                                        node.children.push(docNode);
                                        items[0].items[0].items.push(item);
                                        nodeData.value.push(node);
               }
                }else{
                                   
                                   var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,items[0].items[0]); 
                                   var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,items[0].items[0]); 
                                   items[0].items[0].items.push(docItem);
                                   nodeData.value.push(docNode);
                }
            }
        };
        console.log(items);
    }catch(error){
        console.log(error);
    }
}
const getDocumentType = async () =>{
    try{
        documentTypes.value = await useDocumentType().getAll();
    }catch(error){
        console.log(error);
    }
}
const onOpenTag =async () => {
    if(selectTag.value != null){
        var menu = [
        {
            key:'0',
            label: selectTag.value.plantName,
            icon: 'pi pi-graduation-cap',
            items: [
                {
                    key:'0_1',
                    label: selectTag.value.name,
                    icon: 'pi pi-graduation-cap',
                    type: '',
                    items: [
                        
                    ]
                },
            ]
        }
        ];
        await getDocumentType();
        await getDocumentByTag(selectTag.value.id,menu);
        await getDocumentManufacturerByTag(selectTag.value.id,menu);
        items.value = menu;
        console.log(items.value);
        expandAll();
    } 
}
</script>

