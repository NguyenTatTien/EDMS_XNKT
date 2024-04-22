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
      <EamFilter>
        <NuxtLink to="/eam/inspection/new">
          <Button size="small" class="ml-3">Thêm</Button>
        </NuxtLink>
      </EamFilter>
      <EamSection1></EamSection1>
      <EamInspectionTable v-if="model" class="rounded-lg shadow-md mt-4" v-model="model"></EamInspectionTable>
    </div>
  </div>
</template>


<script setup>
import { ref } from 'vue';
import axios from 'axios';
import Button from 'primevue/button';
const item = ref({})
item.value = "1"
const model = ref(null)

const home = ref({
  icon: 'pi pi-home',
  route: '/'
});
const items = ref([
  { label: 'Tài sản', route: '/eam/assets' },
  { label: useRoute().params.id }
]);


//onMounted
onMounted(() => {
  init();
})

const init = async (page = 1, pageSize = 10, search = "") => {
  let endpoint = "http://localhost:5010/api";
  let res = await axios.get(`${endpoint}/Inspection?page=${page}&pageSize=${pageSize}&search=${search}`, {

  })
  console.log(res.data)
  model.value = res.data;
}


</script>