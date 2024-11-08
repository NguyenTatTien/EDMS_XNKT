<template>
    <div>
        <!-- <a-timeline>
            <a-timeline-item v-for="(item,index) in timeLine">
                {{ item.documentName }}
            </a-timeline-item>
        </a-timeline> -->
        
        <Timeline :value="timeLine">
            <template #opposite="slotProps">
                <small class="p-text-secondary text-[12px] w-[100px] px-2">{{ $dayjs(new Date(slotProps.item.createTime)).format('DD-MM-YYYY HH:MM:ss') }}</small>
            </template>
            <template #content="slotProps">
                <div class="text-[12px]">[ <span class="font-bold" :title="slotProps.item.filePathDocument">{{ slotProps.item.fullName }}</span> ] - {{ slotProps.item.content }} - {{ slotProps.item.documentName }}</div>
            </template>
        </Timeline>
       
    </div>
</template>

<script setup>
import { useStatic }  from '~/stores/static';
import { storeToRefs } from 'pinia';
import Loading from 'vue-loading-overlay';
const { timeLine } = storeToRefs(useStatic());
</script>
<style>
.p-timeline-event-opposite{
    width: 100px !important;
    flex: 0 !important;
    display: contents !important; 
}
</style>