import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlCustomizeWorkflowDetailsGetByWorkflowAndProject,urlCustomizeWorkflowDetialsUpdateAllByProject} from '~/api/setupAPI.js'
export const useCustomizeWorkflowDetails = defineStore('customizeWorkflowDetails', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getByWorkflowAndProject(workflowId: number, projectId: number) {
            let returnData = await useAxios().value.get(`${urlCustomizeWorkflowDetailsGetByWorkflowAndProject}?workflowId=${workflowId}&projectId=${projectId}`);
            this.data = returnData.data;
            return returnData.data;
        },
        async updateAllByProject(data: any,projectId: number,workflowId: number) {
            let returnData = await useAxios().value.post(`${urlCustomizeWorkflowDetialsUpdateAllByProject}?projectId=${projectId}&workflowId=${workflowId}`, data);
            return returnData.data;
        },
    },
})
