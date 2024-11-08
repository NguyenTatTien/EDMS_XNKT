<template>
    <div>
        <DataTable :value="recentDocuments" class="w-full">
        <template #empty> 
        <div class="w-full flex justify-center items-center">
            <span class="flex flex-wrap">
            <img src="https://lf-scm-sg.larksuitecdn.com/ccm/pc/web/resource/bear/images/illustration_empty-neutral-no-file.2d63d7ca.svg"/>
            <span class="w-full text-gray-700">
                No content yet
            </span>
            </span>
        </div>
        </template>
        <Column style="min-width: 50px">
        <template #body="{data }">
           
            <img :src="'/_nuxt/assets/'+data.fileExtensionIcon" class="w-[16px] h-[16px] cursor-pointer" @click="viewFile(data)"/>
        </template>
    </Column> 
        <Column field="name" header="Name"></Column>
        <Column field="createdByName" header="Create By"></Column>
        <Column field="createdDate" header="Create Date">
            <template #body="{data}">
                <span>{{ $dayjs(new Date(data.createdDate)).format('DD-MM-YYYY') }}</span>
            </template>
        </Column>
    </DataTable>
    <Toast />
    <Dialog v-model:visible="visibleViewFile" modal header=" " class="w-full h-full max-h-full" id="viewFile">
    <viewDocument :Id="ViewId" v-model="visibleViewFile"/>
    </Dialog>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import { useUser } from '~/stores/user';
import { storeToRefs } from 'pinia';
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import ColumnGroup from 'primevue/columngroup';   // optional
import Row from 'primevue/row';                   // optional
import { useStatic }  from '~/stores/static';
import { useToast } from "primevue/usetoast";
const { recentDocuments } = storeToRefs(useStatic());
const toast = useToast();
const ViewId = ref("");
const visibleViewFile = ref(false);
const viewFile = (data)=>{
   if(data.isHasFile){
        ViewId.value = data.id;
        visibleViewFile.value = true;
   }else{
    toast.add({ severity: 'error', summary: 'Error Message', detail: "File Not Found!", life: 5000 });
   }
}
</script>
<style>
#viewFile .p-dialog-content{
    width: 100%;
    height: 100%;
}
</style>