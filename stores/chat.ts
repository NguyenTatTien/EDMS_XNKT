// init useCategories
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlChatCreate,urlChatGetByProject,urlChatDelete,urlChatSendMail } from '~/api/setupAPI.js'
export const useChat = defineStore('chat', {
    state: () => {
        return {
            data: [],
            categoriesStore:[],
        }
    },
    actions: {
        //get all categories
        async getByProject(projectID: number) {
            let returnData = await useAxios().value.get(`${urlChatGetByProject}?projectID=${projectID}`);
            this.data = returnData.data
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlChatCreate}`, data);
            return returnData.data
        },
        //delete categories
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlChatDelete}?id=${id}`);
            return returnData.data
        },
        async sendMail(data: any,projectID: number) {
            let returnData = await useAxios().value.post(`${urlChatSendMail}?projectID=${projectID}`, data);
            return returnData.data
        }
    },
    persist: {
        storage: persistedState.localStorage,
      },
})
             