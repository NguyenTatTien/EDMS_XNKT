<template>
    <!-- <a-tree-select
      v-model:value="value"
      style="width: 100%"
      :tree-data="treeData"
      tree-checkable
      allow-clear
      :show-checked-strategy="SHOW_PARENT"
      placeholder="Please select"
      tree-node-filter-prop="label"
    /> -->
    <MultiSelect filter v-model="selectedUsers" display="chip" :options="users" optionLabel="fullName" placeholder="Select users"
     class="w-full md:w-20rem" :panelClass="props.paneClass" />
  </template>
  <script setup>
  import { ref, watch } from 'vue';
  import { TreeSelect } from 'ant-design-vue';
  import { useUser } from '~/stores/user';
  import { storeToRefs } from 'pinia';
  import '../../../assets/css/n-model.css';
  //init emit
  const emit = defineEmits(['update:modelValue','paneClass'])
  const props = defineProps(['modelValue','paneClass'])
  const SHOW_PARENT = TreeSelect.SHOW_PARENT;
  const users = ref([])
  const treeData = ref([]) 
  const selectedUsers = ref([]);
  watch(selectedUsers, () => {
    emit('update:modelValue', selectedUsers.value)
  });
  onMounted(async() => {
    await getUsers();
    selectedUsers.value = props.modelValue;
    console.log(props.modelValue);
  })
  const getUsers = async () => {
    try {
      const data = await useUser().getAll();
      users.value = data;
      console.log(users.value);
    } catch (error) {
      console.log(error);
    }
  }
  
  </script>