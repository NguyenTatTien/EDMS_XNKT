// init useCategories
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlChatMembersGetAllByProject,urlChatMembersCreate,urlChatMembersDelete } from '~/api/setupAPI.js'
export const useChatMembers = defineStore('chatMembers', {
    state: () => {
        return {
            data: [],
            categoriesStore:[],
        }
    },
    actions: {
        //get all categories
        async getByProject(projectID: number) {
            let returnData = await useAxios().value.get(`${urlChatMembersGetAllByProject}?projectID=${projectID}`);
            this.data = returnData.data
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlChatMembersCreate}`, data);
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlChatMembersDelete}?id=${id}`);
            return returnData.data
        },
        //delete categories
    },
    persist: {
        storage: persistedState.localStorage,
      },
})
             