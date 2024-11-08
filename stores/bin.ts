// init useCategories
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlBinDelete,urlBinGetAll,urlBinRestore} from '~/api/setupAPI.js'
export const useBin = defineStore('bin', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        //get all categories
        async getAll() {
            let returnData = await useAxios().value.get(`${urlBinGetAll}`)
            this.data = returnData.data
            return returnData.data
        },
        //get all categories by permission
        //delete categories
        async delete(id: number,isFolder:boolean) {
            let returnData = await useAxios().value.delete(`${urlBinDelete}?Id=${id}&IsFolder=${isFolder}`)
            return returnData.data
        },
        //update categories
        async restore(id: number,isFolder:boolean) {
            let returnData = await useAxios().value.post(`${urlBinRestore}?Id=${id}&IsFolder=${isFolder}`)
            return returnData.data
        },
    }
})
             