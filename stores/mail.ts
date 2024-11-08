//init useMail
import { defineStore } from 'pinia'
import axios from 'axios'
import { useAxios } from '~/composables/useAxios'
import {urlSendMail,urlgetInforMail} from '~/api/setupAPI.js'
export const useMail = defineStore('mail', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
        async sendMail(data: any) {
            let returnData = await useAxios().value.post(`${urlSendMail}`,data)
            return returnData.data
        },
        async getInforMail(data: any) {
            let returnData = await useAxios().value.post(`${urlgetInforMail}?type=${data.type}&url=${data.url}`,data.documents)
            return returnData.data
        }
    }
})
