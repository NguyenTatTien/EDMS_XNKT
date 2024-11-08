//init useModel
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlModelGetAll,urlCreateModel,urlUpdateModel,urlDeleteModel,urlExportModel,urlImportModel,urlModelGetById} from '~/api/setupAPI.js'
export const useModel = defineStore('model', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getAll() {
            let returnData = await useAxios().value.get(`${urlModelGetAll}`)
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlCreateModel}`, data)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlUpdateModel}`, data)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlDeleteModel}?id=${id}`)
            return returnData.data
        },
        async export() {    
            let returnData = await useAxios().value.get(`${urlExportModel}`)
            return returnData.data
        },
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlImportModel}`, data)
            return returnData.data
        },
       //getById
         async getById(id: number) {
          let returnData = await useAxios().value.get(`${urlModelGetById}?id=${id}`,{
            headers: {
                'Content-Type': 'application/json'
              }
          })
          return returnData.data
         }
    }
})