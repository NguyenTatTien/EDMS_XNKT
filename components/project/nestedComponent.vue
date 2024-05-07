<template>
  <div class="flex justify-center">
    <div class="w-full mr-2">
      <span>
        <a-button class="" @click="showAddModel">Thêm</a-button>
      </span>
      <nested-draggable :tasks="list" />

      <a-modal v-model:open="openModel" width="1000px" title="Thêm phase mới" @ok="addPhaseOk">
        <ProjectEditTask v-model="openAddModel"></ProjectEditTask>
      </a-modal>
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
      // {
      //   name: 'Triển khai phase 1',
      //   userCreated: {
      //     name: "admin",
      //     slug: '/user/admin'
      //   },
      //   userRelation: [
      //     {
      //       name: "admin",
      //       slug: '/user/admin'
      //     },
      //     {
      //       name: "Toàn",
      //       slug: '/user/toan'
      //     }
      //   ],
      //   dateStart: new Date(),
      //   dateEnd: new Date(),
      //   comment: "",
      //   document: [
      //     {
      //       name: "Document 1",
      //       slug: '/document/1',
      //       url: {
      //         original: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png",
      //         thumbnail: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png"
      //       }
      //     }
      //   ],
      //   process_percent: 50,
      //   procoss_weight: 20,
      //   tasks: [
      //     {
      //       name: 'Task phase 1',
      //       process_percent: 0,
      //       procoss_weight: 10,
      //       userCreated: {
      //         name: "admin",
      //         slug: '/user/admin'
      //       },
      //       userRelation: [
      //         {
      //           name: "admin",
      //           slug: '/user/admin'
      //         },
      //         {
      //           name: "Toàn",
      //           slug: '/user/toan'
      //         }
      //       ],
      //       dateStart: new Date(),
      //       dateEnd: new Date(),
      //       comment: "",
      //       document: [
      //         {
      //           name: "Document 1",
      //           slug: '/document/1',
      //           url: {
      //             original: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png",
      //             thumbnail: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png"
      //           }
      //         }
      //       ],
      //       // tasks: [],
      //     },
      //     {
      //       name: 'Task phase 2',
      //       process_percent: 100,
      //       procoss_weight: 10,
      //       userCreated: {
      //         name: "admin",
      //         slug: '/user/admin'
      //       },
      //       userRelation: [
      //         {
      //           name: "admin",
      //           slug: '/user/admin'
      //         },
      //         {
      //           name: "Toàn",
      //           slug: '/user/toan'
      //         }
      //       ],
      //       dateStart: new Date(),
      //       dateEnd: new Date(),
      //       comment: "",
      //       document: [
      //         {
      //           name: "Document 1",
      //           slug: '/document/1',
      //           url: {
      //             original: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png",
      //             thumbnail: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png"
      //           }
      //         }
      //       ],
      //       // tasks: [],
      //     },
      //   ],
      // },
      // {
      //   name: 'Triển khai phase 2',
      //   process_percent: 100,
      //   procoss_weight: 30,
      //   userCreated: {
      //     name: "admin",
      //     slug: '/user/admin'
      //   },
      //   userRelation: [
      //     {
      //       name: "admin",
      //       slug: '/user/admin'
      //     },
      //     {
      //       name: "Toàn",
      //       slug: '/user/toan'
      //     }
      //   ],
      //   dateStart: new Date(),
      //   dateEnd: new Date(),
      //   comment: "",
      //   document: [
      //     {
      //       name: "Document 1",
      //       slug: '/document/1',
      //       url: {
      //         original: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png",
      //         thumbnail: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png"
      //       }
      //     }
      //   ],
      //   tasks: [
      //     {
      //       name: 'task 4',
      //       // tasks: [],
      //       process_percent: 100,
      //       procoss_weight: 10,
      //       userCreated: {
      //         name: "admin",
      //         slug: '/user/admin'
      //       },
      //       userRelation: [
      //         {
      //           name: "admin",
      //           slug: '/user/admin'
      //         },
      //         {
      //           name: "Toàn",
      //           slug: '/user/toan'
      //         }
      //       ],
      //       dateStart: new Date(),
      //       dateEnd: new Date(),
      //       comment: "",
      //       document: [
      //         {
      //           name: "Document 1",
      //           slug: '/document/1',
      //           url: {
      //             original: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png",
      //             thumbnail: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png"
      //           }
      //         }
      //       ],
      //     },
      //   ],
      // },
      // {
      //   name: 'Triển khai phase 3',
      //   process_percent: 100,
      //   procoss_weight: 50,
      //   userCreated: {
      //     name: "admin",
      //     slug: '/user/admin'
      //   },
      //   userRelation: [
      //     {
      //       name: "admin",
      //       slug: '/user/admin'
      //     },
      //     {
      //       name: "Toàn",
      //       slug: '/user/toan'
      //     }
      //   ],
      //   dateStart: new Date(),
      //   dateEnd: new Date(),
      //   comment: "",
      //   document: [
      //     {
      //       name: "Document 1",
      //       slug: '/document/1',
      //       url: {
      //         original: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png",
      //         thumbnail: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png"
      //       }
      //     }
      //   ],
      //   tasks: [
      //     {
      //       name: 'Task của phase 3 - 1',
      //       process_percent: 100,
      //       procoss_weight: 10,
      //       userCreated: {
      //         name: "admin",
      //         slug: '/user/admin'
      //       },
      //       userRelation: [
      //         {
      //           name: "admin",
      //           slug: '/user/admin'
      //         },
      //         {
      //           name: "Toàn",
      //           slug: '/user/toan'
      //         }
      //       ],
      //       dateStart: new Date(),
      //       dateEnd: new Date(),
      //       comment: "",
      //       document: [
      //         {
      //           name: "Document 1",
      //           slug: '/document/1',
      //           url: {
      //             original: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png",
      //             thumbnail: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png"
      //           }
      //         }
      //       ],
      //       // tasks: [],
      //     },
      //   ],
      // },
    ])
    return { list }
  },
  data() {
    return {
      openModel: false,
      openAddModel: {
        name: 'Phase mới',
        process_percent: 0,
        procoss_weight: 0,
        userCreated: {
          name: "admin",
          slug: '/user/admin'
        },
        userRelation: [
          {
            name: "admin",
            slug: '/user/admin'
          },
          {
            name: "Toàn",
            slug: '/user/toan'
          }
        ],
        dateStart: new Date(),
        dateEnd: new Date(),
        comment: "",
        document: [
          {
            name: "Document 1",
            slug: '/document/1',
            url: {
              original: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png",
              thumbnail: "https://upload.wikimedia.org/wikipedia/commons/0/08/Microsoft_Word_logo_%282013-2019%29.png"
            }
          }
        ],
        tasks: [],
      },
    }
  },
  methods: {
    showAddModel() {
      this.openModel = true;
    },
    addPhaseOk(){
      this.list.push(
        JSON.parse(JSON.stringify(this.openAddModel))
      );
      this.openModel = false;
    }
  },
  watch: {
    list: {
      deep: true,
      handler() {
        //alert('a')
      }
    }
  }
})
</script>