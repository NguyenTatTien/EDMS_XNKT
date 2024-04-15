<script setup>
definePageMeta({
  layout: 'blank'
})
</script>

<template>
  <div>
    <h1>About page</h1>
    <NuxtLink to="/">Home page</NuxtLink>
    <img v-shared-element:img1 class="rounded-lg h-16 shadow-md" src="https://upload.wikimedia.org/wikipedia/vi/e/e9/Logo_VIETSOVPETRO.png" />
  </div>
</template>
