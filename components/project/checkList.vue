<template>
    <a-list v-if="modelValue != null" size="small" bordered :data-source="modelValue">
        <template #renderItem="{ item }">
            <a-list-item>
                <div class="flex w-full items-center">
                    <a-checkbox  v-model:checked="item.checked" class="mr-2"></a-checkbox>
                    <Inplace :closable="true" class="flex w-full">
                        <template #display> 
                            {{ item.name }}
                        </template>
                        <template #content>
                            <a-input v-model:value="item.name" placeholder="" />
                        </template>
                    </Inplace>
                </div>
            </a-list-item>
        </template>
    </a-list>
  </template>
  <script setup>
  import Inplace from 'primevue/inplace';
  const emit = defineEmits(['update:modelValue'])
  //props
  const props = defineProps(['modelValue'])
  //emit
    // const data = ref([
    //     {
    //         name: 'check 1',
    //         checked: false
    //     }
    // ]);
  </script>