import { defineStore } from 'pinia'
import { useAxios } from '~/composables/useAxios';
import { urlGetDBDataDocument,urlGetDBNewDocument,urlGetDBNewUser,urlGetNewDocumentLog,urlGetDBDocumentALLCategory,urlGetDBDocumentAllMothInYear } from '~/api/setupAPI';

export const useStatic = defineStore('static', {
  state: () => {
    return {
        timeLine: [],
        recentDocuments: [],
        recentUsers: [],
        static: {},
        documentsByCategory: [],
        documentsByTimestamp: []
    }
  },
  actions : {
    async initStatic() {
      
        this.timeLine = [];
        this.recentDocuments = [];
        this.recentUsers = [];
        this.static = {};
        this.documentsByCategory = [];
        this.documentsByTimestamp = [];
        await this.getStatic();
        await this.getRecentDocuments();
        await this.getRecentUser();
        await this.getTimeLine();
        await this.getDocumentsByCategory();
        await this.getDocumentsByTimestamp();
    },
    async getStatic() {
        const response = await useAxios().value.get(`${urlGetDBDataDocument}`);
        this.static = response.data;
    },
    async getRecentDocuments() {
        const response = await useAxios().value.get(`${urlGetDBNewDocument}`);
        this.recentDocuments = response.data;
    },
    async getRecentUser(){
        const response = await useAxios().value.get(`${urlGetDBNewUser}`);
        this.recentUsers = response.data;
    },
    async getTimeLine(){
        const response = await useAxios().value.get(`${urlGetNewDocumentLog}`);
        this.timeLine = response.data;
    },
    async getDocumentsByCategory(){
        const response = await useAxios().value.get(`${urlGetDBDocumentALLCategory}`);
        this.documentsByCategory = response.data;
      
    },
    async getDocumentsByTimestamp(){
        const response = await useAxios().value.get(`${urlGetDBDocumentAllMothInYear}`);
        this.documentsByTimestamp = response.data;
        
    }
  },
  persist: {
    storage: persistedState.localStorage,
  },
})