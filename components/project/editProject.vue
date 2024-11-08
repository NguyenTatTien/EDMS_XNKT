<template>
    <div class="flex-noshink flex-wrap w-full h-full">
      <div class="w-full flex border-bot-1 pb-3 items-center">
        <div class="flex-grow">
          <section name="info" class="w-full flex">
            <span>
                <Tag v-if = "dataModel.isProcess == true && dataModel.isLate == false" value="In Process" :severity="getSeverity(1)" />
                <Tag v-else-if = "dataModel.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                <Tag v-else-if = "dataModel.isLate == true" value="Late" :severity="getSeverity(3)" />
                <Tag v-else-if = "dataModel.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                <Tag v-else value="Cancel" :severity="getSeverity(4)" />
            </span>
            <p class="font-semibold text-[17px] p-0 m-0 text-gray-500 ml-2">{{dataModel.name}}</p>
          </section>
        </div>
       
        <div class="flex items-center mr-8">
          <a-tag v-if="dataModel.approvals != null && dataModel.approvals.filter(t=>t.id == myUser.id).length > 0" @click="onApprove" class="cursor-pointer" color="#55acee">
            <template #icon>
              <!-- <twitter-outlined /> -->
            </template>
            Approve
          </a-tag>
          <a-tag v-if="myUser.id == dataModel.createdBy" @click="onRequestApprove" class="cursor-pointer" color="#55acee">
            <template #icon>
              <!-- <twitter-outlined /> -->
            </template>
            Request Approve
          </a-tag>
          <a-tag @click="onSaveTask" class="cursor-pointer" color="#55acee">
            <template #icon>
              <!-- <twitter-outlined /> -->
            </template>
            Save
          </a-tag>
          <a-tag v-if="dataModel.id != 0" @click="onCancel" class="cursor-pointer  bg-red-500 text-white">
            <template #icon>
              <!-- <twitter-outlined /> -->
            </template>
            Cancel
          </a-tag>
          <!-- <span @click="$emit('maximize', true)" class="mr-2 cursor-pointer">
            <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><polyline points="15 3 21 3 21 9"></polyline><polyline points="9 21 3 21 3 15"></polyline><line x1="21" y1="3" x2="14" y2="10"></line><line x1="3" y1="21" x2="10" y2="14"></line></svg>
          </span>
          <span @click="$emit('close')" class="cursor-pointer">
            <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
          </span> -->
        </div>
      </div>
      <div class="container flex justify-center mt-4" style="height: calc(100% - 45px)">
        <div class="w-full grid grid-cols-12 gap-3">
        <div class="col-span-9">
          <ScrollPanel style="width: 100%; height: 750px">
            <div class="w-full flex flex-wrap p-5">
              <section name="more-info" class="w-full">
                <div class="grid grid-cols-2 gap-3">
                  <div class="w-full grid grid-cols-2 gap-3">
                      <a-form class="col-span-3">
                        <a-form-item label="Name">
                          <span>
                            <Inplace :closable="true" class="flex w-full">
                              <template #display> 
                                <span class="text-blue-500 cursor-pointer">
                                  {{dataModel.name}}
                                </span>
                              </template>
                              <template #content>
                                <a-input v-model:value="dataModel.name" placeholder="" />
                              </template>
                            </Inplace>
                          </span>  
                        </a-form-item>
                        <a-form-item label="Description">
                          <span>
                            <Inplace :closable="true" class="flex w-full">
                              <template #display> 
                                <span class="text-blue-500 cursor-pointer">
                                  {{dataModel.description}}
                                </span>
                              </template>
                              <template #content>
                                <a-input v-model:value="dataModel.description" placeholder="" />
                              </template>
                            </Inplace>
                          </span>  
                        </a-form-item>
                        <a-form-item label="Approve By">
                        <Inplace :closable="true" class="flex w-full">
                          <template #display> 
                            <div v-if="dataModel.approvals != null && data.approvals.length > 0" class="flex w-full">
                              <a-tooltip placement="bottom">
                                <template #title>
                                    <div class="grid grid-cols-1 gap-3">
                                        <span v-for="item in dataModel.approvals.map(p=>p.fullName)" :key="item.id"> 
                                          {{item}}  
                                        </span>
                                    </div>
                                </template>
                                <AvatarGroup class="mr-4">
                                    <Avatar v-for="item in dataModel.approvals.map(p=>p.fullName)" :label="item.charAt(0)" shape="circle" :key="item.id" />
                                </AvatarGroup>
                              </a-tooltip>
                            </div>
                            <span v-else class="text-blue-500 cursor-pointer">
                              Select User
                            </span>
                          </template>
                          <template #content>
                            <div class="flex flex-wrap w-full items-center">
                              <ProjectUserMultiSelect v-model="dataModel.approvals"></ProjectUserMultiSelect>
                            </div>
                          </template>
                        </Inplace>
                      </a-form-item>
                    </a-form>
                  </div>
                  <div class="w-full grid grid-cols-2 gap-3">
                    <a-form class="col-span-3">
                      <a-form-item label="Start Date">
                        <!-- <a-range-picker v-model:value="dateRange" class="w-full"/> -->
                        <Calendar v-model="dataModel.startDate" showIcon iconDisplay="input" dateFormat="dd/mm/yy" class="w-full"/>
                      </a-form-item>
                      <a-form-item label="Expected Date">
                        <!-- <a-range-picker v-model:value="dateRange" class="w-full"/> -->
                        <Calendar v-model="dataModel.expectedDate" showIcon iconDisplay="input" dateFormat="dd/mm/yy" class="w-full"/>
                      </a-form-item>
                      <a-form-item label="Type">
                          <span>
                            <Inplace :closable="true" class="flex w-full">
                              <template #display> 
                                <span class="text-blue-500 cursor-pointer">
                                  {{dataModel.typeName ? dataModel.typeName : "Select Type"}}
                                </span>
                              </template>
                              <template #content>
                                <Dropdown v-model="dataModel.typeID" :options="types" optionLabel="name" optionValue="id" placeholder="Select a Type" @change="(e)=>onChangeType(dataModel,e)" class="p-column-filter"/>
                              </template>
                            </Inplace>
                          </span>  
                        </a-form-item>
                  </a-form>
                  </div>
                </div>
                <div class="w-full flex mt-4">
                  <el-input v-model="dataModel.description" style="width: 100%" :autosize="{ minRows: 2, maxRows: 4 }" type="textarea" placeholder="Thêm mô tả dự án"/>
                </div>
                <!-- <div class="w-full flex mt-4">
                  <section name="sublist" class="w-full">
                    <div class="flex w-full items-center">
                      <span class="my-2 font-semibold text-gray-500">Task phụ</span>
                      <span class="ml-2 cursor-pointer text-sm flex items-center text-gray-500">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="16"></line><line x1="8" y1="12" x2="16" y2="12"></line></svg>
                      </span>
                    </div>
                    <ProjectSubTask class="w-full mt-2"></ProjectSubTask>
                  </section>
                </div> -->
                <!-- <div class="w-full flex mt-4">
                  <section name="checklist" class="w-full">
                    <div class="w-full flex">
                      <span class="my-2 font-semibold text-gray-500">Check List</span>
                      <span @click="addNewCheckList" class="ml-2 cursor-pointer text-sm flex items-center text-gray-500">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="16"></line><line x1="8" y1="12" x2="16" y2="12"></line></svg>
                      </span>
                    </div>
                    <ProjectCheckList v-model="dataModel.checkLists" class="w-full mt-2"></ProjectCheckList>
                  </section>
                </div> -->
                <div class="w-full flex mt-4">
                  <section name="sublist" class="w-full">
                    <div class="flex w-full items-center">
                      <span class="my-2 font-semibold text-gray-500">Attachments</span>
                    </div>
                    <ProjectDocumentList class="w-full mt-2" v-model="docs"></ProjectDocumentList>
                  </section>
                </div>
              </section>
            </div>
          </ScrollPanel>
        </div>
        <div class="col-span-3">
          <div class="w-full flex-noshink flex-wrap bg-gray-100 h-full relative rounded-lg">
            <span class="w-full py-3 px-2 bg-white flex">
              <span class="font-semibold text-gray-500">
                Hoạt động
              </span>
            </span>
            <ProjectActivityAndChat></ProjectActivityAndChat>
          </div>
        </div>
      </div>
      </div>
      <Toast />
      <loading v-model:active="isLoading"
      :is-full-page="true" color="#3B82F6"/>
    </div>
