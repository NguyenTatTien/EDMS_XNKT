<template>
    <div class="h-screen background-1 w-full flex items-center justify-center">
        <section class="bg-white rounded-lg shadow-md p-4 w-[400px]">
            <img v-shared-element:img1 class="rounded-lg shadow-md h-48" src="https://upload.wikimedia.org/wikipedia/vi/e/e9/Logo_VIETSOVPETRO.png" />
            <h1 class="text-2xl font-bold">Login</h1>
            <NuxtLink to="/">Login</NuxtLink>
        </section>
    </div>
</template>

<script setup>
//use blank layout
definePageMeta({
  layout: 'blank'
})
</script>

<style>
body {
    padding: 0;
    margin: 0;
}
.background-1 {
    background-image: url('https://www.vietsov.com.vn/_catalogs/masterpage/vietsov/assets/images/intro/bh.jpg');
    background-size: cover;
    background-repeat: no-repeat;
}
</style>