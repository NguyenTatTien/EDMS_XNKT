<template>
      <div class="h-full flex">
        <n-infinite-scroll class="workflow-container h-full" :distance="10">
          <div class="flex justify-end w-full px=2">
          <Card class="w-[280px]">
          <template #content>
              <div class="font-bold text-center w-full">{{ steps[0][0].workflowName }}</div>
            <hr class="w-full mt-3 h-0" style="border-top:1px solid gainsboro"/>
            <div class="flex justify-center gap-2">
              <n-button type="error" @click="deleteWorkflow">
                <template #icon>
                    <i class="pi pi-trash"></i>
                </template>
                Delete
              </n-button>
              <n-button type="primary" @click="onOpenHistory">
                <template #icon>
                  <i class="pi pi-stopwatch"></i>
                </template>
                History
              </n-button>
            </div>
          </template>
      </Card>
        </div>
        <div class="w-max h-max flex justify-center">
          <div v-for="step in steps" :key="step[0].id" class="step flex justify-center items-center">
              <div class="flex flex-col justify-between items-center">
                  <div v-for="st in step" :key="'st_'+st.id" class="flex items-center">
                    <n-card :bordered="false" style="box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); border-radius: 8px;" :title="st.userFullName" class="w-[260px] m-[10px] h-[200px]" header-class="text-center" header-style="padding-bottom:10px;color:white;display: none;" @click="openStepDetail(st)">
                        <div class="w-full mt-3 flex items-center">
                          <Tag v-if = "st.isComplete" value="Approved" :severity="getSeverity(1)" />
                          <Tag v-else-if = "st.isLeaf" value="In-Process" :severity="getSeverity(2)" />
                          <Tag v-else-if = "st.isLeaf != true && st.isReject != true" value="Wait for approval" :severity="getSeverity(0)" />
                          <Tag v-else value="Reject" :severity="getSeverity(3)" />
                          <i class="pi pi-check pl-2" style="color:green" v-if="st.isComplete && st.assignedBy == st.userID"/>
                        </div>
                        <div class="mt-3 text-lg font-bold " style="line-height: normal; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                              {{ st.currentWorkflowStepName }}
                        </div>
                        <div class="mt-3 flex" style="line-height: normal;">
                            <i class="pi pi-pen-to-square pr-2 text-gray-400"/> <div class="text-black" style="line-height: normal; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">{{ st.commentContent }}</div>
                        </div>
                        <hr class="w-full mt-3 h-0" style="border-top:1px solid gainsboro"/>
                        <div class="mt-3" style="line-height: normal;">
                            <i class="pi pi-user pr-2 text-gray-400"/> <span style="font-size: 14px; color: black;">{{ st.userFullName }}</span>
                        </div>
                        <div class="mt-3" style="line-height: normal;">
                            <i lass="pi pi-calendar pr-2 text-gray-400"/> 
                            <span class="text-black" v-if="st.isComplete">Approved {{st.actualDate !=null? format(st.actualDate, 'dd/MM/yyyy') :""}}</span>
                            <span class="text-black" v-else-if="st.isLeaf">Plan Date {{st.planCompleteDate != null? format(st.planCompleteDate, 'dd/MM/yyyy') :""}}</span>
                        </div>
                    </n-card>
                    <i class="pi pi-minus text-gray-400" v-if="step.length >1" style="line-height: unset;"/>
                  </div>
              </div>
              <div class="flex" :style="`height:${step.length * 220 -220}px`"><div class="w-[2px] bg-gray-400 h-[100%]" v-if="step.length > 1"></div></div>
              <div v-if="step[0].nextWorkflowStepId != null" style="line-height: 0;">
                  <i class="pi pi-arrow-right text-gray-400" style="line-height: unset;"></i>
              </div>
          </div>
        </div>
        </n-infinite-scroll>
      <n-drawer v-model:show="showStepWorkflow" :width="500" class="bg-transparent" style="box-shadow: none;">
  <n-drawer-content>
    <ProjectWorkflowStepDetails v-model="currentStep" @next="next" @prev="prev" @closeDrawer="closeDrawer" @refresh="refresh" :project="project"/>
    <template #footer>
    </template>
  </n-drawer-content>
</n-drawer>
<n-drawer v-model:show="showHistory" :width="400" class="bg-transparent" style="box-shadow: none;">
  <n-drawer-content>
    <ProjectWorkflowHistory v-model="project"/>
    <template #footer>
    </template>
  </n-drawer-content>
</n-drawer>
<Toast />
<loading v-model:active="isLoading"
      :is-full-page="true" color="#3B82F6" class="left-[50%] top-[50%]"/>
    </div>
  </template>
  <script setup>
