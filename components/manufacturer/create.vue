<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter manufacturer information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="manufacturer.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="manufacturer.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="bg-[#3b82f6] p-2 text-white" @click="saveManufacturer"></Button>
    </div>
    <Toast />
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import { useManufacturer } from '~/stores/manufacturer';
import { useToast } from "primevue/usetoast";
const toast = useToast();
const manufacturer = ref({
  id: 0,
  name: "",
  description: "",
  createdBy: null,
  createdDate: null,
  lastUpdatedBy: null,
  lasrUpdatedDate: null
});
const emit = defineEmits(['update:modelValue', 'manufacturers']);
const props = defineProps(['manufacturers']);
var manufacturers = props.manufacturers;
const saveManufacturer = async () => {
     try{
        var data = await useManufacturer().create(manufacturer.value);
        emit('update:modelValue', false);
        manufacturers.push(data);
        toast.add({ severity: 'success', detail: 'Create successfully!', summary: 'Success Message', life: 5000 });
     }catch(error){
        toast.add({ severity: 'error', detail: 'Create fail!', summary: 'Error Message', life: 5000 });
        console.log(error);
     }
}
const closeDialog = () => {
    emit('update:modelValue', false);
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