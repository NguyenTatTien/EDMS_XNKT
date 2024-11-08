import axios from 'axios'
import {urlSyncFolderGetAll,urlSyncFolder} from './setupAPI.js'
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
  export const syncFolderAPI = async (folderID,folderSyncID) => {
    try {
      const response = await axios.post(`${urlSyncFolder}?folderID=${folderID}&folderSyncID=${folderSyncID}`, {
          headers: {
              'Content-Type': 'application/json',
          },
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  }