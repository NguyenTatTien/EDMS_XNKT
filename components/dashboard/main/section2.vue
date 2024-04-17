<template>
    <div>
        <section class="my-2">
            <!-- <span class="text-xl text-gray-500 my-2">
                Thống kê:
            </span> -->
            <div class="w-full grid grid-cols-4 gap-3">
                <span class="w-full">
                    <DashboardCard class="h-full">
                        Biểu đồ:
                        <template #content>
                            <DashboardMainChart1></DashboardMainChart1>
                        </template>
                    </DashboardCard>
                </span>
                <span class="w-full col-span-1">
                    <DashboardCard class="h-full">
                        Người tham gia:
                        <template #content>
                            <DashboardMainEmployee></DashboardMainEmployee>
                        </template>
                    </DashboardCard>
                </span>
                <span class="w-full">
                    <DashboardCard>
                        Công việc không đúng hạn
                        <template #content>
                            <div class="flex flex-wrap w-full">
                                <span class="w-full mt-6">
                                    <a-tooltip title="3 done / 3 in progress / 4 to do">
                                        <a-progress :percent="60" :success="{ percent: 30 }" :size="80" type="dashboard" />
                                    </a-tooltip>
                                </span>
                                <span class="w-full mt-6 flex items-center">
                                    <a-tooltip title="3 done / 3 in progress / 4 to do">
                                        <a-progress :percent="10" :success="{ percent: 60 }" :size="80" type="dashboard" />
                                    </a-tooltip>
                                    <span class="text-red-500 text-3xl p-3">
                                        30
                                    </span>
                                    <span>
                                        việc đã trễ hạn
                                    </span>
                                </span>
                                <a-divider type="" class="w-full" />
                                <span class="mt-3 border-t-2 text-sm border-gray-500">
                                    <InfoCircleOutlined />
                                    Có 2 công việc được tạo không có thời hạn
                                </span>
                            </div>
                        </template>
                    </DashboardCard>
                </span>
                <span class="grid grid-cols-1 gap-3">
                    <div class="grid grid-cols-2 gap-0 w-full h-full shadow-md rounded-lg">
                        <span class="bg-green-100 rounded-lg">
                            1
                        </span>
                        <span>
                            2
                        </span>
                        <span>
                            3
                        </span>
                        <span class="bg-green-100 rounded-lg">
                            4
                        </span>
                    </div>
                    <DashboardCard>
                        Công việc chờ đánh giá
                    </DashboardCard>
                </span>
            </div>
        </section>
    </div>
</template>

<script setup>
</script>