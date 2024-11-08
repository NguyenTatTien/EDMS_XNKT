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
    /> --><n-select
      v-model:value="selectedUsers"
      multiple
      filterable
      placeholder="Select users"
      value-field="id"
    label-field="fullName"
      :options="users"
    />
  </template>
  <script setup>
  import { ref, watch } from 'vue';
  import { TreeSelect } from 'ant-design-vue';
  import { useUser } from '~/stores/user';
  import { storeToRefs } from 'pinia';
  import '../../../assets/css/n-model.css';
  //init emit
  const emit = defineEmits(['update:modelValue','onUpdateUser'])
  const props = defineProps(['modelValue'])
  const SHOW_PARENT = TreeSelect.SHOW_PARENT;
  const users = ref([])
  const treeData = ref([]) 
  const selectedUsers = ref([]);
  watch(selectedUsers, () => {
    var selects = users.value.filter((user) => selectedUsers.value.includes(user.id));console.log(selects);
    emit('update:modelValue', selects)
  });
  onMounted(async() => {
    await getUsers();
    if(props.modelValue){
        selectedUsers.value = props.modelValue.map((user) => user.id);
    }
  })
  const getUsers = async () => {
    try {
      const data = await useUser().getAll();
      users.value = data;
    } catch (error) {
      console.log(error);
    }
  }
  </script>