<template>
    <div>
        <a-table class="w-full" :columns="columns" :data-source="modelValue"  :expand-column-width="100">
            <template #bodyCell="{ column, record }">
                <template v-if="column.key === 'assetCode'">
                    <NuxtLink :to="`/eam/inspection/${record.id}`">{{ record.assetCode }}</NuxtLink>
                </template>
                <template v-if="column.key === 'action'">
                <span class="w-full flex">
                    <a-button>Delete</a-button>
                </span>
                </template>
            </template>
        </a-table>
    </div>
  </template>
  <script setup>
import { ref,toRaw } from 'vue';
import { storeToRefs } from 'pinia';
import { PoweroffOutlined } from '@ant-design/icons-vue'

const columns = [
    // { title: 'Loại', dataIndex: 'assetCode', key: 'assetCode', fixed: true, width: 60 },
    { title: 'Mã', dataIndex: 'assetCode', key: 'assetCode', fixed: true, width:300 },
    { title: 'comment', dataIndex: 'comment', key: 'comment', fixed: true, width: 120 },
    { title: 'Mô tả', dataIndex: 'assDesc', key: 'assDesc', fixed: true },
    { title: 'Loại lớp', dataIndex: 'assClass', key: 'assClass', fixed: true },
    { title: 'Danh mục', dataIndex: 'assCategory', key: 'assCategory', fixed: true },
    { title: 'MRC', dataIndex: 'assMrc', key: 'assMrc', fixed: true },
    { title: 'Trạng thái', dataIndex: 'assStatus', key: 'assStatus', fixed: true },
];

  //props from parent
  const props = defineProps(['modelValue'])
  //emit to parent
  const emit = defineEmits(['update:modelValue'])

  const page = ref(1)
  const pageSize = ref(10)
  const total = ref(100)

  console.log()

  onMounted(async () => {
    
  })

  </script>
  <style>
  .ant-btn {
    @apply flex items-center
  }
  </style>