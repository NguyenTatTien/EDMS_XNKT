import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios'
import { urlProjectCreate,urlProjectGetAll,urlProjectApprove,urlProjectRequestApprove ,urlProjectUpdate,urlProjectDelete,urlProjectGetByID,urlProjectGetAllTask,urlProjectCancel,urlProjectReport,urlProjectUpFileApprove,urlProjectRestore,urlProjectGetChatMembers} from '~/api/setupAPI'
export const useProject = defineStore('project', {
     state: () => {
        return {
            data: [],
            selectedModel: {},
            openModal: false,
            templateModel: {
                id: 0,
                name: "Dự án 1",
                description: "Dự án quản lý dự án",
                khoiID: 0,
                phongID: 0,
                banID: 0,
                userID: 0,
                type: 0,
                status: 0,
                dateStart: new Date(),
                dateEnd: new Date(),
                process_percent: 0,
                tasks: []
            },
            templateTask: {
                id: 0,
                name: "Task 1",
                process_percent: 0,
                process_weight: 0,
                userCreated: {
                    name: "admin",
                    slug: '/user/admin'
                },
                userReponsibility: {
                    name: "admin",
                    slug: '/user/admin'
                },
                userRelation: [
                    {
                        name: "admin",
                        slug: '/user/admin'
                    },
                    {
                        name: "Toàn",
                        slug: '/user/toan'
                    }
                ],
                dateStart: new Date(),
                dateEnd: new Date(),
                end: new Date(),
                start: new Date(),
                tasks: [],
                status : 1, //1 la chua xoa, 0 la xoa
                ffStatus : 0,//0: chua thuc hiện, 1: dang thuc hiện, 2: da thuc hiện; 3: tu choi; 4 huy;
                comments: [
                    {
                        id: 0,
                        userCreated: {
                            name: "admin",
                            slug: '/user/admin'
                        },
                        content: '',
                        createdDate: new Date(),
                        status: 0,
                        parent: 0
                    }
                ],
                subTasks: [
                    {
                        id: 0,
                        name: "Sub Task 1",
                        userCreated: {
                            name: "admin",
                            slug: '/user/admin'
                        },
                        userRelation: [
                            {
                                name: "admin",
                                slug: '/user/admin'
                            },
                            {
                                name: "Toàn",
                                slug: '/user/toan'
                            }
                        ],
                        dateStart: new Date(),
                        dateEnd: new Date(),
                        status: 0, //0: chua thuc hiện, 1: dang thuc hiện, 2: da thuc hiện; 3: tu choi; 4 huy;
                    }
                ],
                checkLists: [
                    {
                        id: 0,
                        name: 'check 1',
                        checked : false,
                        createdDate: new Date()
                    }
                ],
                documents: [
                    {
                        //document model
                    }
                ]
            }
        }
    },
    actions: {
        find(id: number) {
          
            return this.data.filter(x => x.id == id)[0];
        },
        add(model: any) {
            model.id = this.data.length;
            model.status = 0 ;
            this.data.push(model);
        },
        async create(data: any) {
            let returnData = await useAxios().value.post(`${urlProjectCreate}`, data)
            return returnData.data
        },
        async getAll(){
            let returnData = await useAxios().value.get(`${urlProjectGetAll}`)
            return returnData.data
        },
        async requestApprove(data: any) {
            let returnData = await useAxios().value.post(`${urlProjectRequestApprove}`,data)
            return returnData.data
        },
        async approve(data: any) {
            let returnData = await useAxios().value.post(`${urlProjectApprove}`,data)
            return returnData.data
        },
        async update(data: any) {
            let returnData = await useAxios().value.put(`${urlProjectUpdate}`, data)
            return returnData.data
        },
        async delete(id: number) {
            let returnData = await useAxios().value.delete(`${urlProjectDelete}?Id=${id}`)
            return returnData.data
        },
        async getByID(id: number) {
            let returnData = await useAxios().value.get(`${urlProjectGetByID}?id=${id}`)
            return returnData.data
        },
        async getAllTask() {
            let returnData = await useAxios().value.get(`${urlProjectGetAllTask}`)
            return returnData.data
        },
        async cancel(data:any) {
            let returnData = await useAxios().value.put(`${urlProjectCancel}`,data)
            return returnData.data
        },
        async restore(data:any) {
            let returnData = await useAxios().value.put(`${urlProjectRestore}`,data)
            return returnData.data
        },
        async report (data:any) {
            let returnData = await useAxios().value.post(`${urlProjectReport}`,data)
            return returnData.data
        },
        async upFileApprove(data:any){
            console.log(urlProjectUpFileApprove);
            let returnData = await useAxios().value.post(`${urlProjectUpFileApprove}`,data)
            return returnData.data
        },
        async getChatMembers(projectID:number){
            let returnData = await useAxios().value.get(`${urlProjectGetChatMembers}?projectID=${projectID}`)
            return returnData.data
        }
    },
    persist: {
        storage: persistedState.localStorage,
    },
})