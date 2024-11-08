<template>
    <div>
        <!-- <a-table class="w-full"  :columns="columns" :data-source="modelValue"  :expand-column-width="100">
            <template #bodyCell="{ column, record }">
              <template v-if="column.key === 'action'">
                  <span class="w-full flex">
                      <a-button type="text" danger>Xóa</a-button>
                  </span>
                </template>
                <template v-if="column.key === 'name'">
                    <NuxtLink :to="`/projects/${record.id}`">{{ record.name }}</NuxtLink>
                </template>
                <template v-if="column.key === 'unit'">
                    {{record.unitName}}
                </template>
                <template v-if="column.key === 'status'">
                    <span class="bg-gray-500 rounded-lg text-white p-0.5 px-2" v-if="record.status == 0">
                      Wait for approval
                    </span>
                    <span class="bg-orange-500-500 rounded-lg text-white p-0.5 px-2" v-else-if="record.status == 1">
                      Processing
                    </span>
                    <span class="bg-orange-500-500 rounded-lg text-white p-0.5 px-2" v-else-if="record.status == 2">
                      Completed
                    </span>
                    <span class="bg-red-500 rounded-lg text-white p-0.5 px-2" v-else>
                      Cancel
                    </span>
                </template>
            </template>
        </a-table> -->
        <DataTable paginator  v-model:expandedRows="expandedRows" :rows="50" dataKey="id" scrollable filterDisplay="menu"
          :globalFilterFields="['name', 'description']" class="text-xs h-[100%]" :value="dataModel" showGridlines stripedRows v-model:filters="filters" editMode="cell">
      <template #empty> No found. </template>
      <template #loading> Loading data. Please wait. </template>
      <Column expander style="width: 5rem" />
    <Column header="" style="width: 2rem">
        <template #body="{data}">     
            <i v-if="attachDocuments.filter(t=>t.type=='Project' && t.projectID == data.id).length == 0" class="pi pi-paperclip cursor-pointer" style="color: #4471ef;" @click="onAttachToProject(data.id)"></i>
            <i v-else class="pi pi-check cursor-pointer" style="color: #22c55e;"></i>
        </template>
    </Column>
      <Column field="name" header="Name" style="min-width: 10rem">
        <template #body="{data}">
            <div class="cursor-pointer">
                {{data.name}}
            </div>
        </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
          </template> -->
      </Column>
      <Column header="Description" field="description" style="min-width: 13rem">
        
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template> -->
      </Column>
      <Column header="Process Percent" field="process_Percent" style="min-width: 10rem">
        <template #body="{data}">
            <ProgressBar :value="data.process_Percent"></ProgressBar>
        </template>
    </Column>
      <Column header="Unit" field="unitName" style="min-width: 9rem">
         
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template> -->
      </Column>
      <Column header="Start Date" field="startDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.startDate !=null? format(data.startDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          
          <!-- <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template> -->
      </Column>
      <Column header="Expected Date" field="expectedDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.expectedDate !=null? format(data.expectedDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template>
      </Column>
      <Column header="End Date" field="endDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.endDate !=null? format(data.endDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          <template #editor="{ data }">
            <Calendar v-model="data.endDate" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="p-column-filter" @focus="formatValue(data)"/>
          </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template> -->
      </Column>
      <Column header="Approve" field="approvedBy" style="min-width: 10rem">
          <template #body="{data}">
              {{ data.approvedByName }}
          </template>
         
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template> -->
      </Column>
      <Column header="Created By" field="createdByName" style="min-width: 10rem">
          <template #body="{data}">
              {{ data.createdByName }}
          </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template> -->
      </Column>
    <Column header="Status" field="status">
        <template #body="{data}">
                <Tag v-if = "data.isProcess == true && data.isLate == false" value="In Progress" :severity="getSeverity(1)" />
                <Tag v-else-if = "data.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                <Tag v-else-if = "data.isLate == true" value="Late" :severity="getSeverity(3)" />
                <Tag v-else-if = "data.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                <Tag v-else value="Cancel" :severity="getSeverity(4)" />
        </template>
    </Column> 
    <template #expansion="slotProps">
        <div class="p-2">
            <DataTable :value="slotProps.data.phases"  class="text-xs h-[100%]" v-model:expandedRows="expandedRows_2">
                <template #empty> No found. </template>
      <template #loading> Loading data. Please wait. </template>
      <Column expander style="width: 5rem" />
    <Column header="" style="width: 2rem">
        <template #body="{data
        }">
          <i v-if="attachDocuments.filter(t=>t.type=='Phase' && t.phaseID == data.id).length == 0"  class="pi pi-paperclip cursor-pointer" style="color: #4471ef;" @click="onAttachToPhase(data.id,data.projectID)"></i>
          <i v-else class="pi pi-check cursor-pointer" style="color: #22c55e;"></i>
        </template>
    </Column>
      <Column field="name" header="Name" style="min-width: 10rem">
        <template #body="{data}">
            <div class="cursor-pointer">
                {{data.name}}
            </div>
        </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
          </template> -->
      </Column>
      <Column header="Description" field="description" style="min-width: 13rem">
          <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template>
      </Column>
      <Column header="Process Percent" field="process_Percent" style="min-width: 10rem">
        <template #body="{data}">
            <ProgressBar :value="data.process_Percent"></ProgressBar>
        </template>
    </Column>
      <Column header="Start Date" field="startDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.startDate !=null? format(data.startDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template> -->
      </Column>
      <Column header="Expected Date" field="expectedDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.expectedDate !=null? format(data.expectedDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template> -->
      </Column>
      <Column header="End Date" field="endDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.endDate !=null? format(data.endDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          <template #editor="{ data }">
            <Calendar v-model="data.endDate" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="p-column-filter" @focus="formatValue(data)"/>
          </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template> -->
      </Column>
      <Column header="Approve" field="approvedBy" style="min-width: 10rem">
          <template #body="{data}">
              {{ data.approvedByName }}
          </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template> -->
      </Column>
      <Column header="Created By" field="createdByName" style="min-width: 10rem">
          <template #body="{data}">
              {{ data.createdByName }}
          </template>
         
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template> -->
      </Column>
    <Column header="Status" field="status">
        <template #body="{data}">
                <Tag v-if = "data.isProcess == true && data.isLate == false" value="In Progress" :severity="getSeverity(1)" />
                <Tag v-else-if = "data.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                <Tag v-else-if = "data.isLate == true" value="Late" :severity="getSeverity(3)" />
                <Tag v-else-if = "data.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                <Tag v-else value="Cancel" :severity="getSeverity(4)" />
        </template>
    </Column> 
    <template #expansion="slotProps">
        <div class="p-2">
           
            <DataTable :value="slotProps.data.tasks"  class="text-xs h-[100%]">
                <template #empty> No found. </template>
      <template #loading> Loading data. Please wait. </template>
    <Column header="" style="width: 2rem">
        <template #body="{data}">
          <i v-if="attachDocuments.filter(t=>t.type=='Task' && t.taskID == data.id).length == 0"  class="pi pi-paperclip cursor-pointer" style="color: #4471ef;" @click="onAttachToTask(data.id,data.phaseID,data.projectID)"></i>
          <i v-else class="pi pi-check cursor-pointer" style="color: #22c55e;"></i>
        </template>
    </Column>
      <Column field="name" header="Name" style="min-width: 10rem">
        <template #body="{data}">
            <div class="cursor-pointer">
                {{data.name}}
            </div>
        </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filter py-[0.5rem] px-[0.75rem]" placeholder="Search by name" />
          </template> -->
      </Column>
      <Column header="Description" field="description" style="min-width: 13rem">
        
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template> -->
      </Column>
      <Column header="Process Percent" field="process_Percent" style="min-width: 10rem">
        <template #body="{data}">
            <ProgressBar :value="data.process_Percent"></ProgressBar>
        </template>
    </Column>
      <Column header="Start Date" field="startDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.startDate !=null? format(data.startDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          
          <!-- <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template> -->
      </Column>
      <Column header="Expected Date" field="expectedDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.expectedDate !=null? format(data.expectedDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          
          <!-- <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template> -->
      </Column>
      <Column header="End Date" field="endDate" style="min-width: 8rem">
        <template #body="{ data }">
          <div>{{data.endDate !=null? format(data.endDate, 'dd/MM/yyyy') :""}}</div>
        </template>
          <template #editor="{ data }">
            <Calendar v-model="data.endDate" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="p-column-filter" @focus="formatValue(data)"/>
          </template>
          <!-- <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
          </template> -->
      </Column>
      <Column field="mainJoinByName" header="Main Join"></Column>
                <Column field="auxiliaryJoinConvert" header="Join">
                   
                    <template #body="{data}">
                    
                        <a-tooltip v-if="data.auxiliaryJoinConvert != null" placement="bottom">
                                            <template #title>
                                                <div class="grid grid-cols-1 gap-3">
                                                    <span v-for="item in data.auxiliaryJoinConvert.map(p=>p.fullName)" :key="item.id"> 
                                                    {{item}}
                                                    </span>
                                                </div>  
                                            </template>
                                    <AvatarGroup class="mr-4">
                                        <Avatar v-for="item in data.auxiliaryJoinConvert.map(p=>p.fullName)" :label="item.charAt(0)" shape="circle" :key="item.id"/>
                                    </AvatarGroup>
                        </a-tooltip>
                    </template>
                </Column>
                <Column header="Work Hour" field="workHour"></Column>
      <Column header="Created By" field="createdByName" style="min-width: 10rem">
          <template #body="{data}">
              {{ data.createdByName }}
          </template>
         
          <!-- <template #filter="{ filterModel, filterCallback }">
              <InputText type="text" v-model="filterModel.value" @input="filterCallback()" class="p-column-filte py-[0.5rem] px-[0.75rem]" placeholder="Search by description" />
          </template> -->
      </Column>
    <Column header="Status" field="status">
        <template #body="{data}">
                <Tag v-if = "data.isProcess == true && data.isLate == false" value="In Progress" :severity="getSeverity(1)" />
                <Tag v-else-if = "data.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                <Tag v-else-if = "data.isLate == true" value="Late" :severity="getSeverity(3)" />
                <Tag v-else-if = "data.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                <Tag v-else value="Cancel" :severity="getSeverity(4)" />
        </template>
    </Column> 
            </DataTable>
        </div>
    </template>
            </DataTable>
        </div>
    </template>
      <template #footer> <div class="w-full text-end">In total there are {{ countRows }} rows. </div></template>
      </DataTable>
      <a-modal v-model:open="openModel" width="80vw" style="top: 60px" :destroyOnClose="true">
        <template #footer>
        </template>
        <ProjectEditProject v-model="openModel" :data="openAddModel" @update="updateModel"></ProjectEditProject>
      </a-modal>
      <Toast />
    </div>
  </template>
  <script setup>
