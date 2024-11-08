<template>
    <div class="flex flex-wrap w-full justify-center h-full px-2 custom-scrollbar">
      <div class="w-full h-full">
        <div class="w-full grid grid-cols-12 h-full" style="display: flex;">
            <div class="col-span-12 h-full w-full">
              <!-- <ProjectTable v-model="modelData"></ProjectTable> -->
              <!-- <ProjectTable v-if="data" class="rounded-lg shadow-md mt-4" v-model="data"></ProjectTable> -->
              <!-- <a-tabs v-model:activeKey="activeKey" @tab-click="onTabClick" class="h-full pb-[50px]">
                    <a-tab-pane key="1" tab="List Project">
                        <Splitter style="height: 100%;">
                            <SplitterPanel id="pnProject"  class="flex w-full" :size="sizeProject"  :style="{ transition: 'transition: flex-basis 500ms ease-in-out' }"><ProjectTable v-model="modelData" @openPhase="openPhase"></ProjectTable></SplitterPanel>
                            <SplitterPanel id="pnPhase" v-if="sizePhase>0" class="flex w-full" :size="sizePhase" :style="{ transition: 'transition: flex-basis 500ms ease-in-out' }"> <ProjectTablePhase v-model="phases" :project="project" @openTask="openTask" @closePhase="closePhase" :sizePhase="sizePhase"></ProjectTablePhase> </SplitterPanel>
                            <SplitterPanel id="pnTask" v-if="sizeTask>0" class="flex w-full" :size="sizeTask"> <ProjectTableTask v-model="lsTask" :project="project" :phase="phase" @closeTask="closeTask" @updateTask="updateTask" :sizeTask="sizeTask"></ProjectTableTask></SplitterPanel>
                        </Splitter>
                    </a-tab-pane> 
                    <a-tab-pane key="2" tab="Gantt Chart">
                        <ProjectGantt v-model="modelData" :key="componentKey" :type="'project'"></ProjectGantt>
                    </a-tab-pane>
                    <a-tab-pane key="3" tab="Kanban" class="h-full">
                      <ProjectKanbanBroad v-model="tasks" :key="commentKey" @updateTask="updateTask"></ProjectKanbanBroad>
                    </a-tab-pane>
              </a-tabs> -->
              <Splitter style="height: 100%;" :resizable="false">
                            <SplitterPanel id="pnProject"  class="flex w-full" :size="sizeProject" :minSize="sizeProject"><ProjectTable v-model="modelData" @openPhase="openPhase" @closePhase="closePhase" @updateProject="updateProject"></ProjectTable></SplitterPanel>
                            <SplitterPanel id="pnPhase" v-if="sizePhase>0" class="flex w-full" :size="sizePhase" :minSize="sizePhase"><ProjectPhase v-model="project" @updateProject="updateProject"></ProjectPhase></SplitterPanel>
              </Splitter>
            </div>
        </div>
      </div>
    </div>
  </template>
  <script setup>
  import { ref,nextTick,watch  } from 'vue';
  import axios from 'axios';
  import Button from 'primevue/button';
  import { useStore } from '/stores/main'
  import { useProject } from '~/stores/project'
  import { storeToRefs } from 'pinia';
  import { useTask } from '~/stores/task';
  import { useObjectAssginUser } from '~/stores/objectAssginUser';
  import { useUser } from '~/stores/user';
  const item = ref({})
  item.value = "1"
  const modelData = ref([])
  const tasks = ref([]);
  const lsTask = ref([]);
  const phases = ref([]);
  const project = ref({});
  const sizeProject = ref(100);
  const sizePhase = ref(0);
  const phase = ref({});
  const componentKey = ref(0);
  const myUser = ref(useUser().getUser());
  const home = ref({
    icon: 'pi pi-home',
    route: '/'
  });
  const items = ref([
    { label: 'Dự án', route: '/projects' },
    { label: 'Danh sách dự án' }
  ]);
  watch(() => modelData.value, async (value) => {
      if(project.value.id){
        project.value = value.find(x => x.id == project.value.id);
      }
  })
  //onMounted
  onMounted(async() => {
     await getProject();
  })
  const getProject = async () => {
    try {
      const data = await useProject().getAll();
      modelData.value = data;
      // tasks.value = [];
      // modelData.value.forEach(element => {
      //   element.phases.forEach(phase => {
      //     tasks.value.push(...phase.tasks);
      //   });
      // });
    } catch (error) {
      console.log(error);
    }
  }
  const openPhase = async (projectID) => {
    const pnProject = document.getElementById('pnProject');
    //const pnPhase = document.getElementById('pnPhase');
    try {
      project.value = modelData.value.find(item => item.id === projectID);
      sizeProject.value = 20;
      sizePhase.value = 80;
      if (pnProject) {
        pnProject.style.transition = 'flex-basis 0.5s ease';
        pnProject.style.flexBasis = `${sizeProject.value}%`;
       // pnPhase.style.flexBasis = `${sizePhase.value}%`;
      }
    } catch (error) {
      console.log(error);
    }
    finally{
    //  pnProject.style.transition = 'none';
    }
  }
  const updateTask = (project) =>{
       var gproject = modelData.value.find(x => x.id == project.id);
       gproject.process_Percent = project.process_Percent;
        var phase = gproject.phases.find(x => x.id == project.phases[0].id);
        phase.process_Percent = project.phases[0].process_Percent;
        var taskIndex = phase.tasks.findIndex(x => x.id == project.phases[0].tasks[0].id);
        phase.tasks[taskIndex] = project.phases[0].tasks[0];
        tasks.value = [];
      modelData.value.forEach(element => {
        element.phases.forEach(phase => {
          tasks.value.push(...phase.tasks);
        });
      });
    }
  const closePhase = ()=>{
      const pnProject = document.getElementById('pnProject');
      const pnPhase = document.getElementById('pnPhase');
      sizePhase.value = 0;
      sizeProject.value = 100;
      if (pnPhase) {
        pnPhase.style.flexBasis = `${sizePhase.value}%`;
        pnProject.style.flexBasis = `${sizeProject.value}%`;
      }
    }
  const onTabClick = ()=>{
      componentKey.value += 1;
    }
  const updateProject = (data) => {
    project.value = data;
    modelData.value = modelData.value.map(p=>p.id == data.id? data : p);
}
  </script>
  <style>
   .ant-tabs-content{
      height: 100%;
    }.ant-tabs-nav-wrap{
      background-color: #f8fafc;
    }
    .ant-tabs-nav{
      margin: 0 !important;
    }
    #pnPhase{
      transition: flex-basis 0.5s ease !important;
    }
</style>