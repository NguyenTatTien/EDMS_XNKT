<template>
     <QuillEditor :options="globalOptions" contentType="html" :style="style"/>
 </template>
 <script setup>
 import { QuillEditor } from '@vueup/vue-quill';
 import '@vueup/vue-quill/dist/vue-quill.snow.css';

 const emit = defineEmits(['style']);
 const props = defineProps(['style']);
 const style = ref(props.style);
 const toolbarOptions = [
   ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
   ['blockquote', 'code-block'],
   ['link', 'image', 'video', 'formula'],
 
   [{ 'header': 1 }, { 'header': 2 }],               // custom button values
   [{ 'list': 'ordered'}, { 'list': 'bullet' }, { 'list': 'check' }],
   [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
   [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
   [{ 'direction': 'rtl' }],                         // text direction
 
   [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
   [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
 
   [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
   [{ 'font': [] }],
   [{ 'align': [] }],
   ['clean']                                         // remove formatting button
 ];
 const globalOptions = ref({
   modules: {
     toolbar: toolbarOptions,
     table: true
   },
   placeholder: 'Compose an epic...',
   readOnly: false,
   theme: 'snow'
 });
 </script>