import { ref,toRaw,onMounted,watch } from 'vue';
import { storeToRefs } from 'pinia';
import { PoweroffOutlined } from '@ant-design/icons-vue'
import {FilterMatchMode } from 'primevue/api';
import { format, parse,formatISO   } from 'date-fns';
import {Project} from '~/models/project';
import { useToast } from "primevue/usetoast";
import {useUser} from '~/stores/user';
import { useAttachDocument } from '~/stores/attachDocument';
import { AttachDocument } from '~/models/attachDocument';
  //props from parent
  const emit = defineEmits(['update:modelValue','attachDocuments','documentID']);
  const props = defineProps(['modelValue','attachDocuments','documentID']);
  //emit to parent
  const expandedRows = ref([]);
  const expandedRows_2 = ref([]);
  const dataModel = ref(props.modelValue);
  const page = ref(1)
  const openAddModel = ref(new Project());
  const toast = useToast();
  const openModel = ref(false);
  const pageSize = ref(10);
  const attachDocuments = ref(props.attachDocuments);
  const total = ref(100);
  const myUser = useUser().getUser();
  const filters = ref({
          global: { value: null, matchMode: FilterMatchMode.CONTAINS },
          name: { value: null, matchMode: FilterMatchMode.CONTAINS },
          description: { value: null, matchMode: FilterMatchMode.CONTAINS },
          unitName: { value: null, matchMode: FilterMatchMode.CONTAINS },
          startDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
          expectedDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
          endDate: { value: null, matchMode: FilterMatchMode.CONTAINS },
          approvedBy: { value: null, matchMode: FilterMatchMode.CONTAINS },
          assistedBy: { value: null, matchMode: FilterMatchMode.CONTAINS },
          status: { value: null, matchMode: FilterMatchMode.CONTAINS },
          createdByName: { value: null, matchMode: FilterMatchMode.CONTAINS },
      });
  onMounted(() => {
    dataModel.value = props.modelValue;
  });
  watch(() => props.modelValue, (newValue) => {
    dataModel.value = newValue;
});
watch(() => props.attachDocuments, (newValue) => {
attachDocuments.value = newValue;
console.log(newValue);
});
  const getSeverity = (status) => {
    switch (status) {
        case 0:
            return 'secondary';
        case 1:
            return 'warning';
            case 2:
            return 'success';
        case 3:
            return 'danger';
        case 4:
            return 'danger';
        default:
            return null;
    }
};
const onAttachToProject = async(projectID) =>{
   try{
    var st = confirm("Are you sure to attach document to this project?");
    if(st == false){
      return;
    }
    var attachDocument = new AttachDocument();
    attachDocument.documentID = props.documentID; 
    attachDocument.projectID = projectID;
    attachDocument.type = "Project";
    console.log(attachDocument);
    var data = await useAttachDocument().create(attachDocument);
    attachDocuments.value.push(data);
    toast.add({ severity: 'success', summary: 'Success Message', detail: "Delete successfully!", life: 5000 });
   }catch(error){
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Delete fail!", life: 5000 });
    console.log(error);
   }
}
const onAttachToPhase = async(phaseID,projectID) =>{
   try{
    var st = confirm("Are you sure to attach document to this phase?");
    if(st == false){
      return;
    }
    var attachDocument = new AttachDocument();
    attachDocument.documentID = props.documentID; 
    attachDocument.phaseID = phaseID;
    attachDocument.projectID = projectID;
    attachDocument.type = "Phase";
    console.log(attachDocument);
    var data = await useAttachDocument().create(attachDocument);
    attachDocuments.value.push(data);
    toast.add({ severity: 'success', summary: 'Success Message', detail: "Attach successfully!", life: 5000 });
   }catch(error){
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Attach fail!", life: 5000 });
    console.log(error);
   }
}
const onAttachToTask = async(taskID,phaseID,projectID) =>{
   try{
    var st = confirm("Are you sure to attach document to this task?");
    if(st == false){
      return;
    }
    var attachDocument = new AttachDocument();
    attachDocument.documentID = props.documentID; 
    attachDocument.phaseID = phaseID;
    attachDocument.projectID = projectID;
    attachDocument.taskID = taskID;
    attachDocument.type = "Task";
    console.log(attachDocument);
    var data = await useAttachDocument().create(attachDocument);
    attachDocuments.value.push(data);
    toast.add({ severity: 'success', summary: 'Success Message', detail: "Delete successfully!", life: 5000 });
   }catch(error){
    toast.add({ severity: 'error', summary: 'Error Message', detail: "Delete fail!", life: 5000 });
    console.log(error);
   }
}
  </script>
  <style>
  .ant-btn {
    @apply flex items-center
  }
  </style>