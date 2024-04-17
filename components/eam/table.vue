<template>
    <div>
        <a-table class="w-full" :pagination="{pageSize: pageSize, total: total}"  :columns="columns" :data-source="modelValue.data"  :expand-column-width="100">
            <template #bodyCell="{ column, record }">
                <template v-if="column.key === 'assCode'">
                    <NuxtLink :to="`/thiet-bi/${record.assCode}`">{{ record.assCode }}</NuxtLink>
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
    { title: 'Loại', dataIndex: 'assType', key: 'assType', fixed: true, width: 60 },
    { title: 'Mã', dataIndex: 'assCode', key: 'assCode', fixed: true, width:300 },
    { title: 'Tổ chức', dataIndex: 'assOrg', key: 'assOrg', fixed: true, width: 80 },
    { title: 'Mô tả', dataIndex: 'assDesc', key: 'assDesc', fixed: true },
    { title: 'Loại lớp', dataIndex: 'assClass', key: 'assClass', fixed: true },
    // { title: 'Tổ chức lớp', dataIndex: 'assClassOrg', key: 'assClassOrg', fixed: true },
    { title: 'Danh mục', dataIndex: 'assCategory', key: 'assCategory', fixed: true },
    // { title: 'Loại lớp', dataIndex: 'assLtype', key: 'assLtype', fixed: true },
    // { title: 'Vị trí', dataIndex: 'assLocation', key: 'assLocation', fixed: true },
    // { title: 'Tổ chức vị trí', dataIndex: 'assLocationOrg', key: 'assLocationOrg', fixed: true },
    // { title: 'Thẻ', dataIndex: 'assTag', key: 'assTag', fixed: true },
    // { title: 'Loại P', dataIndex: 'assPtype', key: 'assPtype', fixed: true },
    // { title: 'Vị trí', dataIndex: 'assPosition', key: 'assPosition', fixed: true },
    // { title: 'Tổ chức vị trí', dataIndex: 'assPositionOrg', key: 'assPositionOrg', fixed: true },
    // { title: 'Cha', dataIndex: 'assParent', key: 'assParent', fixed: true },
    // { title: 'Tổ chức cha', dataIndex: 'assParentOrg', key: 'assParentOrg', fixed: true },
    // { title: 'Phụ thuộc', dataIndex: 'assDepend', key: 'assDepend', fixed: true },
    // { title: 'Nhà sản xuất', dataIndex: 'assManufact', key: 'assManufact', fixed: true },
    { title: 'MRC', dataIndex: 'assMrc', key: 'assMrc', fixed: true },
    // { title: 'Phần', dataIndex: 'assPart', key: 'assPart', fixed: true },
    // { title: 'Tổ chức phần', dataIndex: 'assPartOrg', key: 'assPartOrg', fixed: true },
    // { title: 'Số Serial', dataIndex: 'assSerialno', key: 'assSerialno', fixed: true },
    // { title: 'Kho', dataIndex: 'assStore', key: 'assStore', fixed: true },
    // { title: 'Thùng', dataIndex: 'assBin', key: 'assBin', fixed: true },
    // { title: 'Lô', dataIndex: 'assLot', key: 'assLot', fixed: true },
    { title: 'Trạng thái', dataIndex: 'assStatus', key: 'assStatus', fixed: true },
    // { title: 'R', dataIndex: 'assRstatus', key: 'assRstatus', fixed: true },
    // { title: 'Ngày tạo', dataIndex: 'assCommiss', key: 'assCommiss', fixed: true },
    // { title: 'Ngày rút', dataIndex: 'assWithdraw', key: 'assWithdraw', fixed: true }
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
    pageSize.value = toRaw(props.modelValue).pagination.pageSize;
    total.value = toRaw(props.modelValue).pagination.total;
  })

  </script>
  <style>
  .ant-btn {
    @apply flex items-center
  }
  </style>