<template>
    <div class="flex flex-wrap w-full justify-center h-full">
      <div class="w-full h-full px-2">
        <!-- <div class="flex items-center w-full py-2 px-5 text-[15px] text-gray-600">
            <span @click="router.back()"><i class="pi pi-qrcode cursor-pointer mr-1"></i> Project</span> <i class="pi pi-angle-right mx-1"></i><span class="font-bold"> {{project.name}}</span>
        </div> -->
        <div class="px-5 py-2 flex items-center justify-between">
          <div class="flex">
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
          <n-space>
          <div class=" text-[#9cabbb]" style="font-weight: 500;">Type: <span class="inline-block text-black">{{ project.typeName }}</span></div>
          <div class="w-[2px] h-full bg-[#f8fafc]"></div>
            <div class="text-gray-600"><span class="inline-block text-[#9cabbb]" style="font-weight: 500;">Status:</span> <Tag v-if = "project.isProcess == true && project.isLate == false" value="In Process" :severity="getSeverity(1)" />
                <Tag v-else-if = "project.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                <Tag v-else-if = "project.isLate == true" value="Late" :severity="getSeverity(3)" />
                <Tag v-else-if = "project.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                <Tag v-else value="Cancel" :severity="getSeverity(4)" /></div>
                <div class="w-[2px] h-full bg-[#f8fafc]"></div>
            <div class="text-black" style="font-weight: 500;"><span class="inline-block text-[#9cabbb]">Deadline:</span> {{project.estimatedDate !=null? format(project.estimatedDate, 'dd/MM/yyyy') :""}}</div>    
          </n-space>                  
        </div>   
        <div class="w-full grid grid-cols-12 gap-3 h-full" style="display: flex;">
            <div class="col-span-12 h-full w-full">
              <n-tabs type="line" animated class="h-full pb-[50px] tabproject">
                  <n-tab-pane name="List" tab="List" class="h-full">
                    <ProjectTablePhase v-model="phases" :project="project"></ProjectTablePhase>
                  </n-tab-pane>
                  <n-tab-pane name="Gantt Chart" tab="Gantt Chart"  class="h-full">
                    <ProjectGantt v-model="phases" :type="'phase'"></ProjectGantt>
                  </n-tab-pane>
                  <n-tab-pane name="Kanban" tab="Kanban"  class="h-full">
                    <ProjectKanbanBroad v-model="phases"></ProjectKanbanBroad> 
                  </n-tab-pane>
                  <n-tab-pane name="Workflow" tab="Workflow"  class="h-full">
                    <ProjectWorkflow v-model="phases" :project="project"></ProjectWorkflow>
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
  import { ref,onMounted } from 'vue';
  import axios from 'axios';
  import Button from 'primevue/button';
  import Dialog from 'primevue/dialog';
  import { useStore } from '/stores/main';
  import { useKhoiBanPhong } from "~/stores/KhoiBanPhong";
  import { format, parse,formatISO   } from 'date-fns';
  import { useProject } from "~/stores/project";
  import { useRoute } from 'vue-router';
  import { usePhase } from '~/stores/phase';
  import { useRouter } from 'vue-router';
  const router = useRouter();
  const store = useProject();
  const route = useRoute();
  const model = await store.find(useRoute().params.id);
  const projectID = ref(0);
  const item = ref({});
  const activeKey = ref('1');
  const visible = ref(false);
  const phases = ref([]);
  const phase = ref({});
  const project = ref({});
  const commentKey = ref(0);
  const sizePhase = ref(100);
  const sizeTask = ref(0);
  item.value = "1"; 
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
    projectID.value = route.params.id;
    await getProject();
    getTasks();
});
const init = async () => {
}
  const save = async () => {
    store.add(model.value);
    useRouter().push({ path: '/projects' });
  }
  const onCloseTask = () => {
    const pnTask = document.getElementById('pnTask');
    sizeTask.value = 0;
    if(pnTask){
      pnTask.style.transition = 'flex-basis 0.5s ease';
      pnTask.style.flexBasis = `${sizeTask.value}%`;
    }
  }
  const selectPhase = (ph) => {
    phase.value = ph;
    const pnPhase = document.getElementById('pnPhase');
    const pnTask = document.getElementById('pnTask');
    sizePhase.value = 20;
    sizeTask.value = 80;
    if(pnPhase){
      pnPhase.style.transition = 'flex-basis 0.5s ease';
      pnPhase.style.flexBasis = `${sizePhase.value}%`;
    }
    commentKey.value++;
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