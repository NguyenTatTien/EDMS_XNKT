
<template>
  <div class="chat-input">
    <div class="input-wrapper">
      <!-- <n-mention type="textarea" :options="options" autosize @keyup="sendChat" placeholder="Your message..." v-model:value="inputContent" @search="onSearch"/> -->
      <div id="quill_editor" class="w-full"></div>
      <div class="input-actions">
        <n-upload
          :show-file-list="false"
          @change="onFileSelect"
        >
          <n-button text style="font-size: 1.25rem; padding: 0;">
            <i class="pi pi-paperclip text-xl"></i>
          </n-button>
        </n-upload>
        <n-popover :overlap="false" placement="top" trigger="click" style="padding: 0;">
          <template #trigger>
            <i class="pi pi-face-smile text-xl"></i>
          </template>
          <n-tabs type="line" animated id="chat-input-emoji">
              <n-tab-pane name="Emoji" tab="Emoji">
                <EmojiPicker :native="true" @select="addEmoji" />
              </n-tab-pane>
              <n-tab-pane name="Gif" tab="Gif" id="gifPicker">
                <GifPicker api-key="AIzaSyCDhOJhr1p1ApmOnYsRtdm3iguw9C-RLwY" @gifSent="handleGif"></GifPicker>
              </n-tab-pane>
          </n-tabs>
        </n-popover>
      </div>
    </div>
    <button @click="sendChat" class="send-button">
      <i class="pi pi-send text-2xl"></i>
    </button>
  </div>
