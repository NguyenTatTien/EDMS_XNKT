<template>
    <div>
        <div class="flex justify-between flex-col gap-2">
            <n-input v-model:value="value" type="text" placeholder="Workflow Name" />
            <div class="flex gap-2 justify-center">
                <n-button strong secondary>
                    <template #icon>
                        <i class="pi pi-times-circle"></i>
                    </template>
                    Cancel
                </n-button>
                <n-button strong secondary type="info" @click="saveChange">
                    <template #icon>
                        <i class="pi pi-save"></i>
                    </template>
                    Save
                </n-button>
            </div>
        </div>
        <Toast />
        <loading v-model:active="isLoading"
      :is-full-page="true" color="#3B82F6"/>
    </div>
</template>
<script setup>
import { ref,onMounted,watch} from 'vue';
import { useWorkflow } from '~/stores/workflow';
import {Workflow} from '~/models/workflow';
import Loading from 'vue-loading-overlay';
const emit = defineEmits(['update:modelValue','updateStatus','selectNewWorfklow']);
import { useToast } from "primevue/usetoast";
import { ta } from 'date-fns/locale';
const props = defineProps(['modelValue']);
const wfs = ref(props.modelValue);
const toast = useToast();
const value = ref();
    
const saveChange = async() => {
    try{
        var workflow = new Workflow();
        workflow.name = value.value;
        var data = await useWorkflow().create(workflow);
        // wfs.value.push(data);
        // emit('update:modelValue',wfs);
        emit('selectNewWorfklow',data);
        emit('updateStatus',false);
        toast.add({severity:'success',summary:'Success',detail:'Create successfully!',life:5000});
    }catch(e){
        console.log(e);
        toast.add({severity:'error',summary:'Error',detail:'Create failed!',life:5000});
    }
};
</script>