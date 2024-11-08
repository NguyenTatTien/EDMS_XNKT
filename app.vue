<template>
   <n-notification-provider placement="bottom-right" :max="1"><NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</n-notification-provider>
</template>

<script setup>

import 'primevue/resources/themes/aura-light-blue/theme.css'
import 'primeicons/primeicons.css'

// const handleBeforeUnload = async(e) => {
//   await useUser().logOut();
//   e.preventDefault(); // Ngăn chặn hành động mặc định
//   e.returnValue = ''; 
// }

</script>
<style>
.layout-enter-active,
.layout-leave-active {
  transition: all 0.4s;
}
.layout-enter-from,
.layout-leave-to {
  /* filter: grayscale(1); */
  opacity: 0;
}
.page-enter-active,
.page-leave-active {
  transition: all 0.4s;
}
.page-enter-from,
.page-leave-to {
  opacity: 0;
  /* filter: blur(1rem); */
}
html,body, #__nuxt{
    height: 100%;
    margin: 0 !important;
    overflow: hidden;
    display: flex;
    width: 100%;
    position: absolute;
}
.vl-overlay[aria-label="Loading"]{
  position: absolute;

}
.custom-scrollbar ::-webkit-scrollbar {
    width: 0px;
    height: 0px; /* Adjust the width of the scrollbar */
}

.custom-scrollbar ::-webkit-scrollbar-track {
   display: none;
}
.custom-scrollbar ::-webkit-scrollbar-thumb {
    background-color: #00000040; /* Color of the scroll thumb */
    border-radius: 10px; /* Rounded edges of the scroll thumb */
}
</style>
