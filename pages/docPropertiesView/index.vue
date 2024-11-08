<template>
    <div>
        <div class="flex flex-wrap">
        <dl class="accordion w-full">
            <dt style="width: 100%;">
                <span>Config document properties view</span>
            </dt>
        </dl>
        <div class="w-full flex justify-left items-center mb-2">
            <span class="w-[200px] text-right mr-2">Categories</span>
            <Dropdown v-model="selectedCategory" :options="categories" filter optionLabel="name" placeholder="Select a category" class="w-[400px] md:w-20rem" @change="onselect"></Dropdown>
        </div>
        <div class="w-full flex justify-left items-center mb-2">
            <span class="w-[200px] text-right mr-2">Document properties</span>
            <MultiSelect v-model="selectProperties" :options="docType" filter optionLabel="name" placeholder="Select properties"
            :maxSelectedLabels="3" class="w-[400px] md:w-20rem" @change="changePropreties"/>
        </div>
        </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import { useCategories } from '~/stores/categories';
import { useDocPropertiesView } from '~/stores/docPropertiesView';
const selectProperties = ref([]);
const selectedCategory = ref();
const categories = ref([]);
const objProperties = ref(null);
const docType = ref([
    {
        id:1,
        name: 'Doc Number',
    },

    {
        id:2,
        name: 'Title',
    },
    {
        id:3,
        name: 'Revision',
    },
    {
        id:4,
        name: 'Date',
    },
    {
        id:5,
        name: 'From/To',
    },
    {
        id:6,
        name: 'Discipline',
    },
    {
        id:7,
        name: 'Document Type',
    },
    {
        id:8,
        name: 'Platform',
    },
    {
        id:9,
        name: 'Remark',
    },
    {
        id:10,
        name: 'Contractor',
    },
    {
        id:11,
        name: 'Tag',
    },
    {
        id:12,
        name: 'CreatedByName',
    },
]);
onMounted( async()=>{
    await loadAllCategories();
    
});
const loadAllCategories = async () => {
    categories.value = await useCategories().getAll();
    if(categories.value.length > 0){
        selectedCategory.value = categories.value[0];
        loadPropertiesByCategory();
    }
};
const loadPropertiesByCategory = async () => {
    objProperties.value = await useDocPropertiesView().getDocPropertiesByCategory(selectedCategory.value.id);
    selectProperties.value = [];
    if(objProperties.value != null){
       var properties = objProperties.value.propertyIndex.split(',');
       properties.forEach(element => {
        if(element.trim() != "" && element != null && element != undefined){
            selectProperties.value.push(docType.value.filter(x => x.id == parseInt(element))[0]);  
        }
       });
    }
};
const onselect = async () => {
    await loadPropertiesByCategory();
};
const changePropreties = async () => {
    var properties = "";
    selectProperties.value.forEach(element => {
        properties += element.id + ",";
    });
    objProperties.value.propertyIndex = properties;
    await useDocPropertiesView().update(objProperties.value);
};
</script>
<style>
.accordion dt span {
    color: #085B8F;
    border-bottom: 2px solid #46A3D3;
    font-size: 1.5em;
    font-weight: bold;
    letter-spacing: -0.03em;
    line-height: 1.2;
    margin: 0.5em auto 0.6em;
    padding: 0;
    text-align: left;
    text-decoration: none;
    display: block;
}
</style>