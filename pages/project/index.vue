<template>
    <div class="flex flex-wrap w-full justify-center">
      <div class="container w-full">
        <div class="flex items-center w-full">
          <Breadcrumb class="mt-4" :home="home" :model="items">
            <template #item="{ item, props }">
              <router-link v-if="item.route" v-slot="{ href, navigate }" :to="item.route" custom>
                <a :href="href" v-bind="props.action" @click="navigate">
                  <span :class="[item.icon, 'text-color']" />
                  <span class="">{{ item.label }}</span>
                </a>
              </router-link>
              <a v-else :href="item.url" :target="item.target" v-bind="props.action">
                <span class="text-color">{{ item.label }}</span>
              </a>
            </template>
          </Breadcrumb>
        </div>
        <ProjectFilter>
          <NuxtLink to="/project/new">
            <Button size="small" class="ml-3">Thêm</Button>
          </NuxtLink>
        </ProjectFilter>
        <div class="w-full grid grid-cols-12 gap-3">
            <div class="col-span-9">
                <ProjectTable v-if="data" class="rounded-lg shadow-md mt-4" v-model="data"></ProjectTable>
            </div>
            <div class="col-span-3">
                <ProjectSection1></ProjectSection1>
                <ProjectChart1 class="bg-white rounded-lg shadow-md p-3"></ProjectChart1>
            </div>
        </div>
      </div>
    </div>
  </template>
  
  
  <script setup>
  import { ref } from 'vue';
  import axios from 'axios';
  import Button from 'primevue/button';
  import { useStore } from '/stores/main'
  import { useProject } from '/stores/project'
  import { storeToRefs } from 'pinia';

  const { someState } = storeToRefs(useStore())
  const { data } = storeToRefs(useProject())

  const item = ref({})
  item.value = "1"
  const model = ref([])
  
  const home = ref({
    icon: 'pi pi-home',
    route: '/'
  });
  const items = ref([
    { label: 'Dự án', route: '/project' },
    { label: 'Danh sách dự án' }
  ]);
  
  
  //onMounted
  onMounted(() => {
    init();
  })
  
  const init = async (page = 1, pageSize = 10, search = "") => {
    
  }
  
  
  </script>