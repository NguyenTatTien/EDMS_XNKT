<template>
    <div>
        <el-table :data="_documents" size="small" style="width: 100%" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" />
            <el-table-column prop="department" label="Phòng" :width="300" />
            <el-table-column prop="name" label="Tên" :width="400" />
            <el-table-column prop="slug" label="Đường dẫn" :width="400" />
            <el-table-column label="Loại">
                <template #default="scope">
                    {{scope.row.type }}
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script setup>
import { ref, reactive, watch } from 'vue'
const documents = ref([
  {
    department: '01. Phòng CNTT',
    name: 'Du lieu 1',
    slug: '/folder-1/data/du-lieu-1.xlsx',
    type: 'xlxs'
  },
  {
    department: '02. Phòng Kế Toán',
    name: 'Data 2',
    slug: '/folder-2/data/data-2.csv',
    type: 'csv'
  },
  {
    department: '03. Phòng Marketting',
    name: 'Info 3',
    slug: '/folder-3/info/info-3.docx',
    type: 'docx'
  },
  {
    department: '04. Phòng HR',
    name: 'HR Data',
    slug: '/folder-4/data/hr-data.txt',
    type: 'txt'
  },
  {
    department: '05. Phòng Kỹ Thuật',
    name: 'Technical Report',
    slug: '/folder-5/reports/technical-report.pdf',
    type: 'pdf'
  },
  {
    department: '06. Phòng Hành Chính',
    name: 'Admin Info',
    slug: '/folder-6/info/admin-info.txt',
    type: 'txt'
  },
  {
    department: '07. Phòng Quản Lý',
    name: 'Management Data',
    slug: '/folder-7/data/management-data.csv',
    type: 'csv'
  },
  {
    department: '08. Phòng Sản Xuất',
    name: 'Production Report',
    slug: '/folder-8/reports/production-report.xlsx',
    type: 'xlsx'
  },
  {
    department: '09. Phòng Logistics',
    name: 'Logistics Info',
    slug: '/folder-9/info/logistics-info.docx',
    type: 'docx'
  },
  {
    department: '10. Phòng Tiếp Thị',
    name: 'Marketing Data',
    slug: '/folder-10/data/marketing-data.csv',
    type: 'csv'
  },
  {
    department: '11. Phòng Kinh Doanh',
    name: 'Sales Report',
    slug: '/folder-11/reports/sales-report.pdf',
    type: 'pdf'
  },
])
//init props for search
const props = defineProps({
    search: {
        type: String,
        default: ''
    },
    selected: {
        type: Array,
        default: ()=> []
    }
})
//init emit
const emit = defineEmits(['update:selected'])

const search = computed(()=> {
    return props.search
})
const _documents = computed(()=> {
    if(search && search.value != ''){
        return documents.value.filter((d) => d.slug.includes(search.value));
    }else{
        return documents.value;
    }
})

function handleSelectionChange(val) {
    emit('update:selected',val);
}

</script>