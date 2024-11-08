<template>
    <div>
        <div>
        <span class="p-text-secondary block mb-5">Enter user information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[7rem] text-[14px]">Old Password</label>
        <InputText type="password" v-model="oldPassword" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[7rem] text-[14px]">New Password</label>
        <InputText type="password" v-model="newPassword" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[7rem] text-[14px]">Confirm new Password</label>
        <InputText type="password" v-model="confirmPassword" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Cancel" severity="secondary" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" class="p-2 text-white" @click="changePassword"></Button>
    </div>
    <Toast />
    </div>
</template>

<script setup>
import { ref } from 'vue';
import {useUser} from "~/stores/user";
import { useToast } from "primevue/usetoast";
const emit = defineEmits(['update:modelValue']);
const toast = useToast();
const oldPassword = ref('');
const newPassword = ref('');
const confirmPassword = ref('');
const changePassword = async () => {
    try{
            if(oldPassword.value != '' && newPassword.value != '' && confirmPassword.value != ''){
                if(newPassword.value != confirmPassword.value){
                toast.add({severity:'error', summary: 'Error', detail:'Confirm password is not match!', life: 3000});
            }else{
                    var data = await useUser().changePassword(oldPassword.value, newPassword.value);
                    console.log(data);
                    if(typeof data == 'string' && data != ''){
                        toast.add({severity:'error', summary: 'Error Message', detail:data, life: 3000});
                        return;
                    }
                    toast.add({severity:'success', summary: 'Success', detail:'Change password successfully!', life: 3000});
                    emit('update:modelValue', false);
            }
        }else{
            toast.add({severity:'error', summary: 'Error', detail:'Please enter password!', life: 3000});
        }
    }
    catch(error){
        toast.add({severity:'error', summary: 'Error', detail:'Change password failed!', life: 3000});
    }
}
const closeDialog = () => {
    emit('update:modelValue', false);
}

</script>