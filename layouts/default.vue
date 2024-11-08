<template>
    <div id="content" class="flex flex-col flex-1 w-full">
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
      <n-config-provider :theme-overrides="getThemeOverrides" class="h-full">
       <slot />
      </n-config-provider>
      </ClientOnly>
      <n-modal v-model:show="showChat" preset="dialog" :title="projectSelect.name" style="width: 900px;height: 100%;position: absolute;top: 0;left: 0;bottom: 0;right: 0;padding: 1rem;" content-style="height: 95%;" id="chat-modal">
          <ProjectChat v-model="projectSelect" @updateReadByProject="updateReadByProject"/>
      </n-modal>
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
  <script setup>
  import { onMounted,h,ref } from "vue";
  import { useToast } from "primevue/usetoast";
  import { useUser } from "~/stores/user";
  import { useNotification } from 'naive-ui';
  import {useProject} from '~/stores/project';
  const toast = useToast();
  const notification = useNotification()
  const projectSelect = ref({
    id: null,
    name: ""
  });
  const showChat = ref(false);
  const { listenToMessages, sendMessage } = useSignalR();
  const myUser = useUser().getUser();
  onMounted(() => {
    console.log("fff");
    listenToMessages((data) => {
      if(data.userID != myUser.id && data.members.filter(p=>p.id == myUser.id).length > 0){
        if(data.message.typeID == 1){
          notification.info({
            title: data.message.objectName,
            content: () =>
            h('div', {
              
              style: 'text-size:15px;'
            },[
              h('b',{
              style: 'float:left;'
            },data.message.commentByName +": "),
              h('span',{innerHTML:data.message.message})
            ]),
            duration: 500000,
            key: data.message.id,
            onClick: async(e) => {
              if(e.target.className == 'n-notification-main'){
                projectSelect.value = await useProject().getByID(data.message.objectID);
                showChat.value = true;
              }
              // projectSelect.value = await useProject().getByID(data.message.objectID);
              // showChat.value = true;
            }
          });
        }else{
          notification.info({
            title: data.message.objectName,
            content: () =>
            h('div', {
              style: 'text-size:15px;'
            },[
              h('b',data.message.commentByName +": "),
              h('span','sent a file!')
            ]),
            duration: 5000,
            key: data.message.id,
            onClick: async(e) => {
              if(e.target.className == 'n-notification-main'){
                projectSelect.value = await useProject().getByID(data.message.objectID);
                showChat.value = true;
              }
            }
          });
        }
      }
    });
  });
  const updateReadByProject = async(projectID)=>{
  await useChatStatus().updateReadByProject(projectID);
}

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
  <style>
  .n-notification-main__content p{
    margin: 0;
  }
  </style>