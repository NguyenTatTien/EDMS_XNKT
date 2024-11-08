<template>
    <div>
        <span class="w-full flex flex-wrap p-3 text-xs">
            <div class="w-full flex flex-wrap">
                <span class="text-gray-600 w-full flex">
                    <span class="flex-grow">
                        Task "xxx" được tạo bởi <span class="text-blue-500 px-1">Nguyễn Văn A</span>
                    </span>
                    <span class="">
                        {{ new Date().toLocaleDateString() }}
                    </span>
                </span>
                <span class="text-gray-600 w-full flex">
                    <span class="flex-grow">
                        Task "xxx" bị <span class="text-red-500 px-1">từ chối</span> bởi <span
                            class="text-blue-500 px-1">Nguyễn Văn A</span>
                    </span>
                    <span class="">
                        {{ new Date().toLocaleDateString() }}
                    </span>
                </span>
                <span name="chat" class="w-full bg-white rounded-lg p-3 flex flex-wrap text-sm my-2 items-center">
                    <span class="w-full flex text-sm items-center">
                        <span class="flex-grow">
                            <Avatar label="U" class="mr-2" style="background-color: #dee9fc; color: #1a2551" />
                        </span>
                        <span>
                            {{ new Date().toLocaleDateString() }}
                        </span>
                    </span>
                    <span class="my-3">
                        Sao lại từ chối ??
                    </span>
                </span>
            </div>
        </span>
        <div class="flex absolute bottom-0 left-0 w-full p-3 mt-2">
            <span class="w-full bg-white rounded-lg p-3 flex flex-wrap text-sm">
                <div v-if="!isExpanded" @click="expandChat" class="flex w-full items-center">
                    <!-- <span class="flex-grow">
                        Gửi tin nhắn
                    </span> -->
                    <a-input v-model="message" style="width: 100%" placeholder="Message" class="mr-2"/>
                    <span>
                        <span class="cursor-pointer text-sm px-4 py-1 bg-blue-500 text-white rounded">Gửi</span>
                    </span>
                </div>
                <div v-if="isExpanded" class="flex w-full items-center">
                    <span class="flex w-full">
                        <div class="flex flex-wrap w-full">
                            <span class="h-16">
                                Gửi tin nhắn 2
                            </span>
                            <span class="w-full flex">
                                <span class="flex-grow">
                                    <!-- 1,2,3,4,5 -->
                                </span>
                                <span>
                                    <span
                                        class="cursor-pointer text-sm px-4 py-1 bg-blue-500 text-white rounded">Gửi</span>
                                </span>
                            </span>
                        </div>
                    </span>
                </div>
            </span>
        </div>
    </div>
</template>

<script setup>
 const message = ref("");
</script>