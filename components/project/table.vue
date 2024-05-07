<template>
    <div>
        <a-table class="w-full"  :columns="columns" :data-source="modelValue"  :expand-column-width="100">
            <template #bodyCell="{ column, record }">
                <template v-if="column.key === 'name'">
                    <NuxtLink :to="`/project/${record.id}`">{{ record.name }}</NuxtLink>
                </template>
                <template v-if="column.key === 'khoi'">
                    <!-- {{ khoi.filter(p=> p.id == record.khoiID)[0].name }} -->
                </template>
                <template v-if="column.key === 'phong'">
                    {{ phong.filter(p=> p.id == record.phongID)[0].name }}
                </template>
                <template v-if="column.key === 'ban'">
                    {{ ban.filter(p=> p.id == record.banID)[0].name }}
                </template>
                <template v-if="column.key === 'status'">
                    <span class="bg-green-500 rounded-lg text-white p-0.5 px-2" v-if="record.status == 0">
                      Đang thực hiện
                    </span>
                    <span class="bg-red-500 rounded-lg text-whit p-0.5 px-2" v-else>
                      Đã hủy
                    </span>
                </template>
                <template v-if="column.key === 'action'">
                  <span class="w-full flex">
                      <a-button type="text" danger>Xóa</a-button>
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
import { useKhoiBanPhong } from '~/stores/KhoiBanPhong';

const { khoi, phong, ban } = storeToRefs(useKhoiBanPhong())

const columns = [
    { title: 'ID', dataIndex: 'id', key: 'id', fixed: false, width: 60 },
    { title: 'Tên dự án', dataIndex: 'name', key: 'name', fixed: true, width:120 },
    { title: 'Mô tả', dataIndex: 'description', key: 'description', fixed: false, width: 220 },
    // { title: 'Khối', dataIndex: 'khoiID', key: 'khoi', fixed: false },
    { title: 'Ban', dataIndex: 'banID', key: 'ban', fixed: false },
    { title: 'Phòng', dataIndex: 'phongID', key: 'phong', fixed: false },
    { title: 'Trạng thái', dataIndex: 'status', key: 'status', fixed: false },
    { title: '', dataIndex: 'action', key: 'action', fixed: false, width: 50 },
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