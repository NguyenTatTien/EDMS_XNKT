<template>
    <div>
        <DataTable v-model:selection="selectedDocuments" scrollable class="text-xs h-[100%]" stripedRows editMode="cell" :value="documents">
    <template #empty> No found. </template>
    <template #loading> Loading data. Please wait. </template>
    <Column selectionMode="multiple" headerStyle="width: 2rem"></Column>
    <Column style="min-width: 50px">
        <template #body="{data }">
            <i class="pi pi-folder" v-if="data.type == 'folder'"></i>
            <img  :src="'/_nuxt/assets/'+data.object.fileExtensionIcon" v-else class="w-[16px] h-[16px] cursor-pointer"/>
        </template>
    </Column>
    <Column field="object.name" header="Name" style="min-width: 20rem">
        <template #body="{ data }">
            <a href="#" class="no-underline text-gray-700"><div  @click="openDocument(data)" class="cursor-pointer">{{ data.object.name }}</div></a>
        </template>
    </Column>
    <Column header="Description" style="min-width: 20rem">
        <template #body="{ data }">
            <div v-if="data.type == 'folder'">{{ data.object.description }}</div>
            <div v-else>{{ data.object.title }}</div>
        </template>
    </Column>
    <Column style="min-width: 12rem">
        <template #body="{ data }">
            <i class="pi pi-ellipsis-v cursor-pointer" @click="(event)=> toggle(event, data)"></i>
        </template>
    </Column>
</DataTable>
    </div>
</template>
<script setup>
import { ref, onMounted,watch, getCurrentInstance,nextTick   } from 'vue';
import { useDropZone, useEventListener, useDraggable  } from '@vueuse/core'
const emit = defineEmits(['documents','nextbreadcrumbItems','openDocument','toggle']);
const props = defineProps(['documents']);
 const documents = ref([]);
 const dragElement = ref();
 const pngRef = ref();
const elRef = ref();
const selectedDocuments = ref();
const metaKey = ref(true);
onMounted(() => {
    nextTick(() => {
    });
    useEventListener(elRef, 'dragstart', (event) => {
        console.log(event);
         var a = document.getElementById(event.target.id);
        dragElement.value = pngRef;
        console.log(toRaw(dragElement.value));
    });
});
watch(() => props.documents, (newValue) => {
    documents.value = newValue;
   
});
const openDocument = async (data) => {
    if(data.type=="folder"){
        emit('openDocument',data);
        emit('nextbreadcrumbItems',data);
    }
}
const toggle = (event,data) => {
    emit('toggle',{event,data});
};
</script>
