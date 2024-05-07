<template>
    <div>
        <div class="w-full grid grid-cols-1 gap-3 mt-3">
            <DashboardCard>
                Số dự án
                <template #content>
                    <div class="grid grid-cols-6 gap-3">
                        <span class="text-4xl text-blue-500 col-span-2">
                            {{data.length}}
                        </span>
                        <span class="flex flex-wrap w-full col-span-4">
                            <span class="w-full flex items-center">
                                <span class="text-blue-500 text-xs mr-2">●</span>
                                <span class="text-gray-500">
                                    {{data.length}} đang thực hiện
                                </span>
                            </span>
                            <span class="w-full flex items-center mt-2">
                                <span class="text-yellow-500 text-xs mr-2">●</span>
                                <span class="text-gray-500">
                                    0 đang tạm dừng
                                </span>
                            </span>
                        </span>
                    </div>
                </template>
            </DashboardCard>
            <DashboardCard>
                Số dự án kế hoạch
                <template #content>
                    <div class="grid grid-cols-6 gap-3">
                        <span class="text-4xl text-blue-500 col-span-2">
                            0
                        </span>
                        <span class="flex flex-wrap w-full col-span-4">
                            <span class="w-full flex items-center">
                                <span class="text-blue-500 text-xs mr-2">●</span>
                                <span class="text-gray-500">
                                    0 đang thực hiện
                                </span>
                            </span>
                            <span class="w-full flex items-center mt-2">
                                <span class="text-red-500 text-xs mr-2">●</span>
                                <span class="text-gray-500">
                                    0 đang thực hiện
                                </span>
                            </span>
                        </span>
                    </div>
                </template>
            </DashboardCard>
            <DashboardCard>
                Số dự án phát sinh
                <template #content>
                    <div class="grid grid-cols-6 gap-3">
                        <span class="text-4xl text-blue-500 col-span-2">
                            0
                        </span>
                        <span class="flex flex-wrap w-full col-span-4">
                            <span class="w-full flex items-center">
                                <span class="text-blue-500 text-xs mr-2">●</span>
                                <span class="text-gray-500">
                                    0 đang thực hiện
                                </span>
                            </span>
                            <span class="w-full flex items-center mt-2">
                                <span class="text-red-500 text-xs mr-2">●</span>
                                <span class="text-gray-500">
                                    0 đang tạm dừng
                                </span>
                            </span>
                        </span>
                    </div>
                </template>
            </DashboardCard>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue'
import { useProject } from '/stores/project'
import { storeToRefs } from 'pinia';
const { data } = storeToRefs(useProject())
</script>
