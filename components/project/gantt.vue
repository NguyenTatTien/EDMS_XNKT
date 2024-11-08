<template>
  <div class="w-full grid-cols-12 mt-3 h-full pb-[40px]">
    <div class="col-span-12 h-max flex justify-between mx-2">
      <section name="timeRange">
        <span
          class="cursor-pointer rounded shadow-md mr-2 p-2 hover:text-white hover:bg-blue-500 transition-all duration-500"
          @click="changeMode('Quarter Day')"> Quarter Day</span>
        <span
          class="cursor-pointer rounded shadow-md mr-2 p-2 hover:text-white hover:bg-blue-500 transition-all duration-500"
          @click="changeMode('Half Day')">Half Day</span>
        <span
          class="cursor-pointer rounded shadow-md mr-2 p-2 hover:text-white hover:bg-blue-500 transition-all duration-500"
          @click="changeMode('Day')">Day</span>
        <span
          class="cursor-pointer rounded shadow-md mr-2 p-2 hover:text-white hover:bg-blue-500 transition-all duration-500"
          @click="changeMode('Week')">Week</span>
        <span
          class="cursor-pointer rounded shadow-md mr-2 p-2 hover:text-white hover:bg-blue-500 transition-all duration-500"
          @click="changeMode('Month')">Month</span>
      </section>
      <n-select v-model:value="selectedValue" :options="modelData" clearable value-field="id" label-field="name" class="w-[300px]"/>
      <!-- <section name="addTask" class="mt-4">
        <a-form>
          <a-form-item>
            <a-input v-model:value="taskModel.name" placeholder="Task Name" />
          </a-form-item>  
          <a-form-item>
            <a-range-picker v-model:value="dateRange" />
          </a-form-item>
          <a-form-item>
            <a-button type="primary">Add Task</a-button>
          </a-form-item>
        </a-form>
          <span>
            {{ $dayjs(new Date()).format('YYYY-MM-DD') }}
          </span>
      </section> -->
    </div>
    <span class="col-span-12 h-full">
      <div id="gantt" class="h-full">
      </div>
    </span>
  </div>
