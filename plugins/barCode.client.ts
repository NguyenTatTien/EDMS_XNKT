
import Vue3Barcode from 'vue3-barcode'

export default defineNuxtPlugin((nuxtApp) => {
    nuxtApp.vueApp.use(Vue3Barcode)
  return {
    provide: {
        Vue3Barcode
    }
  }
})