</template>
<script setup>
import { ref,watch } from 'vue';
import Avatar from 'primevue/avatar';
import AvatarGroup from 'primevue/avatargroup';   //Optional for grouping
import ScrollPanel from 'primevue/scrollpanel';
import Inplace from 'primevue/inplace';
import { useTask } from '~/stores/task';
import { useProject } from '~/stores/project';
import { useToast } from "primevue/usetoast";
import {useUser} from '~/stores/user';
import { format, parse,formatISO   } from 'date-fns';
import Loading from 'vue-loading-overlay';
import { useAttachDocument } from '~/stores/attachDocument';
const isLoading = ref(false);
const emit = defineEmits(['update:modelValue','data','update']);
//props for v-model
const props = defineProps(['data']);
//emit to parents
const toast = useToast();
const dataModel = ref({});
const isTask = ref(props.isTask);
const myUser = useUser().getUser();
const types = ref([
  {
    id:1,
    name:"Type 1"
  },
  {
    id:2,
    name:"Type 2"
  }
]);
const docs = ref([]);
onMounted(() => {
  dataModel.value = props.data;
  dataModel.value.startDate = new Date(props.data.startDate);
  dataModel.value.expectedDate = new Date(props.data.expectedDate);
  dataModel.value.endDate = props.data.endDate != null ? new Date(props.data.endDate):null;
  GetDocsByProject(); 
})
const getSeverity = (status) => {
    switch (status) {
        case 0:
            return 'secondary';
        case 1:
            return 'warning';
        case 2:
            return 'success';
        case 3:
            return 'danger';
        case 4:
            return 'danger';
        default:
            return null;
    }
};
const GetDocsByProject = async() => {
  try{
    isLoading.value = true;
    docs.value = await useAttachDocument().getDocumentAttachToProject(dataModel.value.id);
    console.log(docs.value);
  }catch(e){
    console.log(e);
  }finally{
    isLoading.value = false;
  }
}
//watch dateRange
watch(props.data, () => {
  dataModel.value = props.data;
})
watch(props.isTask, () => {
  isTask.value = props.isTask;
})
const onChangeType = (data,e) => {
    data.typeName = types.value.filter(p=>p.id == e.value)[0].name;
}
// const test = (val) => {
//   alert(val);
// }

