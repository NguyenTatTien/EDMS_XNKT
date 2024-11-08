//init useModel
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlWorkflowStepGetByWorkflow,urlWorkflowStepCreate,urlWorkflowStepDelete,urlWorkflowStepUpdate} from '~/api/setupAPI.js'
export const useWorkflowStep = defineStore('workflowStep', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getByWorkflow(id: number) {
            let returnData = await useAxios().value.get(`${urlWorkflowStepGetByWorkflow}?id=${id}`)
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlWorkflowStepCreate}`, data)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlWorkflowStepUpdate}`, data)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlWorkflowStepDelete}?id=${id}`)
            return returnData.data
        },
    }
})