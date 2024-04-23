<template>
    <div class="flex justify-center">
      <div class="w-full mr-2">
        <nested-draggable :tasks="list" />
        {{ list }}
      </div>
    </div>
  </template>
  
  <script>
  import { defineComponent, ref } from 'vue'
  import nestedDraggable from './nested.vue'
  export default defineComponent({
    name: 'nested-example',
    display: 'Nested',
    order: 15,
    components: {
      nestedDraggable,
    },
    setup() {
      const list = ref([
        {
          name: 'task 1',
          tasks: [
            {
              name: 'task 2',
              tasks: [],
            },
          ],
        },
        {
          name: 'task 3',
          tasks: [
            {
              name: 'task 4',
              tasks: [],
            },
          ],
        },
        {
          name: 'task 5',
          tasks: [],
        },
      ])
      return { list }
    },
  })
  </script>