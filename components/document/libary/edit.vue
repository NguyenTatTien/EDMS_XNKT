<template>
    <div class="w-[400px] px-[10px]">
        <span class="p-text-secondary block mb-5">Enter doucment information.</span>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Name</label>
        <InputText v-if="documentEdit != null" v-model="documentEdit.object.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Description</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.object.documentNumber" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Description</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.object.title" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Tab</label>
        <!-- <Dropdown  v-if="documentEdit != null" v-model="selectTab" editable :options="tabs" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" /> -->
        <MultiSelect v-if="documentEdit != null" v-model="selectTag" :options="tags" filter optionLabel="tabSystemPlant" placeholder="Select tag" :maxSelectedLabels="3" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]"/> 
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Document Type</label>
        <Dropdown  v-if="documentEdit != null" v-model="selectDocumentType" editable :options="documentTypes" optionLabel="name" placeholder="Select document type" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label for="username" class="font-semibold w-[6rem]">Discipline</label>
        <Dropdown  v-if="documentEdit != null" v-model="selectDisciplines" editable :options="disciplines" optionLabel="name" placeholder="Select discipline" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Model</label>
        <Dropdown  v-if="documentEdit != null" v-model="selectModel" :options=" models" optionLabel="name" placeholder="Select model" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Standard</label>
        <Dropdown  v-if="documentEdit != null" v-model="selectStandard" :options="standards" optionLabel="name" placeholder="Select standard" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <!-- <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Contractor</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.object.contractor" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Form To</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.object.fromTo" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div> -->
    <div class="flex items-center gap-3 mb-3">
        <FileUpload name="demo[]" :multiple="false" :maxFileSize="1000000" class="w-full" @select="document_onSelect">
            <template #empty>
            </template>
        </FileUpload>
    </div>
    <div class="flex justify-center gap-2">
        <Button type="button" label="Cancel" severity="secondary" icon="pi pi-times" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" icon="pi pi-save" class="p-2 text-white" @click="savedocument"></Button>
    </div>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import {modelGetAllAPI} from "../../../api/modelAPI";
