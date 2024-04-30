<template>
    <div class="card flex">
        <Sidebar v-model:visible="visible">
            <template #container="{ closeCallback }">
                <div class="flex flex-col h-full">
                    <div class="flex items-center justify-between px-4 pt-3 shrink-0">
                        <span class="inline-flex items-center gap-2">
                            <img src="../../assets/Images/THEA_Logo_vn_Backup.png" alt="logo" height="100" class="mr-2" />
                           
                        </span>
                        <span>
                            <Button type="button" @click="closeCallback" icon="pi pi-times" rounded outlined class="h-2rem w-2rem"></Button>
                        </span>
                    </div>
                    <div class="overflow-y-auto">
                        <PanelMenu :model="items" class="w-full md:w-20rem mt-10">
                        <template #item="{ item }">
                            <a v-if="item.items" v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparent" :href="item.url" :target="item.target">
                                <i :class="item.icon"/>
                                <span class="ml-2 text-black text-base">{{ item.label }}</span>
                                <span v-if="item.items" class="pi pi-angle-down text-black ml-auto " />
                            </a>
                            <a v-else v-ripple class="flex items-center cursor-pointer px-3 py-2 bg-transparent" :href="item.url" :target="item.target" @click="changePage(item.label)">
                                <i :class="item.icon"/>
                                <span class="ml-2 text-black text-base">{{ item.label }}</span>
                            </a>
                        </template>
                    </PanelMenu>
                    </div>
                    <div class="mt-auto">
                        <hr class="mb-3 mx-3 border-top-1 border surface-border" />
                        <a v-ripple class="m-3 flex items-center cursor-pointer p-3 gap-2 rounded text-700 hover:surface-100 transition-duration-150 transition-colors p-ripple">
                            <Avatar image="https://primefaces.org/cdn/primevue/images/avatar/amyelsner.png" shape="circle" />
                            <span class="font-bold">Amy Elsner</span>
                        </a>
                    </div>
                </div>
            </template>
        </Sidebar>
        <Button icon="pi pi-bars" class="p-button-rounded p-button-text" @click="visible = true" />
    </div>
</template>

<script setup>
import { ref } from "vue";

const visible = ref(false);
const items = ref([
    {
        label: 'Dashboard',
        icon:"pi pi-home",
        items: null,
    },
    {
        label: 'Document Library',
        icon:"pi pi-bookmark",
        items: null,
    },
    {
        label: 'Documents',
        icon:'pi pi-folder',
        items: [
            {
                label: 'O&M Documents',
                icon:'pi pi-file',
                items: null
            },
            {
                label: 'Design Documents',
                icon:'pi pi-file',
                items: null
            },
            {
                label: 'Vendor Documents',
                icon:'pi pi-file',
                items: null
            }
        ]
    },
    {
        label: 'Tabs',
        icon:'pi pi-wrench',
        items: null,
  },
    {
        label: 'System',
        icon:'pi pi-microchip',
        items: [
           
            {
                label: 'Models',
                icon:'pi pi-tag',
                items: null,
            },
            {
                label: 'Manufacturers',
                icon:'pi pi-truck',
                items: null,
            },
            {
                label: 'Users',
                icon:'pi pi-user',
                items: null,
            },
            {
                label: 'Groups',
                icon:'pi pi-users',
                items: null,
            },
        ],
      
    },
    {
        label: 'Projects',
        icon:'pi pi-calendar',
        items: null,
  },
   
]);
const changePage = (label) => {
    if(label.includes('Design Documents')) {
       navigateTo('/documents/design');
    }
    else if(label.includes('Vendor Documents')) {
       navigateTo('/documents/vendor');
    }
    else if(label.includes('O&M Documents')) {
       navigateTo('/documents/om');
    }
    else if(label.includes('Document Library')) {
       navigateTo('/document_library');
    }
    else{
        navigateTo('/'+label);
    }
}
</script>
<style>
.p-panelmenu-panel{
    border: none !important;
}

</style>