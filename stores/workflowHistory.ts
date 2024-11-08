import { defineStore } from "pinia";
import { urlWorkflowHistoryGetByProject } from "@/api/setupAPI";
import axios from "axios";
export const useWorkflowHistory = defineStore("workflowHistory",{
    state:()=>({
      
    }),
    actions:{
        async getByProject(projectID:number){
            const res = await axios.get(urlWorkflowHistoryGetByProject+"?projectID="+projectID);
            return res.data;
        }
    }
})
