//init useUser
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlUserGetAll,urlUpdateUser,urlDeleteUser,urlCreateUser,urlExportUser,urlImportUser,urlLogin,urlChangePassword,urlLogOut,urlLoginAdminUser,urlResetPassword} from '~/api/setupAPI.js'
export const useUser = defineStore('user', {
  state: () => {
    return {
      data: [],
      user:{
        id:"",
        username:"",
        fullName:"",
        token:"",
        refreshToken:"",
      }
    }
  },
  actions: {
    //
    async loginUserAdmin() {
      let returnData = await useAxios().value.get(`${urlLoginAdminUser}`)
      return returnData.data
    },
    //get all user
    async getAll() {
      let returnData = await useAxios().value.get(`${urlUserGetAll}`)
      return returnData.data
    },
    //update user
    async update(data: any) {
      let returnData = await useAxios().value.put(`${urlUpdateUser}`, data)
      return returnData.data 
    },
    //delete user
    async delete(id: number) {
      let returnData = await useAxios().value.delete(`${urlDeleteUser}?id=${id}`)
      return returnData.data
    },
    //create user
    async create(data: any) {
      let returnData = await useAxios().value.post(`${urlCreateUser}`, data)
      return returnData.data
    },
    //export user
    async export() {
      let returnData = await useAxios().value.get(`${urlExportUser}`)
      return returnData.data
    },
    //import user
    async import(data: any) {
      let returnData = await useAxios().value.post(`${urlImportUser}`, data, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      return returnData.data
    },
    //login
    async login(usersLoginHistory:any,UserName: string, Password: string) {
      let returnData = await useAxios().value.post(`${urlLogin}?UserName=${UserName}&Password=${Password}`,usersLoginHistory)
      return returnData.data
    },
    async resetPassword(userId: number) {
      let returnData = await useAxios().value.put(`${urlResetPassword}?userId=${userId}`)
      return returnData.data
    },
    //change password
    async changePassword(oldPassword: string, newPassword: string) {
      let returnData = await useAxios().value.put(`${urlChangePassword}?oldPassword=${oldPassword}&newPassword=${newPassword}`)
      return returnData.data;
    },
      setUser(user: any) {
        
        this.user = user;
    },
    getUser() {
        return this.user;
    },
    clearUser() {
        this.user = {
            id:"",
            username:"",
            fullName:"",
            token:"",
            refreshToken:"",
        }
    },
    //logout
    async logOut() {
      let returnData = await useAxios().value.get(`${urlLogOut}`)
      return returnData.data
    },
  },
  persist: {
    storage:persistedState.localStorage,
},
})