<template>
    <div class="grid grid-cols-3 gap-3 w-full">
        <a-form class="col-span-3">
            <a-form-item label="Tên task">
                <a-input v-model:value="modelValue.name" placeholder="" />
            </a-form-item>
            <a-form-item label="Ghi chú">
                <a-input rows="3" v-model:value="modelValue.comment" placeholder="" />
            </a-form-item>
            <a-form-item label="Tỷ lệ hoàn thành">
                <a-input :min="1" :max="100" v-model:value="modelValue.process_percent" placeholder="" class="w-full" />
            </a-form-item>
            <a-form-item label="Tỷ trọng">
                <a-input :min="1" v-model:value="modelValue.procoss_weight" placeholder="" class="w-full" />
            </a-form-item>
            <a-form-item label="Thời gian">
                <a-range-picker v-model:value="dateRange" class="w-full"/>
            </a-form-item>
            <a-form-item label="Quản lý">
                <div class="flex flex-wrap w-full items-center">
                    <a-mentions v-model:value="value" autofocus :options="options" @select="onSelect"></a-mentions>
                    <!-- <span class="w-full">
                        <span class="text-blue-500 underline py-2 cursor-pointer">
                            Chọn từ danh sách
                        </span>
                    </span> -->
                </div>
            </a-form-item>
            <a-form-item label="Nhân sự">
                <div class="flex flex-wrap w-full items-center">
                    <a-mentions v-model:value="value2"  rows="3" :options="options" @select="onSelect"></a-mentions>
                    <!-- <span class="w-full">
                        <span class="text-blue-500 underline py-2 cursor-pointer">
                            Chọn từ danh sách
                        </span>
                    </span> -->
                </div>
            </a-form-item>
        </a-form>
        <!-- <div class="col-span-1">
            <label class="text-lg text-gray-600">Danh sách tài liệu</label>
            <div class="grid grid-cols-1 gap-3">
                <span v-for="item in 5" :key="item" class="borber-b-2 border-gray-300">
                    Tài liệu {{item}}
                </span>
            </div>
        </div> -->
    </div>
</template>

<script setup>
import { ref,watch } from 'vue';
const dateRange = ref([]);
//props for v-model
const props = defineProps(['modelValue'])
//emit to parents
const emit = defineEmits(['update:modelValue'])

//watch dateRange
watch(dateRange, () => {
   
})

const value = ref('');
const value2 = ref('');

watch(value, () => {
  console.log('value', value);
});
const onSelect = (e) => {
  console.log('select', e);
};

const options = [
  {
    value: 'Nguyễn Văn A',
    label: 'Nguyễn Văn A',
  },
  {
    value: 'Nguyễn Văn B',
    label: 'Nguyễn Văn B',
  },
  {
    value: 'Nguyễn Văn C',
    label: 'Nguyễn Văn C',
  },
];
</script>