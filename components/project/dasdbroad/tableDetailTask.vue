<template>
     <div class="flex justify-center">
      <DataTable :value="tasks" dataKey="id"
        class="text-xs h-[100%] w-full" scrollable filterDisplay="menu" stripedRows id="tbTask">
       
                <Column field="name" header="Name" style="min-width: 17rem" alignFrozen="left" :frozen="true">
                    <template #body="{data}">
                        <div class="cursor-pointer">
                            {{data.name}}
                            <Tag v-if="data.isCancel" value="Cancel" :severity="getSeverity(4)" />
                            <Tag v-else-if = "data.isProcess == true && !isLate(data.estimatedDate)" value="In Process" :severity="getSeverity(1)" />
                        <Tag v-else-if = "data.isComplete == true" value="Completed" :severity="getSeverity(2)" />
                        <Tag v-else-if = "data.isProcess == true && isLate(data.estimatedDate)" value="Late" :severity="getSeverity(3)" />
                        <Tag v-else-if = "data.isApprove == false" value="Wait for approval" :severity="getSeverity(0)" />
                        </div>
                    </template>
                </Column>
        <Column header="Process Percent" field="process_Percent" style="min-width: 8rem">
                <template #body="{data}">
                    <a-progress :steps="5" :percent="data.process_Percent" class="pro_per"/>
                </template>
        </Column>
        <Column header="Process Weight" field="process_Weight" style="min-width: 8rem">
            <template #body="{data}">
                <a-progress :steps="5" :percent="data.process_Weight"/>
            </template>
        </Column>
        <Column field="mainJoinBy" header="Main Join" style="min-width: 8rem">
            <template #body="{data}">
                {{data.mainJoinByName }}
            </template>
            <template #editor="{data}">
                <Dropdown v-model="data.mainJoinBy" :options="users" optionLabel="fullName" optionValue="id" placeholder="Select a Main Join" class="w-full" />
            </template>
        </Column>
        <Column field="auxiliaryJoins" header="Join" style="min-width: 10rem">
                    <template #body="{data}">
                        <a-tooltip v-if="data.auxiliaryJoins != null" placement="bottom">
                                            <template #title>
                                                <div class="grid grid-cols-1 gap-3">
                                                    <span v-for="item in data.auxiliaryJoins.map(p=>p.fullName)" :key="item.id"> 
                                                    {{item}}
                                                    </span>
                                                </div>  
                                            </template>
                                    <AvatarGroup class="mr-4">
                                        <Avatar v-for="item in data.auxiliaryJoins.map(p=>p.fullName)" :label="item.charAt(0)" shape="circle" :key="item.id"/>
                                    </AvatarGroup>
                        </a-tooltip>
                    </template>
        </Column>
                <Column header="Work Hour" field="workHour" style="min-width: 6rem">
                    <template #editor="{data}">
                        <InputNumber v-model="data.workHour" class="w-full" mode="decimal" :min="0" />
                    </template>
                </Column>
                <Column header="Start Date" field="startDate" style="min-width: 6rem">
                    <template #body="{data}">
                        {{data.startDate !=null? format(data.startDate, 'dd/MM/yyyy') :""}}
                    </template>
                   
                </Column>
                <Column header="Estimated Date" field="estimatedDate" style="min-width: 6rem">
                    <template #body="{data}">
                        {{data.estimatedDate !=null? format(data.estimatedDate, 'dd/MM/yyyy') :""}}
                    </template>
                </Column>
                <Column field="endDate" header="End Date" style="min-width: 6rem">
                    <template #body="{data}">
                        {{data.endDate !=null? format(data.endDate, 'dd/MM/yyyy') :""}}
                    </template>
                </Column>
                <Column header="Created By" field="createdByName" style="min-width: 8rem">
                    <template #body="{data}">
                        {{ data.createdByName }}
                    </template>
                </Column>
                <Column field="remark" header="Note" style="min-width: 8rem">
                </Column>
            </DataTable>
    </div>
</template>
<script setup>
import { ref,onMounted,watch } from 'vue';
import { format, parse,formatISO   } from 'date-fns';
const emit = defineEmits(['update:modelValue','tasks']);
const props = defineProps(['modelValue','tasks']);
const tasks = ref(props.tasks);
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
// watch props.tasks
watch(() => props.tasks, (newTasks) => {
  tasks.value = newTasks;
}, { deep: true });

const isLate = (date)=>{
    let plantDate = new Date(date);
    let currentDate = new Date();
    if(plantDate < currentDate){
        return true;
    }else{
        return false;
    }
}
</script>