</template>
<script setup>
import { ref, toRaw,watch } from 'vue'
import { useTask } from '~/stores/task';
import { usePhase } from '~/stores/phase';
import Gantt from 'frappe-gantt';
import { format, parse,formatISO   } from 'date-fns';
const emit = defineEmits(['update:modelValue','type']);
const props = defineProps(['modelValue','type']);
const modelData = ref(props.modelValue); 
const dateRange = ref({})
const tasks = ref([])
const selectedValue = ref(null);
watch(()=>selectedValue.value, async(newValue) => {
  if(newValue == null) {await init(modelData.value);}
  else 
    {
      var data = modelData.value.filter(p=> p.id == newValue); 
      await init(data);
    }
})
watch(() => props.modelValue, async(newValue) => {
  modelData.value = newValue;
  await init(modelData.value);
});
const taskModel = ref({
  id: 'Task 1',
  name: 'Redesign website',
  start: '2024-05-20',
  end: '2024-05-20',
  progress: 0,
  dependencies: '',// 'Task 2, Task 3',
  custom_class: '' // optional
})
const _gantt = ref(null)
const changeMode = (mode) => {
  _gantt.value.change_view_mode(mode);
}
const addTask = (data) => {
  tasks.value.push(data);

  taskModel.value = {
    id: 'new Task',
    name: 'test',
    start: '2024-05-20',
    end: '2024-05-20',
    progress: 0,
    dependencies: '',// 'Task 2, Task 3',
    custom_class: '' // optional
  }
}
function formatDate(date) {
  if (!(date instanceof Date) || isNaN(date)) {
    throw new Error('Invalid Date');
  }
  let day = date.getDate().toString().padStart(2, '0');
  let month = (date.getMonth() + 1).toString().padStart(2, '0');
  let year = date.getFullYear();
  return `${year}-${month}-${day}`;
}
function initGantt(){
  
  var gantt = new Gantt("#gantt", tasks.value, {
    
    header_height: 50,
    column_width: 30, 
    step: 24,
    view_modes: ["Quarter Day", "Half Day", "Day", "Week", "Month"],
    bar_height: 20,
    bar_corner_radius: 3,
    arrow_curve: 5,
     padding: 18,
    view_mode: "Day",
    date_format: "YYYY-MM-DD",
    language: "en", // or 'es', 'it', 'ru', 'ptBr', 'fr', 'tr', 'zh', 'de', 'hu'
    custom_popup_html: null,
    custom_popup_html: function (task) {
      // the task object will contain the updated
      // dates and progress value
      task = toRaw(task);
      const end_date = new Date(task.end).toDateString();
      return `
      <div class="details-container">
        <h3>${task.name}</h5>
        <p>Expected to finish by ${end_date}</p>
        <p>${task.progress}% completed!</p>
      </div>
      `;
    },
    // on_click: function (task) {
    //   console.log(task);
    // },
    // on_date_change: function (task, start, end) {
    //   console.log(task, start, end);
    // },
    // on_progress_change: function (task, progress) {
    //   console.log(task, progress);
    // },
    // on_view_change: function (mode) {
      
    // },
  });
  // Quarter Day, Half Day, Day, Week, Month 
  _gantt.value = gantt;
  gantt.change_view_mode('Day')
}
onMounted(async() => {
  init(modelData.value);
});
const getPhase = async(Ids) => {
  var data = await usePhase().getByListProjectID(Ids);
  return data;
}
const getTask = async(Ids) => {
  var data = await useTask().getListPhaseID(Ids);
  return data;
}
const convertToModelGantt = (p,id) => {
  
  taskModel.value = {
    id: id,
    name: p.name,
    start: format(p.startDate, 'yyyy-MM-dd'),
    end: format(p.estimatedDate, 'yyyy-MM-dd'),
    progress: p.process_Percent,
    dependencies: p.parentID ?[`${p.parentID}`]:[],// 'Task 2, Task 3',
    custom_class: 'bar-milestone' // optional
  }// optional
  addTask(taskModel.value);
}
const init = async (data) => {
  console.log(data);
  if(data.length > 0){
    tasks.value = [];
    if(data.length > 0){
    if(props.type=="task"){
      data.forEach(p=> {
      convertToModelGantt(p);
      });
    }else if(props.type=="phase"){
      var Ids = data.map(p=> p.id);
      var tks = await getTask(Ids);
      data.forEach(p=> {
      convertToModelGantt(p,'phase_'+p.id);
      var tkByPhase = tks.filter(t=> t.phaseID == p.id);
        tkByPhase.forEach(t=> {
        t.parentID = 'phase_'+t.phaseID;
        convertToModelGantt(t,'task_'+t.id);
      });
      });
     
    }
    else {
      var Ids = data.map(p=> p.id);
      var phases = await getPhase(Ids);
      var phaseIds = phases.map(p=> p.id);
      var tks = await getTask(phaseIds);
      data.forEach(p=> {
      convertToModelGantt(p,'project_'+p.id);
      });
      phases.forEach(p=> {
      p.parentID = 'project_'+p.projectID;
      convertToModelGantt(p,'phase_'+p.id);
      });
      tks.forEach(p=> {
      p.parentID = 'phase_'+p.phaseID;
      convertToModelGantt(p,'task_'+p.id);
      });
    }
    initGantt();
  }
}else{
    tasks.value = [];
    initGantt();
  }
}
</script>
<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
.gantt .bar-label{
  fill: #fff !important;
}
.gantt-container .popup-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  background: rgb(255 255 255 / 80%);
  padding: 0;
  color: #959da5;
  border-radius: 3px;
  width: 200px;
  height: auto;
}.gantt-container{
  height: 100%;
}
.details-container{
  background: black;
  opacity: 0.7;
  color: white;
  padding: 2px 10px;
}
.bar-milestone .bar-progress {
  fill: #2080f0 !important;
}#gantt{
  padding-bottom: 10px;
}
#gantt .gantt-container:hover::-webkit-scrollbar{
  width: 4px;
  height: 5px;
}
</style>