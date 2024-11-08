//init useSystem
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlPhaseCreate,urlPhaseDelete,urlPhaseUpdate,urlPhaseGetAllByProject,urlPhaseRequestApprove,urlPhaseApprove,urlPhaseGetByID,urlPhaseByListProjectID,urlPhaseCancel,urlPhaseRestore} from '~/api/setupAPI.js'
export const usePhase = defineStore('phase', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
     
        async update(task: any) {
            let returnData = await useAxios().value.put(`${urlPhaseUpdate}`,task)
            return returnData.data
        },
        async create(task: any) {
            let returnData = await useAxios().value.post(`${urlPhaseCreate}`,task)
            return returnData.data
        },
        async delete(Id: number) {
            let returnData = await useAxios().value.delete(`${urlPhaseDelete}?Id=${Id}`)
            return returnData.data
        },
        async getAllByProject(Id: number) {
            let returnData = await useAxios().value.get(`${urlPhaseGetAllByProject}?Id=${Id}`)
            return returnData.data
        },
        async requestApprove(data: any) {
            let returnData = await useAxios().value.post(`${urlPhaseRequestApprove}`,data)
            return returnData.data
        },
        async approve(data: any) {
            let returnData = await useAxios().value.post(`${urlPhaseApprove}`,data)
            return returnData.data
        },
        async getByID(Id: number) {
            let returnData = await useAxios().value.get(`${urlPhaseGetByID}?id=${Id}`)
            return returnData.data
        },
        async getByListProjectID(Ids: any) {
            let returnData = await useAxios().value.post(`${urlPhaseByListProjectID}`,Ids)
            return returnData.data
        },
        async cancel(data:any) {
            let returnData = await useAxios().value.put(`${urlPhaseCancel}`,data)
            return returnData.data
        },
        async restore(data:any) {
            let returnData = await useAxios().value.put(`${urlPhaseRestore}`,data)
            return returnData.data
        }
    }
})