<template>
    <div class="flex flex-wrap w-full justify-center items-center px-2" id="divGrid">
        <DataTable paginator :rows="50" dataKey="id" scrollable filterDisplay="row" id="tbTags"
         :globalFilterFields="['name', 'description','assetCode','plantName','systemName']" class="text-xs h-[100%]" stripedRows v-model:filters="filters" editMode="cell" :value="mailHistorys">
            <template #header>
                <div class="flex justify-end">
                    <div>
                    </div>
                </div>
            </template>
            <template #empty> No found. </template>
            <template #loading> Loading data. Please wait. </template>
            <Column field="subject" header="Subject" :style="{width: '300px'}">
                <template #body="{data}">
                    <div @click="openMail(data)" class="cursor-pointer">{{ data.subject }}</div>
                </template>
                <template #filter="{ filterModel, filterCallback }">
                    <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
                </template>
            </Column>
            <Column field="sendTo" header="Send To" :style="{width: '150px'}">
                <template #filter="{ filterModel, filterCallback }">
                    <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
                </template>
            </Column>
            <Column field="sendCC" header="Send CC" :style="{width: '80px'}">
                <template #filter="{ filterModel, filterCallback }">
                <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search..." />
                </template>
            </Column>
            <Column field="sendDate" header="Send Date" :style="{width: '150px'}">
                    <template #body="{data}">
                        {{data.sendDate !=null? format(data.sendDate, 'dd/MM/yyyy') :""}}
                    </template>
                    <template #filter="{ filterModel, filterCallback }">
                        <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
                    </template>
            </Column>
            <template #footer><div class="w-full text-end">In total there are rows.</div></template>
        </DataTable>
    <n-drawer v-model:show="active" :width="1000">
        <n-drawer-content v-if="selectedMail != null" :title="selectedMail.subject" closable>
            <div v-html="selectedMail.body"></div>
        </n-drawer-content>
    </n-drawer>
     </div>
</template>
<script setup>
    //setlayout to system
     definePageMeta({
     layout: 'default'
     })
     import '../../assets/CSS/grid.css';
     import '../../assets/CSS/styleMain.css';
     import '../../assets/css/sidebar.css';
     import {FilterMatchMode} from 'primevue/api';
     import { format, parse,formatISO   } from 'date-fns';
     import { ref, onMounted } from 'vue';
     import { useMailHistory } from '~/stores/mailHistory.ts';
     const isLoading = ref(false);
     const mailHistorys = ref([]);
     const selectedMail = ref(null);
     const active = ref(false);
     const filters = ref({
     global: { value: null, matchMode: FilterMatchMode.CONTAINS },
     subject: { value: null, matchMode: FilterMatchMode.CONTAINS },
     sendTo: { value: null, matchMode: FilterMatchMode.CONTAINS },
     sendCC: { value: null, matchMode: FilterMatchMode.CONTAINS },
     sendDate: { value: null, matchMode: FilterMatchMode.EQUALS },
 });
     onMounted(async ()=>{
        isLoading.value = true;
         try{
            mailHistorys.value = await useMailHistory().getByUser();
         }catch(error){
            console.log("Error get list manufacturer:"+error);
         }finally{
            isLoading.value = false;
         }
     });
    const openMail = (data) => {
        selectedMail.value = data;
       active.value = true;
    }
    </script>
    <style>
     .p-dialog-content{
        height: 100%;
     }
     .p-icon-field{
        height: fit-content;
     }
     #tbTabs{
        width: 100%;
        flex: 1 1 auto;
     }
     #importTag {
        width: 40px !important;
        margin-right: 0.5rem;
     }
     #importTag .p-fileupload-choose{
        width: 40px !important;
     }
     #importTag .p-button-icon {
            margin-right: 0;
    }
    #importTag .p-button-label{
        display: none;
    }
    #tbTags{
        width: 0 !important;
        flex: 1 1 0% !important;
    
    }
    .p-fileupload{
        width: 40px !important;
    }
</style>
    