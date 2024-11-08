<template>
    <div id="divGrid" style="padding-bottom: 0 !important;" v-bind="getRootProps()">
        <DataTable v-model:selection="selectedDocuments" paginator :rows="50" sortMode="multiple" :metaKeySelection="true" :selectAll="selectAll" v-model:filters="filters" scrollable class="text-xs" stripedRows editMode="cell" :value="documents" @select-all-change="onSelectAllChange"  @update:selection="onSelectionChange"  @cell-edit-complete="onCellEditComplete" @cell-edit-init="onCellEditInit" filterDisplay="row" :globalFilterFields="['object.name', 'object.description', 'object.revisionName', 'object.fromTo']">
    <template #empty> No found. </template>
    <template #loading> Loading data. Please wait. </template>
    <Column selectionMode="multiple" headerStyle="width: 2rem" frozen>
        <!-- <template #body="{data}">
            <Checkbox v-if="data.type != 'folder'" :value="data" v-model="selectedDocuments"/>
        </template> -->
    </Column>
    <Column style="min-width: 50px">
        <template #body="{data }">
            <img v-if="data.isFolder" class="w-[18px] h-[18px] cursor-pointer" @click="openDocument(data)" src="../../../assets/images/folder_2.png"/>
            <img v-else :src="'/_nuxt/assets/'+data.fileExtensionIcon" class="w-[16px] h-[16px] cursor-pointer" @click="viewFile(data)"/>
        </template>
    </Column> 
    <Column header="Name" field="name" sortable style="min-width: 30rem">
        <template #body="{ data }">
            <span class="no-underline text-gray-700" :title="data.isFolder?data.vitualPath: data.vitualPath + '/' + data.name"><div>{{ data.name }} <img v-if="data.isNewFile"  src="../../../assets/images/new.png"/> <i v-if="!data.isHasFile" class="pi pi-exclamation-triangle text-[#ff9900]" title="File Not Found"/></div></span>
        </template>
        <template #editor="{ data }"> 
            <div v-if="permissionFolderSelect != null && permissionFolderSelect.isWrite && data.isFolder">
                <InputText  v-model="data.name" autofocus style="min-width: 30rem"/>
            </div>
            <a v-else href="#" class="no-underline text-gray-700"><div>{{ data.name }} <img v-if="data.isNewFile"  src="../../../assets/images/new.png"/> <i v-if="!data.isHasFile" class="pi pi-exclamation-triangle text-[#ff9900]" title="File Not Found"/></div></a>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Description" sortable field="title" style="min-width: 30rem" :rowEditor="false" v-if="docView.includes('2')">
        <template #editor="{ data }">
            <div v-if="permissionFolderSelect != null && permissionFolderSelect.isWrite && data.isFolder">
                <InputText v-if="data.isFolder" v-model="data.title" autofocus style="min-width: 30rem"/>
            </div>
            <div v-else-if="permissionParent != null && permissionParent.isWrite && !data.isFolder">
                <InputText v-if="!data.isFolder" v-model="data.title" autofocus style="min-width: 30rem"/>
            </div>
            <div v-else>
                <div v-if="data.isFolder">{{ data.title }}</div>
                <div v-else>{{ data.title }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Document Number" sortable field="documentNumber" style="min-width: 15rem" v-if="docView.includes('1')">
        <template #editor="{ data }">
            <div v-if ="permissionParent != null && permissionParent.isWrite">
                <InputText v-if="!data.isFolder" v-model="data.documentNumber" autofocus style="min-width: 15rem"/>
            </div>
           <div v-else>
                <div v-if="!data.isFolder && permissionParent != null && permissionParent.isWrite == true">{{ data.documentNumber }}</div>
           </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Revision" sortable field="revisionName" style="min-width: 15rem" v-if="docView.includes('3')">
        <template #editor="{ data }">
            <div v-if ="permissionParent != null && permissionParent.isWrite">
                <InputText v-if="!data.isFolder" v-model="data.revisionName" autofocus style="min-width: 15rem"/>
            </div>
           <div v-else>
                <div v-if="!data.isFolder && permissionParent != null && permissionParent.isWrite == true">{{ data.revisionName }}</div>
           </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="From/To" sortable field="fromTo" style="min-width: 15rem" v-if="docView.includes('5')">
        <template #editor="{ data }">
            <div v-if="permissionParent != null && permissionParent.isWrite">
                <InputText v-if="!data.isFolder" v-model="data.fromTo" autofocus style="min-width: 15rem"/>
            </div>
            <div v-else>
                <div v-if="!data.isFolder">{{ data.fromTo }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <div>
                <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
            </div>   
        </template>
    </Column>
    <Column header="Platform" sortable field="platFormName" style="min-width: 15rem" v-if="docView.includes('8')">
        <template #editor="{ data }">
            <div v-if="permissionParent != null && permissionParent.isWrite">
                <Dropdown v-if="!data.isFolder" showClear  v-model="data.platFormID" editable :options="plants" optionLabel="name" optionValue="id" placeholder="Select document type" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
            </div>
            <div v-else>
                <div v-if="!data.isFolder">{{ data.platFormName }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Contractor" sortable field="contractor" style="min-width: 15rem" v-if="docView.includes('10')">
        <template #editor="{ data }">
            <div v-if="permissionParent != null && permissionParent.isWrite">
                <InputText v-if="!data.isFolder" v-model="data.contractor" autofocus style="min-width: 15rem"/>
            </div>
            <div v-else>
                <div v-if="!data.isFolder">{{ data.contractor }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Document Type" sortable field="documentTypeName" style="min-width: 20rem" v-if="docView.includes('7')">
       
        <template #editor="{ data }">
            <div v-if="permissionParent != null && permissionParent.isWrite">
                <Dropdown v-if="!data.isFolder" showClear  v-model="data.documentTypeID" editable :options="documentTypes" optionLabel="name" optionValue="id" placeholder="Select document type" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
            </div>
            <div v-else>
                <div v-if="!data.isFolder">{{ data.documentTypeName }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Tag" sortable field="tagSystemPlant" style="min-width: 20rem" v-if="docView.includes('11')">
        <template #body="{data}">
            <div>{{data.tagName}}</div>
        </template>
        <template #editor="{ data }">
            <div v-if="permissionParent != null && permissionParent.isWrite">
                <MultiSelect v-if="!data.isFolder" showClear v-model="selectTags" :virtualScrollerOptions="{ itemSize: 30 }" :options="tags" :loading="loadingTag" filter optionLabel="tagSystemPlant" optionValue="id" placeholder="Select tag" :maxSelectedLabels="3" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" @change="tag_onChange(data)"/>
            </div>
            <div v-else>
                <div v-if="!data.isFolder">{{ data.tagName }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Discipline" sortable field="disciplineName" style="min-width: 20rem" v-if="docView.includes('6')">
        <template #editor="{ data }">
            <div v-if="permissionParent != null && permissionParent.isWrite">
                <Dropdown  v-if="!data.isFolder" showClear  v-model="data.disciplineID" editable :options="disciplines" optionLabel="name" optionValue="id" placeholder="Select discipline" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
            </div>
            <div v-else>
                <div v-if="!data.isFolder">{{ data.disciplineName }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Sub Type" sortable field="typeName" style="min-width: 20rem" v-if="docView.includes('7')">
        <template #editor="{ data }">
           <div v-if="permissionParent != null && permissionParent.isWrite == true">
            <Dropdown v-if="!data.isFolder" showClear   v-model="data.typeID" editable :options="types" optionLabel="name" optionValue="id" placeholder="Select types" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
           </div>
           <div v-else>
            <div v-if="!data.isFolder">{{ data.typeName }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Model" sortable field="modelName" style="min-width: 20rem" v-if="docView.includes('7')">
        <template #editor="{ data }">
           <div v-if="permissionParent != null && permissionParent.isWrite == true">
            <Dropdown v-if="!data.isFolder" showClear  v-model="data.modelID" editable :options="models" optionLabel="name" optionValue="id" placeholder="Select model" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
           </div>
           <div v-else>
            <div v-if="!data.isFolder">{{ data.modelName }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <!-- <Column header="Manufacturer" field="object.manufacturerName" style="min-width: 20rem">
        <template #body="{ data }">
            <div v-if="data.isFolder">{{ data.manufacturerName }}</div>
        </template>
        <template #editor="{ data }">
           <div v-if="permissionParent != null && permissionParent.isWrite == true">
            <Dropdown v-if="data.isFolder" v-model="data.manufacturerID" editable :options="manufacturers" optionLabel="name" optionValue="id" placeholder="Select manufacturer" class="flex-auto border-[#cbd5e1] border border-solid text-ellipsis w-[200px]" />
           </div>
           <div v-else>
            <div v-if="data.isFolder">{{ data.manufacturerName }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column> -->
    <Column header="Remarks" sortable field="remark" style="min-width: 20rem" v-if="docView.includes('9')">
        <template #editor="{ data }">
            <div v-if="permissionParent != null && permissionParent.isWrite">
                <InputText v-if="!data.isFolder" v-model="data.remark" autofocus style="min-width: 20rem"/>
            </div>
            <div v-else>
                <div v-if="!data.isFolder">{{ data.remark }}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column>
    <Column header="Create By Name" sortable field="createdByName" style="min-width: 15rem" v-if="docView.includes('12')">
        <template #filter="{ filterModel, filterCallback }">
            <InputText v-model="filterModel.value" type="text" @input="filterCallback()" class="p-column-filter" placeholder="Search..." />
        </template>
    </Column> 
    <Column header="Date" field="date" sortable dataType="date" style="min-width: 15rem" v-if="docView.includes('4')">
        <template #body="{ data }">
            <div v-if="!data.isFolder">{{data.date !=null? format(data.date, 'dd/MM/yyyy') :""}}</div>
        </template>
        <template #editor="{ data }">
            <div v-if="permissionParent != null && permissionParent.isWrite">
                <Calendar v-if="!data.isFolder" v-model="data.date" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" class="p-column-filter" @focus="formatValue(data)"/>
            </div>
            <div v-else>
                <div v-if="!data.isFolder">{{data.date !=null? format(data.date, 'dd/MM/yyyy') :""}}</div>
            </div>
        </template>
        <template #filter="{ filterModel, filterCallback }">
            <Calendar v-model="filterModel.value" dateFormat="dd/mm/yy" placeholder="dd/mm/yyyy" mask="99/99/9999" @date-select="filterCallback()" @change="filterCallback()" class="p-column-filter"/>
        </template>
    </Column>
    <Column style="min-width: 3rem" frozen alignFrozen="right">
        <template #header>
            <i v-if="openClose==false" class="pi pi-angle-right cursor-pointer" @click="openInfor()"></i>
            <i v-else class="pi pi-angle-left cursor-pointer" @click="closeInfor()"></i>
        </template>
        <template #body="{ data }">
            <i class="pi pi-ellipsis-v cursor-pointer" @click="(event)=> toggle(event, data)"></i>
        </template>
    </Column>
</DataTable>
<Dialog v-model:visible="visibleViewFile" modal header=" " class="w-full h-full max-h-full" id="viewFile">
    <viewDocument :Id="ViewId" v-model="visibleViewFile"/>
</Dialog>
<loading v-model:active="isLoading"
                 :is-full-page="true" color="#3B82F6"/>
<Toast />
    </div>
</template>
<script setup>
import '../../../assets/CSS/styleMain.css';
import { ref, onMounted,watch, getCurrentInstance,nextTick   } from 'vue';
import {Folder} from '~/models/folder.js';
import {useDocument} from "~/stores/document";
import {useFolder} from "~/stores/folder";
import {usePermissionFolder} from "~/stores/permissionFolder";
import {useDisciplines} from "~/stores/disciplines";
import {Document} from '../../models/document.js';
import {useModel} from "~/stores/model";
import {useManufacturer} from "~/stores/manufacturer";
import {useTag} from "~/stores/tag";
import { FilterMatchMode,FilterOperator  } from 'primevue/api';
import {useDomain} from "~/stores/domain";
import Loading from 'vue-loading-overlay';
import { useDocPropertiesView } from '~/stores/docPropertiesView';
import { format, parse,formatISO   } from 'date-fns';
import { storeToRefs } from 'pinia';
import {useTypeFile} from "~/stores/typeFile";
import { useToast } from "primevue/usetoast";
import { usePlatForm } from '~/stores/platForm';
import { useDropzone } from "vue3-dropzone";
import folderIconSrc from '~/assets/images/folder_2.png';
const toast = useToast();
const {image} = storeToRefs(useTypeFile());
const {video} = storeToRefs(useTypeFile());
const {autoCard} = storeToRefs(useTypeFile());
const {url} = storeToRefs(useDomain());
import {openSidebarRight,closeSidebarRight} from '../../assets/js/sidebar.js';
import Toast from 'primevue/toast';
const emit = defineEmits(['documents','nextbreadcrumbItems','openDocument','toggle','modelValue','permissionParent','categoryID','parentFolderID']);
const props = defineProps(['documents','permissionParent','categoryID','parentFolderID','modelValue']);
const parentFolderID = ref(props.parentFolderID);
const documents = ref([]);
const dragElement = ref();
const isLoading = ref(false);
const pngRef = ref();
const elRef = ref();
const selectedDocuments = ref(props.modelValue);
const tags = ref([]);
const types = ref([]);
const disciplines = ref([]);
const plants = ref([]);
const selectPlant = ref([]);
const documentTypes = ref([]);
const documentTypesAll = ref([]);
const selectTags = ref([]);
const openClose = ref(false);
const permissionParent = ref(props.permissionParent);
const categoryID = ref(props.categoryID);
const visibleViewFile = ref(false);
const loadingTag = ref(false);
const ViewId = ref("");
const permissionFolderSelect = ref({
    isWrite: false,
    isRead: false,
    isDelete: false,
    isChangePer: false,
    isCreate: false,
});
const docView = ref([]);
const selectAll = ref(false);
const models = ref([]);
const manufacturers = ref([]);
const onDrop = (acceptFiles, rejectReasons)=> {
    if(permissionParent.value != null && permissionParent.value.isWrite){
    uploadFiles(acceptFiles);
    }else{
        toast.add({ severity: 'error', summary: 'Error Message', detail: "Access denied!", life: 5000 });
    }
 }
 const dropzoneProps = useDropzone({ onDrop });
 const getRootProps = dropzoneProps.getRootProps;
 const getInputProps = dropzoneProps.getInputProps;
 const rest = dropzoneProps;
 const isDragActive = dropzoneProps.isDragActive;
const filters = ref({
    global: { value: null, matchMode: FilterMatchMode.CONTAINS },
    'name': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'title': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'remark': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'createdByName': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'date': { value: null, matchMode: FilterMatchMode.DATE_IS },
    'revisionName': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'fromTo': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'platFormName': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'contractor': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'disciplineName': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'typeName': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'modelName': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'manufacturerName': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'tagSystemPlant': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'documentTypeName': { value: null, matchMode: FilterMatchMode.CONTAINS },
    'documentNumber': { value: null, matchMode: FilterMatchMode.CONTAINS }
});
onMounted( async() => {
    documents.value = props.documents;
    convertDate(documents.value);
    await loadAllDocumentType();
 //   await loadAllTag();
   // await loadDisciplines();
   // await loadModels();
    await loadManufacturers();
    await loadDocPropertiesView();
    //await LoadPlants();
});
watch(() => props.documents, (newValue) => {

    documents.value = newValue;
    convertDate(documents.value);
});
watch(() => props.modelValue, (newValue) => {
selectedDocuments.value = newValue;
});
const convertDate = (data)=>{
    data.forEach(element => {
        if(!element.isFolder && element.date != null){
            element.date = new Date(element.date);
        }
    });
}
watch(() => props.permissionParent, (newValue) => {
    permissionParent.value = newValue;
});
watch(() => props.categoryID, (newValue) => {
    categoryID.value = newValue;
    loadDocPropertiesView();
});
const loadDocPropertiesView =async ()=>{
    try{
        const data = await useDocPropertiesView().getDocPropertiesByCategory(categoryID.value);
        if(data.propertyIndex != null && data.propertyIndex != ""){
            docView.value = data.propertyIndex.replace(/\s+/g, '').split(",");
        }
    }catch(error){
        console.log("Error get list model:"+error);
    }
};
const LoadPlants = async () => {
        try{
            plants.value = await usePlatForm().getAll();
        }
        catch(error){
            console.log("Error get list plant:"+error);
        }
}
const loadAllTag = async () => {
        try{
            tags.value = await useTag().getAll();
        }
        catch(error){
            console.log("Error get list tag:"+error);
        }
}
const loadDisciplines = async () => {
    try{
            disciplines.value = await useDisciplines().getAll();
        }
        catch(error){
            console.log("Error get list model:"+error);
    }
}
const loadAllDocumentType = async () => {
        try{
            documentTypesAll.value = await useDocumentType().getAll();
            documentTypes.value = documentTypesAll.value.filter(x => x.parentId == null);
        }
        catch(error){
            console.log("Error get list document type:"+error);
        }
}
const loadModels = async () => {
    try{
        models.value = await useModel().getAll();
    }catch(error){
        console.log("Error get list model:"+error);
    }
}
const loadManufacturers= async () => {
    try{
        manufacturers.value = await useManufacturer().getAll();
    }catch(error){
        console.log("Error get list manufacturer:"+error);
    }
}
const openDocument = async (data) => {
    if(data.isFolder){
        if(data.isFolder && categoryID.value != 0 && categoryID.value != null){
        permissionFolderSelect.value = await usePermissionFolder().getJsonPermissionByFolder(data.id,categoryID.value);
        console.log(permissionFolderSelect.value);
        if(permissionFolderSelect.value.isRead){
            //navigateTo("/document_library/"+categoryID.value+"/"+data.id);
            navigateTo(`/document_library?category=${categoryID.value}&folder=${data.id}`,{external:true});
        }else{
            toast.add({ severity: 'error', summary: 'Error Message', detail: "Access denied Folder!", life: 5000 });
        }
    }
       // navigateTo("/document_library/"+categoryID.value+"/"+data.id);
        //window.location.href = "/document_library/"+categoryID.value+"/"+data.id;
    }
}
const toggle = (event,data) => {
    emit('toggle',{event,data});
};
const onSelectAllChange = (e)=>{
    selectAll.value = e.checked;
    if (selectAll.value) {
   // selectedDocuments.value = documents.value.filter((x) => !(x.isFolder && x.isHasSubFolder));
   selectedDocuments.value = documents.value;
  } else {
    selectedDocuments.value = [];
  }
 emit('update:modelValue',selectedDocuments.value);
};
const onSelectionChange = (value) => {
    // if(value.length >0){
    //     if(value[value.length - 1].isFolder && value[value.length - 1].isHasSubFolder){
    //     toast.add({ severity: 'error', summary: 'Error Message', detail: "You are not allowed to select a folder with subfolders!", life: 5000 });
    //     }
    // }
    // selectedDocuments.value = selectedDocuments.value.filter(x => !(x.isFolder && x.isHasSubFolder));
    selectedDocuments.value = selectedDocuments.value;
    emit('update:modelValue',selectedDocuments.value);
  selectAll.value = value.length === documents.value.length;
};
const onCellEditComplete = async (event) =>{
    let { data, newValue, field,newData } = event;
      switch (field) {
        case "documentTypeName":
            if(data.documentTypeID != null && data.documentTypeID != 0 && data.typeID != null && data.typeID != 0){
                if(data.documentTypeID != newData.documentTypeID){
                    toast.add({
                        severity: 'error',
                        summary: 'Error Message',
                        detail: "This document has been type. You cannot change the document type!",
                        life: 5000
                    });
                    break;
                }
            }
            if(data.documentTypeID != null && data.documentTypeID != 0 && data.modelID != null && data.modelID != 0){
                if(data.documentTypeID != newData.documentTypeID){
                    toast.add({
                        severity: 'error',
                        summary: 'Error Message',
                        detail: "This document has been model. You cannot change the document type!",
                        life: 5000
                    });
                    break;
                }
            }
            if(newData.documentTypeID != null && data.documentTypeID != 0 ){
                var name = documentTypes.value.filter(x => x.id == newData.documentTypeID)[0].name;
            data.documentTypeID = newData.documentTypeID;
            data.documentTypeName = name;
            }else{
                data.documentTypeID = null;
                data.documentTypeName = null;
                data.typeID = null;
                data.typeName = null;
                data.modelID = null;
                data.modelName = null;
            }
            break;
        case "disciplineName":
            if(newData.disciplineID != null && newData.disciplineID != 0){
                var name = disciplines.value.filter(x => x.id == newData.disciplineID)[0].name;
                data.disciplineID = newData.disciplineID;
                data.disciplineName = name;
            }else{
                data.disciplineID = null;
                data.disciplineName = null;
            }
            break;
        case "modelName":
            var model = models.value.filter(x => x.id == newData.modelID)[0];
            if(model != null){
                data.modelID = newData.modelID;
                 data.modelName = model.name;
                 if(model.manufacturerId != null){
                var manufacturer = manufacturers.value.filter(model.manufacturerId)[0];
                data.manufacturerID = manufacturer.id;
                data.manufacturerName = manufacturer.name;
            }
            }else{
                data.modelID = null;
                data.modelName = null;
                data.manufacturerID = null;
                data.manufacturerName = null;
            }
            break;
            case "platFormName":
            if(newData.tagID != null && newData.tagID != 0){
                if(data.platFormID != newData.platFormID){
                    toast.add({
                        severity: 'error',
                        summary: 'Error Message',
                        detail: "This document has been tagged. You cannot change the plat form!",
                        life: 5000
                    });
                    break;
                }
            }
            if(newData.platFormID != null && newData.platFormID != 0 ){
                var name = plants.value.filter(x => x.id == newData.platFormID)[0].name;
                data.platFormID = newData.platFormID;
                data.platFormName = name;
                break;
            }else{
                data.platFormID = null;
                data.platFormName = null;
                data.tagID = null;
                data.tagSystemPlant = null;
                data.tagName = null;
                break;
            }
        case "tagSystemPlant":
            // newValue = selectTags.value;
            // var tagIDs = "";
            // var tagNames = "";
            // var name = '';
            // newValue.forEach(x => tagIDs+= x + ",");
            // newValue.forEach(x => tagNames+= tags.value.find(y => y.id == x).tagSystemPlant + ",");
            // newValue.forEach(x => name+= tags.value.find(y => y.id == x).name + ",");
            // tagIDs = tagIDs.slice(0, -1);
            // tagNames = tagNames.slice(0, -1);
            // name = name.slice(0, -1);
            // data.tagSystemPlant = tagNames;
            //  data.tagName = name;
            //  data.tagID = tagIDs;
            break;
        case "typeName":
            if(newData.typeID != null && newData.typeID != 0){
                var name = types.value.filter(x => x.id == newData.typeID)[0].name;
                data.typeID = newData.typeID;
                data.typeName = name;
            }else{
                data.typeID = null;
                data.typeName = null;
            }
            break;
        case "date":
            if (newValue != null) {
                var date = new Date(newValue);
                console.log(date);
                data[field] = newValue;
            }
            break;
          default:
          if (newValue != null) data[field] = newValue.trim();
            break;
    }
    if(!data.isFolder){
       
        await useDocument().update(data);
    }else{
        var folder = new Folder();
        folder.id = data.id;
        folder.name = data.name;
        folder.description = data.title;
        await useFolder().update(folder);
    }
}
const onCellEditInit =async (event) =>{
    const { data, field } = event;
    if(field == "tagSystemPlant"){
        if(data.platFormID != null && data.platFormID != 0){
            try{
                loadingTag.value = true;
                tags.value = await useTag().getByPlatForm(data.platFormID);
                var tagIDs = tags.value.map(x => x.id);       
                selectTags.value = (data.tagID != "" && data.tagID != null)? data.tagID.split(",").map(Number):[];     
                if(selectTags.value != null && selectTags.value != "" && selectTags.value.length > 0){
                   selectTags.value = selectTags.value.filter(x => tagIDs.includes(x));
                } else{
                    selectTags.value = [];
                }  
            }catch(error){
                console.log("Error get list tag:"+error);
            }finally{
                loadingTag.value = false;
            }
        }else{
            tags.value = [];
            selectTags.value = [];
        }
    }
    else if(field == "disciplineName"){
        disciplines.value = await useDisciplines().getAll();
    }
    else if(field == "platFormName"){
        plants.value = await usePlatForm().getAll();
    }
    else if(field == "typeName"){
       if(data.documentTypeID != null){
        var documentType = documentTypesAll.value.filter(x => x.id == data.documentTypeID)[0];
        if(documentType.isVendorDocument == false || documentType.isVendorDocument == null){
            console.log(data.documentTypeID);
            types.value = documentTypesAll.value.filter(x => x.parentId == data.documentTypeID);
            }else{
                types.value = [];
                data.typeID = null;
                data.typeName = null;
            }
        }else{
            types.value = [];
            data.typeID = null;
            data.typeName = null;
        }
    }
    else if(field == "modelName"){
        if(data.documentTypeID != null){
        var documentType = documentTypesAll.value.filter(x => x.id == data.documentTypeID)[0];
        if(documentType.isVendorDocument == true){
           await loadModels();
            }else{
                models.value = [];
                data.modelID = null;
                data.modelName = null;
            }
        }else{
            models.value = [];
            data.modelID = null;
            data.modelName = null;
        }
     }
    if(data.isFolder && categoryID.value != 0 && categoryID.value != null){
        permissionFolderSelect.value = await usePermissionFolder().getJsonPermissionByFolder(data.id,categoryID.value);
    }
}
const viewFile = (data)=>{
   if(data.isHasFile){
    if(permissionParent.value != null && permissionParent.value.isRead == true){
        ViewId.value = data.id;
        visibleViewFile.value = true;
    }else{
        toast.add({ severity: 'error', summary: 'Error Message', detail: "Access denied file!", life: 5000 });
    }
   }else{
    toast.add({ severity: 'error', summary: 'Error Message', detail: "File Not Found!", life: 5000 });
   }
}
const openInfor = () => {
    openSidebarRight("250px");
    openClose.value = true;
}
const closeInfor = () => {
    closeSidebarRight();
    openClose.value = false;
}
const tag_onChange = async(data) => {
            var newValue = selectTags.value;
            var tagIDs = "";
            var tagNames = "";
            var name = '';
            newValue.forEach(x => tagIDs+= x + ",");
            newValue.forEach(x => tagNames+= tags.value.find(y => y.id == x).tagSystemPlant + ",");
            newValue.forEach(x => name+= tags.value.find(y => y.id == x).name + ",");
            tagIDs = tagIDs.slice(0, -1);
            tagNames = tagNames.slice(0, -1);
            name = name.slice(0, -1);
            data.tagSystemPlant = tagNames;
             data.tagName = name;
             data.tagID = tagIDs;
             await useDocument().update(data);
             var index = documents.value.findIndex(t=>t.id==data.id && !(t.isFolder));
             documents.value[index].tagID = data.tagID;
             documents.value[index].tagName = data.tagName;
             documents.value[index].tagSystemPlant = data.tagSystemPlant;
}
const formatValue = (data)=>{
    if (data.date) {
    data.date = parse(format(data.date, 'dd/MM/yyyy'), 'dd/MM/yyyy', new Date());
  }
}
const uploadFiles = async(files) => {
    isLoading.value = true;
   try{
        for (const file of files) {
        var praID = parentFolderID.value;
        var folders = file.path.split("/").slice(1).slice(0, -1);
       
        for (let folder of folders) {
            try {
                folder = folder.replace("&", "*!and!*");
                const res = await useFolder().getByName(folder, praID, categoryID.value);
                if (!res) {
                    folder = folder.replace("*!and!*", "&");
                    let newFolder = new Folder();
                    newFolder.name = folder;
                    newFolder.parentID = praID;
                    newFolder.categoryID = categoryID.value;
                    newFolder = await useFolder().create(newFolder);
                    // Cập nhật praID nếu cần
                    praID = newFolder.id;
                }else{ 
                    praID = res.id;
                }
            } catch (error) {
                console.error("Error:", error);
            }
        }
        var newFile = new Document();
                newFile.name = file.name;
                newFile.folderID = praID;
                newFile.categoryID = categoryID.value;
                newFile.fileExtension = file.name.split('.').pop();
                newFile.size = file.size;
                var formData = new FormData();
                formData.append('formFile', file);
                formData.append('jsonDocument', JSON.stringify(newFile));
                formData.append('folderID', praID);
      
                var data = await useDocument().create(formData);
               
                if(typeof data === 'string'){
                    toast.add({ severity: 'warn', summary: 'Warn Message', detail: data, life: 5000 });
                }
        }
        var fd = {
            type:"folder",
            object:new Folder()
        }
        fd.object.id = parentFolderID.value;
        fd.object.categoryID = categoryID.value;
        emit('openDocument',fd.object);
        useFolder().refreshFoldersByCategory(categoryID.value);
        emit('update:modelValue', false);
        toast.add({ severity: 'success', summary: 'Success Message', detail: 'Upload successfull!', life: 5000 });
   }catch(error){ 
        toast.add({ severity: 'error', summary: 'Error Message', detail: 'Upload fail!.', life: 5000 });
        console.log(error);
   }
   finally{
    isLoading.value = false;
   }
}
</script>
<style>
#viewFile .p-dialog-content{
    padding: 0px;
    height: 100%;
    overflow: hidden;
}
#viewFile .p-dialog-header{
    padding: 10px !important;
}
</style>
