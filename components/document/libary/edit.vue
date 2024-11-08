<template>
    <div class="w-full">
        <span class="p-text-secondary block mb-5">Enter doucment information.</span>
    <div class="w-full px-[10px] h-[34rem]" style="overflow-y: scroll;">
        <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Name</label>
        <InputText v-if="documentEdit != null" v-model="documentEdit.name" id="username" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('1')">
        <label class="font-semibold w-[6rem]">Document Number</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.documentNumber" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('2')">
        <label class="font-semibold w-[6rem]">Description</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.title" id="fullName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('3')">
        <label class="font-semibold w-[6rem]">Revision</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.revisionName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('5')">
        <label class="font-semibold w-[6rem]">Form/To</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.fromTo" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('8')">
        <label class="font-semibold w-[6rem]">PlatForm</label>
        <Dropdown  v-if="documentEdit != null" v-model="selectPlant" editable :options="plants" optionLabel="name" placeholder="Select platform" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" @change="platForm_onChange"/>
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('10')">
        <label class="font-semibold w-[6rem]">Contractor</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.contractor" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('11')">
        <label class="font-semibold w-[6rem]">Tab</label>
        <!-- <Dropdown  v-if="documentEdit != null" v-model="selectTab" editable :options="tabs" optionLabel="name" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" /> -->
        <MultiSelect v-if="documentEdit != null" v-model="selectTag" :options="tags" :virtualScrollerOptions="{ itemSize: 30 }" filter optionLabel="tagSystemPlant" placeholder="Select tag" :maxSelectedLabels="3" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]"/> 
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('7')">
        <label class="font-semibold w-[6rem]">Document Type</label>
        <Dropdown  v-if="documentEdit != null" v-model="selectDocumentType" editable :options="documentTypes" optionLabel="name" placeholder="Select document type" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" @change="docType_onChange"/>
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('6')">
        <label for="username" class="font-semibold w-[6rem]">Discipline</label>
        <Dropdown  v-if="documentEdit != null" v-model="selectDisciplines" editable :options="disciplines" optionLabel="name" placeholder="Select discipline" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('7')">
        <label class="font-semibold w-[6rem]">Sub Type</label>
        <Dropdown v-model="selectTypes" :options="types" optionLabel="name" placeholder="Select type" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div>
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('7')">
        <label class="font-semibold w-[6rem]">Model</label>
        <Dropdown v-model="selectModel" :options=" models" optionLabel="name" placeholder="Select model" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
        
    </div>
    
    <!-- <div class="flex items-center gap-3 mb-3">
        <label class="font-semibold w-[6rem]">Manufacturer</label>
        <Dropdown v-model="selectManufacturer" :options=" manufacturers" optionLabel="name" placeholder="Select type" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
    </div> -->
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('4')">
        <label class="font-semibold w-[6rem]">Date</label>
        <Calendar  v-if="documentEdit != null" v-model="documentEdit.date" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="p-column-filter flex-auto border-[#cbd5e1] border border-solid"/>
    </div>
    <!-- <div class="flex items-center gap-3 mb-3" v-if="docView.includes('12')">
        <label class="font-semibold w-[6rem]">Created By Name</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.createdByName" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div> -->
    <div class="flex items-center gap-3 mb-3" v-if="docView.includes('9')">
        <label class="font-semibold w-[6rem]">Remark</label>
        <InputText  v-if="documentEdit != null" v-model="documentEdit.remark" class="flex-auto border-[#cbd5e1] border border-solid" autocomplete="off" />
    </div>
    <div class="flex items-center gap-3 mb-3">
        <FileUpload name="demo[]" :multiple="false" :maxFileSize="1000000000" class="w-full" @select="document_onSelect" ref="fileUpload">
            <template #empty>
            </template>
            <template #content="{removeFileCallback}">
        <div v-if="selectFile != null">
            
            <div class="flex flex-wrap p-0 sm:p-5 gap-5">
                <div class="card m-0 flex flex-column border-1 surface-border align-items-center gap-3">
                    <div>
                        <img v-if="selectFile.type == 'application/pdf'" alt="pdf" src="../../../assets/images/pdf-64.png" class="max-w-[2rem] ">
                        <img v-else-if="selectFile.type == 'image/png' || selectFile.type =='image/jpeg'" alt="pdf" src="../../../assets/images/image-64.png" class="max-w-[2rem] ">
                        <img v-else-if="selectFile.type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' || selectFile.type == 'application/vnd.ms-excel'" alt="pdf" src="../../../assets/images/excel-64.png" class="max-w-[2rem] ">
                        <img v-else-if="selectFile.type == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' || selectFile.type == 'application/msword'" alt="pdf" src="../../../assets/images/word-64.png" class="max-w-[2rem] ">
                        <img v-else-if="selectFile.type == 'application/vnd.openxmlformats-officedocument.presentationml.presentation' || selectFile.type == 'application/vnd.ms-powerpoint'" alt="pdf" src="../../../assets/images/pp-64.png" class="max-w-[2rem] ">
                        <img v-else-if="selectFile.type == 'text/plain'" alt="pdf" src="../../../assets/images/document-64.png" class="max-w-[2rem] ">
                        <img v-else-if="selectFile.type == 'application/x-compressed'" alt="pdf" src="../../../assets/images/rar-64.png" class="max-w-[2rem] ">
                        <img v-else-if="selectFile.type == 'application/x-zip-compressed'" alt="pdf" src="../../../assets/images/zip-64.png" class="max-w-[2rem] ">
                        <img v-else alt="pdf" src="../../../assets/images/file-64.png" class="max-w-[2rem] ">
                    </div>
                    <span class="font-semibold">{{ selectFile.name }}</span>
                    <Button icon="pi pi-times" @click="onRemoveTemplatingFile(removeFileCallback)" outlined rounded  severity="danger" />
                </div>
            </div>
        </div>
        <div v-else></div>
        </template>
        <template #default>
        </template>
        </FileUpload>
    </div>
    </div>
    <div class="flex justify-center gap-2 fiexd sticky bottom-0">
        <Button type="button" label="Cancel" severity="secondary" icon="pi pi-times" class="bg-[#f1f5f9] p-2 text-black" @click="closeDialog"></Button>
        <Button type="button" label="Save" icon="pi pi-save" class="p-2 text-white" @click="savedocument"></Button>
    </div>
    <Toast />
    <loading v-model:active="isLoading"
    :is-full-page="true" color="#3B82F6"/>
    </div>
