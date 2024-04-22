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
                    <a-form>
                        <a-form-item label="Field A">
                            <a-input v-model:value="model.assetCode" placeholder="input placeholder" />
                        </a-form-item>
                        <a-form-item label="Field B">
                            <a-input v-model:value="model.comment" placeholder="input placeholder" />
                        </a-form-item>
                    </a-form>
                    <span @click="addDetail()">
                        add
                    </span>
                    <a-form>
                        <a-form-item label="Field A">
                            <a-input v-model:value="detailModel.partCode" placeholder="input placeholder" />
                        </a-form-item>
                        <a-form-item label="Field B">
                            <a-input v-model:value="detailModel.result" placeholder="input placeholder" />
                        </a-form-item>
                        <a-form-item label="Field B">
                            <a-input v-model:value="detailModel.statusCode" placeholder="input placeholder" />
                        </a-form-item>
                    </a-form>
                    <ul>
                       <li v-for="(item,index) in model.inspectionDetails" :key="index">
                           {{ item }}
                       </li> 
                    </ul>
                    <code>
                        {{ model }}
                    </code>
                </section>
                <section class="col-span-3">
                    <span class="cursor-pointer" @click="save()">
                        Save
                    </span>
                    {{ model.documents }}
                </section>
            </div>
        </div>
      </div>
    </div>
</template>
<script lang="ts" setup>
import { computed, reactive, ref, toRaw } from 'vue';
import Breadcrumb from 'primevue/breadcrumb';
import axios from 'axios';

const isLoading = ref(true)

const home = ref({
    icon: 'pi pi-home',
    route: '/'
});
const items = ref([
    { label: 'Tuần kiểm', route: '/eam/inspection' },
    { label: useRoute().params.id }
]);

const detailModel = ref({
    partCode: '',
    result: '',
    statusCode: 0,
    test: 0,
    inspectionId: 0
})

const model = ref(
    {
        "assetCode": "string",
        "comment": "string",
        "inspectionDetails": [
            {
                "partCode": "string",
                "result": "string",
                "statusCode": 0,
                "test": 0,
                "inspectionId": 0
            }
        ],
        "documents": [
            {
                "name": "string",
                "url": "string"
            }
        ]
    }
)

const addDetail = () => {
    model.value.inspectionDetails.push(detailModel.value)
}

const save = async () => { 
    let endpoint = "http://localhost:5010/api";
    let res = await axios.post(`${endpoint}/Inspection`, toRaw(model.value))
    model.value = res.data;
    useRouter().push({ path: '/eam/inspection' })
    return res;
}

</script>