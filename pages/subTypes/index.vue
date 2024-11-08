<template>
    <div class="w-full h-full justify-center items-center" id="divGrid">
          <DataTable paginator :rows="50" dataKey="id" scrollable filterDisplay="row" v-model:selection="selectedDocumentType" @cell-edit-complete="onCellEditComplete"
          :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" :value="documentTypes" showGridlines stripedRows v-model:filters="filters" editMode="cell" @filter="onFilter">
      <template #header>
          <div class="flex justify-end">
              <div class="flex justify-between items-center">
            <Button icon="pi pi-plus" class="mr-2 h-[2rem]" @click="visibleDialog = true"/>
            <Button icon="pi pi-cloud-download" class="mr-2 h-[2rem]" @click="exportDocumentTypes"/>
            <FileUpload mode="basic" name="demo[]" url="/api/upload" accept=".xls,.xlsx" :maxFileSize="1000000" chooseLabel=' ' chooseIcon="pi pi-cloud-upload" uploadIcon="pi pi-cloud-upload" class="mr-2 h-[2rem] flex justify-center" id="importHeader" @select="importDocumentTypes"/>
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
        <template #body="{ data }">
           <i v-if="user.roleId == 1" class="pi pi-times cursor-pointer" style="color: #EF4444;" @click="deleteDocumentType(data.id)"></i>
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
      <Column header="Document Type" field="parentId" style="min-width: 12rem">
    <template #body="{ data }">
            <div>{{ data.parentName }}</div>
    </template>
     <template #editor="{ data }">
        <Dropdown v-model="data.parentId" editable :options="docTypeNotParents" optionLabel="name" optionValue="id" placeholder="Select document type" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
     <template #filter="{ filterModel, filterCallback }">
        <Dropdown v-model="filterModel.value" editable :showClear="true" :options="docTypeNotParents" @change="filterCallback()" optionLabel="name" optionValue="id" placeholder="Select document type" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
 </Column>
 <!-- <Column header="Manufacturer" field="refId" style="min-width: 12rem">
    <template #body="{ data }">
            <div>{{ data.refName }}</div>
    </template>
     <template #editor="{ data }">
        <Dropdown v-model="data.refId" editable :options="manufacturers" optionLabel="name" optionValue="id" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
     <template #filter="{ filterModel, filterCallback }">
        <Dropdown v-model="filterModel.value" editable :showClear="true" :options="manufacturers" @change="filterCallback()" optionLabel="name" optionValue="id" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[250px]" />
     </template>
 </Column> -->
 <template #footer> <div class="w-full text-end">In total there are {{ countRows }} rows. </div></template>
      </DataTable>
      <Dialog v-model:visible="visibleDialog" modal header="Create Sub Type" :style="{ width: '30rem' }">
      <SubTypeCreate v-model="visibleDialog" :documentTypes="documentTypes" :docTypeNotParents="docTypeNotParents" :manufacturers="manufacturers"/>
      </Dialog>
      <Toast />
      <!-- <div class="bg-[#3B82F6] text-[#ffffff] w-full h-[20px] flex items-center font-bold text-[17px] bottom-0 right-0 absolute p-5">
        <div class="w-full text-right">Total Row: {{ documentTypes.length }}</div>
    </div> -->
      <loading v-model:active="isLoading"
                 :is-full-page="true" color="#10b981"/>
      </div>
      </template>
      <script setup>
      definePageMeta({
      layout: 'default'
      })
      import '../../assets/CSS/grid.css'
      import '../../assets/CSS/styleMain.css'
      import { useDocumentType } from '~/stores/documentType';
      import {useManufacturer} from '~/stores/manufacturer';
      import { FilterMatchMode } from 'primevue/api';
      import { ref, onMounted } from 'vue';
      import { useToast } from "primevue/usetoast";
        import moment from 'moment';
        import Loading from 'vue-loading-overlay';
        import {useUser} from '~/stores/user';
        const user = useUser().getUser();
        const isLoading = ref(false);
        const toast = useToast();
      const visibleDialog = ref(false);
      const selectedDocumentType = ref();
      const documentTypes = ref([]);
      const docTypeNotParents = ref(null);
      const manufacturers = ref(null);
      const countRows = ref(0);
      const filters = ref({
          global: { value: null, matchMode: FilterMatchMode.CONTAINS },
          name: { value: null, matchMode: FilterMatchMode.CONTAINS },
          description: { value: null, matchMode: FilterMatchMode.CONTAINS },
          parentId: { value: null, matchMode: FilterMatchMode.CONTAINS },
          //refId: { value: null, matchMode: FilterMatchMode.CONTAINS },
      });
      onMounted(async ()=>{
           try{
               await getListDocTypeNotParent();
              //  getListmanufacturers();
               await getListDocumentTypes();
           }catch(error){
               console.log("Error get list:"+error);
           }finally{
               isLoading.value = false;
           }
      })
      const getListDocumentTypes = async () =>{
          try{
            documentTypes.value = await useDocumentType().getAllParent();
            documentTypes.value = documentTypes.value.filter(x => x.refId == null);
          }catch(error){
              console.log("Error get list:"+error);
          }
      }
      const getListDocTypeNotParent = async () =>{
          try{
            docTypeNotParents.value = await useDocumentType().getDocumentTypeNotParent();
            docTypeNotParents.value = docTypeNotParents.value.filter(x => x.isVendorDocument == false);
          }catch(error){
              console.log("Error get list:"+error);
          }
      }
    //   const getListmanufacturers = async () =>{
    //       try{
    //         manufacturers.value = await useManufacturer().getAll();
    //       }catch(error){
    //           console.log("Error get list:"+error);
    //       }
    //   }
      const onCellEditComplete = async (event) => {
      let { data, newValue, field,newData } = event;
      switch (field) {
        case "parentId":
            var parent = docTypeNotParents.value.filter(x => x.id == newValue)[0];
            data.parentId = parent.id;
            data.parentName = parent.name;
         break;
      
          default:
              if (newValue != null && newValue.trim().length > 0) data[field] = newValue;
              break;
      }
      await useDocumentType().update(data);
      };
      const deleteDocumentType = async (id) => {
            try{
                var st = confirm("Do you want to delete this document type?");
                    if (st) {
                        await useDocumentType().delete(id);
                        documentTypes.value = documentTypes.value.filter(item => item.id !== id);
                    }
            }catch(error){
                console.log(error);
            }
      }
      const exportDocumentTypes = async() => {
    var response = await useDocumentType().export();
    const link = document.createElement('a');
    link.href = response;
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
   }
   const importDocumentTypes =async (e) => {
        isLoading.value = true;
        try{
            var file = e.files[0];
        var fromData = new FormData();
        fromData.append("formFile",file);
        await useDocumentType().import(fromData);
        await getListDocumentTypes();
        toast.add({ severity: 'success', detail: 'Import successfully!', summary: 'Success', life: 5000 });
        }catch(error){
            console.log(error);
        }finally{
            isLoading.value = false;
        }
   }
   const onFilter = (value) => {
        countRows.value = value.filteredValue.length;
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