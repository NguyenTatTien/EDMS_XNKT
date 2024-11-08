<template>
    <div>
        <div class="flex flex-wrap">
        <div class="w-full flex justify-center items-center mb-2">
            <span class="w-[100px]">To:</span>
            <!-- <MultiSelect v-model="selectedUsersTo" :options="users.filter(u=>u.email!='')" filter optionLabel="email" placeholder="Select Cities"
            :maxSelectedLabels="3" class="w-full md:w-20rem" /> -->
            
            <n-select v-model:value="selectedUsersTo" filterable multiple tag :options="users.filter(u=>u.email!='')" label-field="email" value-field="email" @keyup.enter="onAddEmailTo"/>
            
        </div>
        <div class="w-full flex justify-center items-center mb-2">
            <span class="w-[100px]">CC:</span>
            <n-select v-model:value="selectUsersCC" filterable multiple tag :options="users.filter(u=>u.email!='')" label-field="email" value-field="email" @keyup.enter="onAddEmailTo"/>
            <!-- <MultiSelect v-model="selectUsersCC" :options="users.filter(u=>u.email!='')" filter optionLabel="email" placeholder="Select Cities"
            :maxSelectedLabels="3" class="w-full md:w-20rem" /> -->
        </div>
        <div class="w-full flex justify-center items-center mb-2">
            <span class="w-[100px]">Subject:</span>
            <n-input v-model:value="objectMail.subject" type="text" placeholder="" />
            <!-- <InputText id="subjcetMail" v-model="objectMail.subject" aria-describedby="username-help" class="w-full md:w-20rem" /> -->
        </div> 
        </div>
        <div class="mb-2">
            <ClientOnly>
                <Editor v-model="value" ref="editor" editorStyle="height: 320px" @load="onLoadEditor"/>
            </ClientOnly>
        </div>
        <div class="flex justify-end gap-2">
            <Button type="button" label="Send" class="p-2 text-white" @click="onSendMail"></Button>
        </div>
        <Toast />
        <loading v-model:active="isLoading"
        :is-full-page="true" color="#3B82F6"/>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {ObjectMail} from '../../../models/objectMail.js';
import {useUser} from '../../../stores/user';
import Editor from 'primevue/editor';
import {useMail} from '../../../stores/mail';
import { useToast } from "primevue/usetoast";
import { useDocument } from '~/stores/document';
import { useMailHistory } from '~/stores/mailHistory.ts';
import { MailHistory } from '~/models/mailHistory.js';
import Loading from 'vue-loading-overlay';
const isLoading = ref(false);
 const toast = useToast();
const emit = defineEmits(["update:modelValue","multiDocuments","typeSendMail"]);
const props = defineProps(["multiDocuments","typeSendMail"]);
const users = ref([]);
const editor = ref(null);
const selectedUsersTo = ref([]);
const selectUsersCC = ref([]);
const objectMail = ref(new ObjectMail());
const content = ref();
const multiDocuments = ref(props.multiDocuments);
const typeSendMail = ref(props.typeSendMail);
onMounted(async()=>{
    await loadAllUser();
    //await loadObjcetMailAPI();
});
watch(() => props.multiDocuments, (newValue) => {
    multiDocuments.value = newValue;
});
watch(() => props.typeSendMail, (newValue) => {
    typeSendMail.value = newValue;
});
const loadAllUser = async () =>{
    users.value = await useUser().getAll();
    users.value = users.value.filter((item, index, self) =>
  index === self.findIndex(t => t.email === item.email)
);
}
const loadObjcetMailAPI = async () =>{
    try{
       const documents = multiDocuments.value.filter(d => !d.isFolder);
       const folders = multiDocuments.value.filter(d => d.isFolder);
        var docs = await useDocument().getAllDocumentsByListFolder(folders);
        docs.forEach(element => {
            documents.push(element);
        });
       var data = {
           documents:JSON.parse(JSON.stringify(documents)),
           type:typeSendMail.value,
           url:(window.location.href).replace("&","*%*%")
       };
       objectMail.value = await useMail().getInforMail(data);
    }catch(err){
        console.log(err);
    }
}
const onSendMail = async () =>{
    isLoading.value = true;
    try{
        if(selectedUsersTo.value.length !=0 || selectedUsersTo.value.length != 0){
            objectMail.value.toUsers = selectedUsersTo.value;
            objectMail.value.ccUsers = selectUsersCC.value;
            await useMail().sendMail(objectMail.value); 
            var mailHistory = new MailHistory();
            mailHistory.sendTo = selectedUsersTo.value.join(",");
            mailHistory.sendCC = selectUsersCC.value.join(",");
            mailHistory.body = objectMail.value.body;
            mailHistory.subject = objectMail.value.subject;
            await useMailHistory().create(mailHistory);
            emit("update:modelValue",false);
            toast.add({ severity: 'success', detail: 'Send mail successfully!', summary: 'Success', life: 5000 });
        }
        else{
            toast.add({ severity: 'error', detail: 'Please select at least one user!', summary: 'Error', life: 5000 });
        }
    }
    catch(err){
        toast.add({ severity: 'error', detail: 'Send mail fail!', summary: 'Error', life: 5000 });
    }
    finally{
        isLoading.value = false;
    }
}
const onLoadEditor =async ()=> {
    await loadObjcetMailAPI();
    const delta = editor.value.quill.clipboard.convert({ html: objectMail.value.body });
    editor.value.quill.setContents(delta, 'silent');
}
const onAddEmailTo = () =>{
    if(!isValidEmail(selectedUsersTo.value[selectedUsersTo.value.length-1])){
        selectedUsersTo.value.pop();
        toast.add({ severity: 'error', detail: 'Email is invalid!', summary: 'Error', life: 5000 });
    }
}
function isValidEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

</script>
<style>
        .table-row {
            display: flex;
            border-bottom: 1px solid #ddd;
        }
        .table-cell {
            flex: 1;
            padding: 8px;
            border-right: 1px solid #ddd;
        }
        .table-cell:last-child {
            border-right: none;
        }
        .header-cell {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        .table-row:nth-child(even) .table-cell {
            background-color: #f9f9f9;
        }
        .ql-editor table td{
            border:  1px solid gray;
        }
        .ql-editor table{
            border-collapse: collapse;
        }
       .ql-editor table td:nth-child(1){
           width: 40px;
       }
       .ql-editor table td:nth-child(2){
           width: 330px;
       }
       .ql-editor table td:nth-child(3){
           width: 330px;
       }
       .ql-editor table td:nth-child(4){
           width: 120px;
       }
       .ql-editor table td:nth-child(5){
           width: 330px;
       }
</style>
