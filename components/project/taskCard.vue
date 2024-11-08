<template>
    <div>
        <n-popover trigger="hover" placement="right" class="w-[300px]" @update:show="handleUpdateShow">
        <template #trigger>
          <div class="bg-white shadow rounded px-3 pt-3 pb-5 border border-white">
            <div class="flex justify-between" style="height: max-content">
              <p class="text-gray-700 font-semibold font-sans tracking-wide text-sm m-1" v-html="task.name.replace(/\n/g, '<br>')"></p>
              <Inplace :closable="true" class="flex w-max col-span-7">
                                <template #display>
                                  <span class="text-blue-500 cursor-pointer w-max">
                                    {{task.process_Percent}}
                                  </span>
                                </template>
                                <template #content>
                                  <div class="flex flex-wrap w-[50px] items-center">
                                      <InputNumber v-if="task.isProcess" v-model="task.process_Percent" style="width: 100px !important;" inputStyle="width: 50px !important;" inputId="minmax" :min="0" :max="100"  @blur="(e)=>onBlur(e,task)"/>
                                  </div>
                                </template>
              </Inplace>
            </div>
            <div class="flex justify-between">
              <p class="text-gray-700 font-sans tracking-wide text-sm m-1"> Phase: {{ phaseName }}</p>
            </div>
            <div class="flex justify-between">
              <p class="text-gray-700 font-sans tracking-wide text-sm m-1"> Main join: {{ task.mainJoinByName }}</p>
            </div>
            <div class="flex">
              <p class="text-gray-700 font-sans tracking-wide text-sm m-1">Sub Join: {{ task.subJoins.map(p=>p.fullName).join(",") }}</p>
           
              <!-- <AvatarGroup v-if="task.subJoins != undefined" class="ml-2">
                      <Avatar v-for="item in task.subJoins.map(p=>p.fullName)" :label="item.charAt(0)" shape="circle" :key="item.id"/>
              </AvatarGroup> -->
            </div>
            <div class="flex justify-between items-center">
              <span class="text-sm text-gray-600 m-1">Start Date: {{task.startDate !=null? format(task.startDate, 'dd/MM/yyyy') :""}}</span>
              <span class="text-sm text-gray-600 m-1" v-if="task.isComplate == false">Expected Date: {{task.estimatedDate !=null? format(task.estimatedDate, 'dd/MM/yyyy') :""}}</span>
              <span class="text-sm text-gray-600 m-1" v-else>End Date: {{task.endDate !=null? format(task.endDate, 'dd/MM/yyyy') :""}}</span>
            </div>
          </div>
        </template>
        <n-input
          v-model:value="task.remark"
          type="textarea"
          placeholder="Comment"/>
        </n-popover>
    <a-modal v-model:open="openModel" width="80vw" style="top: 60px" :destroyOnClose="true">
        <template #footer>
        </template>
        <ProjectEditTask v-model="openModel" :parentID="parentID" :data="task" @update="updateModel"></ProjectEditTask>
      </a-modal>
    </div>
  </template>
  <script setup>
  import { computed,watch } from 'vue';
  import Avatar from 'primevue/avatar';
  import AvatarGroup from 'primevue/avatargroup';
  import { format, parse,formatISO   } from 'date-fns';
  import { useTask } from '~/stores/task.ts';
  const emit = defineEmits(['task','updateTask','phaseName','updatePhase','updateProject']);
  const props = defineProps(['task','phaseName']);
  const task = ref(props.task);
  const parentID = props.task.phaseID;
  const phaseName = props.phaseName;
  const openModel = ref(false);
  const badgeColor = computed(() => {
  const mappings = {
      Design: 'purple',
      'Feature Request': 'teal',
      Backend: 'blue',
      QA: 'green',
      default: 'teal'
    }
    return mappings[props.task.type] || mappings.default
  })
  const updateModel = (isCreate,data) => {
    if(isCreate){
    }
    else{
        emit('updateTask',data);
    }
  }
  const onBlur = async(e,tk)=>{
      tk.process_Percent = Number(e.value);
      var data = await useTask().update(tk);console.log(data);
      emit('updateProject',data.project);
      emit('updatePhase',data.phase);
  }
  const handleUpdateShow = async(value) => {
    if(value == false){
      
    }
  }
  </script>