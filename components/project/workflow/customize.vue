<template>
     <div class="w-max h-max flex justify-center items-center min-h-[50px]" id="customize">
        <n-button strong secondary type="success" class="cursor-pointer p-1 mx-1 h-max" style="line-height: unset !important;" v-if="workflow">
                        <template #icon>
                            <i class="pi pi-plus" style="color: green;line-height: unset;" @click="onAddFistStep()"></i>
                        </template>
        </n-button>
          <div v-for="step in steps" :key="step.id" class="step flex justify-center items-center">
              <div class="flex flex-col justify-between items-center">
                  <div v-for="st in step.approveUsersCV" :key="'st_'+st.id" class="flex items-center">
                    <n-card :bordered="false" style="box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); border-radius: 8px;" :title="st.fullName" class="w-[260px] m-[10px] h-[140px]" header-class="text-center" header-style="padding-bottom:10px;color:white;display: none;">
                        <div class="mt-3 grid grid-cols-12">
                             <Inplace :closable="true" class="flex w-full col-span-11">
                                        <template #display>
                                            <div class="text-blue-500 cursor-pointer text-md font-bold" style="line-height: normal; overflow: hidden; text-overflow: ellipsis; height: 35px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                            {{step.currentWorkflowStepName ?? ''}}
                                               </div>
                                        </template>
                                        <template #content>
                                            <div class="flex flex-wrap w-full items-center">
                                                <n-input v-model:value="step.currentWorkflowStepName" type="text" placeholder="Basic Input" @blur="onSaveStep(step)"/>
                                            </div>
                                        </template>
                            </Inplace>
                            <i class="pi pi-times cursor-pointer" style="color: red;" @click="onDeleteUser(step,st)"></i>
                        </div>
                        <div class="mt-3 flex" style="line-height: normal;">
                            <i class="pi pi-pen-to-square pr-2 text-gray-400"/> 
                            <Inplace :closable="true" class="flex w-full col-span-11">
                                        <template #display>
                                            <div class="text-blue-500 cursor-pointer text-md font-bold">
                                                {{ step.duration ?? 0 }}
                                            </div>
                                        </template>
                                        <template #content>
                                            <div class="flex flex-wrap w-full items-center">
                                                <n-input-number v-model:value="step.duration" placeholder="Min" :min="0" :max="1000" :update-value-on-input="true" @blur="onSaveStep(step)"/>
                                            </div>
                                        </template>
                            </Inplace>
                        </div>
                        <hr class="w-full mt-3 h-0" style="border-top:1px solid gainsboro"/>
                        <div class="mt-3 flex" style="line-height: normal;">
                            <i class="pi pi-user pr-2 text-gray-400"/><span style="font-size: 14px; color: black;" class="pr-2">{{st.fullName}}</span>
                                            <n-popover :overlap="false" placement="bottom" trigger="click">
                                                <template #trigger>
                                                    <i class="pi pi-pencil cursor-pointer"></i>
                                                </template>
                                                <div class="w-[300px] flex items-end flex-col">
                                                    <SelectMultiUser v-model="step.approveUsersCV" placement="top" @blur="onSaveStep(step)"/>
                                                
                                                </div>
                                            </n-popover>
                        </div>
                    </n-card>
                    <i class="pi pi-minus text-gray-400" v-if="step.approveUsersCV.length > 1" style="line-height: unset;"/>
                  </div>
                  <div v-if="step.approveUsersCV.length==0" class="flex items-center">
                    <n-card :bordered="false" style="box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); border-radius: 8px;" class="w-[260px] m-[10px] h-[140px]" header-class="text-center" header-style="padding-bottom:10px;color:white;display: none;">
                        <div class="mt-3 grid grid-cols-12">
                            <Inplace :closable="true" class="flex w-full col-span-11">
                                        <template #display>
                                            <div class="text-blue-500 cursor-pointer text-md font-bold" style="line-height: normal; overflow: hidden; text-overflow: ellipsis; height: 35px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                            {{step.currentWorkflowStepName ?? ''}}
                                            </div>
                                        </template>
                                        <template #content>
                                            <div class="flex flex-wrap w-full items-center">
                                                <n-input v-model:value="step.currentWorkflowStepName" type="text" placeholder="Basic Input" @blur="onSaveStep(step)"/>
                                            </div>
                                        </template>
                            </Inplace>
                            <i class="pi pi-times cursor-pointer" style="color: red;" @click="onDeleteUser(step,st)"></i>
                        </div>
                        <div class="mt-3 flex" style="line-height: normal;">
                            <i class="pi pi-pen-to-square pr-2 text-gray-400"/> 
                            <Inplace :closable="true" class="flex w-full col-span-11">
                                        <template #display>
                                            <div class="text-blue-500 cursor-pointer text-md font-bold">
                                                {{ step.duration ?? 0 }}
                                            </div>
                                        </template>
                                        <template #content>
                                            <div class="flex flex-wrap w-full items-center">
                                                <n-input-number v-model:value="step.duration" placeholder="Min" :min="0" :max="1000" :update-value-on-input="true" @blur="onSaveStep(step)"/>
                                            </div>
                                        </template>
                            </Inplace>
                        </div>
                        <hr class="w-full mt-3 h-0" style="border-top:1px solid gainsboro"/>
                        <div class="mt-3 flex" style="line-height: normal;">
                            <i class="pi pi-user pr-2 text-gray-400"/><span style="font-size: 14px; color: black;" class="pr-2"></span>
                                            <n-popover :overlap="false" placement="bottom" trigger="click">
                                                <template #trigger>
                                                    <i class="pi pi-pencil cursor-pointer"></i>
                                                </template>
                                                <div class="w-[300px] flex items-end flex-col">
                                                    <SelectMultiUser v-model="step.approveUsersCV" placement="top" @blur="onSaveStep(step)"/>
                                                </div>
                                            </n-popover>
                        </div>
                    </n-card>
                    <i class="pi pi-minus text-gray-400" v-if="step.approveUsersCV.length > 1" style="line-height: unset;"/>
                  </div>
              </div>
              <div class="flex" :style="`height:${step.approveUsersCV.length * 160 - 160}px`"><div class="w-[2px] bg-gray-400 h-[100%]" v-if="step.approveUsersCV.length > 1"></div></div>
                    <n-button strong secondary type="success" class="cursor-pointer p-1 mx-1 h-max" style="line-height: unset !important;">
                        <template #icon>
                            <i class="pi pi-plus" style="color: green;line-height: unset;" @click="onAddStep(step)"></i>
                        </template>
                    </n-button>
              <div v-if="step.nextWorkflowStepID != null" style="line-height: 0;">
                  <i class="pi pi-arrow-right text-gray-400" style="line-height: unset;"></i>
              </div>
          </div>
        </div>
