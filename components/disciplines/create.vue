<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter disciplines information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="disciplines.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="disciplines.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="bg-[#3b82f6] p-2 text-white" @click="saveDisciplines"></Button>
    </div>
    <Toast />
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import { useDisciplines } from '~/stores/disciplines';
import { useToast } from "primevue/usetoast";
const toast = useToast();
const emit = defineEmits(['update:modelValue', 'discipliness']);
const props = defineProps(['discipliness']);
const discipliness = props.discipliness;
const disciplines = ref({
    name: "",
    description: "",
    createdBy: 1,
    lastUpdatedBy: null,
    createdDate: null,
    lastUpdatedDate: null,
});
const closeDialog = () => {
    emit('update:modelValue', false);
}
const saveDisciplines = async () => {
    try{
        var data = await useDisciplines().create(disciplines.value);
    emit('update:modelValue', false);
    discipliness.push(data);
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