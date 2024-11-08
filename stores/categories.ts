// init useCategories
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlCategoriesGetAll,urlCategoriesCreate,urlCategoriesDelete,urlCategoriesExport,urlCategoriesImport,urlCategoriesGetAllByPermission } from '~/api/setupAPI.js'
export const useCategories = defineStore('categories', {
    state: () => {
        return {
            data: [],
            categoriesStore:[],
        }
    },
    actions: {
        //get all categories
        async getAll() {
            let returnData = await useAxios().value.get(`${urlCategoriesGetAll}`)
            this.data = returnData.data
            return returnData.data
        },
        //get all categories by permission
        async getAllByPermission() {
            let returnData = await useAxios().value.get(`${urlCategoriesGetAllByPermission}`);
            this.categoriesStore = returnData.data;
            return returnData.data;
        },
        //create categories
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlCategoriesCreate}`, data);
            await this.getAllByPermission();
            return returnData.data
        },
        //delete categories
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlCategoriesDelete}?id=${id}`);
            await this.getAllByPermission();
            return returnData.data
        },
        //update categories
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlCategoriesDelete}`, data);
            await this.getAllByPermission();
            return returnData.data
        },
        //export categories
        async export() {
            let returnData = await useAxios().value.get(`${urlCategoriesExport}`);
            return returnData.data
        },
        //import categories
        async import(data: any) {
            let returnData = await useAxios().value.post(`${urlCategoriesImport}`, data);
            await this.getAllByPermission();
            return returnData.data
        },
        clearCategories() {
            this.categoriesStore = [];
        }
    },
    persist: {
        storage: persistedState.localStorage,
      },
})
             