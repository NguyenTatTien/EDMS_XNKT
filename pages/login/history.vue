<template>
    <div class="w-full h-full justify-center items-center" id="divGrid">
          <DataTable paginator :rows="50" dataKey="id" scrollable filterDisplay="menu" v-model:selection="selectedCategory"
          :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" :value="loginHistorys" showGridlines stripedRows v-model:filters="filters" editMode="cell">
     
      <template #empty> No found. </template>
      <template #loading> Loading data. Please wait. </template>
      <Column header="" style="width: 2rem">
        <template #body="{ data }">
           <i class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="deleteCategories(data.id)"></i>
        </template>
    </Column>
      <Column field="userName" header="User Name" style="min-width: 8rem">
        
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
          </template>
      </Column>
      <Column header="Full Name" field="fullName" style="min-width: 12  rem">
         
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template>
      </Column>
      <Column header="User Login Server Time" field="serverTime" style="min-width: 10rem">
         <template #body="{ data }">
             <span>{{ moment(data.serverTime).format('DD-MM-YYYY HH:mm:ss') }}</span>
            </template>
         <template #filter="{ filterModel, filterCallback }">
             <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
         </template>
     </Column>
     <Column header="User Login Local Time" field="localTime" style="min-width: 10rem">
        <template #body="{ data }">
             <span>{{ moment(data.localTime).format('DD-MM-YYYY HH:mm:ss') }}</span>
            </template>
         <template #filter="{ filterModel, filterCallback }">
             <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
         </template>
     </Column>
     <Column header="User Login Local Time Zone" field="localTimeZone" style="min-width: 10rem">
        <template #body="{ data }">
             <span>{{ moment(data.localTime).format('DD-MM-YYYY HH:mm:ss') }}</span>
            </template>
         <template #filter="{ filterModel, filterCallback }">
             <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
         </template>
     </Column>
     <Column header="User Logout Local Time" field="logoutLocalTime" style="min-width: 10rem">
        <template #body="{ data }">
             <span>{{ moment(data.localTime).format('DD-MM-YYYY HH:mm:ss') }}</span>
            </template>
         <template #filter="{ filterModel, filterCallback }">
             <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
         </template>
     </Column>
     <Column header="User Login Duration" field="durationTimeLogin" style="min-width: 10rem">
        <template #body="{ data }">
             <span>{{ moment(data.localTime).format('DD-MM-YYYY HH:mm:ss') }}</span>
            </template>
         <template #filter="{ filterModel, filterCallback }">
             <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
         </template>
     </Column>
     <Column header="IP V4 Appdress" field="ipAddress" style="min-width: 10rem">
        <template #body="{ data }">
             <span>{{ data.ipAddress != null ? data.ipAddress.replace(/::1,|::1/g, ""):"" }}</span>
            </template>
         <template #filter="{ filterModel, filterCallback }">
             <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
         </template>
     </Column>
     <Column header="Window Host Name" field="windownDomainUser" style="min-width: 10rem">
        <template #body="{ data }">
             <span>{{ data.windownDomainUser !=null ?data.windownDomainUser.replace(/::1,|::1/g, ""):"" }}</span>
            </template>
       <template #filter="{ filterModel, filterCallback }">
           <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
       </template>
   </Column>
   <Column header="Browser" field="browser" style="min-width: 10rem">
       <template #filter="{ filterModel, filterCallback }">
           <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
       </template>
   </Column>
      </DataTable>
     
      <loading v-model:active="isLoading"
                    :is-full-page="true" color="#3B82F6"/>
      </div>
      </template>
      <script setup>
      definePageMeta({
      layout: 'default'
      })
      import '../../assets/CSS/grid.css'
      import '../../assets/CSS/styleMain.css'
      import { useUserLoginHistory } from '~/stores/userLoginHistory';
      import { FilterMatchMode } from 'primevue/api';
      import { ref, onMounted } from 'vue';
      import { useToast } from "primevue/usetoast";
    import moment from 'moment';
    import Loading from 'vue-loading-overlay';
    const isLoading = ref(false);
      const selectedCategory = ref();
      const loginHistorys = ref(null);
      const filters = ref({
          global: { value: null, matchMode: FilterMatchMode.CONTAINS },
          name: { value: null, matchMode: FilterMatchMode.CONTAINS },
          description: { value: null, matchMode: FilterMatchMode.CONTAINS },
      });
      onMounted(async ()=>{
          getListHistory();
      })
      const getListHistory = async () =>{
       isLoading.value = true;
          try{
            loginHistorys.value = await useUserLoginHistory().getAll();
          }catch(error){
              console.log("Error get list group:"+error);
          }
          finally{
              isLoading.value = false;
          }
      }
    
     
      </script>
      <style>
      #importCategories {
       width: 40px !important;
       margin-right: 0.5rem;
    }
    #importCategories .p-fileupload-choose{
       width: 40px !important;
    }
    #importCategories .p-button-icon {
           margin-right: 0;
   }
   #importCategories .p-button-label{
       display: none;
   }
   .p-fileupload{
       width: 40px !important;
   }
      </style>