<template>
    <div>
            <div class="mt-6">
                <a-tabs v-model:activeKey="activeKey" class="h-full pb-[50px]" :destroyInactiveTabPane="true">
                    <a-tab-pane key="1" tab="Workflow Step" class="h-full">
                        <ProjectWorkflowStep v-model="workflow"/>
                    </a-tab-pane>
                    <a-tab-pane key="2" tab="Workflow Detail" class="h-full">
                        <ProjectWorkflowDetailStep v-model="workflow" />
                    </a-tab-pane>
                </a-tabs>
            </div>
    </div>
</template>
<script setup>
    import { ref, onMounted } from 'vue';
    import { useWorkflowStep } from '~/stores/workflowStep';
    import { FilterMatchMode } from 'primevue/api';
    import { WorkflowStep } from '~/models/workflowStep';
    import { useToast } from "primevue/usetoast";
    const emit = defineEmits(['update:modelValue','workflow']);
    const props = defineProps(['modelValue','workflow']);
    const workflow = ref(props.workflow);
    const activeKey = ref('1');
    onMounted(async() => {
});
</script>
<style>
    .ant-tabs-nav-list{
        margin-left: 32px;
    }
</style>
