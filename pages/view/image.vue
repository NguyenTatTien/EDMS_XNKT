<template>
    <div class="text-center">
      <img :src="imageSrc" alt="Image" class="max-w-[600px] overflow-auto">
    </div>
  </template>
  <script setup>
     definePageMeta({
     layout: 'blank'
  });
  import { ref,onMounted,onScopeDispose } from 'vue'
  import { useRoute } from 'vue-router';
  import { useDocument } from '~/stores/document';
  const imageSrc = ref('');
  const route = useRoute();
  onMounted(async() => {
    imageSrc.value = route.query.file;
  });
  onScopeDispose(async() => {
    var fileName = imageSrc.value.split('/').pop();
    await useDocument().deleteFile(fileName);
  });
</script>
