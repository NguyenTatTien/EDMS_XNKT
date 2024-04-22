// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: false },

  app: {
    pageTransition: { name: 'page', mode: 'out-in' },
    layoutTransition: { name: 'layout', mode: 'out-in' },
    
  },
  modules: [
    '@nuxtjs/tailwindcss',
    'nuxt-primevue',
    '@ant-design-vue/nuxt',
    '@pinia/nuxt',
    '@pinia-plugin-persistedstate/nuxt',
  ],
  primevue: {
    cssLayerOrder: 'reset,primevue'
  },
  components: {
    global: true,
    dirs: ['~/components']
  },
  css: [
    '~/assets/css/main.css',
  ],
})