</template>
<script setup>
import { ref, onMounted } from 'vue';
import { useDocument } from "~/stores/document";
import { useDocumentType } from "~/stores/documentType";
import { useTag } from "~/stores/tag";
import { useDisciplines } from "~/stores/disciplines";
import { useToast } from "primevue/usetoast";
import { useDocPropertiesView } from '~/stores/docPropertiesView';
import { useManufacturer } from '~/stores/manufacturer';
import { usePlatForm } from '~/stores/platForm';
import Loading from 'vue-loading-overlay';
const isLoading = ref(false);
const toast = useToast();
const emit = defineEmits(['modelValue', 'documents','selectDocument','parentFolderID','categoryID']);
const props = defineProps(['documents','selectDocument','parentFolderID','categoryID']);
const tags = ref([]);
const selectDisciplines = ref([]);
const selectDocumentType = ref([]);
const selectTag = ref([]);
const types = ref([]);
const models = ref([]);
const manufacturers = ref([]);
const selectTypes = ref(null);
const selectModel = ref(null);
const selectFile = ref(null);
const fileUpload = ref(null);
const documentTypes = ref([]);
const disciplines = ref([]);
const plants = ref([]);
const selectPlant = ref(null);
const documents = ref(props.documents);
const documentEdit = ref(null);
const parentFolderID = ref(props.parentFolderID);
const categoryID = ref(props.categoryID);
const docView = ref([]);
onMounted(async ()=>{
     await getDisciplines();
    // await loadAllTag();
     await loadAllDocumentType();
     await loadDocPropertiesView();
     await getManufacturers();
     await loadAllPlant();
      updateDropdown();
      documentEdit.value = props.selectDocument;
});
watch(() => props.selectDocument, (newValue) => {
    documentEdit.value = newValue;
    updateDropdown();
});
const loadAllPlant = async () => {
    try{
        plants.value = await usePlatForm().getAll();
    }
    catch(error){
        console.log("Error get list plant:"+error);
    }
}
const loadDocPropertiesView =async ()=>{
    try{
       
        const data = await useDocPropertiesView().getDocPropertiesByCategory(categoryID.value);
        docView.value = data.propertyIndex.replace(/\s+/g, '').split(",");
        
    }catch(error){
        console.log("Error get list model:"+error);
    }
};
const updateDropdown = () => {
    // selectDisciplines.value = disciplines.value.find(x => x.id == documentEdit.value.disciplineID);
    // selectDocumentType.value = documentTypes.value.find(x => x.id == documentEdit.value.documentTypeID);
    // selectModel.value = models.value.find(x => x.id == documentEdit.value.modelID);
    // selectStandard.value = standards.value.find(x => x.id == documentEdit.value.standardID);
    // documentEdit.value.tagID != null ? documentEdit.value.tagID.split(",").forEach(x => selectTag.value.push(tags.value.find(y => y.id == x))):"";
    selectDisciplines.value = [];
    selectDocumentType.value = [];
    selectPlant.value = [];
    selectTypes.value = [];
    selectTag.value = [];
    fileUpload.value.clear();
    selectFile.value = null;
}
watch(() => props.documents, (newValue) => {
    documents.value = newValue;
});
const platForm_onChange= async()=>{
    try{
        //console.log(selectPlant.value)
            tags.value = await useTag().getByPlatForm(selectPlant.value.id);
        }
        catch(error){
            console.log("Error get list tab:"+error);
        }
}

