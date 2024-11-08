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
                <a-form-item label="Name Project">
                    <a-input v-model:value="model.name" placeholder="Name Project" />
                </a-form-item>
                <a-form-item label="Description">
                    <a-input v-model:value="model.description" placeholder="Description" />
                </a-form-item>
                <a-form-item label="Unit">
                  
                    <Dropdown v-model="selectedUnit" :options="units" filter optionLabel="name" placeholder="Select..." class="w-full h-[33px]" @change="unit_onChange"></Dropdown>
                </a-form-item>
                <a-form-item label="Start Date">
                  <Calendar v-model="model.startDate" showIcon iconDisplay="input"  dateFormat="dd/mm/yy" class="h-[33px] w-full"/>
                  <!-- <a-date-picker v-model:value="model.startDate" :format="['DD/MM/YYYY', 'DD/MM/YY']" style="width: 100%" /> -->
                  <!-- <a-range-picker v-model:value="dateRange" @change="onChangeDate" style="width: 100%"/> -->
                </a-form-item>
                <a-form-item label="Expected Date">
                  <Calendar v-model="model.expectedDate" showIcon iconDisplay="input"  dateFormat="dd/mm/yy" class="h-[33px] w-full"/>
                
                  <!-- <a-range-picker v-model:value="dateRange" @change="onChangeDate" style="width: 100%"/> -->
                </a-form-item>
                
                <a-form-item label="Approved By">
                  <!-- <a-select
                        ref="select"
                        v-model:value="model.approvedBy"
                        style="width: 100%"
                        @change="approved_onChange">
                        <a-select-option v-for="item in users" :key="item.id" :value="item.id">{{ item.fullName }}</a-select-option>
                    </a-select> -->
                    <Dropdown v-model="selectedApprove" :options="users" filter optionLabel="fullName" placeholder="Select..." class="w-full h-[33px]" @change="approved_onChange">
                      <!-- <template #value="slotProps">
        
                    <span>
                        {{ slotProps.placeholder }}
                    </span>
    </template> -->
                    </Dropdown>
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
  import { useUnit } from '~/stores/unit';
  import { Project } from '~/models/project';
  import {useUser} from '~/stores/user';
  const { someState } = storeToRefs(useStore())
  const { data } = storeToRefs(useProject())
  const units = ref([])
  const store = useProject();
  const dateRange = ref({});
  const selectedApprove = ref(null);
  const selectedAssist = ref(null);
  const selectedUnit = ref(null);
  const item = ref({})
  item.value = "1"
  const model = ref(new Project());
  const users = ref([])
  const home = ref({
    icon: 'pi pi-home',
    route: '/'
  });
  const items = ref([
    { label: 'Dự án', route: '/projects' },
    { label: 'Tạo dự án mới' }
  ]);
  //onMounted
  onMounted(async() => {
    init();
    await getUnit();
    await getUser();
  })
  const getUnit = async () =>{
    units.value = await useUnit().getAll();
  }
  const getUser = async () =>{
    users.value = await useUser().getAll();
  }
  const init = async (page = 1, pageSize = 10, search = "") => {
    // let endpoint = "http://localhost:5010/api";
    // let res = await axios.get(`${endpoint}/Inspection?page=${page}&pageSize=${pageSize}&search=${search}`, {
    // })
    // console.log(res.data)
    // model.value = res.data;
  }
  const save = async () => {
    console.log(model.value);
    var data = store.create(model.value);
    store.add(data);
    useRouter().push({ path: '/projects' });
  }
  const approved_onChange = (value) => {
    console.log(value);
    model.value.approvedBy = value.value.id;
    model.value.approvedByName = value.value.fullName;
  }
  const unit_onChange = (value) => {
    model.value.unitID = value.value.id;
   
  }
  </script>
  <style>
    .ant-form-item-label label {
        width: 120px;
    }
</style>