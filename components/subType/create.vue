<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter Sub Type information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="documentType.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="documentType.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Document Type</label>
        <Dropdown  v-model="selectDocType" editagle :options="docTypeNotParents" optionLabel="name" placeholder="Select document type" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <!-- <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Manufacturer</label>
        <Dropdown  v-model="selectManufacturer" editagle :options="manufacturers" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div> -->
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
const emit = defineEmits(['update:modelValue', 'documentTypes','docTypeNotParents']);
const props = defineProps(['documentTypes','docTypeNotParents']);
const documentTypes = props.documentTypes;
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
});
const closeDialog = () => {
    emit('update:modelValue', false);
}
const saveDocumentType = async () => {
    try{
        documentType.value.parentId = selectDocType.value != null ? selectDocType.value.id: null;
    // documentType.value.refId = selectManufacturer.value != null ? selectManufacturer.value.id: null;
        var data = await useDocumentType().create(documentType.value);
        emit('update:modelValue', false);
        documentTypes.push(data);
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