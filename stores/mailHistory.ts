//init useMail
import { defineStore } from 'pinia'
import axios from 'axios'
import { useAxios } from '~/composables/useAxios'
import {urlMailHistoryCreate,urlMailHistoryGetByUser,urlMailHistoryUpdate,urlMailHistoryDelete} from '~/api/setupAPI.js'
export const useMailHistory = defineStore('mailHistory', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async getByUser() {
            let returnData = await useAxios().value.get(`${urlMailHistoryGetByUser}`)
            return returnData.data
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlMailHistoryCreate}`, data)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlMailHistoryUpdate}`, data)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlMailHistoryDelete}?id=${id}`)
            return returnData.data
        },
    }
})
