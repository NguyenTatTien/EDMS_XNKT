
import { useDropzone } from "vue3-dropzone";
export default defineNuxtPlugin((nuxtApp) => {
  nuxtApp.vueApp.use(useDropzone);
});