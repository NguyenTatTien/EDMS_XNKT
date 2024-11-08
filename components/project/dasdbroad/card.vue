<template>
    <div>
        <Card style="height: 9rem; overflow: hidden;box-shadow: none; border-radius: 5px;">
            <template #title><div class="text-[1.15rem]">{{text}}</div></template>
            <template #content>
                <p class="mt-4 font-bold text-xl" :class="color">
                    {{modelValue}}
                </p>
            </template>
        </Card>
    </div>
</template>
<script setup>
import {ref,watch,onMounted} from 'vue';
const emit = defineEmits(['update:modelValue','text','color']);
const props = defineProps(['modelValue','text','color']);
const text = ref(props.text);
const modelValue = ref(props.modelValue);
const color = ref(props.color);
watch(() => props.modelValue, (value) => {
    modelValue.value = value;
   
});
onMounted(()=>{
    modelValue.value = props.modelValue;
    
})
</script>