<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter documentType information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="documentType.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="documentType.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]"></label>
        <Checkbox v-model="documentType.isVendorDocument" :binary="true" />
        <label for="ingredient2"> Is Vendor Document </label>
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="bg-[#3b82f6] p-2 text-white" @click="saveDocumentType"></Button>
    </div>
    <Toast />
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import { useDocumentType } from '~/stores/documentType';
import { useToast } from "primevue/usetoast";
const toast = useToast();
const emit = defineEmits(['update:modelValue','docTypeNotParents']);
const props = defineProps(['docTypeNotParents']);
const docTypeNotParents = props.docTypeNotParents;
//const manufacturers = props.manufacturers;
const selectDocType = ref(null);
const selectManufacturer = ref(null);
const documentType = ref({
    name: "",
    description: "",
    parentId: null,
    refId: null,
    createdBy: 1,
    lastUpdatedBy: null,
    createdDate: null,
    lastUpdatedDate: null,
    isVendorDocument: false
});
const closeDialog = () => {
    emit('update:modelValue', false);
}
const saveDocumentType = async () => {

   // documentType.value.refId = selectManufacturer.value != null ? selectManufacturer.value.id: null;
    try{
        var data = await useDocumentType().create(documentType.value);
        emit('update:modelValue', false);
        docTypeNotParents.push(data);
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