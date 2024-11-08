<template>
    <div id="content" class="flex flex-col flex-1 w-full">
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
  </style>
  <script setup>
  const appTheme = '#3b82f6'
  import {ref,onMounted,h} from 'vue';
  import { useNotification } from 'naive-ui';
  import { useProject } from '@/stores/project';
  import { useUser } from '@/stores/user';
  const notification = useNotification()
  const showChat = ref(false);
  const projectSelect = ref({
    id: null,
    name: ""
  });
  const myUser = useUser().getUser();
  const { listenToMessages } = useSignalR();
  onMounted(() => {
    listenToMessages((data) => {
      if(data.userID != myUser.id && data.members.filter(p=>p.id == myUser.id).length > 0){
        if(data.message.typeID == 1){console.log(data);
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
            duration: 50000,
            key: data.message.id,
            onClick: async(e) => {
              if(e.target.className == 'n-notification-main'){
                projectSelect.value = await useProject().getByID(data.message.objectID);
                showChat.value = true;
              }
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
  })
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