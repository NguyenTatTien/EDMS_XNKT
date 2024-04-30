import axios from 'axios'
import {urlSyncFolderGetAll} from './setupAPI.js'
export const syncFolderGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlSyncFolderGetAll}`, {
          headers: {
              'Content-Type': 'application/json',
          },
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  };