<template>
    <div class="w-full h-full">
        <iframe :src="src" class="w-full h-full" id="framview"/>
    </div>
</template>
<script setup>
import { ref,onMounted,onDeactivated } from 'vue'
  import { useRoute } from 'vue-router';
  import { useDocument } from '~/stores/document';
  import { useTypeFile } from '~/stores/typeFile';
  import { storeToRefs } from 'pinia';
const Id = ref('');
  const src = ref('');
  const route = useRoute();

  onMounted(async() => {
    Id.value = route.query.Id;
    if(Id.value){ 
      var data = await useDocument().ViewFile(Id.value);
      src.value = data;
    //   if(office.value.includes(typefile)){
    //     window.open(src.value, '_blank');
    //     emit('update:modelValue',false);
    //   }
    }
  });
</script>
