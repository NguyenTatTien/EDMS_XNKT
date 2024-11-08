//init useUnit
import { defineStore } from 'pinia'
export const useTypeFile = defineStore('typeFile', {
    state: () => {
        return {
            data: [],
            video: ["mp4","avi","mkv","mov","wmv","webm"],
            image: ["jpg","jpeg","png","gif","bmp",'tiff','svg','tif'],
            office: ["doc","docx","xls","xlsx","ppt","pptx","xlsm",'pdf'],
            autoCard: ["dwg","dxf"],
        }
    },
    actions: {
    }
})