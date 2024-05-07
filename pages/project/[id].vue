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
                        <ProjectTreeTable></ProjectTreeTable>
                    </a-tab-pane>
                    <a-tab-pane key="2" tab="Bảng Kanban" force-render>
                      <ClientOnly>
                        <!-- <ProjectKanban></ProjectKanban> -->
                      </ClientOnly>
                    </a-tab-pane>
                    <a-tab-pane key="3" tab="Bảng Gantt">
                        <!-- {{ model}} -->
                    </a-tab-pane>
                </a-tabs>
            </div>
            <div class="col-span-3">
                <span class="flex flex-wrap w-full">
                    <div class="flex flex-wrap w-full shadow-md p-3">
                      <div class="w-full">
                        <span class="text-lg font-semibold my-1">
                          {{ model.name }}
                        </span>
                      </div>
                      <div class="w-full">
                        <span class="text-gray-400 text-sm my-2">
                          {{ model.description }}
                        </span>
                      </div>
                      <div  class="w-full mt-3">
                        Từ <span class="text-blue-500">{{ new Date().toLocaleDateString() }}</span> - Tới <span class="text-blue-500">{{ new Date().toLocaleDateString() }}</span>
                      </div>
                    </div>
                    <div class="w-full my-3 shadow-md p-3">
                      <span class="text-lg font-semibold text-gray-500">
                        Thành viên
                      </span>
                      <div v-if="false" class="w-full">
                        <a-list size="small" bordered :data-source="data">
                          <template #renderItem="{ item }">
                            <a-list-item>{{ item }}</a-list-item>
                          </template>
                        </a-list>
                      </div>
                      <div v-else class="w-full">
                        <span class="text-gray-400 text-sm">
                          Chưa có người nào đước gán vào dự án
                        </span>
                      </div>
                    </div>
                    <div class="w-full flex flex-wrap shadow-md p-3">
                      <span class="text-lg font-semibold text-gray-500">
                        Trạng thái
                      </span>
                      <span class="text-green-500 w-full my-2 flex items-center">
                        <span class="animate-ping mr-2 text-xs">
                          ●
                        </span>
                        Đang thực hiện
                      </span>
                    </div>
                    <div class="w-full shadow-md p-3"> 
                      <span class="text-lg font-semibold text-gray-500">
                        Công việc của tôi
                      </span>
                      <div class="w-full grid grid-cols-3 gap-3 my-2">
                        <span class="flex flex-wrap border-r-2 border-gray-500 w-full">
                          <span class="w-full flex justify-center text-lg">
                            Phải làm
                          </span>
                          <span class="w-full flex justify-center items-center text-3xl p-3 text-yellow-500">
                            0
                          </span>
                        </span>
                        <span class="flex flex-wrap">
                          <span class="w-full flex justify-center text-lg">
                            Đang làm
                          </span>
                          <span class="w-full flex justify-center items-center text-3xl p-3 text-blue-500">
                            0
                          </span>
                        </span>
                        <span class="flex flex-wrap">
                          <span class="w-full flex justify-center text-lg">
                            Hoàn thành
                          </span>
                          <span class="w-full flex justify-center items-center text-3xl p-3 text-green-500">
                            0
                          </span>
                        </span>
                      </div>
                      <div class="w-full grid grid-cols-1 gap-3">
                        <span class="border-b-4 border-gray-700 border">
                          Việc cần lưu ý
                        </span>
                        <span>
                          Mới được giao
                        </span>
                        <span>
                          Giao đi & quá hạn
                        </span>
                      </div>
                    </div>
                    <!-- <div class="w-full flex flex-wrap shadow-md p-3">
                      <span class="text-lg font-semibold text-gray-500">
                        Mục tiêu
                      </span>
                      <div class="w-full flex">
                        <span>
                          <img class="h-32" src="/calendar.png"/>
                        </span>
                        <span class="flex items-center text-blue-500 underline cursor-pointer">
                          Đặt mục tiêu sắp tới
                        </span>
                      </div>
                    </div> -->
                </span>
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
  
  const list = ref([
        {
          name: "task 1",
          tasks: [
            {
              name: "task 2",
              tasks: []
            }
          ]
        },
        {
          name: "task 3",
          tasks: [
            {
              name: "task 4",
              tasks: []
            }
          ]
        },
        {
          name: "task 5",
          tasks: []
        }
      ])
  
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