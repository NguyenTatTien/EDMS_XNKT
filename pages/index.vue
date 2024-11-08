<template>
  <div class="flex flex-wrap w-full justify-center h-full pb-[43px]" id="dashboard">

    <n-tabs type="line" animated class="h-full">
      <n-tab-pane name="Document" tab="Document" class="h-full">
        <div class="flex flex-wrap w-full justify-center overflow-auto h-full px-4"><PageIndexAdminDashBoard></PageIndexAdminDashBoard></div>  
      </n-tab-pane>
      <n-tab-pane name="Project" tab="Project" class="h-full">
          <DashboardProject></DashboardProject>
      </n-tab-pane>
    </n-tabs>
  </div>
</template>
<style>
.p-breadcrumb {
  background: #ffffff;
  border: 0 none;
  border-radius: 6px;
  padding: 0.5rem !important;
}
#dashboard  .n-tabs-nav-scroll-wrapper{
  margin-left: 20px !important;
  margin-right: 20px !important;
}
</style> 