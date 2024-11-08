import axios from 'axios'
import {urlSystemGetAll,urlSystemCreate,urlSystemDelete,urlSystemUpdate,urlSystemExport,urlSystemImport} from './setupAPI.js'
export const systemGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlSystemGetAll}`, {
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
  export const createSystemAPI = async (System) => {
     
    try {
      const response = await axios.post(`${urlSystemCreate}`,System, {
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
  export const deleteSystemAPI = async (id) => {
     
    try {
      const response = await axios.delete(`${urlSystemDelete}?id=${id}`, {
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
  export const updateSystemAPI = async (System) => {
     
    try {
      const response = await axios.put(`${urlSystemUpdate}`,System, {
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
  export const exportSystemAPI = async () => {
    try {
      const response = await axios.get(`${urlSystemExport}`,{
        responseType: 'blob'
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  };
  export const importSystemAPI = async (formFile) => {
    try {
      const response = await axios.post(`${urlSystemImport}`,formFile, {
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