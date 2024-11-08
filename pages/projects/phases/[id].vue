<template>
    <div class="flex flex-wrap w-full justify-center h-full">
      <div class="w-full h-full px-2">
        <div class="flex items-center w-full py-2 text-[20px] font-semibold">
          <Button icon="pi pi-angle-left" aria-label="Submit" class="rounded-none mr-2 bg-transparent text-blue-500" @click="router.back()"/>
           <!-- <img src="../../assets/images/Go-home.png" class="w-8 h-8 mr-2"> -->
           {{ phase.name }}
        </div>
        <div class="w-full grid grid-cols-12 gap-3 h-full" style="display: flex;">
            <div class="col-span-12 h-full w-full"> 
                <a-tabs v-model:activeKey="activeKey" @tab-click="updateModel" class="h-full pb-[50px]">
                    <a-tab-pane key="1" tab="List Task">
                        <ProjectTableTask v-model="modelData" :project="project" :phase="phase"></ProjectTableTask>
                    </a-tab-pane>
                    <a-tab-pane key="2" tab="Gantt Chart">
                        <ProjectGantt v-model="modelData" :key="componentKey" :type="'task'"></ProjectGantt>
                    </a-tab-pane>
                    <a-tab-pane key="3" tab="Kanban" class="h-full">
                      <ProjectKanbanBroad v-model="modelData" :key="commentKey"></ProjectKanbanBroad>
                    </a-tab-pane>
                </a-tabs>
            </div>    
        </div>
      </div>
    </div>
  </template>
  <script setup>
  import { ref,watch } from 'vue';
  import axios from 'axios';
  import Button from 'primevue/button';
  import Dialog from 'primevue/dialog';
  import { useStore } from '/stores/main'
  import { useKhoiBanPhong } from "~/stores/KhoiBanPhong";
  import { useTask } from "~/stores/task";
  import { useProject } from "~/stores/project";
  import { usePhase } from '~/stores/phase';
  import { storeToRefs } from 'pinia';
  import Avatar from 'primevue/avatar';
  import AvatarGroup from 'primevue/avatargroup';
  import { useRoute } from 'vue-router';
  import { useRouter } from 'vue-router';
  const router = useRouter();
  const parentID = useRoute().params.id;
  const item = ref({})
  const activeKey = ref('1')
  const visible = ref(false)
  const componentKey = ref(0);
  const project = ref({});
  const phase = ref({});
  item.value = "1"
  const home = ref({
    icon: 'pi pi-home',
    route: '/'
  });
  const modelData = ref([]);
  watch(modelData.value, () => {

  });
  onMounted(async() => {
    await init();

  });
  const init = async () => {
    modelData.value = await useTask().getAllByPhase(parentID);
    phase.value = await usePhase().getByID(parentID);
    project.value = await useProject().getByID(phase.value.projectID);
  }
  const updateModel = () => {
    componentKey.value += 1;
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
</style>