const loadAllTag = async () => {
        try{
            tags.value = await useTag().getAll();
        }
        catch(error){
            console.log("Error get list tab:"+error);
        }
    }
    const loadAllDocumentType = async () => {
        try{
            documentTypes.value = await useDocumentType().getDocumentTypeNotParent();
           
        }
        catch(error){
            console.log("Error get list document type:"+error);
        }
}
const closeDialog = () => {
    emit('update:modelValue',false);
}
const getDisciplines = async () => {
    try{
            disciplines.value = await useDisciplines().getAll();
        }
    catch(error){
            console.log("Error get list model:"+error);
    }
}
const getManufacturers = async () => {
    try{
            manufacturers.value = await useManufacturer().getAll();
        }
    catch(error){
            console.log("Error get list manufacturer:"+error);
    }
}
const savedocument = async () => {
        isLoading.value = true;
       try{
        var tagIDs = "";
        var tagNames = "";
        var tagSystemPlant = "";
        selectTag.value.map(x => x.id).forEach(x => tagIDs+= x + ",");
        selectTag.value.map(x => x.name).forEach(x => tagNames+= x + ",");
        selectTag.value.map(x => x.tagSystemPlant).forEach(x => tagSystemPlant+= x + ",");
        tagIDs = tagIDs.slice(0, -1);
        tagNames = tagNames.slice(0, -1);
        tagSystemPlant = tagSystemPlant.slice(0, -1);
        documentEdit.value.disciplineID = selectDisciplines.value? selectDisciplines.value.id:null;
        documentEdit.value.disciplineName = selectDisciplines.value? selectDisciplines.value.name:"";
        documentEdit.value.platFormID = selectPlant.value? selectPlant.value.id:null;
        documentEdit.value.platFormName = selectPlant.value? selectPlant.value.name:"";
        documentEdit.value.documentTypeID = selectDocumentType.value? selectDocumentType.value.id:null;
        documentEdit.value.documentTypeName = selectDocumentType.value? selectDocumentType.value.name:"";
        documentEdit.value.modelID = selectModel.value? selectModel.value.id:null;
        documentEdit.value.modelName = selectModel.value? selectModel.value.name:"";
        if(selectModel.value != null){
            var manufacturer = manufacturers.value.find(x => x.id ==selectModel.value.manufacturerID);
            if(manufacturer != null){
                documentEdit.value.manufacturerID = manufacturer.id;
                documentEdit.value.manufacturerName = manufacturer.name;
            }
        }
        documentEdit.value.tagID = tagIDs;
        documentEdit.value.tagName = tagNames;
        documentEdit.value.tagSystemPlant = tagSystemPlant;
        documentEdit.value.typeID = selectTypes.value? selectTypes.value.id:null;
        documentEdit.value.typeName = selectTypes.value? selectTypes.value.name:"";
        documentEdit.value.folderID = parentFolderID.value;
        documentEdit.value.categoryID = categoryID.value;
        if(selectFile.value != null){
            documentEdit.value.fileExtension = selectFile.value.name.split('.')[1];
            if(selectFile.value.name.split('.')[1]=="docx" || selectFile.value.name.split('.')[1]=="doc"){
                documentEdit.value.fileExtensionIcon = "/images/wordfile.png";
            }else if(selectFile.value.name.split('.')[1]=="pdf"){
                documentEdit.value.fileExtensionIcon = "/images/pdffile.png";
            }else if(selectFile.value.name.split('.')[1]=="xlsx" || selectFile.value.name.split('.')[1]=="xls"){
                documentEdit.value.fileExtensionIcon = "/images/excelfile.png";
            }
    }
    if(documentEdit.value.id == 0){
        await insertDocument();
    }
    else{
       await updateDocument();
    }
    emit('update:documents', documents.value);
  
       }catch(error){
              
        toast.add({ severity: 'error', summary: 'Error Message', detail: 'Create document fail!', life: 5000 });
       }finally{
        emit('update:modelValue',false);
           isLoading.value = false;
       }
}
const insertDocument = async () => {
   try{
        var formData = new FormData();
        formData.append('formFile', selectFile.value);
        formData.append('jsonDocument', JSON.stringify(documentEdit.value));
        formData.append('folderID', parentFolderID.value);
        var document = await useDocument().create(formData);
        if(typeof document == 'string'){
            toast.add({ severity: 'warn', summary: 'Warning Message', detail: document, life: 5000 });
        }else{
            documents.value.push(document);
        toast.add({ severity: 'success', summary: 'Success Message', detail: 'Create document successfully!', life: 5000 });
        }
         
   }
   catch(error){
       console.log(error);
   }
}
const updateDocument = async () => {
   try{
        await useDocument().update(documentEdit.value);
        var document = documents.value.map(item =>{
                if(item.id == documentEdit.value.id){
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
    console.log(event);
    documentEdit.value.name = event.files[0].name;
}
const docType_onChange =async (e)=>{
    const parentID = e.value.id;
    if(e.value.isVendorDocument == true){
        types.value = []
        selectTypes.value = [];
        models.value = await useModel().getAll();
        return;
    }
    types.value = await useDocumentType().getDocumentTypeByParent(parentID);
    models.value = [];
}
const onRemoveTemplatingFile = (removeFileCallback)=>{
    removeFileCallback(0);
    selectFile.value = null
    documentEdit.value.name = "";
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