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
            <a-form class="col-span-6 mt-4">
                <a-form-item label="Tên dự án">
                    <a-input v-model:value="model.name" placeholder="input placeholder" />
                </a-form-item>
                <a-form-item label="Mô tả dự án">
                    <a-input v-model:value="model.description" placeholder="input placeholder" />
                </a-form-item>
                <a-form-item label="Khoi">
                    <a-select
                        ref="select"
                        v-model:value="model.khoiID"
                        style="width: 100%"
                        >
                        <a-select-option v-for="item in khoi" :key="item.id" :value="item.id">{{ item.name }}</a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="Phong">
                    <a-select
                        ref="select"
                        v-model:value="model.phongID"
                        style="width: 100%"
                        >
                        <a-select-option v-for="item in phong" :key="item.id" :value="item.id">{{ item.name }}</a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="Ban">
                    <a-select
                        ref="select"
                        v-model:value="model.banID"
                        style="width: 100%"
                        >
                        <a-select-option v-for="item in ban" :key="item.id" :value="item.id">{{ item.name }}</a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="Loai">
                    <a-select
                        ref="select"
                        v-model:value="model.type"
                        style="width: 100%"
                        >
                        <a-select-option v-for="item in 2" :key="item" :value="item">
                          <span v-if="item == 1">
                            Dự án trong kế hoạch
                          </span>
                          <span v-if="item == 2">
                            Dự án phát sinh
                          </span>
                        </a-select-option>
                    </a-select>
                </a-form-item>
                <a-button @click="save()" type="primary">Lưu</a-button>
            </a-form>
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

  const item = ref({})
  item.value = "1"
  const model = ref(
    {
        id: 0,
        name : "Dự án 1",
        description : "Dự án quản lý dự án",
        khoiID: 0,
        phongID: 0,
        banID: 0,
        userID: 0,
        type: 0,
        dateStart: new Date(),
        dateEnd: new Date(),
        details: [
            {
                name: "Cong viec 1",
                description: "noi dung cong viec 1",
                type: 0,
                statusCode: 0,
                users: [
                    { 
                        userID: 0,
                        name: "User 1",
                        avatar: "",
                        groupID: 0,
                        status: 0,
                    }
                ]
            }
        ]
      }
  )
  
  const home = ref({
    icon: 'pi pi-home',
    route: '/'
  });
  const items = ref([
    { label: 'Dự án', route: '/project' },
    { label: 'Tạo dự án mới' }
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