//init usePlant
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlTypeCreate,urlTypeDelete,urlTypeUpdate,urlTypeGetAll} from '~/api/setupAPI.js'
export const useType = defineStore('type', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        //get all plant
        async getAll() {
            let returnData = await useAxios().value.get(`${urlTypeGetAll}`)
            return returnData.data
        },
        //create plant
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlTypeCreate}`, data)
            return returnData.data
        },
        //delete plant
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlTypeDelete}?id=${id}`)
            return returnData.data
        },
        //update plant
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlTypeUpdate}`, data)
            return returnData.data
        },
        //export plant
        // async export() {
        //     let returnData = await useAxios().value.get(`${urlPlatFormExport}`)
        //     return returnData.data
        // },
        // //import plant
        // async import(data: any) {
        //     let returnData = await useAxios().value.post(`${urlPlatFormImport}`, data)
        //     return returnData.data
        // }
    }
})