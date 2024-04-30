<template>
    <div class="px-2">
        <Button label="Infor Map" icon="pi pi-map flex px-2" outlined  @click="visibleInforMap = true"/>
        <PanelMenu :model="items" multiple>
            <template #item="{ item }">
                <a v-ripple class="flex align-items-center py-2 cursor-pointer">
                    
                    <img v-if="item.type == 'document'" :src="'/_nuxt/assets/' + item.icon" class="h-[16px] w-[16px]" />
                    <span v-else :class="item.icon" />
                  
                    <span :class="['ml-5']">{{ item.label }}</span>
                    <span v-if="item.items != null" class="pi pi-angle-down text-primary ml-auto" />
                </a>
 </template>
        </PanelMenu>
    </div>
    <Dialog v-model:visible="visibleInforMap" modal header="Infor Map" :style="{ width: '100rem' , height: '100rem' }">
    <TabInforMap/>
</Dialog>
</template>
<script setup>
import { ref,onMounted } from 'vue';
import {getDocumentByTabAPI} from '../../api/documentAPI.js';
const visibleInforMap = ref(false);
const items = ref([
    {
        label: 'Gian-001',
        icon: 'pi pi-graduation-cap',
        type: '',
        items: [
            {
                label: 'Tab-001',
                icon: 'pi pi-graduation-cap',
                type: '',
                items: [
                    {
                        label: 'Design Document',
                        icon: 'pi pi-file',
                        type: '',
                        items:null
                    },
                    {
                        label: 'Vendor Document',
                        icon: 'pi pi-file',
                        type: '',
                        items:null
                    },
                    
                    {
                        label: 'O&M Document',
                        icon: 'pi pi-file',
                        type: '',
                        items:null
                    }
                ]
            },
            
        ]
    }
]);
const documents = ref([]);
onMounted(async ()=>{
    await getDocumentByTab();
});
const getDocumentByTab = async () =>{
    try{
        documents.value = await getDocumentByTabAPI(1);
        if(documents.value.filter(p => p.documentTypeID == 1).length>0){
            items.value[0].items[0].items[0].items = [];
            documents.value.filter(p => p.documentTypeID == 1).forEach(element => {
          
            items.value[0].items[0].items[0].items.push({
                label: element.name,
                icon: element.fileExtensionIcon,
                type:"document",
            });
        });
        }
        
        if(documents.value.filter(p => p.documentTypeID == 2).length>0){
            items.value[0].items[0].items[1].items = [];
            documents.value.filter(p => p.documentTypeID == 2).forEach(element => {
           
            items.value[0].items[0].items[1].items.push({
                label: element.name,
                icon: element.fileExtensionIcon,type:"document",});
        });
        }
        if(documents.value.filter(p => p.documentTypeID == 3).length>0){
            items.value[0].items[0].items[2].items = [];
            documents.value.filter(p => p.documentTypeID == 3).forEach(element => {
            items.value[0].items[0].items[2].items.push({
                label: element.name,
                icon: element.fileExtensionIcon,type:"document",items:null});
        });
        }
      
       
    }catch(error){
        console.log(error);
    }
}
</script>
