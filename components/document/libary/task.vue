<template>
    <div class="w-full h-full justify-center items-center flex-wrap" id="divGrid">
       <ProjectTb v-model="projects" :attachDocuments="attachDocuments" :documentID="props.document.id"></ProjectTb>
    
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
      import { useTask } from '~/stores/task';
      import { useProject } from '~/stores/project';
      import { FilterMatchMode } from 'primevue/api';
      import { ref, onMounted } from 'vue';
      import { useToast } from "primevue/usetoast";
      import { useAttachDocument } from '~/stores/attachDocument';
      import { storeToRefs } from 'pinia';
    import moment from 'moment';
    import Loading from 'vue-loading-overlay';
    import {useUser} from '~/stores/user';
    const emit = defineEmits(['update:modelValue','document']);
    const props = defineProps(['document']);
    const document = ref(props.document);
    const user = useUser().getUser();
    const isLoading = ref(false);
    const toast = useToast();
      const visibleDialog = ref(false);
      const selectedNotAttached = ref();
      const selectedAttached = ref();
      const projects = ref([]);
      const attachDocuments = ref([]);
      const filters = ref({
          global: { value: null, matchMode: FilterMatchMode.CONTAINS },
          name: { value: null, matchMode: FilterMatchMode.CONTAINS },
          projectName: { value: null, matchMode: FilterMatchMode.CONTAINS },
      });
      onMounted(async ()=>{
        isLoading.value = true;
        try{
            await getListTask();
            await getListAttachDocuments();
        }
        catch(error){
            console.log("Error get list group:"+error);
        }
        finally{
          isLoading.value = false;
        }
      });
      const getListTask = async () =>{
          try{
            projects.value = await useProject().getAllTask();
          }catch(error){
              console.log("Error get list group:"+error);
          }
      }
      const getListAttachDocuments = async () =>{
          try{
            attachDocuments.value = await useAttachDocument().getByDocument(props.document.id);
          }catch(error){
              console.log("Error get list group:"+error);
          }
      }
      const onFilter_1 = async (value) => {
        countRows_1.value =  value.filteredValue.length;
        }
    const onFilter_2 = async (value) => {
            countRows_2.value =  value.filteredValue.length;
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
</style>
