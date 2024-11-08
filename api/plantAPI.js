import axios from 'axios'
import {urlPlantGetAll,urlPlantCreate,urlPlantDelete,urlPlantUpdate,urlPlantExport,urlPlantImport} from './setupAPI.js'
export const plantGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlPlantGetAll}`, {
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
  export const createPlantAPI = async (plant) => { 
    try {
     
      const response = await axios.post(`${urlPlantCreate}`,plant, {
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
  export const deletePlantAPI = async (id) => {
     
    try {
      const response = await axios.delete(`${urlPlantDelete}?id=${id}`, {
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
  export const updatePlantAPI = async (plant) => {
     
    try {
      const response = await axios.put(`${urlPlantUpdate}`,plant, {
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
  export const exportPlantAPI = async () => {
    try {
      const response = await axios.get(`${urlPlantExport}`,{
        responseType: 'blob'
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  };
  export const importPlantAPI = async (formFile) => {
    try {
      const response = await axios.post(`${urlPlantImport}`,formFile, {
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