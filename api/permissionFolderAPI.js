import {urlPermissionGetByFolder,urlCreateFolderPermission,urlDeleteFolderPermission,urlUpdateFolderPermission} from './setupAPI.js';
import axios from 'axios';
export const getPermissionByFolderAPI = async (folderId) => {
    try {
      const response = await axios.get(`${urlPermissionGetByFolder}?folderId=${folderId}`, {
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
export const createFolderPermissionAPI = async (folderPermission)=>{
    try {
      const response = await axios.post(`${urlCreateFolderPermission}`,folderPermission, {
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
export const deleteFolderPermissionAPI = async (Id)=>{
  try {
    const response = await axios.delete(`${urlDeleteFolderPermission}?Id=${Id}`, {
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
export const updateFolderPermissionAPI = async (folderPermission)=>{
  try {
    const response = await axios.put(`${urlUpdateFolderPermission}`,folderPermission, {
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