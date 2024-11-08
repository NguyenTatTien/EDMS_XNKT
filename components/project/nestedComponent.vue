<template>
  <div class="flex justify-center">
    <div class="w-full mr-2">
      <ProjectTablePhase v-model="list" />
      <a-modal v-model:open="openModel" width="80vw" @ok="addPhaseOk"  style="top: 60px" :destroyOnClose="true">
        <template #footer>
        </template>
        <ProjectEditPhase v-model="openModel" :isTask="true" :parentID="projectID" :data="openAddModel" @close="closeDialog"></ProjectEditPhase>
      </a-modal>
      <!-- <Dialog v-model:visible="openModel" modal header=" " class="w-[80vw] h-full max-h-full" id="viewFile">
        <ProjectEditTask v-model="openModel" :isTask="true" :data="openAddModel"></ProjectEditTask>
    </Dialog> -->
    </div>
  </div>
</template>
<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import nestedDraggable from './nested.vue'
import { useProject } from '~/stores/project'
import { storeToRefs } from 'pinia'
import Dialog from 'primevue/dialog';
import { Phase } from '~/models/phase';
import { usePhase } from '~/stores/phase';
import { useTask } from '~/stores/task'
import { useRoute } from 'vue-router';
const props = defineProps(['modelValue'])
const emit = defineEmits(['modelValue'])
const route = useRoute();
const list = ref([])
const openModel = ref(false)
const openAddModel = ref(new Phase())
const list2 = computed(() => props.modelValue)
const projectID = ref(0);
function test() {
  openModel.value = false
}

function showAddModel() {
  openModel.value = true
}
onMounted(() => {
  projectID.value = route.params.id;
  getTasks();
})
const getTasks = async() => {
  
 
  list.value = await usePhase().getAllByProject(projectID.value);
}
function addPhaseOk() {
  openModel.value = false
  openAddModel.value.id = Date.now().toString()
  list.value.push(JSON.parse(JSON.stringify(openAddModel.value)))
  openModel.value = false
}
const closeDialog = () => {
  openModel.value = false
}
// watch(list, (newModel, oldModel) => {
//   newModel.forEach(p => {
//     if (p.tasks.length > 0) {
//       let sum = p.tasks.reduce((a, b) => a + (b.process_percent * b.process_weight / 100), 0)
//       p.process_percent = sum
//     }
//   })
//   const { selectedModel } = storeToRefs(useProject())
//   selectedModel.value.tasks = newModel
// }, { deep: true })

// Mounting logic if any
</script>