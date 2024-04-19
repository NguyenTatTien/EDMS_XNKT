<template>
    <div class="flex flex-wrap w-full justify-center">
      <div class="container w-full">
        <div class="flex flex-wrap">
            <Breadcrumb class="mt-4" :home="home" :model="items">
                <template #item="{ item, props }">
                    <router-link v-if="item.route" v-slot="{ href, navigate }" :to="item.route" custom>
                        <a :href="href" v-bind="props.action" @click="navigate">
                            <span :class="[item.icon, 'text-color']" />
                            <span class="">{{ item.label }}</span>
                        </a>
                    </router-link>
                    <a v-else :href="item.url" :target="item.target" v-bind="props.action">
                        <span class="text-color">{{ item.label }}</span>
                    </a>
                </template>
            </Breadcrumb>
            <div class="w-full grid grid-cols-12 gap-3">
                <section class="col-span-9">
                    <Skeleton v-if="isLoading" class="mb-2"></Skeleton>
                    <div v-else>
                        {{ model }}
                    </div>
                </section>
                <section class="col-span-3">
                    <Skeleton v-if="isLoading" class="mb-2"></Skeleton>
                    <div v-else>
                        a
                    </div>
                </section>
            </div>
        </div>
      </div>
    </div>
</template>

<script setup>
import { useRoute } from 'vue-router'
import Breadcrumb from 'primevue/breadcrumb';
import axios from 'axios';

const model = ref({})
const isLoading = ref(true)

const home = ref({
    icon: 'pi pi-home',
    route: '/'
});
const items = ref([
    { label: 'Tuần kiểm', route: '/eam/inspection' },
    { label: useRoute().params.id }
]);

onMounted(async () => {
    isLoading.value = true
    model.value = await getByID(useRoute().params.id)
    isLoading.value = false
})

const getByID = async(id) => {
    let endpoint = "http://localhost:5010/api";
    let res = await axios.get(`${endpoint}/Inspection/${id}`, {
    
    })
    return res;
}
</script>