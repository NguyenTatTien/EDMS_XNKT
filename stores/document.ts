import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlDocumentGetAll,urlDocumentGetByFolder,urlGetAllDocumentsByListFolder,urlDocumentGetByType,urlCopyFileToFolder,urlMoveFileToFolder,urlGetDocumentByTag,
  urlGetDocumentByTagAndType,urlCreateDocument,urlUpdateDocument,urlDeleteDocument,urlExportDocument,urlSearchDocument,urlImportDocument,urlDownload,urlDownloadMulti,
  urlSearchDocumentByCategory,urlDocumentGetByID,urlDocumentUpload,urlDocumentDeleteFile,urlDocumentViewFile,urlGetDocumentsByListFolder,urlGet500Items,urlSearchContractor,
  urlSearchDocNumber,urlSearchDocType,urlSearchFormTo,urlSearchModel,urlSearchName,urlSearchPlatForm,urlSearchRemark,urlSearchSubType,urlSearchTag,urlSearchTitle,urlDeleteMulti,
  urlUploadDocument,urlGetCountDocuments,urlDocumentSearchAllChild,urlDocumentUploadInsDocument} from '~/api/setupAPI.js'
export const useDocument = defineStore('document', {
  state: () => {
    return {
      data: [],
      files:[],
      folder:[],
      fileAndFolder:[]
    }
  },
  actions: {
   async getDocumentByFolder(folderId: number) {
     let returnData = await useAxios().value.get(`${urlDocumentGetByFolder}?folderId=${folderId}`)
     this.data = returnData.data;
     return returnData.data;
    },
    //get all document
    async getAll() {
      let returnData = await useAxios().value.get(`${urlDocumentGetAll}`)
      this.data = returnData.data;
      return returnData.data;
    },
    //document by type
    async getByType(typeId: number) {
      let returnData = await useAxios().value.get(`${urlDocumentGetByType}?typeId=${typeId}`)
      return returnData.data
    },
    //copy file
    async copyFile(fileId: number, folderId: number) {
      let returnData = await useAxios().value.post(`${urlCopyFileToFolder}?fileId=${fileId}&folderId=${folderId}`)
      return returnData.data
    },
    //move file
    async moveFile(fileId: number, folderId: number) {
      let returnData = await useAxios().value.post(`${urlMoveFileToFolder}?fileId=${fileId}&folderId=${folderId}`)
      return returnData.data
    },
    //get document by tag
    async getDocumentByTag(tagId: number) {
      let returnData = await useAxios().value.get(`${urlGetDocumentByTag}?tagId=${tagId}`)
      return returnData.data
    },
    //get document by tag and type
    async getDocumentByTagAndType(tagId: number, typeId: number) {
      let returnData = await useAxios().value.get(`${urlGetDocumentByTagAndType}?tagId=${tagId}&typeId=${typeId}`)
      return returnData.data
    },
    //create document
    async create(data: any) {
      let returnData = await useAxios().value.post(`${urlCreateDocument}`, data)
      return returnData.data
    },
    //update document
    async update(data: any) {
      let returnData = await useAxios().value.put(`${urlUpdateDocument}`, data)
      return returnData.data
    },
    //delete document
    async delete(id: number) {
      let returnData = await useAxios().value.delete(`${urlDeleteDocument}?id=${id}`)
      return returnData.data
    },
    async deleteMulti(data:any) {
      let returnData = await useAxios().value.post(`${urlDeleteMulti}`, data)
      return returnData.data   
    },
    //export document
    async export(data:any) {
      let returnData = await useAxios().value.post(`${urlExportDocument}`,data)
      return returnData.data
    },
    //search document
    async search(data: any) {
      let returnData = await useAxios().value.post(`${urlSearchDocument}`, data)
      return returnData.data
    },
    //import document
    async import(data: any) {
      let returnData = await useAxios().value.post(`${urlImportDocument}`, data)
      return returnData.data
    },
    //download
    async download(data: any) {
      let returnData = await useAxios().value.post(`${urlDownload}`,data,{
        headers: {
          'Content-Type': 'application/json'
        },
      },)
      return returnData
    },
    //download multi
    async downloadMulti(data:any) {
      let returnData = await useAxios().value.post(`${urlDownloadMulti}`,data)
      return returnData
    },
    // search document by category
    async searchByCategory(search: string,categoryID:number) {
      let returnData = await useAxios().value.get(`${urlSearchDocumentByCategory}?search=${search}&categoryID=${categoryID}`)
      return returnData.data
    },
    async getByID(Id: number) {
      let returnData = await useAxios().value.get(`${urlDocumentGetByID}?Id=${Id}`)
      return returnData.data
    },
    async deleteFile(files: string) {
      let returnData = await useAxios().value.delete(`${urlDocumentDeleteFile}?filePath=${files}`)
      return returnData.data;
    },
    async ViewFile(id: number) {
      let returnData = await useAxios().value.get(`${urlDocumentViewFile}?Id=${id}`)
      return returnData.data;
    },
    async getDocumentsByListFolder(folders: any) {
      let returnData = await useAxios().value.post(`${urlGetDocumentsByListFolder}`,folders)
      return returnData.data;
    },
    async getAllDocumentsByListFolder(folders: any) {
      let returnData = await useAxios().value.post(`${urlGetAllDocumentsByListFolder}`,folders)
      return returnData.data;
    },
    //get 200 itemsq
    async get500Items() {
      let returnData = await useAxios().value.get(`${urlGet500Items}`)
      return returnData.data;
    },
    async getCountDocuments(){
      let returnData = await useAxios().value.get(`${urlGetCountDocuments}`)
      return returnData.data;
    },
    //search contractor
    async searchContractor(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchContractor}?search=${search}`)
      return returnData.data;
    },
    //search doc number
    async searchDocNumber(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchDocNumber}?search=${search}`)
      return returnData.data;
    },
    //search doc type
    async searchDocType(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchDocType}?search=${search}`)
      return returnData.data;
    },
    //search form to
    async searchFormTo(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchFormTo}?search=${search}`)
      return returnData.data;
    },
    //search model
    async searchModel(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchModel}?search=${search}`)
      return returnData.data;
    },
    //search name
    async searchName(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchName}?search=${search}`)
      return returnData.data;
    },
    //search platform
    async searchPlatForm(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchPlatForm}?search=${search}`)
      return returnData.data;
    },
    //search remark
    async searchRemark(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchRemark}?search=${search}`)
      return returnData.data;
    },
    //search sub type
    async searchSubType(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchSubType}?search=${search}`)
      return returnData.data;
    },
    //search tag
    async searchTag(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchTag}?search=${search}`)
      return returnData.data;
    },
    //search title
    async searchTitle(search: string) {
      let returnData = await useAxios().value.get(`${urlSearchTitle}?search=${search}`)
      return returnData.data;
    },
    async upload(data:any){
      let returnData = await useAxios().value.post(`${urlUploadDocument}`,data)
      return returnData.data;
    },
    async searchDocumentAllChild(folderID: number,search: string){
      let returnData = await useAxios().value.post(`${urlDocumentSearchAllChild}?folderID=${folderID}&search=${search}`)
      return returnData.data;
    },
    async uploadInsDocument(data:any){
      let returnData = await useAxios().value.post(`${urlDocumentUploadInsDocument}`,data)
      return returnData.data;
    }

  },
  persist: {
    storage: persistedState.localStorage,
  },
})