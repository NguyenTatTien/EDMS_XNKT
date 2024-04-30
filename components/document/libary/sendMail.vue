<template>
    <div class="flex flex-wrap">
        <div class="w-full flex justify-center items-center mb-2">
            <span class="w-[100px]">To:</span>
            <MultiSelect v-model="selectedUsersTo" :options="users.filter(u=>u.email!='')" filter optionLabel="email" placeholder="Select Cities"
            :maxSelectedLabels="3" class="w-full md:w-20rem" />
        </div>
        <div class="w-full flex justify-center items-center mb-2">
            <span class="w-[100px]">CC:</span>
            <MultiSelect v-model="selectUsersCC" :options="users.filter(u=>u.email!='')" filter optionLabel="email" placeholder="Select Cities"
            :maxSelectedLabels="3" class="w-full md:w-20rem" />
        </div>
        <div class="w-full flex justify-center items-center mb-2">
            <span class="w-[100px]">Subject:</span>
            <InputText id="subjcetMail" v-model="subjectMail" aria-describedby="username-help" class="w-full md:w-20rem" />
        </div> 
    </div>
    <div class="mb-2">
        <Editor v-model="objectMail.body" editorStyle="height: 320px"/>
    </div>
    <div class="flex justify-end gap-2">
        <Button type="button" label="Send" class="p-2 text-white" @click="onSendMail"></Button>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {userGetAllAPI} from '../../../api/userAPI';
import {ObjectMail} from '../../../models/objectMail.js';
import Editor from 'primevue/editor';
import {sendMailAPI,getObjcetMailAPI} from '../../../api/mailAPI.js';
import '@vueup/vue-quill/dist/vue-quill.snow.css';
const users = ref([]);
const selectedUsersTo = ref();
const selectUsersCC = ref();
const subjectMail = ref("Availability of New/Updated 02. P.Tổ chức nhân sự / ОУП Documents on EDMS System");
const objectMail = ref(new ObjectMail());
onMounted(()=>{
    loadAllUser();
    loadObjcetMailAPI();
});
const loadAllUser = async () =>{
    users.value = await userGetAllAPI();
}
const loadObjcetMailAPI = async () =>{
    try{
        objectMail.value = await getObjcetMailAPI();
    }catch(err){
        console.log(err);
    }
}
const onSendMail = async () =>{
    
    objectMail.body = contentMail.value;
    await sendMailAPI(objectMail);
}
</script>
