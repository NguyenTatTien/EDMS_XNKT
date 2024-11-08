//init useUnit
import { defineStore } from 'pinia'
export const useToken = defineStore('token', {
    state: () => {
        return {
            data: [],
            token:""
        }
    },
    actions: {
        setToken(token: string) {
            this.token = token
        },
        getToken() {
            return this.token
        }
    },
    persist: {
        storage:persistedState.localStorage,
    }
})