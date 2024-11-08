import axios from 'axios'
import {urlDisciplinesGetAll,urlDisciplinesCreate,urlDisciplinesDelete,urlDisciplinesUpdate,urlDisciplinesExport,urlDisciplinesImport} from './setupAPI.js'
export const disciplinesGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlDisciplinesGetAll}`, {
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
  export const createDisciplinesAPI = async (disciplines) => {
     
    try {
     
      const response = await axios.post(`${urlDisciplinesCreate}`,disciplines, {
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
  export const deleteDisciplinesAPI = async (id) => {
     
    try {
      const response = await axios.delete(`${urlDisciplinesDelete}?id=${id}`, {
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
  export const updateDisciplinesAPI = async (disciplines) => {
     
    try {
      const response = await axios.put(`${urlDisciplinesUpdate}`,disciplines, {
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
  export const exportDisciplinesAPI = async () => {
    try {
      const response = await axios.get(`${urlDisciplinesExport}`,{
        responseType: 'blob'
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  };
  export const importDisciplinesAPI = async (formFile) => {
    try {
      const response = await axios.post(`${urlDisciplinesImport}`,formFile, {
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