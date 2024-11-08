<template>
    <div>
        <a-input v-model:value="searchString" placeholder="input with clear icon" allow-clear />
        <ProjectDocumentFind :search="searchString" v-model:selected="selectedModel" class="mt-4"></ProjectDocumentFind>
        {{ selectedModel }}
    </div>
</template>

<script setup>
definePageMeta({
    layout: 'blank'
})
const searchString = ref('')
const selectedModel = ref([])
//selectedModel have data right now
</script>