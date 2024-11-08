// init usePermissionFolder
import { defineStore } from 'pinia'
import axios from 'axios'
import { useAxios } from '~/composables/useAxios'
import {urlPermissionGetByFolder,urlCreateFolderPermission,urlDeleteFolderPermission,urlUpdateFolderPermission,urlGetPermissionByFolder} from '~/api/setupAPI.js'
export const usePermissionFolder = defineStore('permissionFolder', {
    state: () => {
        return {
            data: [],
            files:[],
            folder:[],
            fileAndFolder:[]
        }
    },
    actions: {
        //get permission by folder
        async getPermissionByFolder(folderId: number) {
            let returnData = await useAxios().value.get(`${urlPermissionGetByFolder}?folderId=${folderId}`)
            return returnData.data
        },
        //create folder permission
        async create(folderPermission: any,checkedAll:boolean) {
            let returnData = await useAxios().value.post(`${urlCreateFolderPermission}?checkedAll=${checkedAll}`,folderPermission)
            return returnData.data
        },
        //delete folder permission
        async delete(Id: number) {
            let returnData = await useAxios().value.delete(`${urlDeleteFolderPermission}?Id=${Id}`)
            return returnData.data
        },
        //update folder permission
        async update(folderPermission: any) {
            let returnData = await useAxios().value.put(`${urlUpdateFolderPermission}`,folderPermission)
            return returnData.data
        },
        //get json permission by folder
        async getJsonPermissionByFolder(folderId: number,categoryId: number) {
            let returnData = await useAxios().value.get(`${urlGetPermissionByFolder}?folderId=${folderId}&categoryId=${categoryId}`)
            return returnData.data
        }
    }
})