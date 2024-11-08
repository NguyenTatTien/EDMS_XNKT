<template>
    <span class="shadow-md rounded-none flex justify-between text-white" :class="colorDask">
        <span class="p-6 flex">
            <span class="flex items-center text-lg font-bold">
            <slot>
                0
            </slot>
        </span>
        <span class="w-full flex flex-wrap ml-4">
            <span class="w-full font-semibold text-lg">
                <slot name="Name">
                    New
                </slot>
            </span>
            <span class="w-full text-sm">
                <slot name="description">
                    Create new document
                </slot>
            </span>
        </span>
        </span>
        <span class="flex flex-wrap ml-4 items-center w-[70px] justify-center" :class="colorLight">
            <slot name="icon">
                <i class="pi pi-list" style="font-size: 1.5rem"></i>
            </slot>
        </span>
    </span>
</template>

<script setup>
const emit = defineEmits(['colorLight','colorDask']);
const props = defineProps(['colorLight','colorDask']);
const colorLight = ref(props.colorLight);
const colorDask = ref(props.colorDask);
</script>   