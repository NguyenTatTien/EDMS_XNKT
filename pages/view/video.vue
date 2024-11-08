<template>
    <div class="text-center w-full h-full">
        <!-- <video-player
              :src="videoSrc"
            controls
            :loop="true"
            :volume="0.6"
        class="w-full h-full"/> -->
        <iframe :src="videoSrc" class="w-full h-full" id="framview"/>
    </div>
</template>

<script setup>
    definePageMeta({
     layout: 'blank'
  });
import { ref,onMounted,onActivated } from 'vue'
  import { useRoute } from 'vue-router';
  import { useDocument } from '~/stores/document';

  const route = useRoute();
  const videoSrc = ref('');
  onMounted(async() => {
    videoSrc.value = route.query.file;
  });
  onActivated(async() => {
    var fileName = videoSrc.value.split('/').pop();
    await useDocument().deleteFile(fileName);
  });
</script>