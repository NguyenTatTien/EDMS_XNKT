/** @type {import('tailwindcss').Config} */
module.exports = {
    mode: 'jit',
    //prefix: 'tw-',
    content: [
      "./components/**/*.{js,vue,ts}",
      "./layouts/**/*.vue",
      "./pages/**/*.vue",
      "./plugins/**/*.{js,ts}",
      "./nuxt.config.{js,ts}",
      "./app.vue",
    ],
    theme: {
      extend: {
        transitionProperty: {
          'height': 'height'
        }
      }
    },
    corePlugins: {
      preflight: false,
    },
    variants: {
      height: ['responsive', 'hover', 'focus']
    }
  } 