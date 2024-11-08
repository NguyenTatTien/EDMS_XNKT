<template>
  <div>
    <ProjectNestedComponent/>
  </div>
</template>
<script setup>
//props
const props = defineProps({
    modelValue: {
        type: Object,
        default: {}
    },
})
</script>