import {disciplinesGetAllAPI} from "../../../api/disciplinesAPI.js";
import {createDocumentAPI,updateDocumentAPI} from  '../../../api/documentAPI.js';
import {tagGetAllAPI} from '../../../api/tagAPI';
import {documentTypeGetAllAPI,documentTypeByParentAPI} from '../../../api/documentTypeAPI';
const emit = defineEmits(['closeNav', 'documents','documentEdit','parentFolderID']);
const props = defineProps(['documents','documentEdit','parentFolderID']);
const models = ref([]);
const tags = ref([]);
const selectDisciplines = ref([]);
const selectDocumentType = ref([]);
const selectTag = ref([]);
const selectModel = ref([]);
const selectFile = ref(null);
const documentTypes = ref([]);
const disciplines = ref([]);
const standards = ref([]);
const selectStandard = ref([]);
const documents = ref(props.documents);
const documentEdit = ref(props.documentEdit);
const parentFolderID = ref(props.parentFolderID);
onMounted(async ()=>{
    await getModels();
    await getDisciplines();
    await loadAllTag();
    await loadAllDocumentType();
    await getStandards();
    updateDropdown();
});
watch(() => props.documentEdit, (newValue) => {
    documentEdit.value = newValue;
    updateDropdown();
});
const updateDropdown = () => {
    selectDisciplines.value = disciplines.value.find(x => x.id == documentEdit.value.object.disciplineID);
    selectDocumentType.value = documentTypes.value.find(x => x.id == documentEdit.value.object.documentTypeID);
    selectModel.value = models.value.find(x => x.id == documentEdit.value.object.modelID);
    selectStandard.value = standards.value.find(x => x.id == documentEdit.value.object.standardID);
    documentEdit.value.object.tagID.split(",").forEach(x => selectTag.value.push(tags.value.find(y => y.id == x)));
}
watch(() => props.documents, (newValue) => {
    documents.value = newValue;
});
const loadAllTag = async () => {
        try{
            tags.value = await tagGetAllAPI();
        }
        catch(error){
            console.log("Error get list tab:"+error);
        }
    }
    const loadAllDocumentType = async () => {
        try{
            documentTypes.value = await documentTypeGetAllAPI();
        }
        catch(error){
            console.log("Error get list document type:"+error);
        }
}
const closeDialog = () => {
    emit('closeNav');
}
const getModels = async () => {
    try{
        models.value = await modelGetAllAPI();
        }
        catch(error){
            console.log("Error get list model:"+error);
    }
}
const getDisciplines = async () => {
    try{
            disciplines.value = await disciplinesGetAllAPI();
        }
        catch(error){
            console.log("Error get list model:"+error);
    }
}
const getStandards = async () => {
    try{
        standards.value = await documentTypeByParentAPI(3);
    }    
    catch(error){
        console.log("Error get list document type:"+error);
    }
}
const savedocument = async () => {
        var tagIDs = "";
        var tagNames = "";
        selectTag.value.map(x => x.id).forEach(x => tagIDs+= x + ",");
        selectTag.value.map(x => x.name).forEach(x => tagNames+= x + ",");
        tagIDs = tagIDs.slice(0, -1);
        tagNames = tagNames.slice(0, -1);
        documentEdit.value.object.disciplineID = selectDisciplines.value? selectDisciplines.value.id:null;
        documentEdit.value.object.disciplineName = selectDisciplines.value? selectDisciplines.value.name:"";
        documentEdit.value.object.documentTypeID = selectDocumentType.value? selectDocumentType.value.id:null;
        documentEdit.value.object.documentTypeName = selectDocumentType.value? selectDocumentType.value.name:"";
        documentEdit.value.object.tagID = tagIDs;
        documentEdit.value.object.tagName = tagNames;
        documentEdit.value.object.modelID = selectModel.value? selectModel.value.id:null;
        documentEdit.value.object.modelName = selectModel.value? selectModel.value.name:"";
        documentEdit.value.object.standardID = selectStandard.value? selectStandard.value.id:null;
        documentEdit.value.object.standardName = selectStandard.value? selectStandard.value.name:"";
        if(selectFile.value != null){
            documentEdit.value.object.fileExtension = selectFile.value.name.split('.')[1];
            if(selectFile.value.name.split('.')[1]=="docx" || selectFile.value.name.split('.')[1]=="doc"){
                documentEdit.value.object.fileExtensionIcon = "/images/wordfile.png";
            }else if(selectFile.value.name.split('.')[1]=="pdf"){
                documentEdit.value.object.fileExtensionIcon = "/images/pdffile.png";
            }else if(selectFile.value.name.split('.')[1]=="xlsx" || selectFile.value.name.split('.')[1]=="xls"){
                documentEdit.value.object.fileExtensionIcon = "/images/excelfile.png";
            }
        }
    if(documentEdit.value.object.id == 0){
        
        insertDocument();
    }
    else{
        updateDocument();
    }
    emit('update:documents', documents.value);
}
const insertDocument = async () => {
   try{
        documentEdit.value.object.folderID = parentFolderID.value;
        var document = await createDocumentAPI(documentEdit.value.object);
        documents.value.push({type:'document',object: document});
   }
   catch(error){
       console.log(error);
   }
}
const updateDocument = async () => {
   try{
        await updateDocumentAPI(documentEdit.value.object);
        var document = documents.value.map(item =>{
                if(item.object.id == documentEdit.value.object.id){
                return documentEdit.value;
            }else{
                return item;
            }
        });
    }
    catch(error){
        console.log(error);
    }
}
const document_onSelect = (event) =>{
    selectFile.value = event.files[0];
}
</script>
<style>
    .p-fileupload-buttonbar .p-button[aria-label="Upload"],.p-fileupload-buttonbar .p-button[aria-label="Cancel"]{
        display: none !important;
    }
    .p-fileupload-choose{
        width: max-content !important;
    }
    .p-fileupload{
        width: 100% !important;
}
</style>