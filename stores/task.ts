//init useSystem
import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import {urlTaskUpdate,urlTaskCreate,urlTaskDelete,urlTaskGetAllByPhase,urlTaskGetListPhaseID,urlTaskGetAllByProject,urlTaskGetAllProject,urlTaskCancel,urlTaskRestore,urlTaskGetWorkHourInYear} from '~/api/setupAPI.js'
export const useTask = defineStore('task', {
    state: () => {
        return {
            data: [],
        }
    },
    actions: {
     
        async update(task: any) {
            let returnData = await useAxios().value.put(`${urlTaskUpdate}`,task)
            return returnData.data
        },
        async create(task: any) {
            let returnData = await useAxios().value.post(`${urlTaskCreate}`,task)
            return returnData.data
        },
        async delete(Id: number) {
            let returnData = await useAxios().value.delete(`${urlTaskDelete}?Id=${Id}`)
            return returnData.data
        },
        async getAllByPhase(Id: number) {
            let returnData = await useAxios().value.get(`${urlTaskGetAllByPhase}?Id=${Id}`)
            return returnData.data
        },
        async getListPhaseID(Ids: any) {
            let returnData = await useAxios().value.post(`${urlTaskGetListPhaseID}`,Ids)
            return returnData.data
        },
        async getAllByProject(Id: number) {
            let returnData = await useAxios().value.get(`${urlTaskGetAllByProject}?Id=${Id}`)
            return returnData.data
        },
        async getAllProject() {
            let returnData = await useAxios().value.get(`${urlTaskGetAllProject}`)
            return returnData.data
        },
        async cancel(data:any) {
            let returnData = await useAxios().value.put(`${urlTaskCancel}`,data)
            return returnData.data
        },
        async restore(data:any) {
            let returnData = await useAxios().value.put(`${urlTaskRestore}`,data)
            return returnData.data
        },
        async getWorkHourInYear() {
            let returnData = await useAxios().value.get(`${urlTaskGetWorkHourInYear}`)
            return returnData.data
        }
    }
})