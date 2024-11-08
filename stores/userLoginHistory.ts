//init useUser
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlGetAllLoginHistory} from '~/api/setupAPI.js'
export const useUserLoginHistory = defineStore('userLoginHistory', {
  state: () => {
    return {
      data: [],
    }
  },
  actions: {
    //get all user
    async getAll() {
      let returnData = await useAxios().value.get(`${urlGetAllLoginHistory}`)
      return returnData.data
    },
    //update user
   
    
  }
})