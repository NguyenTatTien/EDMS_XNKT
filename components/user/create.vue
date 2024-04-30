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
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="bg-[#3b82f6] p-2 text-white" @click="saveUser"></Button>
    </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {groupGetAllAPI} from '../../api/groupAPI.js';
import {userCreateAPI} from '../../api/userAPI.js';
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
})
const groups = ref([
]);
const getListGroup = async () =>{
        try{
            groups.value = await groupGetAllAPI();
        }catch(error){
            console.log("Error get list user:"+error);
        }
    }
const saveUser = async () => {
    user.value.roleId = selectedGroup.value.id;
    var data = await userCreateAPI(user.value);
    emit('update:modelValue', false);
    users.push(data);
}
onMounted(async ()=>{
    await getListGroup();
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