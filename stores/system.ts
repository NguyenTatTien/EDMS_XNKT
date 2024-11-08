//init useSystem
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlSystemGetAll,urlSystemCreate,urlSystemDelete,urlSystemUpdate,urlSystemExport,urlSystemImport} from '~/api/setupAPI.js'
export const useSystem = defineStore('system', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getAll() {
            let returnData = await useAxios().value.get(`${urlSystemGetAll}`)
            this.data = returnData.data
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlSystemCreate}`, data)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlSystemDelete}?id=${id}`)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlSystemUpdate}`, data)
            return returnData.data
        },
        async export() {
            let returnData = await useAxios().value.get(`${urlSystemExport}`)
            return returnData.data
        },
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlSystemImport}`, data)
            return returnData.data
        }
}
})