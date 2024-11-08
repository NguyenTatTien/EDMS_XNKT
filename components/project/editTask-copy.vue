<template>
    <div class="flex flex-wrap w-full">
      <div class="w-full flex border-bot-1 pb-3 items-center">
        <div class="flex-grow">

        </div>
        <div class="flex items-center">
          <span @click="$emit('maximize', true)" class="mr-2 cursor-pointer">
            <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><polyline points="15 3 21 3 21 9"></polyline><polyline points="9 21 3 21 3 15"></polyline><line x1="21" y1="3" x2="14" y2="10"></line><line x1="3" y1="21" x2="10" y2="14"></line></svg>
          </span>
          <span @click="$emit('close')" class="cursor-pointer">
            <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
          </span>
        </div>
      </div>
      <div class="container flex justify-center mt-4">
        <div class="w-full grid grid-cols-12 gap-3">
        <div class="col-span-9">
          <ScrollPanel style="width: 100%; height: 700px">
            <div class="w-full flex flex-wrap">
              <section name="info" class="w-full">
                <p class="font-semibold text-lg mb-3">Tạo task</p>
              </section>
            </div>
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
                      <a-input :min="1" v-model:value="modelValue.process_weight" placeholder="" class="w-full" />
                  </a-form-item>
                  <a-form-item label="Thời gian">
                      <a-range-picker v-model:value="dateRange" class="w-full"/>
                  </a-form-item>
                  <a-form-item label="Quản lý">
                      <div class="flex flex-wrap w-full items-center">
                          <a-mentions v-model:value="value" autofocus :options="options" @select="onSelect"></a-mentions>
                      </div>
                  </a-form-item>
                  <a-form-item label="Nhân sự">
                      <div class="flex flex-wrap w-full items-center">
                          <a-mentions v-model:value="value2"  rows="3" :options="options" @select="onSelect"></a-mentions>
                      </div>
                  </a-form-item>
              </a-form>
            </div>
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
                      <a-input :min="1" v-model:value="modelValue.process_weight" placeholder="" class="w-full" />
                  </a-form-item>
                  <a-form-item label="Thời gian">
                      <a-range-picker v-model:value="dateRange" class="w-full"/>
                  </a-form-item>
                  <a-form-item label="Quản lý">
                      <div class="flex flex-wrap w-full items-center">
                          <a-mentions v-model:value="value" autofocus :options="options" @select="onSelect"></a-mentions>
                      </div>
                  </a-form-item>
                  <a-form-item label="Nhân sự">
                      <div class="flex flex-wrap w-full items-center">
                          <a-mentions v-model:value="value2"  rows="3" :options="options" @select="onSelect"></a-mentions>
                      </div>
                  </a-form-item>
              </a-form>
            </div>
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
                      <a-input :min="1" v-model:value="modelValue.process_weight" placeholder="" class="w-full" />
                  </a-form-item>
                  <a-form-item label="Thời gian">
                      <a-range-picker v-model:value="dateRange" class="w-full"/>
                  </a-form-item>
                  <a-form-item label="Quản lý">
                      <div class="flex flex-wrap w-full items-center">
                          <a-mentions v-model:value="value" autofocus :options="options" @select="onSelect"></a-mentions>
                      </div>
                  </a-form-item>
                  <a-form-item label="Nhân sự">
                      <div class="flex flex-wrap w-full items-center">
                          <a-mentions v-model:value="value2"  rows="3" :options="options" @select="onSelect"></a-mentions>
                      </div>
                  </a-form-item>
              </a-form>
            </div>
          </ScrollPanel>
        </div>
        <div class="col-span-3">
          aaa
        </div>
      </div>
      </div>
    </div>
</template>

<script setup>
import { ref,watch } from 'vue';
import ScrollPanel from 'primevue/scrollpanel';

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

<style>
.border-bot-1 {
  border-bottom: 1px solid #d9d7d7;
}
</style>