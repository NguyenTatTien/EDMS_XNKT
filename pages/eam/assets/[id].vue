<template>
    <div class="flex flex-wrap w-full justify-center">
      <div class="container w-full">
        <div class="flex flex-wrap">
            <Breadcrumb class="mt-4" :home="home" :model="items">
                <template #item="{ item, props }">
                    <router-link v-if="item.route" v-slot="{ href, navigate }" :to="item.route" custom>
                        <a :href="href" v-bind="props.action" @click="navigate">
                            <span :class="[item.icon, 'text-color']" />
                            <span class="">{{ item.label }}</span>
                        </a>
                    </router-link>
                    <a v-else :href="item.url" :target="item.target" v-bind="props.action">
                        <span class="text-color">{{ item.label }}</span>
                    </a>
                </template>
            </Breadcrumb>
            <div class="w-full grid grid-cols-12 gap-3">
                <section class="col-span-9">
                    <Skeleton v-if="isLoading" class="mb-2"></Skeleton>
                    <div v-else>
                        <section class="p-3 shadow-md rounded-lg bg-white">
                            <a-tabs v-model:activeKey="activeKey" size="default">
                                <a-tab-pane key="1" tab="Lịch sử tuẩn kiểm">
                                    <div class="max-h-screen-fix-1">
                                      
                                    </div>
                                </a-tab-pane>
                                <a-tab-pane key="2" tab="Tiêu chuẩn tuần kiểm">
                                    <ul class="max-h-screen-fix">
                                        <li v-for="item in model.data.tieuchuantuankiem" :key="item.id">
                                            {{ item }}
                                        </li>
                                    </ul>
                                </a-tab-pane>
                                <a-tab-pane key="3" tab="Thiết bị, phụ tùng">
                                    <div class="max-h-screen-fix">
                                        {{ model.data.cayphancap }}
                                    </div>
                                </a-tab-pane>
                            </a-tabs>
                        </section>
                    </div>
                </section>
                <section class="col-span-3">
                    <Skeleton v-if="isLoading" class="mb-2"></Skeleton>
                    <div v-else>
                        <div class="flex-noshink w-full grid grid-cols-1 gap-3">
                            <span class="w-full flex flex-wrap justify-center rounded-lg shadow-md p-3 bg-white">
                                <div class="w-full flex">
                                    <span class="text-xl font-semibold text-blue-500">
                                        Mã thiết bị
                                    </span>
                                </div>
                                <vue3-barcode :value="model.data.asset.assCode" :height="50" :width="1" />
                            </span>
                            <span class="w-full flex flex-wrap justify-center rounded-lg shadow-md p-3 bg-white">
                                <div class="w-full flex flex-wrap">
                                    <span class="text-xl font-semibold text-blue-500">
                                        Mô tả
                                    </span>
                                    <span class="grid grid-cols-1 gap-3 w-full mt-3">
                                        <span class="grid grid-cols-6 gap-3">
                                            <label class="col-span-2">
                                                Tổ chức:
                                            </label>
                                            <span class="col-span-4">
                                                <NuxtLink to="/thiet-bi">
                                                    {{ model.data.asset.assOrg }}
                                                </NuxtLink>
                                            </span>
                                        </span>
                                        <span class="grid grid-cols-6 gap-3">
                                            <label class="col-span-2">
                                                Mô tả:
                                            </label>
                                            <span class="col-span-4 text-xs">
                                                {{ model.data.asset.assDesc }}
                                            </span>
                                        </span>
                                        <span class="grid grid-cols-6 gap-3">
                                            <label class="col-span-2">
                                                Phòng ban:
                                            </label>
                                            <span class="col-span-4">
                                                <NuxtLink to="/thiet-bi">
                                                    {{ model.data.asset.assMrc }}
                                                </NuxtLink>
                                            </span>
                                        </span>
                                        <span class="grid grid-cols-6 gap-3">
                                            <label class="col-span-2 text-sm">
                                                Nhà sản xuất:
                                            </label>
                                            <span class="col-span-4 text-yellow-500">
                                                Chưa được đề cập
                                            </span>
                                        </span>
                                    </span>
                                </div>
                            </span>
                            <span class="w-full flex flex-wrap justify-center rounded-lg shadow-md p-3 bg-white">
                                <div class="w-full flex flex-wrap">
                                    <span class="text-xl font-semibold text-blue-500">
                                        Trạng thái thiết bị:
                                    </span>
                                    <span class="grid grid-cols-1 gap-3 w-full mt-3">
                                        <span class="grid grid-cols-6 gap-3">
                                            <label class="col-span-3">
                                                Trạng thái chung:
                                            </label>
                                            <span class="col-span-3">
                                                <a-tag color="green">Đã lắp đặt</a-tag>
                                            </span>
                                        </span>
                                        <span class="grid grid-cols-6 gap-3">
                                            <label class="col-span-3">
                                                Ngày lắp đặt:
                                            </label>
                                            <span class="col-span-3">
                                                08/04/2024
                                            </span>
                                        </span>
                                        <span class="grid grid-cols-6 gap-3">
                                            <label class="col-span-3 text-sm">
                                                Ngày bảo dưỡng gần nhất
                                            </label>
                                            <span class="col-span-3">
                                                08/04/2024
                                            </span>
                                        </span>
                                    </span>
                                </div>
                            </span>
                            <span class="grid grid-cols-2 gap-3">
                                <section class="p-3 shadow-md rounded-lg bg-white grid grid-cols-1 gap-3">
                                    <label class="text-blue-500 font-semibold">Tổng sử dụng</label>
                                    <span class="text-xl text-semibold text-gray-600">
                                        10000h
                                    </span>
                                </section>
                                <section class="p-3 shadow-md rounded-lg bg-white grid grid-cols-1 gap-3">
                                    <label class="text-blue-500 font-semibold">Giá trị cuối</label>
                                    <span class="text-xl text-semibold text-gray-600">
                                        10000h
                                    </span>
                                </section>
                                <section class="p-3 shadow-md rounded-lg bg-white grid grid-cols-1 gap-3">
                                    <label class="text-blue-500 font-semibold">Phát sinh sự cố</label>
                                    <span class="text-xl text-semibold text-gray-600">
                                        4
                                    </span>
                                </section>
                                <section class="p-3 shadow-md rounded-lg bg-white grid grid-cols-1 gap-3">
                                    <label class="text-blue-500 font-semibold">Bảo trì, bảo dưỡng</label>
                                    <span class="text-xl text-semibold text-gray-600">
                                        12
                                    </span>
                                </section>
                            </span>
                        </div>
                    </div>
                </section>
            </div>
        </div>
      </div>
    </div>
</template>

<script setup>
import { useRoute } from 'vue-router'
import Breadcrumb from 'primevue/breadcrumb';
import axios from 'axios';

const model = ref({})
const isLoading = ref(true)

const home = ref({
    icon: 'pi pi-home',
    route: '/'
});
const items = ref([
    { label: 'Tài sản', route: '/eam/assets' },
    { label: useRoute().params.id }
]);

onMounted(async () => {
    isLoading.value = true
    model.value = await getByID(useRoute().params.id)
    isLoading.value = false
})

const getByID = async(id) => {
    let endpoint = "http://localhost:5010/api";
    let res = await axios.get(`${endpoint}/asset/id?id=${id}`, {
    
    })
    return res;
}
</script>

<style>
.max-h-screen-fix {
    max-height: calc(100vh - 280px);
    overflow: auto;
}
.max-h-screen-fix-1 {
    max-height: calc(100vh - 164px);
    overflow: auto;
}
</style>