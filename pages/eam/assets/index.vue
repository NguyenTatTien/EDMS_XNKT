<template>
    <div class="flex flex-wrap w-full justify-center">
      <div class="container w-full">
        <EamFilter></EamFilter>
        <EamSection1></EamSection1>
        <EamTable class="rounded-lg shadow-md mt-4" v-model="model"></EamTable>
      </div>
    </div>
  </template>
  
  
<script setup>
import { ref } from 'vue';
import axios from 'axios';
import Button from 'primevue/button';
const item = ref({})
item.value = "1"
const model = ref({})
//onMounted
onMounted(() => {
    init();
})

const init = async(page=1,pageSize=10,search="") => {
    let endpoint = "http://localhost:5010/api";
    let res = await axios.get(`${endpoint}/asset?page=${page}&pageSize=${pageSize}&search=${search}`, {
        
    })
    console.log(res.data)
    model.value = res.data;
}


</script>