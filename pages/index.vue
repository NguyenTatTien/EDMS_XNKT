<template>
  <div>
    <h1>Home page</h1>
    <NuxtLink to="/about">About page</NuxtLink>
    <NuxtLink to="/news">new pages</NuxtLink>
  </div>
</template>


<script setup>
import { ref } from 'vue';
const item = ref({})
item.value = "1"
</script>