<template>
    <div class="w-full h-full">
        <iframe :src="src" class="w-full h-full" id="framview"/>
        <Toast />
    </div>
</template>
<script setup>
  definePageMeta({
  layout: 'blank'
})
import { ref,onMounted,onDeactivated } from 'vue'
  import { useRoute } from 'vue-router';
  import { useDocument } from '~/stores/document';
  import {useUser} from '~/stores/user';
  import { useTypeFile } from '~/stores/typeFile';
  import { storeToRefs } from 'pinia';
  import { useToast } from "primevue/usetoast";
const Id = ref('');
  const src = ref('');
  const route = useRoute();
  const toast = useToast();
  onMounted(async() => {
   try{
    await LoginUser();
    Id.value = route.query.Id;
    if(Id.value){ 
      try{
        var data = await useDocument().ViewFile(Id.value);
        src.value = data;
    }catch(error){
      if(error.response.status == 404){
        toast.add({ severity: 'error', summary: 'Error Message', detail: 'File not found!', life: 5000 });
      }
    
      console.log(error);
    }
    //   if(office.value.includes(typefile)){
    //     window.open(src.value, '_blank');
    //     emit('update:modelValue',false);
    //   }
    }
    await useUser().clearUser();
   }catch(error){
     console.log(error);
     await useUser().clearUser();
   }
  });
  const LoginUser = async() =>{
  try{
    var user = await useUser().loginUserAdmin();
    useUser().setUser(user);
  }catch(error){
    console.log(error);
  }
}
</script>
