//init useFolder
import { defineStore } from 'pinia'
export const useExpandedFolder = defineStore('expandedFolder', {
    state: () => {
      return {
        data: [],
        expanFolder:null,
      }
      
    },
    actions: {
      //get all folder
      reset() {
        this.expanFolder = null;
      }
    },
    persist: {
      storage: persistedState.localStorage,
    },
  })