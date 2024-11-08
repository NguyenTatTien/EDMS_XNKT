<template>
    <div v-if="isLoaded && selectTag != null" class="" style="width:100% ; height: 100%">
       <ClientOnly><TagInforMap :nodeData="nodeData" :selectTag="selectTag"/></ClientOnly>
    </div>
  </template>
  <script setup>

  import { onMounted, ref, watch } from 'vue';
  import {useRoute} from 'vue-router';
  import {useTag} from '~/stores/tag';
  import { useDocumentType } from '~/stores/documentType';
  import { useDocument } from '~/stores/document';
  import {useDomain} from '~/stores/domain';
  const {url} = storeToRefs(useDomain());
  const router = useRoute();
  const nodeData = ref([]);
  const selectTag = ref();
  const documents = ref([]);
  const documentTypes = ref([]);
  const items = ref([]);
  const isLoaded = ref(false);
  onMounted( async() => {
    isLoaded.value = false;
    var query = router.query;
    var tagID = query.tagID;
    if(tagID != null){
        selectTag.value = await useTag().getById(tagID);
    }
    else{
      var tag = query.tag;
      var plant = query.platForm;
      selectTag.value = await useTag().getByInfor(tag,plant);
      console.log(selectTag.value);
      console.log(tag);
      console.log(plant);
    }
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
        isLoaded.value = true;
    }
  });
  const getDocumentType = async () =>{
    try{
        documentTypes.value = await useDocumentType().getAll();
    }catch(error){
        console.log(error);
    }
}
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
                            id:id,}
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
                                            var childItem =createItem(element.typeID,model.name,"","pi pi-graduation-cap",childManufacturer);
                                            var childNode =createNode(element.typeID,model.name,'',"",'',item);
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
                                        var childItem =createItem(element.typeID,model.name,"","pi pi-graduation-cap",childManufacturer);
                                        var childNode =createNode(element.typeID,model.name,'','','',childManufacturer);
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
                                        if(childManufacturer.items.filter(p=>p.id==element.typeID).length == 0){
                                                var childItem =createItem(element.typeID,model.name,"","pi pi-graduation-cap",childManufacturer);
                                            var childNode =createNode(element.typeID,model.name,'','','',childManufacturer);
                                            var docItem =createItem(element.id,element.name,"document",element.fileExtensionIcon,childItem);
                                            var docNode =createNode(element.id,element.name,element.fileExtensionIcon,element.fileExtension,element.filePath,childItem); 
                                            childItem.items.push(docItem);
                                        childNode.children.push(docNode);
                                        childManufacturer.items.push(childItem);
                                        nodeManufacturer.children.push(childNode);
                                        item.items.push(childManufacturer);
                                        node.children.push(nodeManufacturer);
                                        }
                                        else{
                                            var childItem = childManufacturer.items.filter(p=>p.id==element.typeID)[0];
                                        var childNode = node.children.filter(p=>p.id==String(element.typeID))[0];
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
                                                        var childItem =createItem(element.typeID,model.name,"","pi pi-graduation-cap",childManufacturer);
                                                        var childNode =createNode(element.typeID,model.name,'','','',item);
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
  </script>
  <style>
  #map {
    height: 100%;
    width: 100%;
  }
  .map-container me-tpc>* {
    pointer-events: all !important;
  }
  </style>
  <!-- <template>
      <VueFlow
   :nodes="nodes" :edges="edges"
   class=".vue-flow__node-custom" />
  
  </template>
  <script setup>
  import { VueFlow, } from '@vue-flow/core';
  
  import { ref, onMounted } from 'vue';
  const nodes = ref([
   {
     id: '1',
     position: { x: -250, y: 300 },
     label: 'Tab',
   },
   { id: '2', label: 'Doucment', position: { x: -15, y: 300 }, },
   { id: '3', label: 'Design Document', position: { x: 200, y: 400 } },
   { id: '4', label: 'Vendor Document', position: { x: 200, y: 300 } },
   { id: '5', label: 'Standard Document', position: { x: 250, y: 50 } },
   { id: '6', label: 'Layout', position: { x:400, y: 450 } },
   { id: '7', label: 'DataSheet', position: { x: 350, y: 550 } },
   { id: '8', label: 'ISO', position: { x: 500, y: 0 } },
   { id: '9', label: 'TCVN', position: { x: 500, y: 100 } },
   { id: '10', label: 'VSP01-E-123-CONNECTION DIAGRAM OF JUNCTION BOX.PDF', position: { x: 500, y: 200 } },
   { id: '11', label: 'VSP01-E-116-ARRANGEMENT OF ANTENNA.PDF', position: { x: 500, y: 250 } },
   { id: '12', label: 'VSP01-E-123-CONNECTION DIAGRAM OF JUNCTION BOX.PDF', position: { x: 500, y: 300 } },
   { id: '13', label: 'VSP01-E-124-CONNECTION DIAGRAM OF ELECTRICAL POWER SYSTEM.PDF', position: { x: 500, y: 350 } },
   { id: '14', label: 'VSP01-E-201-1-INSTRUCTION.PDF', position: { x: 800, y: -50 } },
   { id: '15', label: 'VSP01-E-200-2-TEST REPORT.PDF', position: { x: 800, y: 0 } },
   { id: '16', label: 'VSP01-E-200-1-INSTRUCTION.PDF', position: { x: 800, y: 100 } },
   { id: '17', label: 'VSP01-E-200-2-TEST REPORT.PDF', position: { x: 800, y: 150 } },
   { id: '18', label: 'VSP01-E-200-DIESEL GENERATOR.PDF', position: { x: 800, y: 200 } },
   { id: '19', label: 'VSP01-E-212-MAIN CONTROL CONSOLE & MONITORING SYSTEM.PDF', position: { x: 800, y: 350 } },
   { id: '20', label: 'VSP01-E-201-1-INSTRUCTION.PDF', position: { x: 800, y: 400 } },
   { id: '21', label: 'VSP01-E-202-2-TEST REPORT.PDF', position: { x: 800, y: 450 } },
   { id: '22', label: 'VSP01-E-211-GAS DETECTION AND ALARM (OUT LINE, INSTRUCTION, TEST REPORT).PDF', position: { x: 800, y: 500 } },
  ]);
  const edges = ref([
   {
     id: 'e1-2',
     source: '1',
     target: '2',
   },
   {
     id: 'e2-3',
     source: '2',
     target: '3',
   },{
     id: 'e2-4',
     source: '2',
     target: '4',
   },
   {
     id: 'e2-5',
     source: '2',
     target: '5',
   },
   {
     id: 'e3-6',
     source: '3',
     target: '6',
   },
   {
     id: 'e3-7',
     source: '3',
     target: '7',
   },
   {
     id: 'e5-8',
     source: '5',
     target: '8',
  
   },
   {
     id: 'e5-9',
     source: '5',
     target: '9',
  
   },
   {
     id: 'e4-10',
     source: '4',
     target: '10',
  
   },
   {
     id: 'e4-11',
     source: '4',
     target: '11',
  
   },
   {
     id: 'e4-12',
     source: '4',
     target: '12',
  
   },
   {
     id: 'e4-13',
     source: '4',
     target: '13',
  
   },
   {
     id: 'e8-14',
     source: '8',
     target: '14',
  
   },
   {
     id: 'e8-15',
     source: '8',
     target: '15',
  
   },
   {
     id: 'e9-16',
     source: '9',
     target: '16',
  
   },
   {
     id: 'e9-17',
     source: '9',
     target: '17',
  
   },
   {
     id: 'e9-18',
     source: '9',
     target: '18',
  
   },
   {
     id: 'e6-19',
     source: '6',
     target: '19',
  
   },
   {
     id: 'e6-20',
     source: '6',
     target: '20',
  
   },
   {
     id: 'e7-21',
     source: '7',
     target: '21',
  
   },
   {
     id: 'e7-22',
     source: '7',
     target: '22',
  
   },
  ]);
  const me = ref();
  onMounted(() => {
  
  });
  </script>
  <style>
  @import '@vue-flow/core/dist/theme-default.css';
  @import '@vue-flow/core/dist/style.css';
  
  </style> -->
  <style>
  .main-node-container img{
    float: left;
    margin-right: 5px;
  }
  </style>
  