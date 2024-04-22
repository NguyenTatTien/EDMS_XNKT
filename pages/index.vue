<template>
  <div class="flex flex-wrap w-full justify-center">
    <div class="container w-full">
      <DashboardMainFilter></DashboardMainFilter>
      <DashboardMainSection1></DashboardMainSection1>
      <DashboardMainSection2></DashboardMainSection2>
    </div>
  </div>
</template>


<script setup>
import { ref } from 'vue';
import Button from 'primevue/button';
const item = ref({})
item.value = "1"
</script>

<style>
.p-breadcrumb {
  background: #ffffff;
  border: 0 none;
  border-radius: 6px;
  padding: 0.5rem !important;
}
</style>