import { defineStore } from 'pinia'

export const useUser = defineStore('user', {
  state: () => {
    return {
      data: [
        {
          id: 0,
          name: 'User 1',
          avatar: '',
          groupID: 0,
          status: 0,
        },
        {
          id: 1,
          name: 'User 2',
          avatar: '',
          groupID: 0,
          status: 0,
        }
      ],
    }
  },
  persist: {
    storage: persistedState.localStorage,
  },
})