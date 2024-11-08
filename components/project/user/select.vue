<template>
  <!-- <a-tree-select
    v-model:value="value"
    show-search
    style="width: 100%"
    :dropdown-style="{ maxHeight: '400px', overflow: 'auto' }"
    placeholder="Please select"
    allow-clear
    tree-default-expand-all
    :tree-data="treeData"
    tree-node-filter-prop="label"
  >
    <template #title="{ value: val, label }">
      <b v-if="val === 'parent 1-1'" style="color: #08c">sss</b>
      <template v-else>{{ label }}</template>
    </template>
  </a-tree-select> --> 
  <!-- <a-select
    v-model:value="selectedUser"
    show-search
    placeholder="Select user"
    style="width: 100%"
    :options="userData"  
  > -->
<!-- </a-select> -->
  <Dropdown filter v-model="selectedUser" :options="users" optionLabel="fullName" placeholder="Select user" class="w-full md:w-14rem">
</Dropdown>
</template>
<script setup>
import { ref, watch, onMounted } from 'vue';
import { useUser } from '~/stores/user';
import { storeToRefs } from 'pinia';
// Initialize emit
const emit = defineEmits(['update:modelValue', 'name','id']);
const props = defineProps(['modelValue','name','id']);
const users = ref([]);
const selectedUser = ref();
const value = ref('');
const userData = ref([
]);

watch(selectedUser, () => {
  // const userID = selectedUser.value;
  const user =selectedUser.value;
  props.modelValue[props.id] = user.id;
  props.modelValue[props.name] = user.fullName;
});
// onMounted
onMounted(async() => {
  await getUsers();
  selectedUser.value = users.value.find(p => p.id == props.modelValue[props.id]);
});
const getUsers = async () => {
    try {
      const data = await useUser().getAll();
      users.value = data;
    } catch (error) {
      console.log(error);
    }
};

</script>