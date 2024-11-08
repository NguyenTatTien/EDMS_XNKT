<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter unit information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="unit.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="unit.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="bg-[#3b82f6] p-2 text-white" @click="saveUnit"></Button>
    </div>
    <Toast />
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {createUnitAPI} from '../../api/unitAPI.js';
import { useToast } from "primevue/usetoast";
const toast = useToast();
const emit = defineEmits(['update:modelValue', 'units']);
const props = defineProps(['units']);
const units = props.units;
const unit = ref({
    name: "",
    description: "",
    email:"",
    active:true,
});
const closeDialog = () => {
    emit('update:modelValue', false);
}
const saveUnit = async () => {
   try{
 
    var data = await createUnitAPI(unit.value);
    emit('update:modelValue', false);
    units.push(data);
    toast.add({ severity: 'success', detail: 'Create successfully!', summary: 'Success Message', life: 5000 });
   }catch(error){
        toast.add({ severity: 'error', detail: 'Create fail!', summary: 'Error Message', life: 5000 });
       console.log("Error create unit:"+error);
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