import axios from 'axios'
import {urlTagGetAll,urlCreateTag,urlUpdateTag,urlDeleteTag,urlExportTag,urlImportTag} from './setupAPI.js'
export const tagGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlTagGetAll}`, {
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
  export const createTagAPI = async (tag) => {
    try {
      const response = await axios.post(`${urlCreateTag}`, tag,{
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
  export const deleteTagAPI = async (Id) => {
    try {
      const response = await axios.delete(`${urlDeleteTag}?Id=${Id}`, {
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
  export const updateTagAPI = async (tag) => {
    try {
      const response = await axios.put(`${urlUpdateTag}`,tag, {
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
  export const exportTagAPI = async () => {
    try {
      const response = await axios.get(`${urlExportTag}`,{
        responseType: 'blob'
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  };
  export const importTagAPI = async (formFile) => {
    try {
      const response = await axios.post(`${urlImportTag}`,formFile, {
          headers: {
              'Content-Type': 'multipart/form-data',
          },
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  };