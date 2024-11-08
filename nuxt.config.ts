// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: false },
  runtimeConfig:{
    URL_SERVER_API: process.env.URL_SERVER_API || 'https://localhost:7122'
  },
  app: {
    pageTransition: { name: 'page', mode: 'out-in' },
    layoutTransition: { name: 'layout', mode: 'out-in' },
    head: {
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/THEA_Logo_vn_Backup.png' }
        // { rel: 'stylesheet', href: 'bootstrap/dist/css/bootstrap.min.css' },
        
      ],
      script: [
        { src: 'https://cdn.jsdelivr.net/npm/sortablejs@1.15.2/Sortable.min.js' },
        { src: '//cdnjs.cloudflare.com/ajax/libs/Vue.Draggable/4.0.0/vuedraggable.umd.min.js' },
      ],
    },
  },
  ssr:false,
  modules: [
    '@nuxtjs/tailwindcss',
    'nuxt-primevue',
    '@ant-design-vue/nuxt',
    '@pinia/nuxt',
    '@pinia-plugin-persistedstate/nuxt',
    "nuxt-tiptap-editor",
    "dayjs-nuxt",
    "nuxtjs-naive-ui"
  ],
  tiptap: {
    prefix: "Tiptap",
    lowlight: {
      theme: "github-dark",
    }, //prefix for Tiptap components
  },
  primevue: {
    cssLayerOrder: 'reset,primevue'
  },
  components: {
    global: true,
    dirs: ['~/components']
  },
  vite: {
    optimizeDeps: {
      // include: ['naive-ui', '@css-render/vue3-ssr', 'date-fns-tz/esm/formatInTimeZone']
      include: ['naive-ui', 'date-fns-tz/esm/formatInTimeZone']
    }
  },
  css: [
    '~/assets/css/main.css',
  ],
  plugins: ['~/plugins/signalr.client.ts']
})