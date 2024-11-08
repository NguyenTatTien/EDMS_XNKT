//init usePlant
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlPlatFormGetAll,urlPlatFormCreate,urlPlatFormDelete,urlPlatFormUpdate,urlPlatFormExport,urlPlatFormImport} from '~/api/setupAPI.js'
export const usePlatForm = defineStore('platform', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        //get all plant
        async getAll() {
            let returnData = await useAxios().value.get(`${urlPlatFormGetAll}`)
            return returnData.data
        },
        //create plant
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlPlatFormCreate}`, data)
            return returnData.data
        },
        //delete plant
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlPlatFormDelete}?id=${id}`)
            return returnData.data
        },
        //update plant
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlPlatFormUpdate}`, data)
            return returnData.data
        },
        //export plant
        async export() {
            let returnData = await useAxios().value.get(`${urlPlatFormExport}`)
            return returnData.data
        },
        //import plant
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlPlatFormImport}`, data)
            return returnData.data
        }
    }
})