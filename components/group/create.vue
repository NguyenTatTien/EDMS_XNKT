<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter group information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Name</label>
        <InputText v-model="group.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Description</label>
        <InputText v-model="group.description" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="bg-[#3b82f6] p-2 text-white" @click="saveGroup"></Button>
    </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {createGroupAPI} from '../../api/groupAPI.js';
const emit = defineEmits(['update:modelValue', 'groups']);
const props = defineProps(['groups']);
var groups = props.groups;
const group = ref({
    name: "",
    description: "",
    email:"",
    active:true,
});
const closeDialog = () => {
    emit('update:modelValue', false);
}
const saveGroup = async () => {
    var data = await createGroupAPI(group.value);
    emit('update:modelValue', false);
    groups.push(data);
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