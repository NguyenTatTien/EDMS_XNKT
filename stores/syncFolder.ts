//init useSyncFolder
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlSyncFolderGetAll,urlSyncFolder} from '~/api/setupAPI.js'
export const useSyncFolder = defineStore('syncFolder', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
     async getAll() {
         let returnData = await useAxios().value.get(`${urlSyncFolderGetAll}`)
         return returnData.data
        },
        async syncFolder(folderID:number,folderSyncID:number) {
            let returnData = await useAxios().value.post(`${urlSyncFolder}?folderID=${folderID}&folderSyncID=${folderSyncID}`)
            return returnData.data
        }
    }

})