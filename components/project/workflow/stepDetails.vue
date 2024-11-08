<template>
    <div class="bg-white py-5 h-full flex flex-col w-full justify-between" style="border-radius: 5px;">
        <div>
            <div class="px-5 grid grid-cols-12">
                <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Current Step</span>
                <span class="col-span-7 text-xl" style="font-weight: 500;">{{ currentStep.currentWorkflowStepName }}</span>
            </div>
        <hr class="mt-5"/>
        <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Workflow</span>
            <span class="col-span-7" style="font-weight: 500;">{{ currentStep.currentWorkflowStepName }}</span>
        </div>
        <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Next Step</span>
            <span class="col-span-7" style="font-weight: 500;">{{ currentStep.nextWorkflowStepName }}</span>
        </div>
        <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Reject Step</span>
            <span class="col-span-7" style="font-weight: 500;">{{ currentStep.rejectWorkflowStepName }}</span>
        </div>
        <hr class="mt-5"/>
        <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Received Date</span>
            <span class="col-span-7" style="font-weight: 500;">{{currentStep.receivedDate != null? format(currentStep.receivedDate, 'dd/MM/yyyy') :""}}</span>
        </div>
        <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Plan Date</span>
            <span class="col-span-7" style="font-weight: 500;">{{currentStep.planCompleteDate != null? format(currentStep.planCompleteDate, 'dd/MM/yyyy') :""}}</span>
        </div>
        <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Actual Date</span>
            <span class="col-span-7" style="font-weight: 500;">{{currentStep.actualDate != null? format(currentStep.actualDate, 'dd/MM/yyyy') :""}}</span>
        </div>
        <!-- <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Duration Next Step</span>
            <Inplace :closable="true" class="flex w-full col-span-7">
                          <template #display>
                            <span class="text-blue-500 cursor-pointer">
                              {{currentStep.durationNextStep}}
                            </span>
                          </template>
                          <template #content>
                            <div class="flex flex-wrap w-full items-center">
                                <InputNumber v-model="currentStep.durationNextStep" inputId="minmaxfraction" :minFractionDigits="1" :maxFractionDigits="1" />
                            </div>
                          </template>
            </Inplace>
        </div> -->
        <hr class="mt-5"/>
        <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">User Approve</span>
            <Inplace :closable="true" class="flex w-full col-span-7">
                          <template #display>
                            <span class="text-blue-500 cursor-pointer">
                              {{currentStep.userFullName ?? 'Chọn người'}}
                            </span>
                          </template>
                          <template #content>
                            <div class="flex flex-wrap w-full items-center">
                              <ProjectUserSelect v-model="currentStep" :name="'userFullName'" :id="'userID'"/>
                            </div>
                          </template>
            </Inplace>
        </div>
        <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Next User</span>
            <Inplace :closable="true" class="flex w-full col-span-7">
                        <template #display> 
                            <span class="text-blue-500 cursor-pointer">
                              {{currentStep.userNextSteps ? currentStep.userNextSteps.map(user => user.fullName).join(', ') : 'Chọn người'}}
                            </span>
                        </template>
                        <template #content>
                            <div class="flex flex-wrap w-[90%] items-center">
                              <ProjectUserMultiSelect v-model="currentStep.userNextSteps" :paneClass="'n-model-multiselect'"/>
                            </div>
                        </template>
            </Inplace>
        </div>
        <div class="mt-5 px-5 grid grid-cols-12">
            <span class="col-span-5 inline-block text-[#9cabbb]" style="font-weight: 500;">Status</span>
            <Tag class="col-span-7 w-fit" v-if = "currentStep.isComplete" value="Approved" :severity="getSeverity(1)" />
            <Tag class="col-span-7 w-fit" v-else-if = "currentStep.isLeaf" value="In-Process" :severity="getSeverity(2)" />
            <Tag class="col-span-7 w-fit" v-else-if = "currentStep.isLeaf != true && currentStep.isReject != true" value="Wait for approval" :severity="getSeverity(0)" />
            <Tag class="col-span-7 w-fit" v-else value="Reject" :severity="getSeverity(3)" />
        </div>
        <hr class="mt-5"/>
        <div class="mt-5 px-5">
            <n-input v-model:value="currentStep.commentContent" type="textarea" placeholder="Comment" class="h-[120px]"/>
        </div>
        </div>
        <div class="flex justify-center mt-5">
          
            <Button label="Save" class="mx-2 text-[14px]" @click="onSave" v-if="project.isApprove != true"/>
            <Button label="Approve" severity="info" class="mx-2 text-[14px]" @click="onAttach" v-if="!currentStep.isComplete && currentStep.isLeaf && project.isApprove != true"/>
            <Button label="Reject" severity="danger"  class="mx-2 text-[14px]" @click="onReject" v-if="!currentStep.isComplete && currentStep.rejectWorkflowStepId && currentStep.isLeaf && project.isApprove != true"/>
        </div>
        <Toast baseZIndex="9999" autoZIndex="true" class="n-model-Toast"/>
    </div>
</template>
<script setup>
import { ref,onMounted,watch } from "vue";
import { format, parse,formatISO   } from 'date-fns';
import { useObjectAssginUser } from '~/stores/objectAssginUser';
import { useToast } from "primevue/usetoast";
const value = ref("");
const emit = defineEmits(["update:modelValue",'next','prev','closeDrawer','refresh','project']);
const props = defineProps(["modelValue",'project']);
const project = ref(props.project);
const currentStep = ref(props.modelValue);
const toast = useToast();
watch(()=>props.project,(val)=>{
    project.value = val;
});
watch(()=>props.modelValue,(val)=>{
    currentStep.value = val;
});
onMounted(async()=>{
});
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
const onAttach = async() => {
    // await onSave();
    await useObjectAssginUser().update(currentStep.value);
    emit("next",currentStep.value.id, currentStep.value.projectId);
    emit("closeDrawer");
};
const onReject = async() => {
    await useObjectAssginUser().update(currentStep.value);
    emit("prev",currentStep.value.id, currentStep.value.projectId);
    emit("closeDrawer");
};
const onSave = async() => {
    try{
        await useObjectAssginUser().update(currentStep.value);
        emit("refresh");
        emit("closeDrawer");
        toast.add({ severity: 'success', summary: 'Success', detail: 'Save successfully!', life: 100000 });
    }catch(error){
        toast.add({ severity: 'error', summary: 'Error', detail: 'Save failed!', life: 3000 });
    }
}
</script>