<template>
    <div class="flex flex-wrap w-full justify-center h-full">
      <div class="w-full h-full flex flex-col">
        <!-- <div class="flex items-center w-full py-2 px-5 text-[15px] text-gray-600">
            <span @click="router.back()"><i class="pi pi-qrcode cursor-pointer mr-1"></i> Project</span> <i class="pi pi-angle-right mx-1"></i><span class="font-bold"> {{project.name}}</span>
        </div> -->
        <div class="px-5 flex items-center justify-between">
          <div class="flex h-[60px] items-center">
           <i class="pi pi-building p-3 rounded-full bg-[#f8fafc] h-max"/>
            <div class="pl-3">
              <span class="text-base font-bold">{{project.name}}</span>
              <div class="flex items-center">
                <n-progress
                  type="line"
                  :percentage="project.process_Percent"
                  id="pcProject"
                /> <span class="text-xs text-[#6f7f8f]">Completed</span>
              </div>
            </div>
          </div>
          <n-space class="h-[60px] items-center">
          <div class=" text-[#9cabbb]" style="font-weight: 500;">Type: <span class="inline-block text-black">{{ project.typeName }}</span></div>
          <div class="w-[2px] h-full bg-[#f8fafc]"></div>
            <div class="text-gray-600"><span class="inline-block text-[#9cabbb] mr-2" style="font-weight: 500;">Status:</span> 
              <Tag v-if="project.isCancel" value="Cancel" :severity="getSeverity(4)" />
              <Tag v-else-if = "project.isProcess == true && !isLate(project.estimatedDate)" value="In Process" :severity="getSeverity(1)" />
                <Tag v-else-if = "project.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                <Tag v-else-if = "isLate(project.estimatedDate)" value="Late" :severity="getSeverity(3)" />
                <Tag v-else-if = "project.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                <Tag v-else value="Cancel" :severity="getSeverity(4)" /></div>
                <div class="w-[2px] h-full bg-[#f8fafc]"></div>
            <div class="text-black" style="font-weight: 500;"><span class="inline-block text-[#9cabbb]">Deadline:</span> {{project.estimatedDate !=null? format(project.estimatedDate, 'dd/MM/yyyy') :""}}</div>    
          </n-space>                  
        </div>   
        <div class="w-full grid grid-cols-12 gap-3 h-full overflow-auto" style="display: flex;">
            <div class="col-span-12 h-full w-full">
              <n-tabs type="line" animated class="h-full tabproject">
                  <n-tab-pane name="List" tab="List" class="h-full">
                    <ProjectTablePhase v-model="phases" :project="project" @updateProject="updateProject" @updatePhase="updatePhase"></ProjectTablePhase>
                  </n-tab-pane>
                  <n-tab-pane name="Gantt Chart" tab="Gantt Chart"  class="h-full">
                    <ProjectGantt v-model="phases" :type="'phase'"></ProjectGantt>
                  </n-tab-pane>
                  <n-tab-pane name="Kanban" tab="Kanban"  class="h-full">
                    <ProjectKanbanBroad v-model="phases" :project="project" @updateProject="updateProject" @updatePhase="updatePhase"></ProjectKanbanBroad> 
                  </n-tab-pane>
                  <n-tab-pane name="Workflow" tab="Workflow"  class="h-full">
                    <ProjectWorkflow v-model="project" @updateProject="updateProject"></ProjectWorkflow>
                  </n-tab-pane>
                  <n-tab-pane name="Chat" tab="Chat"  class="h-full absolute">
                    <template #tab>
                      <!-- Custom header for Tab 1 -->
                      <n-badge :value="statusChats.find(p=>p.objectID == project.id) ? statusChats.find(p=>p.objectID == project.id).totalUnRead:0" :max="15">
                        Chat
                      </n-badge>
                    </template>
                    <ProjectChat v-model="project" @updateReadByProject="updateReadByProject"/>
                  </n-tab-pane>
            </n-tabs>
                <!-- <a-tabs v-model:activeKey="activeKey" @tab-click="updateModel" class="h-full pb-[50px]">
                    <a-tab-pane key="1" tab="List" class="h-full">
                        <ProjectTablePhase v-model="phases" :project="project"></ProjectTablePhase>
                    </a-tab-pane>
                    <a-tab-pane key="2" tab="Gantt Chart" class="h-full">
                        <ProjectGantt v-model="phases" :type="'phase'"></ProjectGantt>
                    </a-tab-pane>
                    <a-tab-pane key="3" tab="Kanban" class="h-full">
                        <ProjectKanbanBroad v-model="phases"></ProjectKanbanBroad> 
                    </a-tab-pane>
                    <a-tab-pane key="4" tab="Workflow" class="h-full">
                        <ProjectWorkflow v-model="phases" :project="project"></ProjectWorkflow>
                    </a-tab-pane>
                </a-tabs> -->
            </div>

        </div>
 
      </div>
    </div>
  </template>
  <script setup>
  import { ref, watch,onMounted } from 'vue';
  import axios from 'axios';
  import Button from 'primevue/button';
  import Dialog from 'primevue/dialog';
  import { useStore } from '/stores/main';
  import { useKhoiBanPhong } from "~/stores/KhoiBanPhong";
  import { format, parse,formatISO   } from 'date-fns';
  import {useUser} from '~/stores/user';
  import { useProject } from "~/stores/project";
  import { usePhase } from '~/stores/phase';
  import { useChatStatus } from '~/stores/chatStatus';
  const emit = defineEmits(['update:modelValue','updateProject']);
  const props = defineProps(['modelValue']);
  const route = useRoute();
  const projectID = ref(0);
  const item = ref({});
  const activeKey = ref('1');
  const visible = ref(false);
  const phases = ref([]);
  const phase = ref({});
  const project = ref({});
  const commentKey = ref(0);
  const myUser = useUser().getUser();
  const { listenToMessages, sendMessage } = useSignalR();
  item.value = "1"; 
  const statusChats = ref([]);
