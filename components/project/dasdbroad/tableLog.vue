<template>
    <div>
        <!-- <a-timeline>
            <a-timeline-item v-for="(item,index) in timeLine">
                {{ item.documentName }}
            </a-timeline-item>
        </a-timeline> -->
        <Card style="height: 43rem; overflow: hidden;box-shadow: none; border-radius: 5px;">
            <template #title><div class="text-[1.15rem]">User Join</div></template>
            <template #content>
                <DataTable :value="users"  class="text-xs h-[100%]" stripedRows>
                <template #empty> No found. </template>
      <template #loading> Loading data. Please wait. </template>
      <Column field="userName" header="User" style="min-width: 10rem">
      </Column>
      <Column field="task" header="Task" style="min-width: 6rem">
      </Column>
      <Column header="WorkHour" field="workHour" style="min-width: 6rem">
    </Column>
        </DataTable>
            </template>
        </Card>
    </div>
</template>
<script setup>
import { ref } from 'vue';
const emit = defineEmits(['update:modelValue']);
const props = defineProps(['modelValue']);
const users = ref(props.modelValue);
const getSeverity = (status) => {
    switch (status) {
        case 0:
            return 'secondary';
        case 1:
            return 'warning';
            case 2:
            return 'success';
        case 3:
            return 'danger';
        case 4:
            return 'danger';
        default:
            return null;
    }
};
</script>