// const value = ref('');
// const value2 = ref('');
// const isExpanded = ref(false)

// watch(value, () => {
//   console.log('value', value);
// });
// const onSelect = (e) => {
//   console.log('select', e);
// };

// const expandChat = ()=> {
//   isExpanded.value = !isExpanded.value;
// };

// const addNewCheckList = () => {
//   props.data.checkLists.push({ name: 'New Check List', checked: false });
// }
const onSaveTask = async() => {
  if(dataModel.value.id != null && dataModel.value.id != 0 && dataModel.value.id != undefined){
    
      var data = await useProject().update(dataModel.value);
      if(typeof data == 'string'){
        toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
        return;
        }
        toast.add({ severity: 'success', summary: 'Success Message', detail: "Update Successfully", life: 5000 });
        emit('update',false,data);
        emit('update:modelValue',false);
  }else{
      dataModel.value.projectID = props.parentID;
      
      var data = await useProject().create(dataModel.value);
      if(typeof data == 'string'){
        toast.add({ severity: 'error', summary: 'Error Message', detail: data, life: 5000 });
        return;
      }
      toast.add({ severity: 'success', summary: 'Success Message', detail: "Create Successfully", life: 5000 });
      emit('update',true,data);
      emit('update:modelValue',false);
  }
}
const onRequestApprove =async () =>{
  try{
    isLoading.value = true;
    await useProject().requestApprove(dataModel.value);
    toast.add({ severity: 'success', summary: 'Success Message', detail: "Request Successfully", life: 5000 });
  }catch(e){
    console.log(e);
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Request fail!", life: 5000 });
  }
  finally{
    isLoading.value = false;
  }
}
const onApprove = async() => {
  try{
    isLoading.value = true;
    var data = await useProject().approve(dataModel.value);
    dataModel.value = data;
    dataModel.value.startDate = new Date(dataModel.value.startDate);
  dataModel.value.expectedDate = new Date(dataModel.value.expectedDate);
  dataModel.value.endDate = dataModel.value.endDate != null? new Date(dataModel.value.endDate):null;
    toast.add({ severity: 'success', summary: 'Success Message', detail: "Approve Successfully", life: 5000 });
    emit('update',false,data);
  }catch(e){
    console.log(e);
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Approve fail!", life: 5000 });
  }
  finally{
    isLoading.value = false;
  }
}
const onCancel = async() => {
  var st = confirm("Are you sure you want to cancel this phase?");
  if(st == false){
    return;
  }
    dataModel.value = await useProject().cancel(dataModel.value);
    dataModel.value.startDate = new Date(dataModel.value.startDate);
  dataModel.value.expectedDate = new Date(dataModel.value.expectedDate);
  dataModel.value.endDate = dataModel.value.endDate != null? new Date(dataModel.value.endDate):null;
    emit('update',false,data);
    toast.add({ severity: 'success', summary: 'Success Message', detail: "Cancel Successfully", life: 5000 });
}
</script>
<style>
.border-bot-1 {
  border-bottom: 1px solid #d9d7d7;
}
.p-inplace-content {
  @apply flex w-full
}
.p-inplace-display {
  padding: 0;
  margin: 0;
  font-size: 0.8rem;
}
.p-button-icon-only {
  width: 30px !important;
  height: 30px !important;
}
.ant-form-item {
  @apply mb-2
}
.p-inplace-display {
  @apply w-full
}
</style>