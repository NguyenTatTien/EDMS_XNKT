//init useUnit
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlUnitGetAll,urlUnitCreate,urlUnitDelete,urlUnitUpdate,urlUnitExport,urlUnitImport} from '~/api/setupAPI.js'
export const useUnit = defineStore('unit', {
    state: () => {
        return {
            data: []
        }
    },
    actions: {
        async getAll() {
            let returnData = await useAxios().value.get(`${urlUnitGetAll}`)
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlUnitCreate}`, data)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlUnitDelete}?id=${id}`)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlUnitUpdate}`, data)
            return returnData.data
        },
        async export() {
            let returnData = await useAxios().value.get(`${urlUnitExport}`)
            return returnData.data
        },
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlUnitImport}`, data)
            return returnData.data
        }
    }
})