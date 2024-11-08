//init useFolder
import { defineStore } from 'pinia'
import {urlGetDocPropertiesByCategory,urlDocPropertiesUpdate} from '~/api/setupAPI.js';
import { useAxios } from '~/composables/useAxios';
export const useDocPropertiesView = defineStore('DocPropertiesView', {
    state: () => {
      return {
        data: [],
      }
      
    },
    actions: {
      async getDocPropertiesByCategory(categoryId:number) {
        let returnData = await useAxios().value.get(`${urlGetDocPropertiesByCategory}?categoryId=${categoryId}`)
        this.data = returnData.data
        return returnData.data;
      },
      async update(data: any) {
        let returnData = await useAxios().value.put(`${urlDocPropertiesUpdate}`, data)
        return returnData.data
    },
      
    }
  })