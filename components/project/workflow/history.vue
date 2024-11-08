<template>
    <div class="bg-white py-5 h-full w-full overflow-auto">
        <n-infinite-scroll class="h-full" :distance="10">
            <div class="text-xl font-bold text-blue-400 text-center">Workflow History</div>
        <div class="mt-5 pl-10 pr-5">
                <n-timeline>
            <n-timeline-item v-for="item in wfHistory" :key="item.id" :content="item.workflowStepName" :type="item.actionTypeID == 1?'waring':item.actionTypeID ==2?'error':item.actionTypeID==3?'info': 'error'">
                <template #header>
                    <span :class="item.actionTypeID == 1?'text-yellow-500':item.actionTypeID ==2?'text-red-500':item.actionTypeID==3?'text-blue-500': 'text-red-500'">{{ item.actionTypeName }}</span>
                </template>
                 <template #default>
                    <div class="flex flex-col">
                        <div style="font-weight: 500;" class="text-gray-600">
                            WorkflowStepName: <span class="font-normal text-black">{{ item.workflowStepName }}</span>
                        </div>
                        <div style="font-weight: 500;" class="text-gray-600">
                            User Assgin: <span class="font-normal text-black">{{ item.userFullName }}</span>
                        </div>
                        <div style="font-weight: 500;" class="text-gray-600">
                            WorkflowName: <span class="font-normal text-black">{{ item.workflowName }}</span>
                        </div>
                        <div style="font-weight: 500;" class="text-gray-600">
                            Note: <span class="font-normal text-black">{{ item.message }}</span>
                        </div>
                    </div>
                 </template>
                 <template #footer>
                        <div>{{item.createdDate !=null? format(item.createdDate, 'dd/MM/yyyy HH:mm') :""}}</div>
                 </template>
            </n-timeline-item>
        </n-timeline>
        </div>
        </n-infinite-scroll>
    </div>
</template>
<script setup>
    import { ref,onMounted } from 'vue';
    import { useWorkflowHistory } from '@/stores/workflowHistory';
    import { format, parse,formatISO } from 'date-fns';
    const props = defineProps(["modelValue"]);
    const project = ref(props.modelValue);
    const wfHistory = ref([]);
    onMounted(async()=>{      
        wfHistory.value = await useWorkflowHistory().getByProject(project.value.id);
    });
</script>
