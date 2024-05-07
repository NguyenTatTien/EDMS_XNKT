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
    <Dialog v-model:visible="visibleInforMap" modal header="Infor Map" class="w-full h-full">
    <TagInforMap/>
</Dialog>
</template>
<script setup>
import { ref,onMounted } from 'vue';
import { closeSidebarRight } from '../../assets/js/sidebar.js';
const emit = defineEmits(['treeTag']);
const props = defineProps(['treeTag']);
const visibleInforMap = ref(false);
const expandedKeys = ref({});
const items = ref(props.treeTag);
watch(() => props.treeTag, (newValue) => {
    items.value = newValue;
    expandAll();
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
</script>
