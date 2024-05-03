<template>
    <div id="content">
      <!-- <section class="flex items-center w-full shadow-md py-2">
        <div class="flex-grow px-2">
          <ClientOnly>
            <img v-shared-element:img1 class="rounded-lg shadow-md h-12" src="https://upload.wikimedia.org/wikipedia/vi/e/e9/Logo_VIETSOVPETRO.png" />
          </ClientOnly>
        </div>
        <span class="px-2">
          <NuxtLink to="/login">
            Logout
          </NuxtLink>
        </span>
      </section> -->
      <LayoutSidebar/>
      <ClientOnly>
        <slot />
      </ClientOnly>
    </div>
  </template>
  <style>
  .p-breadcrumb {
    background: #ffffff;
    border: 0 none;
    border-radius: 6px;
    padding: 0.1rem !important;
  }
  </style>