<template>
    <div class="message-wrapper" :class="{'is-own': myUser.id == message.commentBy}">
      
      <Avatar v-if="myUser.id != message.commentBy" :label="message.commentByName.charAt(0)" shape="circle" style="margin-left: 5px; margin-right: 5px"/>
      <div v-if="message.isDelete" class="text-red-500"><div class="text-bubble" :class="{'own-message': myUser.id == message.commentBy, 'other-message': myUser.id != message.commentBy}">
          <div v-if="myUser.id != message.commentBy" class="sender-name-inside">{{ message.commentByName }}</div>
          <p style="margin-top: 5px; margin-bottom: 5px;" class="message-deleted">This message has been deleted</p>
          <div class="message-meta">
            <span class="time">{{isBefore(startOfDay(new Date(message.commentDate)),startOfDay(new Date()),) ?format(message.commentDate, 'dd/MM/yyyy HH:mm'): format(message.commentDate, 'HH:mm') }}</span>
          </div>
        </div>
      </div>
     <div v-else-if="message.fileType == 'image/png' || message.fileType == 'image/jpeg' || message.fileType == 'image/gif'|| message.fileType == 'video/mp4'" class="flex flex-col">
              <div class="sender-name-inside" v-if="myUser.id != message.commentBy">{{ message.commentByName }}</div>
             <div class="flex items-center" :class="{'justify-end': myUser.id == message.commentBy}">
              <i class="pi pi-trash text-xl cursor-pointer text-gray-500 mr-2 acvite-trash" @click="deleteMessage(message.id)" v-if="myUser.id == message.commentBy"></i>
              <i class="pi pi-download mr-2 text-xl cursor-pointer text-gray-500" @click="downloadFile(message.fileURL)" v-if="myUser.id == message.commentBy"></i>
              <img v-if="message.fileType == 'image/png' || message.fileType == 'image/jpeg' || message.fileType == 'image/gif' 
              ||message.fileType == 'image/jpg'" :src="urlServer + message.fileURL" alt="image" class="border-solid border-gray-300 rounded-lg w-full" style="border-width: 1px; max-width: calc(calc(1px*300) - 0.125rem*2); max-height:calc(calc(1px*300) - 0.125rem*2);height: calc(calc(1px*300) - 0.125rem*2)">
               <div v-else-if="message.fileType == 'video/mp4'" style="width: 100%; height: 100%;max-width: calc(calc(1px*300) - 0.125rem*2);max-height: 100%;"><video controls style="border-width: 1px; width: 100%; height: 100%;">
                <source :src="urlServer + message.fileURL" type="video/mp4">
                <source :src="urlServer + message.fileURL" type="video/webm">
                <source :src="urlServer + message.fileURL" type="video/ogg">
               </video></div>
              <i class="pi pi-download ml-2 text-xl cursor-pointer text-gray-500" @click="downloadFile(message.fileURL)" v-if="myUser.id != message.commentBy"></i>
             </div>
              <span class="time" style="font-size: 0.8rem;color: #a0aec0; width: max-content;" :class="{'ml-14': myUser.id == message.commentBy}">{{isBefore(new Date(message.commentDate), new Date()) ? format(message.commentDate, 'HH:mm') : format(message.commentDate, 'dd/MM/yyyy HH:mm') }}</span>
     </div>
      <div class="message-content" v-else>
        <i class="pi pi-trash text-xl cursor-pointer text-gray-500 mr-2 acvite-trash" @click="deleteMessage(message.id)" v-if="myUser.id == message.commentBy"></i>
        <div class="text-bubble" :class="{'own-message': myUser.id == message.commentBy, 'other-message': myUser.id != message.commentBy}">
          <div v-if="myUser.id != message.commentBy" class="sender-name-inside">{{ message.commentByName }}</div>
          <p style="margin-top: 5px; margin-bottom: 5px;" v-if="message.typeID == 1" v-html=" message.message"></p>
          <div v-if="message.typeID == 2">
            <div class="flex justify-between items-center">
                <img alt="pdf" :src="'_nuxt/assets'+message.fileIcon" class="w-[3rem] h-[3rem]">
                <div class="flex flex-col text-left ml-2">
                  <span class="text-sm overflow-hidden text-ellipsis whitespace-nowrap max-w-[12rem]">{{ message.fileName }}</span>
                  <span class="text-sm message-file-size">{{ message.fileSize }}</span>
                </div>
                <i class="pi pi-download ml-2 cursor-pointer" @click="downloadFile(message.fileURL)"></i>
            </div>
          </div>
          <div class="message-meta">
            <span class="time">{{isBefore(startOfDay(new Date(message.commentDate)),startOfDay(new Date()),) ?format(message.commentDate, 'dd/MM/yyyy HH:mm'): format(message.commentDate, 'HH:mm') }}</span>
          </div>
        </div>
      </div>
    </div>
  </template>
  <script setup>
  import {useUser} from '~/stores/user';
  import { format, parse,formatISO ,isBefore,startOfDay  } from 'date-fns';
  import { useChat } from '~/stores/chat';
  import { useDomain } from '@/stores/domain';
  const emit = defineEmits(['updateMessage']);
  const props = defineProps(['message']);
const myUser = ref(useUser().getUser());
const urlServer = useDomain().url.server;
const downloadFile = (fileURL) => {
        const link = document.createElement('a');
        link.href = urlServer + fileURL;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
}
const deleteMessage = async (id) => {
   var comment = await useChat().delete(id);
    emit('updateMessage',comment);
}
  </script>
  <style>
  .message-wrapper {
    display: flex;
    align-items: flex-end;
    margin-bottom: 1rem;
  }
  .message-wrapper.is-own {
    justify-content: flex-end;
    
  }
  .message-content {
    max-width: 70%;
    position: relative;
    display: flex;
    align-items: center;
  }
  .text-bubble {
    padding: 10px 15px;
    border-radius: 20px;
    display: inline-block;
    position: relative;
  }
  .own-message {
    background-color: #7678ed;
    color: white;
    border-radius: 20px 20px 0 20px;
    text-align: left;
  }
  
  .other-message {
    background-color: #edf2f7;
    color: black;
    border-radius: 20px 20px 20px 0;
  }
  
  .sender-name-inside {
    font-weight: bold;
    font-size: 0.9rem;
    color: #4a5568; /* Darker gray for name */
  }
  
  .is-own .message-meta {
    display: flex;
    justify-content: space-between;
    font-size: 0.8rem;
    color: #d1d5db;
  }
  .message-meta {
    display: flex;
    justify-content: space-between;
    font-size: 0.8rem;
    color: gray;
  }
  .avatar {
    width: auto;
    height: auto;
    border-radius: 50%;
  }
  
  .is-own .avatar {
    margin-left: 0;
    margin-right: 0.5rem;
  }
  
  .is-own .message-content {
    text-align: right;
  }
  .acvite-trash{
   visibility: hidden;
  }
  .message-wrapper:hover .acvite-trash{
   visibility: visible;
  }
  .is-own .mention{
    color: #E0F7FA !important;
    background-color: transparent !important;
  }
  .mention{
    color: #0035ff !important;
    background-color: transparent !important;
  }
  .message-deleted{
    color: gray;
  }
  .is-own .message-deleted{
    color: #d1d5db;
  }
  .message-file-size{
    color: gray;
  }
  .is-own .message-file-size{
    color: #d1d5db;
  }
  .message-content p {
    margin: 0;
    font-size: 14px;
  }
  </style>