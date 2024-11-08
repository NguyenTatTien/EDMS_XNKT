//init useGroup
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlGroupGetAll,urlUpdateGroup,urlCreateGroup,urlDeleteGroup,urlExportGroup,urlImportGroup} from '~/api/setupAPI.js'
export const useGroup = defineStore('group', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        //get all group
        async getAll() {
            let returnData = await useAxios().value.get(`${urlGroupGetAll}`)
            return returnData.data
        },
        //create group
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlCreateGroup}`, data)
            return returnData.data
        },
        //update group
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlUpdateGroup}`, data)
            return returnData.data
        },
        //delete group
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlDeleteGroup}?id=${id}`)
            return returnData.data
        },
        //export group
        async export() {
            let returnData = await useAxios().value.get(`${urlExportGroup}`)
            return returnData.data
        },
        //import group
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlImportGroup}`, data)
            return returnData.data
        },

    }

})