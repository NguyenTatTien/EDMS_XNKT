<template>
    <div class="w-full h-full">
        <iframe :src="src" class="w-full h-full" id="framview"/>
        <loading v-model:active="isLoading"
        :is-full-page="true" color="#10b981"/>
    </div>
</template>
<script setup>
import { ref,onMounted,onDeactivated } from 'vue'
  import { useRoute } from 'vue-router';
  import { useDocument } from '~/stores/document';
  import { useTypeFile } from '~/stores/typeFile';
  import { storeToRefs } from 'pinia';
  import Loading from 'vue-loading-overlay';
  const isLoading = ref(false);
  const {office} = storeToRefs(useTypeFile());
  const {image} = storeToRefs(useTypeFile());
  const {video} = storeToRefs(useTypeFile());
    const emit = defineEmits(['Id','update:modelValue']);
    const props = defineProps(['Id']);
  const src = ref('');
  const route = useRoute();
  onMounted(async() => {
    if(props.Id){ 
      isLoading.value = true;
      var data = await useDocument().ViewFile(props.Id);
      src.value = encodeURI(data);
      var typefile = src.value.split('.').pop();
      if(!office.value.includes(typefile) && !image.value.includes(typefile) && !video.value.includes(typefile) && typefile != "html"){
        window.open(src.value, '_blank');
        emit('update:modelValue',false);
      }
      isLoading.value = false;
    }
  });
</script>
<style>
img{
    max-width: 600px !important;
}
</style>
