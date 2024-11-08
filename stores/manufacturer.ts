// init useManufacturer
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlManufacturerGetAll,urlCreateManufacturer,urlUpdateManufacturer,urlDeleteManufacturer,urlExportManufacturer,urlImportManufacturer,urlManufacturerGetById} from '~/api/setupAPI.js'
export const useManufacturer = defineStore('manufacturer', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getAll() {
            let returnData = await useAxios().value.get(`${urlManufacturerGetAll}`)
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlCreateManufacturer}`, data)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlUpdateManufacturer}`, data)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlDeleteManufacturer}?id=${id}`)
            return returnData.data
        },
        async export() {
            let returnData = await useAxios().value.get(`${urlExportManufacturer}`)
            return returnData.data
        },
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlImportManufacturer}`, data)
            return returnData.data
        },
        //getById
        async getById(id: number) {
            let returnData = await useAxios().value.get(`${urlManufacturerGetById}?id=${id}`,{
                headers: {
                    'Content-Type': 'application/json'
                  }
            })
            return returnData.data
        }
    }
})