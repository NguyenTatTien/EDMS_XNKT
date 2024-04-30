<template>
    <div class="flex flex-wrap">
        <div v-for="(item, index) in documents" :key="index" class="p-2">
                <div class="w-[16rem] rounded-2xl bg-[#f0f4f9] p-2 px-4 flex justify-between cursor-pointer">
                    <div class="flex items-center" @click="openDocument(item)">
                        <i class="pi pi-folder" v-if="item.type == 'folder'"></i>
                        <img :src="'/_nuxt/assets/'+item.object.fileExtensionIcon" v-else class="w-[16px] h-[16px]"/>
                        <div class="pl-2" style=" white-space: nowrap; width: 150px; overflow: hidden; text-overflow: ellipsis;">{{item.object.name}}</div>
                    </div>
                    <div>
                        <i class="pi pi-ellipsis-v" @click="(event)=> toggle(event, item)"></i>
                    </div>
                </div>
        </div>
    </div>
</template>
<script setup>
import { ref, onMounted,watch  } from 'vue';
const emit = defineEmits(['documents','nextbreadcrumbItems','openDocument','toggle']);
const props = defineProps(['documents']);
 const documents = ref([]);
onMounted(() => {
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
