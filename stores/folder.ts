//init useFolder
import { defineStore } from 'pinia'
import {urlFolderGetNotParentByCategory,urlFolderGetByParentAndCategory,urlMoveFolderToFolder,urlCretateFolder,urlUpdateFolder,urlDeleteFolder,urlCopyFolder,urlSearchFolder,urlGetFolderByName,urlDownloadFolder,urlGetAllFolderByCategory,urlSearchFolderByCategory,urlGetListParentFolder,urlGetByParentAndCategoryNotPermission,urlDeleteMultiFolder,urlFolderSetPrivate,urlFolderGetAllPermissionWrite,urlFolderGetByID} from '~/api/setupAPI.js';
import { useAxios } from '~/composables/useAxios';
export const useFolder = defineStore('folder', {
    state: () => {
      return {
        data: [],
        foldersStore:[],
      }
      
    },
    actions: {
      //get folder by id
      async getFolderById(id: number) {
        let returnData = await useAxios().value.get(`${urlFolderGetByID}?Id=${id}`)
        return returnData.data;
      },
      //get all folder
      async getFolderNotParentByCategory(categoryId:number) {
        let returnData = await useAxios().value.get(`${urlFolderGetNotParentByCategory}?categoryId=${categoryId}`)
        this.data = returnData.data
        return returnData.data;
      },
      //get folder by parent and category
      async getFolderByParentAndCategory(parentId: number,categoryId: number) {
        let returnData = await useAxios().value.get(`${urlFolderGetByParentAndCategory}?parentId=${parentId}&categoryId=${categoryId}`)
        this.data = returnData.data;
        return returnData.data;
      },
      async getFolderByParentAndCategoryNotPermission(parentId: number,categoryId: number) {
        let returnData = await useAxios().value.get(`${urlGetByParentAndCategoryNotPermission}?parentId=${parentId}&categoryId=${categoryId}`)
        this.data = returnData.data;
        return returnData.data;
      },
      //move folder
      async moveFolder(folderMoveId: number, folderPasteId: number) {
        let returnData = await useAxios().value.post(`${urlMoveFolderToFolder}?folderMoveId=${folderMoveId}&folderPasteId=${folderPasteId}`)
        return returnData.data
      },
      //create folder
      async create(data: any) {
        let returnData = await useAxios().value.post(`${urlCretateFolder}`, data);
        return returnData.data
      },
      //update folder
      async update(data: any) {
        let returnData = await useAxios().value.put(`${urlUpdateFolder}`, data);
        return returnData.data
      },
      //delete folder
      async delete(id: number) {
        let returnData = await useAxios().value.delete(`${urlDeleteFolder}?id=${id}`);
        return returnData.data
      },
      //delete multi folder
      async deleteMulti(Ids: any) {
        let returnData = await useAxios().value.post(`${urlDeleteMultiFolder}`, Ids);
        return returnData.data
      },
      //copy folder
      async copyFolder(folderId: number,folderPasteId: number) {
        let returnData = await useAxios().value.post(`${urlCopyFolder}?folderCopyID=${folderId}&folderPasteID=${folderPasteId}`)
        return returnData.data
      },
      //search folder
      async search(name: string) {
        let returnData = await useAxios().value.get(`${urlSearchFolder}?name=${name}`)
        return returnData.data
      },
      //get folder by name
      async getByName(name: string,parentID: number,categoryID: number) {
        let returnData = await useAxios().value.get(`${urlGetFolderByName}?name=${name}&parentID=${parentID}&categoryID=${categoryID}`)
        return returnData.data
      },
      //download folder
      async download(id: number,categoryId: number) {
        let returnData = await useAxios().value.get(`${urlDownloadFolder}?selectfolder=${id}&categoryID=${categoryId}`)
        return returnData.data;
      },
      //get all folder by category
      async getAllFolderByCategory(categoryId: number) {
        let returnData = await useAxios().value.get(`${urlGetAllFolderByCategory}?categoryId=${categoryId}`);
        this.foldersStore = returnData.data;
        return returnData.data
      },
      //search folder by category
      async searchByCategory(search: string,categoryID:number) {
        let returnData = await useAxios().value.get(`${urlSearchFolderByCategory}?search=${search}&categoryID=${categoryID}`)
        return returnData.data
      },
      async getListParentFolder(folderId:number){
        let returnData = await useAxios().value.get(`${urlGetListParentFolder}?folderId=${folderId}`)
        return returnData.data
      },
      clearFolders() {
        this.foldersStore = [];
      },
      async refreshFoldersByCategory(categoryID: number) {
        await this.getAllFolderByCategory(categoryID);
      },
      async setPrivate(folderId: number, isPrivate: boolean) {
        let returnData = await useAxios().value.post(`${urlFolderSetPrivate}?Id=${folderId}&isPrivate=${isPrivate}`)
        return returnData.data
      },
      async getAllPermissionWrite() {
        let returnData = await useAxios().value.get(`${urlFolderGetAllPermissionWrite}`)
        return returnData.data
      }
    },
    persist: {
      storage: persistedState.localStorage,
    },
  })