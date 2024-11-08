//init useSystem
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlAttachDocumentGetByDocument,urlAttachDocumentCreate,urlAttachGetDocumentDocumentAttachToProject,urlAttachGetDocumentDocumentAttachToPhase,urlAttachGetDocumentDocumentAttachToTask} from '~/api/setupAPI.js'
export const useAttachDocument = defineStore('attachDocument', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getByDocument(documentId: number) {
            let returnData = await useAxios().value.get(`${urlAttachDocumentGetByDocument}?documentID=${documentId}`)
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(urlAttachDocumentCreate, data)
            return returnData.data
        },
        async getDocumentAttachToProject(projectId: number) {
            let returnData = await useAxios().value.get(`${urlAttachGetDocumentDocumentAttachToProject}?projectID=${projectId}`)
            return returnData.data
        },
        async getDocumentAttachToPhase(phaseId: number) {
            let returnData = await useAxios().value.get(`${urlAttachGetDocumentDocumentAttachToPhase}?phaseID=${phaseId}`)
            return returnData.data
        },
        async getDocumentAttachToTask(taskId: number) {
            let returnData = await useAxios().value.get(`${urlAttachGetDocumentDocumentAttachToTask}?taskID=${taskId}`)
            return returnData.data
        },

    }
})