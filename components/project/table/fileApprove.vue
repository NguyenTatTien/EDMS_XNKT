<template>
    <div>
        <div v-if="(project.fileApprove == null || project.fileApprove == '')" class="upFileApprove">
            <FileUpload name="demo[]" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" :maxFileSize="1000000"  @select="(e)=>onSelectedFiles(e,project)">
            <template #header="{ chooseCallback}">
            <div class="flex gap-2">
                <Button @click="chooseCallback()" icon="pi pi-cloud-upload" rounded outlined severity="success"></Button>
            </div>
        </template>
          </FileUpload>
          </div>
          <img src="../../../assets/images/excelfile.png" v-else-if="(project.fileApprove != null && project.fileApprove != '')" class="w-[16px] h-[16px] cursor-pointer" @click="onDownloadFileApprove(project)"/>
          <Toast />
    </div>
</template>
<script setup>
import {ref,watch} from 'vue'
import {useUser} from '~/stores/user';
import { useToast } from "primevue/usetoast";
const emit = defineEmits(['update:modelValue',"project",'selectedProject']);
const props = defineProps(['modelValue','project']);
const dataModel = ref(props.modelValue);
const project = ref(props.project);
const myUser = useUser().getUser();
const toast = useToast();
watch(() => props.project, (newValue) => {
  project.value = newValue;
});
const onSelectedFiles = async(e,data)=>{
  try{
    var form = new FormData();
  form.append("file",e.files[0]);
  form.append("jsonProject",JSON.stringify(data));
  var reponse = await useProject().upFileApprove(form);
  dataModel.value = dataModel.value.map(p=>p.id == reponse.id? reponse : p);
  emit("update:modelValue",dataModel.value);
  emit("selectedProject");
  toast.add({ severity: 'success', summary: 'Success Message', detail: "Upload Successfully!", life: 5000 });
  }catch(e){
    console.log(e);
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Upload fail!", life: 5000 });
  }
}
const onDownloadFileApprove = (data)=>{
    var urldownload = useDomain().url.server + data.fileApprove;
    const link = document.createElement('a');
    link.href = urldownload;
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
}
</script>