<template>
    <div class="h-full">
        <ProjectWorkflowHome v-if="objUsers.length == 0" v-model="project" @refreshWF="refreshWF"/>
        <ProjectWorkflowAttached v-else v-model="objUsers" @refreshWF="refreshWF" :project="project" @updateProject="updateProject"/>
    </div>
</template>
<script setup>
    import { useObjectAssginUser } from '~/stores/objectAssginUser';
    import {ref,onMounted,watch} from 'vue';
    import { useRoute } from 'vue-router';
    const emit = defineEmits(['update:modelValue','updateProject']);
    const props = defineProps(["modelValue"]);
    const project = ref(props.modelValue);
    const objUsers = ref([]);
    const projectID = ref(project.value.id);
    watch(() => props.modelValue, async(newValue) => {
        project.value = newValue;
        projectID.value = project.value.id
        objUsers.value = await useObjectAssginUser().getByProject(project.value.id);
    });
    onMounted(async()=>{
        project.value = props.modelValue;
        objUsers.value = await useObjectAssginUser().getByProject(project.value.id);
    });
    const updateObjectUser = async() => {
        objUsers.value = await useObjectAssginUser().getByProject(projectID.value);
    }
    const refreshWF = async() => {
        console.log("sss");
        objUsers.value = await useObjectAssginUser().getByProject(projectID.value);
        console.log("sssss");
    }
    const updateProject = (data) => {
        emit('updateProject',data);
    }
</script>