<template>
    <div class="w-full h-full justify-center items-center" id="divGrid">
          <DataTable paginator :rows="50" dataKey="id" scrollable filterDisplay="row" v-model:editingRows="editingRows" v-model:selection="selectedTypes" @row-edit-save="onRowEditSave"
          :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" :value="types" showGridlines stripedRows v-model:filters="filters" editMode="row" @filter="onFilter">
      <template #header>
          <div class="flex justify-end">
            
              <div class="flex justify-between items-center">
              <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="onCreateType()"/>
              
              <IconField iconPosition="left">
                  <InputIcon>
                      <i class="pi pi-search" />
                  </InputIcon>
                  <InputText placeholder="Keyword Search" class="py-[0.5rem] px-[0.75rem] pl-[2.5rem]" v-model="filters['global'].value" style="padding-left: 2rem !important"/>
              </IconField>
              </div>
          </div>
      </template>
      <template #empty> No found. </template>
      <template #loading> Loading data. Please wait. </template>
      <Column header="" style="width: 2rem">
       <template #body="{  data}">
          <i v-if="user.roleId==1" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="deleteType(data.id)"></i>
       </template>
   </Column>
   <Column :rowEditor="true" style="width: 1rem" bodyStyle="text-align:center">
          <template #roweditoriniticon>
              <i class="pi pi-file-edit cursor-pointer" style="color: #4471ef;"></i>
          </template>
    </Column>
      <Column field="name" header="Name" style="min-width: 12rem">
          <template #editor="{ data }">
              <InputText v-model="data.name" autofocus />
          </template>
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
          </template>
      </Column>
      <Column header="Description" field="description" style="min-width: 12rem">
          <template #editor="{ data }">
              <InputText v-model="data.description" autofocus />
          </template>
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template>
      </Column>
      <template #footer> <div class="w-full text-end">In total there are {{ countRows }} rows. </div></template>
  </DataTable>
  <Toast />
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
      import { useType } from '~/stores/type';
      import { FilterMatchMode } from 'primevue/api';
      import { ref, onMounted } from 'vue';
      import { useToast } from "primevue/usetoast";
      import Loading from 'vue-loading-overlay';
    import moment from 'moment';
    import {useUser} from '~/stores/user';
    import {Type} from '~/models/type';
    const user = useUser().getUser();
    const toast = useToast();
      const visibleDialog = ref(false);
      const selectedTypes = ref();
      const types = ref([]);
      const isLoading = ref(false);
      const countRows = ref(0);
      const editingRows = ref([]);
      const filters = ref({
          global: { value: null, matchMode: FilterMatchMode.CONTAINS },
          name: { value: null, matchMode: FilterMatchMode.CONTAINS },
          description: { value: null, matchMode: FilterMatchMode.CONTAINS },
      });
      onMounted(async()=>{
         await getListTypes();
      })
      const getListTypes = async () =>{
        isLoading.value = true;
          try{
            types.value = await useType().getAll();
          }catch(error){
              console.log("Error get list unit:"+error);
          }finally{
              isLoading.value = false;
          }
      }
const onRowEditSave = async (event) => {
        if(event.newData.id == 0){
        try{
            var data = await useType().create(event.newData);
            types.value = types.value.map(item => item.id == 0 ? data : item);
            toast.add({ severity: 'success', detail: 'Create successfully!', summary: 'Success', life: 5000 });
        }
        catch(error){
            toast.add({ severity: 'error', detail: 'Create fail!', summary: 'Error', life: 5000 });
        }
    }
    else{
        try{
            var data = await useType().update(event.newData);
            types.value[event.index] = data;
            toast.add({ severity: 'success', detail: 'Update successfully!', summary: 'Success', life: 5000 });
        }catch(error){
            toast.add({ severity: 'error', detail: 'Update fail!', summary: 'Error', life: 5000 });
            console.log(error);
        }
    }
  };
const deleteType = async (id) => {
    try{
        var st = confirm("Do you want to delete this type?");
        if (st) {
                await useType().delete(id);
                types.value = types.value.filter(item => item.id !== id);
                toast.add({ severity: 'success', detail: 'Delete successfully!', summary: 'Success', life: 5000 });
        }
    }catch(error){
          toast.add({ severity: 'error', detail: 'Delete fail!', summary: 'Error', life: 5000 });
          console.log(error);
    }
}
const onFilter = (value) => {
    countRows.value =  value.filteredValue.length;
}
const onCreateType = () => {
    types.value.push(new Type());
    editingRows.value = [types.value[types.value.length - 1]];
}
  </script>
<style>
   #importHeader{
    width: 40px !important;
    margin-right: 0.5rem;
 }
 #importHeader .p-fileupload-choose{
    width: 40px !important;
 }
 #importHeader .p-button-icon {
        margin-right: 0;
}
#importHeader .p-button-label{
    display: none;
}
</style>