</template>
<script setup>
import { ref, onMounted, watch } from 'vue';
import { useWorkflowDetail } from '~/stores/workflowDetail';
import { WorkflowStep } from '~/models/workflowStep';
import { WorkflowDetail } from '~/models/workflowDetail';
import { useWorkflowStep } from '~/stores/workflowStep';
import { ca } from 'date-fns/locale';
const emit = defineEmits(['update:modelValue','workflow']);
const props = defineProps(["modelValue",'workflow']);
const steps = ref(props.modelValue);
const workflow = ref(props.workflow);
const selectUsers = ref([]);
onMounted(async () => {
    steps.value = props.modelValue;
});
watch(() => props.modelValue, async (newValue) => {
    steps.value = newValue;
});
watch(() => props.workflow, async (newValue) => {
    workflow.value = newValue;
});
const onDeleteUser = async(step,user) => {
    var cf = confirm(`Are you sure to delete step ${step.currentWorkflowStepName}?`);
    if(!cf) return;
    step.approveUsersCV = step.approveUsersCV.filter(t=>t.id != user.id);
    if(step.approveUsersCV.length == 0){
        var data = await useWorkflowStep().delete(step.currentWorkflowStepID);
        steps.value = data;
    }else{
        onSaveStep(step);
    }
}
const onSaveStep = async(step) => {
    var users = step.approveUsersCV;
    console.log(users);
    step.approveUserIds =  users.map(t=>t.id).join(';'); 
    step.approveUserNames = users.map(t=>t.fullName).join(';');
   step.duration == null ? step.duration = 0 : step.duration;
  
   var data = await useWorkflowDetail().updateStep(step);
   steps.value = steps.value.map(t=>t.id == data.id ? data : t);
}
const onAddStep = async(step) => {
    try{
        var newStep = new WorkflowStep();
        newStep.workflowID = props.workflow.id;
        newStep.workflowName = props.workflow.name;
        var data = await useWorkflowStep().create(newStep);
        var stepDetail = data.stepDetail;
        stepDetail.rejectWorkflowStepID = step.currentWorkflowStepID;
        stepDetail.rejectWorkflowStepName = step.currentWorkflowStepName;
        stepDetail.nextWorkflowStepID = step.nextWorkflowStepID;
        stepDetail.nextWorkflowStepName = step.nextWorkflowStepName;
        step.nextWorkflowStepID = stepDetail.currentWorkflowStepID;
        step.nextWorkflowStepName = stepDetail.currentWorkflowStepName;
        console.log(stepDetail);
        console.log(step);
        await useWorkflowDetail().update(step);
        await useWorkflowDetail().update(stepDetail);
        let index = steps.value.indexOf(step);console.log(index);
        steps.value.splice(index + 1, 0, stepDetail);
    }catch(error){
        console.log(error);
    }
}
const onAddFistStep = async() => {
    try{
        var newStep = new WorkflowStep();
        newStep.workflowID = props.workflow.id;
        newStep.workflowName = props.workflow.name;
        newStep.isFirst = true;
        var data = await useWorkflowStep().create(newStep);
        steps.value.unshift(data.stepDetail);
    }catch(error){
        console.log(error);
    }
}
</script>
<style>
#customize .n-card > .n-card__content:first-child{
    padding-top: 0 !important;
}
</style>
