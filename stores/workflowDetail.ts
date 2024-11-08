//init useModel
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlWorkflowDetailGetByWorkflow,urlWorkflowDetailCreate,urlWorkflowDetailDelete,urlWorkflowDetailUpdate,urlWorkflowDetailUpdateStep} from '~/api/setupAPI.js'
export const useWorkflowDetail = defineStore('workflowDetail', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getByWorkflow(id: number) {
            let returnData = await useAxios().value.get(`${urlWorkflowDetailGetByWorkflow}?workflowID=${id}`)
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlWorkflowDetailCreate}`, data)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlWorkflowDetailUpdate}`, data)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlWorkflowDetailDelete}?id=${id}`)
            return returnData.data
        },
        async updateStep(data: any) {
            let returnData = await useAxios().value.put(`${urlWorkflowDetailUpdateStep}`, data)
            return returnData.data
        }
    }
})