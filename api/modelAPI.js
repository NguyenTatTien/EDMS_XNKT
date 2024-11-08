import axios from 'axios'
import {urlModelGetAll,urlCreateModel,urlUpdateModel,urlDeleteModel,urlExportModel,urlImportModel} from './setupAPI.js'
export const modelGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlModelGetAll}`, {
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
  export const createModelAPI = async (model) => {
    try {
      const response = await axios.post(`${urlCreateModel}`,model, {
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
  export const updateModelAPI = async (model) => {
    try {
      const response = await axios.put(`${urlUpdateModel}`,model, {
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
  export const deleteModelAPI = async (id) => {
    try {
      const response = await axios.delete(`${urlDeleteModel}?id=${id}`, {
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
  export const exportModelAPI = async () => {
    try {
      const response = await axios.get(`${urlExportModel}`,{
        responseType: 'blob'
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  };
  export const importModelAPI = async (formFile) => {
    try {
      const response = await axios.post(`${urlImportModel}`,formFile, {
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