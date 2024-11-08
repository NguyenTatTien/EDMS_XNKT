<template>
    <div class="w-full h-full flex">
      <div class="chat-container" @click="updateReadByProject" style="border-right: 1px solid #e2e8f0;width: 100%;">
      <!-- <div class="chat-header">
        <h3>Design chat</h3>
        <div class="header-icons">
          <i class="icon-search"></i>
          <i class="icon-settings"></i>
        </div>
      </div> -->
      <n-scrollbar ref="scrollbar" id="scrollableDiv" style="padding-right: 15px; background-color: white;height: 100%;">
      <div class="chat-messages">
        <ProjectChatMessageList
          v-for="(message, index) in messages" 
          :key="index" 
          :message="message" 
          @updateMessage="updateMessage"
        />
      </div>
    </n-scrollbar>
      <ProjectChatInput @sendMessage="addMessage" :project="project" :chatMembers="chatMembers" @scrollToBottom="scrollToBottom"/>
    </div>
    <div class="w-[500px]"><ProjectChatInfor v-model="messages" :chatMembers="chatMembers" :project="project"/></div>
    </div>
  </template>
  <script setup>
import { ref,onMounted,watch } from 'vue';
import { useChat } from '~/stores/chat';
import { useSignalR } from '~/composables/useSignalR'; 
import { useProject } from '~/stores/project';
const { listenToMessages, sendMessage } = useSignalR();
const emit = defineEmits(['update:modelValue','updateReadByProject']);
const props = defineProps(['modelValue']);
const project = ref(props.modelValue);
const chatMembers = ref([]);
const scrollbar = ref(null);
  const messages = ref([
  ]);
  onMounted(async() => {
   await getComment();
    await updateReadByProject();
    await getChatMembers();
    scrollToBottomInit();
    listenToMessages((data) => {
    if (data.objectID == project.value.id) {
      addMessage(data.message);
    }
    });
  });
  watch(() => props.modelValue, async(newValue) => {
    project.value = newValue;
    await getComment();
    scrollToBottomInit();
  });
  const updateReadByProject = async () => {
    
    emit('updateReadByProject',project.value.id);
  }
  const getChatMembers = async () => {
    chatMembers.value = await useProject().getChatMembers(project.value.id);
  }
  const getComment = async () => {
    messages.value = await useChat().getByProject(project.value.id);
  };
  const addMessage = async(newMessage) => {
    messages.value.push(newMessage);
    scrollToBottom();
  };
  const updateMessage = (message) => {
    messages.value = messages.value.map(item => item.id == message.id ? message : item);
  }
  const scrollToBottom = () => {
    if (scrollbar.value) {
    // Đợi DOM cập nhật
    setTimeout(() => {
      const scrollbarEl = scrollbar.value;
      const divElement = document.querySelector('#scrollableDiv .n-scrollbar-content');
      if (scrollbarEl && divElement) {
        scrollbar.value.scrollTo({ top: divElement.scrollHeight, behavior: 'smooth' });
      }
    }, 0);
  }
  };
  const scrollToBottomInit = () => {
    if (scrollbar.value) {
    // Đợi DOM cập nhật
    setTimeout(() => {
      const scrollbarEl = scrollbar.value;
      const divElement = document.querySelector('#scrollableDiv .n-scrollbar-content');
      if (scrollbarEl && divElement) {
        scrollbar.value.scrollTo({ top: divElement.scrollHeight });
      }
    }, 0);
  }
  };
  </script>
  <style scoped>
  .chat-container {
    display: flex;
    flex-direction: column;
    height: 100%;
    background-color: #f3f4f6;
    /* border-radius: 8px; */
    overflow: hidden;
  }
  
  .chat-header {
    display: flex;
    justify-content: space-between;
    padding: 1rem;
    background-color: #4f46e5;
    color: white;
  }
  
  .header-icons i {
    margin-left: 1rem;
    cursor: pointer;
  }
  
  .chat-messages {
    flex-grow: 1;
    padding: 1rem 0rem;
    background-color: white;
  }
  
  .chat-input {
    padding: 0.5rem 1rem;
    background-color: #f3f4f6;
  }
  </style>