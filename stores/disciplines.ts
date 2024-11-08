//init useDisciplines
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlDisciplinesGetAll,urlDisciplinesCreate,urlDisciplinesDelete,urlDisciplinesUpdate,urlDisciplinesExport,urlDisciplinesImport} from '~/api/setupAPI.js'
export const useDisciplines = defineStore('disciplines', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        //get all disciplines
        async getAll() {
            let returnData = await useAxios().value.get(`${urlDisciplinesGetAll}`)
            return returnData.data
        },
        //create disciplines
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlDisciplinesCreate}`, data)
            return returnData.data
        },
        //delete disciplines
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlDisciplinesDelete}?id=${id}`)
            return returnData.data
        },
        //update disciplines
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlDisciplinesUpdate}`, data)
            return returnData.data
        },
        //export disciplines
        async export() {
            let returnData = await useAxios().value.get(`${urlDisciplinesExport}`)
            return returnData.data
        },
        //import disciplines
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlDisciplinesImport}`, data)
            return returnData.data
        },

    }
})