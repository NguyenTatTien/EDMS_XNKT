<template>
    <div>
        <!-- <Dropdown v-model="selectedFolder" :options="folders" filter optionLabel="name" placeholder="Select a Country" class="w-full md:w-14rem"></Dropdown> -->
        <n-select v-model:value="selectedFolder" :options="folders" filterable value-field="id" label-field="name" class="w-full md:w-14rem" @update:value="onSelectFolder"/>
    </div>
</template>
<script setup>
import { ref,onMounted,h,watch } from 'vue';
import { useFolder } from '~/stores/folder';
const emit = defineEmits(['update:modelValue']);
const props = defineProps(['modelValue']);
const object = ref();
const folders = ref([]);
const selectedFolder = ref(null);
onMounted(async () => {
    object.value = props.modelValue;
    folders.value = await useFolder().getAllPermissionWrite();  
    selectedFolder.value = object.value.folderID;
});
const onSelectFolder = () => {
    object.value.folderID = selectedFolder.value;
    object.value.folderName = folders.value.find(folder => folder.id == selectedFolder.value).name;
    emit('update:modelValue', object.value);
}
</script>