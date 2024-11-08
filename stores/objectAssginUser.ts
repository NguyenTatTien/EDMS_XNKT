
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlObjectAssginUserGetByProject,urlObjectAssignUserApprove,urlObjectAssginUserUpdate,urlObjectAssginUserReject,urlObjectAssginUserGetByID,urlObjectAssginUserGetNextStepID} from '~/api/setupAPI.js'
export const useObjectAssginUser = defineStore('objectAssginUser', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getByProject(id: number) {
            let returnData = await useAxios().value.get(`${urlObjectAssginUserGetByProject}?projectID=${id}`)
            return returnData.data
        },
        async getByID(id: number) {
            let returnData = await useAxios().value.get(`${urlObjectAssginUserGetByID}?Id=${id}`)
            return returnData.data
        },
        async getByNextStepID(id: number,projectID: number) {
            let returnData = await useAxios().value.get(`${urlObjectAssginUserGetNextStepID}?Id=${id}&projectID=${projectID}`)
            return returnData.data
        },
        async approve(objID: number,projectID : number) {
            let returnData = await useAxios().value.post(`${urlObjectAssignUserApprove}?objID=${objID}&projectID=${projectID}`)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(urlObjectAssginUserUpdate,data)
            return returnData.data
        },
        async reject(objID: number,projectID : number){
            let returnData = await useAxios().value.post(`${urlObjectAssginUserReject}?objID=${objID}&projectID=${projectID}`)
            return returnData.data
        }
    }
})