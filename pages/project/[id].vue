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
        <div class="w-full grid grid-cols-12 gap-3">
            <div class="col-span-9">
                <a-tabs v-model:activeKey="activeKey">
                    <a-tab-pane key="1" tab="Dạng danh sách">
                        {{ model}}
                    </a-tab-pane>
                    <a-tab-pane key="2" tab="Bảng Kanban" force-render>
                        {{ model}}
                    </a-tab-pane>
                    <a-tab-pane key="3" tab="Bảng Gantt">
                        {{ model}}
                    </a-tab-pane>
                </a-tabs>
            </div>
            <div class="col-span-3">
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
  import { useKhoiBanPhong } from "~/stores/KhoiBanPhong";
  import { useProject } from "~/stores/project";

  import { storeToRefs } from 'pinia';


  const { someState } = storeToRefs(useStore())
  const { data } = storeToRefs(useProject())
  const { khoi, ban, phong } = storeToRefs(useKhoiBanPhong())
  const store = useProject();
  const model = await store.find(useRoute().params.id)

  const item = ref({})
  const activeKey = ref('1')

  item.value = "1"
  
  const home = ref({
    icon: 'pi pi-home',
    route: '/'
  });
  const items = ref([
    { label: 'Dự án', route: '/project' },
    { label: `Dự án ${model.name}` }
  ]);
  
  
  //onMounted
  onMounted(() => {
    init();
  })
  
  const init = async (page = 1, pageSize = 10, search = "") => {
    // let endpoint = "http://localhost:5010/api";
    // let res = await axios.get(`${endpoint}/Inspection?page=${page}&pageSize=${pageSize}&search=${search}`, {
  
    // })
    // console.log(res.data)
    // model.value = res.data;
  }

  const save = async () => {
    store.add(model.value);
    useRouter().push({ path: '/project' })
  }
  
  
  </script>
  
  <style>
    .ant-form-item-label label {
        width: 120px;
    }
</style>