// init useCategories
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlChatStatusGetUnRead,urlChatStatusUpdateReadByProject } from '~/api/setupAPI.js'
export const useChatStatus = defineStore('chatStatus', {
    state: () => {
        return {
            data: [],
            categoriesStore:[],
        }
    },
    actions: {
        //get all categories
        async getUnRead() {
            let returnData = await useAxios().value.get(`${urlChatStatusGetUnRead}`);
            return returnData.data
        },
        async updateReadByProject(projectID:number) {
            let returnData = await useAxios().value.put(`${urlChatStatusUpdateReadByProject}?projectID=${projectID}`);
            return returnData.data
        },
       
        //delete categoriesl
    },
    persist: {
        storage: persistedState.localStorage,
      },
})
             