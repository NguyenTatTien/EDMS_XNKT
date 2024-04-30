<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter user information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="model.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="model.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Manufacturer</label>
        <Dropdown v-model="model.manufacturerID" :options="manufacturers" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[324px]" />
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="bg-[#3b82f6] p-2 text-white" @click="saveModel"></Button>
    </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {manufacturerGetAllAPI} from '../../api/manufacturerAPI.js';
import {createModelAPI} from '../../api/modelAPI.js';
const selectedManufacturer = ref();
const emit = defineEmits(['update:modelValue', 'models']);
const props = defineProps(['models']);
const models = props.models;
const model = ref({
  id: 0,
  name: "",
  description: "",
  manufacturerID: null,
  manufacturer:null,
  createdBy: null,
  createdDate: null,
  lastUpdatedBy: null,
  lasrUpdatedDate: null
})
const manufacturers = ref([
]);
const getListManufacturer = async () =>{
        try{
            manufacturers.value = await manufacturerGetAllAPI();
        }catch(error){
            console.log("Error get list manufacturer:"+error);
        }
    }
const saveModel = async () => {
    model.value.manufacturerID = model.value.manufacturer.id;
    var data = await createModelAPI(model.value);
    emit('update:modelValue', false);
    models.push(data);
}
onMounted(async ()=>{
    await getListManufacturer();
});
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