const home = ref({
    icon: 'pi pi-home',
    route: '/'
});
const getTasks = async() => {
    phases.value = await usePhase().getAllByProject(projectID.value);
}
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
const getProject = async() => {
    project.value = await useProject().getByID(projectID.value);
}
  //onMounted
onMounted(async() => {
if(props.modelValue){
    project.value = props.modelValue;
    projectID.value = props.modelValue.id;
    //await getProject();
    await init();
    listenToMessages((data) => {
      if(data.userID != myUser.id){
        if(statusChats.value.filter(p=>p.objectID == data.objectID).length > 0){
          statusChats.value = statusChats.value.map(p=>p.objectID == data.objectID? {...p,totalUnRead:p.totalUnRead+1} : p);
        }
        else{
          statusChats.value.push({objectID:data.objectID,userID:myUser.id,totalUnRead:1});
        }
      }
    });
}
});
const getChatStatus = async() =>{
  try{
    statusChats.value = await useChatStatus().getUnRead();
  }catch(ex){
    console.log(ex);
  }
}
watch(()=>props.modelValue,async(val)=>{
    project.value = props.modelValue;
    projectID.value = props.modelValue.id;
    // await getProject();
     await init();
});
const init = async () => {
  await getTasks();
  await getChatStatus();
}
  const save = async () => {
    store.add(model.value);
    useRouter().push({ path: '/projects' });
  }
  const updateProject = (data) => {
    emit('updateProject',data);
  }
  const updatePhase = (data)=>{
    var tasks = phases.value.find(x=>x.id == data.id).tasks;
    tasks.map(x=> x.id == data.tasks[0].id ? data.tasks[0] : x);
      phases.value = phases.value.map(x=> x.id == data.id ? data : x);
      phase.value.tasks = tasks;
  }
  const isLate = (date)=>{
    let plantDate = new Date(date);
    let currentDate = new Date();
    if(plantDate < currentDate){
        return true;
    }else{
        return false;
    }
}
const updateReadByProject = async(projectID)=>{
  if(statusChats.value.filter(p=>p.objectID == projectID).length > 0){
  await useChatStatus().updateReadByProject(projectID);
  statusChats.value = statusChats.value.filter(p=>p.objectID != projectID);
  }
}
  </script>
  <style>
    .ant-form-item-label label {
        width: 120px;
    }
    .border-top-1 {
      border-top: 1px solid #d9d7d7;
    }
    .ant-tabs-content{
      height: 100%;
    }
    #pcProject .n-progress-graph-line-rail{
      width: 250px;
    } 
    #pcProject .n-progress-icon--as-text{
      font-size: 0.75rem;
      color: #6f7f8f;
      
    }.tabproject .n-tabs-wrapper{
      padding: 0px 20px;
      
    }.tabproject .n-tabs-nav-scroll-content{
        border-top: 1px solid #efeff5;
    }
    .tabproject .n-tab-pane{
      padding: 0 !important;
    }
    .tabproject .n-tabs-pane-wrapper{
      height: 100%;
    }
</style>