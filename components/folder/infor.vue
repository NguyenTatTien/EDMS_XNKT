<template>
    <div v-if="parentFolder != null" class="flex flex-col justify-between w-[250px] px-[10px] h-[100%]">
        <div class="flex flex-col">
            <span>{{parentFolder.name}}</span>
            <div class="w-full h-[150px] bg-gray-100 flex justify-center items-center mt-[12px]">
                <span class="universe-icon" width="68" height="68" style="font-size: 68px;"><svg width="1em" height="1em" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M1 6h22v13a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V6Z" fill="#FFC60A"></path><path d="M1 4a2 2 0 0 1 2-2h5.275a4 4 0 0 1 1.404.255l2.642.99a4 4 0 0 0 1.404.255H21a2 2 0 0 1 2 2V6H1V4Z" fill="#FF9D4C"></path></svg></span>
            </div>
            <span class="text-[13px] text-[#646a73] leading-6 flex items-center mt-[12px]">Description</span>
            <span class="text-[15px] text-[#1f2329] leading-6 flex items-center mt-[12px] font-medium whitespace-nowrap">{{parentFolder.description}}</span>
            <span class="text-[13px] text-[#646a73] leading-6 flex items-center mt-[12px]">Create By</span>
            <span class="text-[15px] text-[#1f2329] leading-6 flex items-center mt-[12px] font-medium whitespace-nowrap">{{parentFolder.createdByName}}</span>
            <span class="text-[13px] text-[#646a73] leading-6 flex items-center mt-[12px]">Folders</span>
            <span class="text-[15px] text-[#1f2329] leading-6 flex items-center mt-[12px] font-medium whitespace-nowrap">{{parentFolder.numberOfSubfolder}}</span>
            <span class="text-[13px] text-[#646a73] leading-6 flex items-center mt-[12px]">Files</span>
            <span class="text-[15px] text-[#1f2329] leading-6 flex items-center mt-[12px] font-medium whitespace-nowrap">{{parentFolder.numberOfDocument}}</span>
            <span class="text-[13px] text-[#646a73] leading-6 flex items-center mt-[12px]">Size</span>
            <span class="text-[15px] text-[#1f2329] leading-6 flex items-center mt-[12px] font-medium whitespace-nowrap">{{parentFolder.folderSize}} kbs</span>
        </div>
    </div>
    <div v-else class="flex flex-col justify-center w-[250px] px-[10px] h-[100%] text-[18px] text-[#808080] text-center">
        Not Found Folder!
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
const emit = defineEmits(['parentFolder']);
const props = defineProps(['parentFolder']);
const parentFolder = ref(props.parentFolder); 
watch(() => props.parentFolder, (newValue) => {
    parentFolder.value = newValue;
});
</script>
