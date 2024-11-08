<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter   information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="category.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="category.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Department</label>
        <Dropdown v-model="selectedGroup" :options="groups" optionLabel="name" placeholder="Select deparment" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[324px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]"></label>
        <Checkbox v-model="isActive" :binary="true" />
        <label for="ingredient1">Active</label>
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="bg-[#3b82f6] p-2 text-white" @click="saveCategories"></Button>
    </div>
    <Toast />
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';

import { useCategories } from '~/stores/categories';
import { useToast } from "primevue/usetoast";
const toast = useToast();
const emit = defineEmits(['update:modelValue', 'categories']);
const props = defineProps(['categories']);
const categories = props.categories;
const isActive = ref(false);
const category = ref({
    name: "",
    description: "",
    createdBy: 1,
    lastUpdatedBy: null,
    createdDate: null,
    lastUpdatedDate: null,
    isActive: false,
    departmentID: null,
    departmentName:null        
});
const groups = ref([
]);
const selectedGroup = ref();
const closeDialog = () => {
    emit('update:modelValue', false);
}
const getListGroup = async () =>{
        try{
            groups.value = await useGroup().getAll();
        }catch(error){
            console.log("Error get list user:"+error);
        }
    }
    getListGroup();
const saveCategories = async () => {
    try{
            category.value.isActive = isActive.value;
        if(selectedGroup.value){
            category.value.departmentID = selectedGroup.value.id;
            category.value.departmentName = selectedGroup.value.name;
        }
        var data = await useCategories().create(category.value);
        emit('update:modelValue', false);
        categories.push(data);
        toast.add({ severity: 'success', detail: 'Create successfully!', summary: 'Success Message', life: 5000 });
    }catch(error){
        toast.add({ severity: 'error', detail: 'Create fail!', summary: 'Error Message', life: 5000 });
        console.log(error);
    }
}
</script>
<style scoped>
    .p-button{
        padding: 0.5rem 1rem !important;
    }
    .p-inputtext{
        padding: 7px 10px !important;
    }
</style>