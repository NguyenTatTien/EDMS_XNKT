<template>
    <div class="bg-white">
        <!-- handle=".handle" -->
        <draggable  class="dragArea" tag="ul" :list="tasks" :group="{ name: 'g1' }"> 
            <transition-group type="transition" name="flip-list">
                <li v-for="el in tasks" :key="el.name" class="bg-white shadow-md p-2 flex flex-wrap rounded-lg mb-4">
                    <span class="flex w-full items-center">
                        <span class="flex-grow">
                            <div class="flex flex-wrap">
                                <div class="flex items-center w-full">
                                    <!-- <a-popover title="Title">
                                        <template #content>
                                            <input type="text" :value="el.name" v-on:blur="blur(el, $event.target.value)" class="w-full" />
                                        </template>
                                        <p class="text-gray-700">{{ el.name }}</p>
                                    </a-popover> -->
                                    <p class="text-gray-700" @click="showModal(el)">{{ el.name }}</p>
                                    <a-button v-if="!isChild" class="ml-3" @click="showAddModel(el)">Thêm</a-button>
                                </div>
                                <div class="w-full flex">
                                    <div class="flex-grow">
                                        <div class="flex">
                                            <div v-if="!isChild" class="text-xs bg-green-500 text-white px-2 py-1 rounded-full">
                                                <span>Đang thực hiện</span>
                                            </div>
                                            <div class="text-xs px-2 py-1 rounded-full bg-gray-100">
                                                <span>Được tạo bởi: Admin</span>
                                            </div>
                                            <div class="text-xs px-2 py-1 rounded-full bg-gray-100">
                                                <span>Ngày: {{ new Date().toLocaleDateString() }}</span>
                                            </div>
                                            <div class="text-xs px-2 py-1 rounded-full bg-blue-100">
                                                <span>Người làm chính: Nguyễn Văn A</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </span>
                        <div class="flex flex-wrap items-centers">
                            <div class="flex w-full justify-end">
                                <span class="mr-4 text-gray-400">
                                    <span class="text-xs px-2 py-1 rounded-full bg-gray-100">
                                        {{ new Date().toLocaleDateString() }}
                                    </span> - 
                                    <span class="text-xs px-2 py-1 rounded-full bg-gray-100">
                                        {{ new Date().toLocaleDateString() }}
                                    </span>
                                </span>
                                <a-progress :percent="el.process_percent" size="small" class="w-48" />
                                <span class="text-gray-300 hover:text-gray-500 cursor-pointer">
                                    <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                </span>
                            </div>
                            <div class="w-full mt-3">
                                <div v-if="isChild" class="flex items-center justify-end text-xs">
                                    <a-tooltip placement="bottom">
                                        <template #title>
                                            <div class="grid grid-cols-1 gap-3">
                                                <span>Nguyễn Văn A</span>
                                                <span>Nguyễn Văn C</span>
                                                <span>Nguyễn Văn D</span>
                                                <span>Nguyễn Văn E</span>
                                                <span>Nguyễn Văn F</span>
                                            </div>
                                        </template>
                                        <AvatarGroup class="mr-4">
                                            <Avatar label="A" shape="circle"/>
                                            <Avatar label="B" shape="circle"/>
                                            <Avatar label="C" shape="circle"/>
                                            <Avatar label="+2" shape="circle"/>
                                        </AvatarGroup>
                                    </a-tooltip>

                                    <a-tooltip placement="bottom">
                                        <template #title>
                                            <div class="grid grid-cols-1 gap-3">
                                                <span>Thông báo khi có thay đổi</span>
                                            </div>
                                        </template>
                                        <span class="mx-1 hover:text-gray-500 cursor-pointer text-gray-300">
                                            <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
                                        </span>
                                    </a-tooltip> 
                                    <a-tooltip placement="bottom">
                                        <template #title>
                                            <div class="grid grid-cols-1 gap-3">
                                                <span>Thông vào mục tiêu sắp tới</span>
                                            </div>
                                        </template>
                                        <span class="mx-1 hover:text-gray-500 cursor-pointer text-gray-300">
                                        <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path></svg>
                                    </span>
                                    </a-tooltip>                                    
                                </div>
                            </div>
                        </div>
                    </span>
                    <!-- <span class="handle"> + </span> -->
                    <nested-draggable :tasks="el.tasks" :is-child="true" class="bg-gray-100 pl-5 w-full p-1" />
                </li>
            </transition-group>
        </draggable>
        <a-modal v-model:open="open" width="1000px" :title="openModel.name" @ok="handleOk">
            <ProjectEditTask v-model="openModel"></ProjectEditTask>
        </a-modal>
        <a-modal v-model:open="openAdd" width="1000px" title="Thêm task mới" @ok="addTaskHandleOk">
            <ProjectEditTask v-model="openAddModel"></ProjectEditTask>
        </a-modal>
    </div>
</template>
<script>
import { VueDraggableNext } from 'vue-draggable-next'
import Avatar from 'primevue/avatar';
import AvatarGroup from 'primevue/avatargroup';
export default {
    data() {
        return {
            open: false,
            openModel : {},
            openAdd: false,
            openAddModel : {
                    name: 'Task mới',
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
            openAddParentModel: {}
        }
    },
    props: {
        tasks: {
            required: true,
            type: Array,
        },
        isChild: {
            type: Boolean,
            default: false,
        }
    },
    components: {
        draggable: VueDraggableNext,
    },
    name: 'nested-draggable',
    methods: {
        blur(el,data){
            el.name = data;
        },
        addDetail(el) {
            el.tasks.push(
                JSON.parse(JSON.stringify(this.openAddModel))
            )
        },
        showModal(el) {
            this.openModel = el;
            this.open = true;
        },
        handleOk(e) {
            this.open = false
        },
        addTaskHandleOk() {
            this.openAdd = false
            console.log(this.openAddParentModel.process_percent)
            //this.openAddParentModel.process_percent = this.openAddParentModel.tasks.sum(p=> (p.process_percent * p.procoss_weight)/100);
            this.addDetail(this.openAddParentModel)
        },
        showAddModel(el) {
            this.openAddParentModel = el;
            this.openAdd = true
        }
    }
}
</script>
<style>
.dragArea {
    /* min-height: 50px; */
    /* outline: 1px dashed; */
}
.flip-list-move {
  transition: transform 0.5s;
}
ul {
    padding: 0 !important;
}
.ant-modal-footer {
    @apply flex items-center;
}
.p-avatar.p-avatar-circle {
    border-radius: 50%;
    margin: 0 -5px !important;
}
</style>