</template>
<script setup>
import { ref, computed,watch } from 'vue';
import { Chat } from '~/models/chat';
import { useChat } from '~/stores/chat';
import { useUser } from '~/stores/user';
import {useProject} from '~/stores/project';
import {GifPicker} from "vue-gif-emoji-picker";
import EmojiPicker from 'vue3-emoji-picker';
import Quill from "quill";
import "quill-mention/autoregister";
import {Mention, MentionBlot} from "quill-mention";
import '~/node_modules/quill-mention/dist/quill.mention.css';
import "~/node_modules/vue3-emoji-picker/dist/style.css";
import '@vueup/vue-quill/dist/vue-quill.snow.css';
import "~/assets/css/gifPicker.css";
Quill.register({ "blots/mention": MentionBlot, "modules/mention": Mention });
import { useSignalR } from '~/composables/useSignalR'; 
const { listenToMessages, sendMessage } = useSignalR();
const inputContent = ref('');
const showMembers = ref(false);
const filterOptions = ref([])
const offsetXChat = ref(0);
const selectedFile = ref(null);
const options = ref([]);
const emit = defineEmits(['sendMessage', 'project', 'scrollToBottom','chatMembers']);
const props = defineProps(['project','chatMembers']);
const myUser = useUser().getUser();
const project = ref(props.project);
const mentionSelected = ref([]);
const chatMembers = ref(props.chatMembers);
const placeholder = computed(() => selectedFile.value ? selectedFile.value.name : 'Your message');
watch(() => props.chatMembers, (newValue) => {
  chatMembers.value = newValue;
  atValues.value = chatMembers.value.map(p=>{
    return {
      value: p.fullName,
      id: p.id
    }
  });
  initQuillMention();
});
const atValues = ref([
]);
const quillEditor = ref(null);
onMounted(() => {
  atValues.value = chatMembers.value.map(p=>{
    return {
      value: p.fullName,
      id: p.id
    }
  });
  initQuillMention();
});
const sendChat = async (content) => {
  if (content.trim()) {
    var message = new Chat();
    message.message = content;
    message.objectTypeID = 1;
    message.objectTypeName = 'Project';
    message.objectID = project.value.id;
    message.objectName = project.value.name;
    message.typeID = 1;
    message.typeName = 'Message';
    var formData = new FormData();
    formData.append('jsonComment', JSON.stringify(message));
    var data = await useChat().create(formData);
    sendChatRealTime(data);
    quillEditor.value.setText('');
    selectedFile.value = null;
  }
};
const initQuillMention = ()=>{
  quillEditor.value = new Quill("#quill_editor", {
  modules: {
    mention: {
      allowedChars: /^[A-Za-z\sÀ-ỹ\u0300-\u036f]*$/,
      mentionDenotationChars: ["@"],
      source: function(searchTerm, renderList, mentionChar) {
        let values;

        if (mentionChar === "@") {
          values = atValues.value;
        } 
        if (searchTerm.length === 0) {
          renderList(values, searchTerm);
        } else {
          const matches = [];
          for (let i = 0; i < values.length; i++)
            if (
              ~values[i].value.toLowerCase().indexOf(searchTerm.toLowerCase())
            )
              matches.push(values[i]);
          renderList(matches, searchTerm);
        }
      },
      onSelect: function(item, insertItem) {
        insertItem(item);
        mentionSelected.value.push(item);
      }
    },
    keyboard: {
        bindings: {
          ENTER: {
    key: "Enter",
    handler:async function (range, context) {
      if (context && context.event && context.event.target && context.event.target.innerHTML) {
        const text = context.event.target.innerHTML;
       if(text != ""){
        const processedText = convertLinksToAnchors(text);
        await sendChat(processedText);
        if (mentionSelected.value.length > 0) {
          var userids = mentionSelected.value.map(p=>Number(p.id));
           await sendMail(userids);
        }
        mentionSelected.value = [];
       }
    }
      // return !!multiline
    }
  }
        }
      },
  },
});
}
const sendMail = async(data)=>{
    await useChat().sendMail(data,project.value.id);
}
const convertLinksToAnchors = (text) => {
  // Regex để nhận dạng URL
  const urlRegex = /(https?:\/\/[^\s]+)/g;
  // Thay thế URL bằng thẻ a
  return text.replace(urlRegex, (url) => {
    return `<a href="${url}" target="_blank" rel="noopener noreferrer" style="color:blue">${url}</a>`;
  });
}
function addEmoji(emoji) {
    quillEditor.value.insertText(quillEditor.value.getLength() - 1, emoji.i);
}
const onFileSelect =async(options) => {
  const { file } = options;
  if(file.file.size > 25769803){
    alert('File size should be less than 2.5MB!');
    return;
  }
    var message = new Chat();
    message.objectTypeID = 1;
    message.objectTypeName = 'Project';
    message.objectID = project.value.id;
    message.objectName = project.value.name;
    message.typeID = 2;
    message.typeName = 'File';
    message.fileName = file.name;
    var formData = new FormData();
    formData.append('jsonComment', JSON.stringify(message));
    formData.append('formFile', file.file);
    var data = await useChat().create(formData);
    sendChatRealTime(data);
    selectedFile.value = null;
};
const sendChatRealTime = (data)=>{
      sendMessage(project.value.id, myUser.id,chatMembers.value, data);
}
const handleGif = async(gif) => {
  var message = new Chat();
    message.objectTypeID = 1;
    message.objectTypeName = 'Project';
    message.objectID = project.value.id;
    message.objectName = project.value.name;
    message.typeID = 2;
    message.typeName = 'File';
    message.fileName =gif.url.split('/').pop();
  const response = await fetch(gif.url);
  const blob = await response.blob();
  const formData = new FormData();
  formData.append('jsonComment', JSON.stringify(message));
  formData.append('formFile', blob, gif.url.split('/').pop());
  var data = await useChat().create(formData);
  sendChatRealTime(data);
  selectedFile.value = null;
}
const onSearch = (search, prefix) => {
  if (!prefix) {
    options.value = chatMembers.value.map(p => ({
      label: p.fullName,
      value: p.id
    }));
    return;
  }
  options.value = chatMembers.value
    .filter(p => p.fullName.toLowerCase().includes(search.toLowerCase()))
    .map(p => ({
      label: p.fullName,
      value: p.i
    }));
}
</script>
  <style>
  .chat-input {
    display: flex;
    align-items: center;
    background-color: #ffffff;
    padding: 0.5rem;
    border-top: 1px solid #e2e8f0;
  }
  .input-wrapper {
    display: flex;
    align-items: center;
    flex-grow: 1;
    background-color: #f3f4f6;
    border-radius: 20px;
    padding: 0.5rem 1rem;
    margin-right: 0.5rem;
  }
  .chat-input .n-input {
    flex-grow: 1;
    border: none !important;
    background-color: transparent !important;
    outline: none !important;
    font-size: 15px;
    box-shadow: none !important;
    
  }
  .chat-input .n-input--textarea{
    flex-grow: 1;
    border: none !important;
    background-color: transparent !important;
    outline: none !important;
    font-size: 15px;
    box-shadow: none !important;
    --n-box-shadow-focus: none !important;
    --n-border: none !important;
    --n-border-focus: none !important;
    --n-box-shadow: none !important;
  }
  .input-actions {
    display: flex;
    align-items: center;
  }
  .input-actions i {
    margin-left: 0.75rem;
    color: #6b7280;
    cursor: pointer;
  }
  
  .send-button {
    background-color: transparent;
    border: none;
    color: #4f46e5;
    font-size: 1.25rem;
    cursor: pointer;
  }
  
  .send-button:hover {
    color: #4338ca;
  }
  #chat-input-emoji .n-tabs-nav-scroll-wrapper{
   padding-left: 20px !important;
   padding-right: 20px !important;
  }
  .ant-mentions-measure{
    z-index: 99000 !important;
  }
  </style>