//init useModel
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlWorkflowGetAll,urlWorkflowCreate,urlWorkflowDelete,urlWorkflowUpdate,urlWorkflowAttachWorkflow,urlWorkflowDeleteWorkflow} from '~/api/setupAPI.js'
export const useWorkflow = defineStore('workflow', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getAll() {
            let returnData = await useAxios().value.get(`${urlWorkflowGetAll}`)
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlWorkflowCreate}`, data)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlWorkflowUpdate}`, data)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlWorkflowDelete}?id=${id}`)
            return returnData.data
        },
        async attachWorkflow(workflowID: number,projectID:number) {
            let returnData = await useAxios().value.post(`${urlWorkflowAttachWorkflow}?workflowID=${workflowID}&projectID=${projectID}`)
            return returnData.data
        },
        async deleteWorkflow(projectID:number) {
            let returnData = await useAxios().value.delete(`${urlWorkflowDeleteWorkflow}?projectId=${projectID}`)
            return returnData.data
        }
    }
})