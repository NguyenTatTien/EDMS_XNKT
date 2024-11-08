//init useDocumentType
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlDocumentTypeGetAll,urlDocumentTypeByParent,urlDocumentTypeNotParent,urlDocumentTypeCreate,urlDocumentTypeDelete,urlDocumentTypeUpdate,urlDocumentTypeExport,urlDocumentTypeImport,urlDocumentTypeAllParent} from '~/api/setupAPI.js';

export const useDocumentType = defineStore('documentType', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getAll() {
            let returnData = await useAxios().value.get(`${urlDocumentTypeGetAll}`)
            return returnData.data
        },
        async getDocumentTypeByParent(parentId: number) {
            let returnData = await useAxios().value.get(`${urlDocumentTypeByParent}?parentId=${parentId}`)
            return returnData.data
        },
        async getDocumentTypeNotParent() {
            let returnData = await useAxios().value.get(`${urlDocumentTypeNotParent}`)
            return returnData.data
        },
        async create(documentType: any) {
            let returnData = await useAxios().value.post(`${urlDocumentTypeCreate}`, documentType)
            return returnData.data  
            },
        async update(documentType: any) {
            let returnData = await useAxios().value.put(`${urlDocumentTypeUpdate}`, documentType)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlDocumentTypeDelete}?id=${id}`)
            return returnData.data
        },
        async export() {
            let returnData = await useAxios().value.get(`${urlDocumentTypeExport}`)
            return returnData.data
        },
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlDocumentTypeImport}`, data)
            return returnData.data
        },
        async getAllParent() {
            let returnData = await useAxios().value.get(`${urlDocumentTypeAllParent}`)
            return returnData.data
        }  
    }
})
