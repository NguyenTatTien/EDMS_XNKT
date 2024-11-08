//init useMenu
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlMenuGetAll,urlMenuGetByUser,urlMenuGetByRole,urlMenuInsert,urlMenuDelete} from '~/api/setupAPI.js'
export const useMenu = defineStore('menu', {
    state: () => {
        return {
            data: [],
            menu:[],
        }
    },
    actions: {
        async getAll() {
            let returnData = await useAxios().value.get(`${urlMenuGetAll}`);
            this.menu = returnData.data;
            return returnData.data
        },
        async getAllByUser() {
            let returnData = await useAxios().value.get(`${urlMenuGetByUser}`);
            this.menu = returnData.data;
            return returnData.data
        },
        async getAllByRole(roleId: number) {
            let returnData = await useAxios().value.get(`${urlMenuGetByRole}?roleId=${roleId}`)
            return returnData.data
        },
        // insert
        async create(roleId: number, menuId: number) {
            let returnData = await useAxios().value.post(`${urlMenuInsert}?roleId=${roleId}&menuId=${menuId}`);
            await this.getAllByUser();
            return returnData.data
        },
        // delete
        async delete(roleId: number, menuId: number) {
            let returnData = await useAxios().value.delete(`${urlMenuDelete}?roleId=${roleId}&menuId=${menuId}`);
            await this.getAllByUser();
            return returnData.data
        },
        clearMenu() {
            this.menu = [];
        }
        
},
persist: {
    storage: persistedState.localStorage,
  },
})