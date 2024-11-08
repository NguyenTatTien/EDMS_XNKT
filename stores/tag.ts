//init tag
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlTagGetAll,urlCreateTag,urlUpdateTag,urlDeleteTag,urlExportTag,urlImportTag,urlTagGetById,urlTagGetByInfor,urlGetByPlatForm,urlExportDataTag,urlImportDataTag} from '~/api/setupAPI.js';
export const useTag = defineStore('tag', {
    state: () => ({
        tags: [],
    }),
    actions: {
        //get all tag
        async getAll() {
            let returnData = await useAxios().value.get(`${urlTagGetAll}`)
           
            return returnData.data
        },
        async getByPlatForm(platFormID: number) {
            let returnData = await useAxios().value.get(`${urlGetByPlatForm}?platFormID=${platFormID}`)
            
            return returnData.data
        },
        //create tag
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlCreateTag}`, data)
            return returnData.data
        },
        //update tag
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlUpdateTag}`, data)
            return returnData.data
        },
        //delete tag
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlDeleteTag}?id=${id}`)
            return returnData.data
        },
        //export tag
        async export() {
            let returnData = await useAxios().value.get(`${urlExportTag}`)
            return returnData.data
        },
        //import tag
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlImportTag}`, data)
            return returnData.data
        },
        //get tag by id
        async getById(id: number) {
            let returnData = await useAxios().value.get(`${urlTagGetById}?id=${id}`)
            return returnData.data
        },
        //get tag by infor
        async getByInfor(tag: string, plant: string) {
            let returnData = await useAxios().value.get(`${urlTagGetByInfor}?tag=${tag}&plant=${plant}`)
            return returnData.data
        },
        //export data tag
        async exportData(data:any) {
            let returnData = await useAxios().value.post(`${urlExportDataTag}`,data);
            return returnData.data
        },
        //import data tag 
        async importData(data: any) {
            let returnData = await useAxios().value.post(`${urlImportDataTag}`, data)
            return returnData.data
        },
    }
})