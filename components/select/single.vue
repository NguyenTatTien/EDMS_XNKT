<template>
    <div>
        <Dropdown filter v-model="selectedUser" :options="users" optionLabel="fullName" placeholder="Select user" class="w-full md:w-14rem"></Dropdown>
    </div>
</template>
<script>
import { ref, watch, onMounted } from 'vue';
const emit = defineEmits(['update:modelValue']);
const props = defineProps(['modelValue']);
</script>
