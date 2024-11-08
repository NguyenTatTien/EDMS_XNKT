<template>
  <div class="" style="width:100% ; height: 100%">
      <div id="map">
              
      </div>
  </div>
</template>
<script setup>
import MindElixir from "mind-elixir";
import example from "mind-elixir/example";
import { onMounted, ref, watch } from 'vue';
const emit = defineEmits(['modelValue','nodeData','selectTag']);
const props = defineProps(['nodeData','selectTag']);
const nodeData = ref();
const selectTag = ref();
const me = ref();

watch(() => props.nodeData, (newValue) => {
    console.log(newValue);
    nodeData.value = newValue;
});
watch(() => props.selectTag, (newValue) => {
  selectTag.value = newValue;
});
onMounted(() => {
  nodeData.value = props.nodeData;
  selectTag.value = props.selectTag;
  me.value = new MindElixir({
      el: "#map",
      direction: MindElixir.LEFT,
  });
  example.nodeData.id=''+ selectTag.value.id;
  example.nodeData.topic = selectTag.value.name;
example.nodeData.tags[0] = selectTag.value.tagSystemPlant;
nodeData.value.forEach((item) => {
    item.parent.id=''+selectTag.value.id,
    item.parent.topic = selectTag.value.tagSystemPlant,
    item.parent.expanded = true,
    item.parent.root = true
  });
 
  example.nodeData.children = nodeData.value;
  console.log(example);
  me.value.init(example);
  me.value.toCenter();
});
</script>
<style>
#map {
  height: 100%;
  width: 100%;
}
.map-container me-tpc>* {
  pointer-events: all !important;
}
</style>
<!-- <template>
    <VueFlow
 :nodes="nodes" :edges="edges"
 class=".vue-flow__node-custom" />

</template>
<script setup>
import { VueFlow, } from '@vue-flow/core';

import { ref, onMounted } from 'vue';
const nodes = ref([
 {
   id: '1',
   position: { x: -250, y: 300 },
   label: 'Tab',
 },
 { id: '2', label: 'Doucment', position: { x: -15, y: 300 }, },
 { id: '3', label: 'Design Document', position: { x: 200, y: 400 } },
 { id: '4', label: 'Vendor Document', position: { x: 200, y: 300 } },
 { id: '5', label: 'Standard Document', position: { x: 250, y: 50 } },
 { id: '6', label: 'Layout', position: { x:400, y: 450 } },
 { id: '7', label: 'DataSheet', position: { x: 350, y: 550 } },
 { id: '8', label: 'ISO', position: { x: 500, y: 0 } },
 { id: '9', label: 'TCVN', position: { x: 500, y: 100 } },
 { id: '10', label: 'VSP01-E-123-CONNECTION DIAGRAM OF JUNCTION BOX.PDF', position: { x: 500, y: 200 } },
 { id: '11', label: 'VSP01-E-116-ARRANGEMENT OF ANTENNA.PDF', position: { x: 500, y: 250 } },
 { id: '12', label: 'VSP01-E-123-CONNECTION DIAGRAM OF JUNCTION BOX.PDF', position: { x: 500, y: 300 } },
 { id: '13', label: 'VSP01-E-124-CONNECTION DIAGRAM OF ELECTRICAL POWER SYSTEM.PDF', position: { x: 500, y: 350 } },
 { id: '14', label: 'VSP01-E-201-1-INSTRUCTION.PDF', position: { x: 800, y: -50 } },
 { id: '15', label: 'VSP01-E-200-2-TEST REPORT.PDF', position: { x: 800, y: 0 } },
 { id: '16', label: 'VSP01-E-200-1-INSTRUCTION.PDF', position: { x: 800, y: 100 } },
 { id: '17', label: 'VSP01-E-200-2-TEST REPORT.PDF', position: { x: 800, y: 150 } },
 { id: '18', label: 'VSP01-E-200-DIESEL GENERATOR.PDF', position: { x: 800, y: 200 } },
 { id: '19', label: 'VSP01-E-212-MAIN CONTROL CONSOLE & MONITORING SYSTEM.PDF', position: { x: 800, y: 350 } },
 { id: '20', label: 'VSP01-E-201-1-INSTRUCTION.PDF', position: { x: 800, y: 400 } },
 { id: '21', label: 'VSP01-E-202-2-TEST REPORT.PDF', position: { x: 800, y: 450 } },
 { id: '22', label: 'VSP01-E-211-GAS DETECTION AND ALARM (OUT LINE, INSTRUCTION, TEST REPORT).PDF', position: { x: 800, y: 500 } },
]);
const edges = ref([
 {
   id: 'e1-2',
   source: '1',
   target: '2',
 },
 {
   id: 'e2-3',
   source: '2',
   target: '3',
 },{
   id: 'e2-4',
   source: '2',
   target: '4',
 },
 {
   id: 'e2-5',
   source: '2',
   target: '5',
 },
 {
   id: 'e3-6',
   source: '3',
   target: '6',
 },
 {
   id: 'e3-7',
   source: '3',
   target: '7',
 },
 {
   id: 'e5-8',
   source: '5',
   target: '8',

 },
 {
   id: 'e5-9',
   source: '5',
   target: '9',

 },
 {
   id: 'e4-10',
   source: '4',
   target: '10',

 },
 {
   id: 'e4-11',
   source: '4',
   target: '11',

 },
 {
   id: 'e4-12',
   source: '4',
   target: '12',

 },
 {
   id: 'e4-13',
   source: '4',
   target: '13',

 },
 {
   id: 'e8-14',
   source: '8',
   target: '14',

 },
 {
   id: 'e8-15',
   source: '8',
   target: '15',

 },
 {
   id: 'e9-16',
   source: '9',
   target: '16',

 },
 {
   id: 'e9-17',
   source: '9',
   target: '17',

 },
 {
   id: 'e9-18',
   source: '9',
   target: '18',

 },
 {
   id: 'e6-19',
   source: '6',
   target: '19',

 },
 {
   id: 'e6-20',
   source: '6',
   target: '20',

 },
 {
   id: 'e7-21',
   source: '7',
   target: '21',

 },
 {
   id: 'e7-22',
   source: '7',
   target: '22',

 },
]);
const me = ref();
onMounted(() => {

});
</script>
<style>
@import '@vue-flow/core/dist/theme-default.css';
@import '@vue-flow/core/dist/style.css';

</style> -->
<style>
.main-node-container img{
  float: left;
  margin-right: 5px;
}
</style>
