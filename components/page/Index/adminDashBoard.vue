<template>
    <div class="flex flex-wrap w-full justify-center">
      <div class="w-full">
          <div class="grid grid-cols-4 gap-6">
            <PageIndexDashItem :colorDask="'bg-[#326fd1]'" :colorLight="'bg-[#abc9fb]'">
              {{staticData.numberAll}}
              <template #Name>
                Toàn bộ 
              </template>
              <template #description>
                Tổng số tài liệu
              </template>
              <template #icon>
                <i class="pi pi-list" style="font-size: 1.5rem"></i>
              </template>
            </PageIndexDashItem>
            <PageIndexDashItem :colorDask="'bg-[#a47d06]'" :colorLight="'bg-[#f6de95]'">
              {{staticData.numberMoth}} 
              <template #Name>
                Tháng
              </template>
              <template #description>
                Số lượng tài liệu trong tháng
              </template>
              <template #icon>
                <i class="pi pi-calendar" style="font-size: 1.5rem"></i>
              </template>
            </PageIndexDashItem>
            <PageIndexDashItem :colorDask="'bg-[#a5326b]'" :colorLight="'bg-[#f7b0d3]'">
              {{staticData.numberDate}}
              <template #Name>
                Ngày
              </template>
              <template #description>
                Số tài liệu trong ngày
              </template>
              <template #icon>
                <i class="pi pi-calendar-clock" style="font-size: 1.5rem"></i>
              </template>
            </PageIndexDashItem>
            <PageIndexDashItem :colorDask="'bg-[#1da750]'" :colorLight="'bg-[#a0e6ba]'">
              {{staticData.numberUser}}
              <template #Name>
                Người dùng
              </template>
              <template #description>
                Số lượng người dùng
              </template>
              <template #icon>
                <i class="pi pi-user" style="font-size: 1.5rem"></i>
              </template>
            </PageIndexDashItem>
          </div>
          <div class="w-full mt-8">
            <div class="grid grid-cols-12 gap-3">
                <div class="col-span-9">
                    <div class="grid grid-cols-12 gap-3">
                      <PageIndexChart1 class="col-span-12 bg-white rounded-lg shadow-md"/>
                    </div>
                    <div class="grid grid-cols-12 gap-3">
                      <PageIndexChart3 class="col-span-12 bg-white rounded-lg shadow-md mt-3"/>
                    </div>
                    <div class="grid grid-cols-1 gap-3 mt-3">
                      <section name="gridUsers">
                          <PageIndexDocumentTable class="bg-white p-3 rounded-lg shadow-md" />
                      </section>
                    </div>
                </div>
                <div class="col-span-3">
                  <div class="grid grid-cols-1 gap-3">
                    <PageIndexTimeLine class="bg-white py-4 rounded-lg shadow-md"/>
                  </div>
                </div>
            </div>
          </div>
        </div>
        <loading v-model:active="isLoading"
        :is-full-page="true" color="#3B82F6" class="top-[50%]"/>
    </div>
  </template>
  <script setup>
  import { ref } from 'vue';
  import { useUser } from '~/stores/user';
  import { storeToRefs } from 'pinia';
  import DataTable from 'primevue/datatable';
  import Column from 'primevue/column';
  import ColumnGroup from 'primevue/columngroup';   // optional
  import Row from 'primevue/row';                   // optional
  import { useStatic }  from '~/stores/static';
  import Loading from 'vue-loading-overlay';
  const isLoading = ref(false);
  const { static : staticData } = storeToRefs(useStatic());
  const documents = ref([]);
  //await useStatic().initStatic();
  onMounted(async () => {
    isLoading.value = true;
    try{

      await useStatic().initStatic();
    }catch(e){
      console.log(e);
    }finally{ 
      isLoading.value = false;
    }
  })
  </script>
  
  <style>
  .p-breadcrumb {
    background: #ffffff;
    border: 0 none;
    border-radius: 6px;
    padding: 0.5rem !important;
  }
  </style>