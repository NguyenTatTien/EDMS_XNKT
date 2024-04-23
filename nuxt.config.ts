// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: false },

  app: {
    pageTransition: { name: 'page', mode: 'out-in' },
    layoutTransition: { name: 'layout', mode: 'out-in' },
    head: {
      link: [
        // { rel: 'stylesheet', href: 'bootstrap/dist/css/bootstrap.min.css' },
      ],
      script: [
        { src: 'https://cdn.jsdelivr.net/npm/sortablejs@1.15.2/Sortable.min.js' },
        { src: '//cdnjs.cloudflare.com/ajax/libs/Vue.Draggable/4.0.0/vuedraggable.umd.min.js' },
      ],
    },
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