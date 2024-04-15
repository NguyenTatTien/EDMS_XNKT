// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: false },

  app: {
    pageTransition: { name: 'page', mode: 'out-in' },
    layoutTransition: { name: 'layout', mode: 'out-in' },
    modules: [
      'v-shared-element/nuxt',
      '@nuxtjs/tailwindcss',
      'nuxt-primevue'
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
  },

  modules: ["@nuxtjs/tailwindcss"]
})