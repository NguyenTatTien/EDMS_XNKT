<template>
    <div class="h-screen background-1 w-full flex items-center justify-center">
        <section class="bg-white rounded-lg shadow-md p-3 w-[300px] flex flex-wrap justify-center">
            <img v-shared-element:img1 class="rounded-lg shadow-md h-48" src="https://upload.wikimedia.org/wikipedia/vi/e/e9/Logo_VIETSOVPETRO.png" />
            <form action="">
                      <div class="w-full mt-1 text-center">
                          <InputText id="txtUsername" type="text" placeholder="Username" v-model="model.username" class="my-2 border border-gray-300  p-2"/>
                        </div>
                        <div class="w-full mt-1 text-center">
                          <InputText id="txtPassword" type="password" placeholder="Password" v-model="model.password" class="my-2 border border-gray-300 p-2" />       
                        </div>
                        <div class="w-full mt-1 text-center">
                          <Button type="button" @click="login" class="btnLogin w-64 p-1" label="Login"/>
                        </div>
                    </form>
        </section>
    </div>
</template>

<script setup>
//use blank layout
definePageMeta({
  layout: 'blank'
})
const model = ref({
    username: "admin",
    password: "123456"
})
const login = () => {
    navigateTo('/document_library');
}
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