<template>
    <div id="content" class="flex flex-col flex-1 w-full">
      <ClientOnly>
        <n-config-provider :theme-overrides="getThemeOverrides" class="h-full">
        <slot />
    </n-config-provider>
      </ClientOnly>
    </div>
  </template>
  <style>
  </style>
  <script setup>
  const appTheme = '#3b82f6'
const getThemeOverrides = {
  common: {
    primaryColor: appTheme,
    primaryColorHover: "#94a3b8",
    primaryColorPressed: appTheme,
    primaryColorSuppl: appTheme,
  },
  LoadingBar: {
    colorLoading: appTheme,
  },
}
  </script>