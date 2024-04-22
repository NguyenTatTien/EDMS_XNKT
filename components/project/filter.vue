<template>
    <div>
        <div class="w-full grid grid-cols-5 mt-3 gap-3">
            <span class="p-0 rounded-lg">
                <MultiSelect v-model="selectedKhoi" :options="khoi" optionLabel="name" placeholder="Chọn khối"
                :maxSelectedLabels="3" class="w-full md:w-20rem" />
            </span>
            <span class="p-0 rounded-lg">
                <MultiSelect v-model="selectedBan" :options="ban" optionLabel="name" placeholder="Chọn ban"
                :maxSelectedLabels="3" class="w-full md:w-20rem" />
            </span>
            <span class="p-0 rounded-lg">
                <MultiSelect v-model="selectedPhong" :options="phong" optionLabel="name" placeholder="Chọn phòng"
                :maxSelectedLabels="3" class="w-full md:w-20rem" />
            </span>
            <span class="p-0 rounded-lg col-span-2 flex items-center">
                <IconField iconPosition="left" class="w-full">
                    <InputIcon class="pi pi-search"> </InputIcon>
                    <InputText v-model="value1" placeholder="Tìm kiếm" class="w-full"/>
                </IconField>
                <div>
                    <slot></slot>
                </div>
            </span>
        </div>
    </div>
</template>

<script setup>
import { ref } from "vue";
import { useKhoiBanPhong } from "~/stores/KhoiBanPhong";
import { storeToRefs } from "pinia";

const { khoi, ban, phong } = storeToRefs(useKhoiBanPhong())

const selectedKhoi = ref();
const selectedBan = ref();
const selectedPhong = ref();

</script>