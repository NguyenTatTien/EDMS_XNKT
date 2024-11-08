<template>
    <div>
        <span class="p-text-secondary block mb-5">Enter user information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">User name</label>
        <InputText v-model="user.username" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Full name</label>
        <InputText v-model="user.fullName" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Group</label>
        <Dropdown v-model="selectedGroup" :options="groups" optionLabel="name" placeholder="Select group" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[324px]" />
    </div>
    <div class="flex items-center gap-3 mb-5">
        <label for="email" class="font-semibold w-[6rem]">Email</label>
        <InputText v-model="user.email" id="email" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-5">
        <label for="email" class="font-semibold w-[6rem]">Organization</label>
        <Dropdown v-model="selectUnit" :options="units" optionLabel="name" placeholder="Select group" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[324px]" />
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="bg-[#3b82f6] p-2 text-white" @click="saveUser"></Button>
    </div>
    <Toast />
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {useGroup} from '~/stores/group';
import {useUser} from '~/stores/user';
import {useUnit} from '~/stores/unit';
import { useToast } from "primevue/usetoast";
const toast = useToast();
const selectUnit = ref();
const units = ref([]);
const selectedGroup = ref();
const emit = defineEmits(['update:modelValue', 'users']);
const props = defineProps(['users']);
const users = props.users;
const user = ref({
    username: "",
    fullName: "",
    roleId:null,
    email: "",
    password: "123456",
    createdBy:1,
    unitID:null,
    unitName:"",
});
const groups = ref([
]);
const getListGroup = async () =>{
        try{
            groups.value = await useGroup().getAll();
        }catch(error){
            console.log("Error get list user:"+error);
        }
    }
    const getListUnit = async () =>{
        try{
            units.value = await useUnit().getAll();
        }catch(error){
            console.log("Error get list user:"+error);
        }
    }
    const saveUser = async () => {
    try{
        if(user.value.username == "" || user.value.fullName == ""){
            toast.add({ severity: 'error', detail: 'Please enter username and fullname!', summary: 'Error Message', life: 5000 });
            return;
        }
        if(selectedGroup.value == null){
            toast.add({ severity: 'error', detail: 'Please select group!', summary: 'Error Message', life: 5000 });
            return;
        }
        user.value.roleId = selectedGroup.value.id;
        
        if(selectUnit.value){
            user.value.unitID = selectUnit.value.id;
            user.value.unitName = selectUnit.value.name;
        }
        var data = await useUser().create(user.value);
        if(typeof data == "string"){
            toast.add({ severity: 'error', detail: data, summary: 'Error Message', life: 5000 });
            return;
        }
        emit('update:modelValue', false);
        users.push(data);
        toast.add({ severity: 'success', detail: 'Create successfully!', summary: 'Success Message', life: 5000 });
    }catch(error){
        toast.add({ severity: 'error', detail: 'Create fail!', summary: 'Error Message', life: 5000 });
        console.log(error);
    }
}
onMounted(async ()=>{
    await getListGroup();
    await getListUnit();
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