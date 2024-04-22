import { defineStore } from 'pinia'

export const useProject = defineStore('project', {
    state: () => {
        return {
            data: [],
            currentModel: {},
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
                details: [
                    {
                        name: "Cong viec 1",
                        description: "noi dung cong viec 1",
                        type: 0,
                        statusCode: 0,
                        users: [
                            {
                                userID: 0,
                                name: "User 1",
                                avatar: "",
                                groupID: 0,
                                status: 0,
                            }
                        ]
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
        }
    },
    persist: {
        storage: persistedState.localStorage,
    },
})