import { ref,onMounted,watch } from "vue";
import { format, parse,formatISO } from 'date-fns';
import { useObjectAssginUser } from '~/stores/objectAssginUser';
import {useWorkflow} from '~/stores/workflow';
import { useToast } from "primevue/usetoast";
import Loading from 'vue-loading-overlay';
import { useUser } from "~/stores/user";
import { is } from "date-fns/locale";
const isLoading = ref(false);
const current = ref(1);
const currentStatus = ref("process");
const emit = defineEmits(["update:modelValue","refreshWF",'project','updateProject']);
const props = defineProps(["modelValue",'project']);
const steps = ref(props.modelValue);
const project =ref(props.project);
const showStepWorkflow = ref(false);
const showHistory = ref(false);
const toast = useToast();
const currentStep = ref(null);
const myUser = ref(useUser().getUser());
watch(()=>props.project,(val)=>{
  project.value = val;
});
watch(()=>props.modelValue,(val)=>{
  steps.value = val;
});
const next= async(objID, projectID)=> {
  try{
    isLoading.value = true;
    var data = await useObjectAssginUser().approve(objID, projectID);
    emit("updateProject",data);
    await emit("refreshWF");
    if (current.value === null) {
      current.value = 1;
    } else if (current.value >= 5) {
      current.value = null;
    } else {
      current.value++;
    }
    toast.add({severity: 'success', summary: 'Success', detail: 'Approve successfully!', life: 5000});
  }catch(error){
    toast.add({severity: 'error', summary: 'Error', detail: 'Approve failed!', life: 5000});
  }
  finally{
    isLoading.value = false;
  }
}
const prev = async(objID, projectID)=> {
  try{
    isLoading.value = true;
    await useObjectAssginUser().reject(objID, projectID);
    await emit("refreshWF");
    if (current.value === 0) {
      current.value = null;
    } else if (current.value === null) {
      current.value = 5;
    } else {
      current.value--;
    }
    toast.add({severity: 'success', summary: 'Success', detail: 'Reject successfully!', life: 5000});
  }catch(error){
    toast.add({severity: 'error', summary: 'Error', detail: 'Reject failed!', life: 5000});
  }
  finally{
    isLoading.value = false;
  }
}
onMounted(()=>{
   if(steps.value != null && steps.value.length > 0){
      steps.value.forEach(element => {
        if(element[0].isComplete){
          current.value++;
        }
      });
   }
});
const deleteWorkflow = async() => {
  try{
    var st = confirm("Are you sure to delete this workflow?");
    if(!st){
      return;
    }
    await useWorkflow().deleteWorkflow(props.project.id);
    await emit("refreshWF");
    toast.add({severity: 'success', summary: 'Success', detail: 'Delete successfully!', life: 5000});
  }catch(error){
    toast.add({severity: 'error', summary: 'Error', detail: 'Delete failed!', life: 5000});
  }
}
const refresh = async()=>{+
  await emit("refreshWF");
}
const getSeverity = (status) => {
    switch (status) {
        case 0:
            return 'secondary';
        case 1:
            return 'info';
        case 2:
            return 'warning';
        case 3:
            return 'danger';
        default:
            return null;
    }
};
const closeDrawer = () =>{
    showStepWorkflow.value = false;
}
const openStepDetail = (step)=>{
  if(step.userID == myUser.value.id||myUser.value.id == 1){
    currentStep.value = step;
    showStepWorkflow.value = true;
  }
}
const onOpenHistory = ()=>{
  showHistory.value = true;
}
  </script>
  <style>
  .n-card-header__main{
    color: white !important;
  }
  .n-steps .n-step--finish-status .n-step-indicator{
    box-shadow: 0 0 0 1px #4285f4;
  }
  .n-steps .n-step--finish-status .n-step-indicator .n-step-indicator-slot .n-base-icon{
    color: #4285f4;
  }
  .n-steps .n-step--finish-status .n-step-splitor{
    background-color: #4285f4 !important;
  }
  .n-steps .n-step--process-status .n-step-indicator{
    box-shadow: 0 0 0 1px #fa8e42;
    background: #fa8e42;
  }
  .n-steps .n-step--process-status .n-step-indicator .n-step-indicator-slot .n-base-icon{
    color: #fa8e42;
  }
  .n-steps .n-step--process-status .n-step-splitor{
    background-color: #fa8e42 !important;
  }
  .approve{
    --n-text-color-hover: #4285f4 !important;
    /* --n-border-focus: #4285f4 !important; */
    --n-border-hover:1px solid #4285f4 !important;
  }
  .reject{
    --n-text-color-hover: #ff3547 !important;
    /* --n-border-focus: #4285f4 !important; */
    --n-border-hover:1px solid #ff3547 !important;
  }
  .n-step-content__description{
    margin-left: 10px !important;
  }
  .workflow-container {
  position: relative;
  background-color: #f8fafc; 
  padding: 20px;
  grid-template-columns: repeat(8, 1fr);
  grid-template-rows: repeat(10, 1fr); 
}
/* .workflow-container::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: radial-gradient(circle, #ccc 1px, transparent 1px);
  background-size: 30px 30px; 
  pointer-events: none;
} */
.n-drawer-footer{
  border: none !important;
  padding: 0px 24px !important;
}
</style>