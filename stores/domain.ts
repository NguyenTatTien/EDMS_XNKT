import { defineStore } from 'pinia'
export const useDomain = defineStore('domain', {
    state: () => {
        return {
            data: [],
            url:{
                server:"http://localhost:7122/",
                local:"http://localhost:3000/",
                viewOffice:"",
                viewAutoCard:"",
            }
            // url:{
            //     server:"https://spf-edms.vietsov.com.vn:9001/",
            //     local:"https://spf-edms.vietsov.com.vn:8090/",
            //     viewOffice:"http://spf-edms.vietsov.com.vn:9003/",
            //     viewAutoCard:"http://spf-edms.vietsov.com.vn:9005/",
            // }
        }
    },
})