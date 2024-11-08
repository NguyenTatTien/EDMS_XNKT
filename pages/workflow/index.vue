<template>
  <div class="h-full">
      <ProjectWorkflowTable/>
      
  </div>
</template>
<script setup>
  import { useObjectAssginUser } from '~/stores/objectAssginUser';
  import {ref,onMounted} from 'vue';
  import { useRoute } from 'vue-router';
  onMounted(async()=>{
     
  });
  
</script>