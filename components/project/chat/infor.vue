<template>
    <div class="overflow-auto h-full">
        <div class="w-full text-center font-bold py-5">
            {{  props.project.name }}
        </div>
        <hr style="border-color: #e2e8f0; border-width: 1px; margin: 0;"/>
        <div class="h-full">
<PanelMenu  v-model:expandedKeys="expandedKeys" :model="items">
    <template #item="{ item }">
        <div v-if="item.id == 1">
          <n-popselect v-model:value="value" :options="options">
            <div class="px-3 py-2 cursor-pointer">
                <span class="pi pi-users" />
                <span class="ml-2">{{ props.chatMembers.length }} Members</span>
            </div>
          </n-popselect>
        </div>
        <div v-else-if="item.id == 2">
            <n-grid :x-gap="12" :y-gap="8" :cols="4">
    <n-grid-item v-for="item in imagesVideos.slice(0,maxImage)" :key="item">
      <div class="relative">
        <img :src="urlServer+item" class="w-[80px] h-[80px] imgItem" style="object-fit: cover; border-radius: 4px;"/>
        <a :href="urlServer+item" target="_blank"><span class="pi pi-download download-icon-image"></span></a>
      </div>
    </n-grid-item>
  </n-grid>
  <div class="view-all" @click="()=>{maxImage = btnAllImageText == 'View All'? imagesVideos.length:8;btnAllImageText = btnAllImageText == 'View All' ? 'Zoom Out' : 'View All'}">{{btnAllImageText}}</div>
        </div>
        <div v-else-if="item.id == 3">
            <div class="file-list">
              <div class="flex relative file-item-container" v-for="file in files.slice(0,maxFile)" :key="file.name">
          <div class="file-icon mr-2">
            <img :src="'_nuxt/assets'+file.fileIcon" class="w-[3rem] h-[3rem]">
          </div>
          <div class="file-info">
            <div class="file-name">{{ file.fileName }}</div>
            <div class="file-details">
              <span>{{ file.fileSize }}</span>
              <span>{{ file.commentDate }}</span>
            </div>
          </div>
          <div class="download-icon">
            <a :href="urlServer+file.fileURL"><span class="pi pi-download"></span></a>
          </div>
        </div>
            </div>
            <div class="view-all" @click="()=>{maxFile = btnAllFileText == 'View All'? files.length:4; btnAllFileText = btnAllFileText == 'View All' ? 'Zoom Out' : 'View All'}">{{btnAllFileText}}</div>
        </div>
        <a v-else v-ripple class="flex align-items-center cursor-pointer text-color px-3 py-2" :href="item.url" :target="item.target">
            <span :class="item.icon" />
            <span class="ml-2">{{ item.label }}</span>
            <span v-if="item.items" class="pi pi-angle-down text-primary ml-auto" />
        </a>
    </template>
</PanelMenu>
        </div>
    </div>
</template>
<script setup>
import { ref, onMounted,watch } from 'vue';
import { format, parse,formatISO ,isBefore,startOfDay  } from 'date-fns';
import { useDomain } from '@/stores/domain';
const expandedKeys = ref({});
const emit = defineEmits(['update:modelValue','chatMembers','project']);
const props = defineProps(['modelValue','chatMembers','project']);
const messages = ref(props.modelValue);
const imagesVideos = ref([]);
const files = ref([]);
const btnAllImageText = ref('View All');
const maxImage = ref(8);
const btnAllFileText = ref('View All');
const maxFile = ref(4);
const urlServer = useDomain().url.server;
const options = ref([
]);
const value = ref(null);
watch(() => props.modelValue, (newValue) => {
    messages.value = newValue;
    init();
});
watch(() => props.chatMembers, (newValue) => {
   newValue.forEach(p=>{
    options.value.push({
        label: p.fullName,
        value: p.id
    });
  });
});
const items = ref([
    {
      key: '1',
        label: 'Members',
        icon: 'pi pi-users',
        items: [
            {
                 id: 1,
            },
        ]
    },
    {
        key: '2',
        label: 'Image/Video',
        icon: 'pi pi-image',
        items: [
            {
                id:2,
            }
        ]
    },
    {
        key: '3',
        label: 'Files',
        icon: 'pi pi-file',
        items: [
            {
                id:3,
            }
        ]
    }
]);

onMounted(() => {
   init();
   expandedKeys.value = {
        1: true,
        2: true,
        3: true
   }
});
const init =()=>{
    const messageFiles = messages.value.filter(message => message.typeID === 2).sort((a, b) =>  Date.parse(b.commentDate) - Date.parse(a.commentDate));
    imagesVideos.value = messageFiles.filter(m=>['image/png','image/gif','image/jpg','image/jpeg','video/mp4','video/webm','video/ogg'].includes(m.fileType)).map(message => message.fileURL);
    files.value =  messageFiles.filter(m=>!['image/png','image/gif','image/jpg','image/jpeg','video/mp4','video/webm','video/ogg'].includes(m.fileType)).map(message => {
        return {
            fileName: message.fileName,
            fileSize: message.fileSize > 1024 * 1024 ? `${(message.fileSize / (1024 *1024)).toFixed(2)} MB` : `${(message.fileSize / 1024).toFixed(2)} KB`,
            commentDate: format(message.commentDate,'dd/MM/yyyy HH:mm'),
            fileIcon: message.fileIcon,
            fileURL: message.fileURL
        }
    });
    
}
</script>
<style>
.light-green {
  height: 108px;
  background-color: rgba(0, 128, 0, 0.12);
}
.green {
  height: 108px;
  background-color: rgba(0, 128, 0, 0.24);
}
.file-item {
  display: flex;
  gap: 12px;
  padding: 8px 0;
}

.file-info {
  flex: 1;
}

.file-name {
  font-size: 14px;
  margin-bottom: 4px;
}

.file-details {
  display: flex;
  justify-content: space-between;
  color: #666;
  font-size: 12px;
}
.view-all {
  text-align: center;
  padding: 8px;
  background-color: #f5f5f5;
  border-radius: 4px;
  cursor: pointer;
}
.file-item-container {
  position: relative;
  padding: 8px;
}

.file-item-container:hover {
  background-color: #f5f5f5;
}

.download-icon {
  position: absolute;
  right: 8px;
  top: 30%;
  transform: translateY(-50%);
  opacity: 0;
  transition: opacity 0.2s ease;
  cursor: pointer;
}

.file-item-container:hover .download-icon {
  opacity: 1;
}
.download-icon:hover {
  color: #2196F3;
}
.download-icon-image {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%); /* Updated to center both horizontally and vertically */
  opacity: 0;
  transition: opacity 0.2s ease;
  cursor: pointer;
  color: white; /* Make icon white for better visibility */
}
.relative:hover .download-icon-image {
  opacity: 1;
}
.relative:hover img {
  filter: brightness(0.7); /* Optional: dim the image on hover */
}
</style>