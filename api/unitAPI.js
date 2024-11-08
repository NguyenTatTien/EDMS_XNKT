import axios from 'axios'
import {urlUnitGetAll,urlUnitCreate,urlUnitDelete,urlUnitUpdate,urlUnitExport,urlUnitImport} from './setupAPI.js'
export const unitGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlUnitGetAll}`, {
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
  export const createUnitAPI = async (Unit) => {
    try {
      const response = await axios.post(`${urlUnitCreate}`,Unit, {
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
  export const deleteUnitAPI = async (id) => {
     
    try {
      const response = await axios.delete(`${urlUnitDelete}?id=${id}`, {
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
  export const updateUnitAPI = async (Unit) => {
     
    try {
      const response = await axios.put(`${urlUnitUpdate}`,Unit, {
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
  export const exportUnitAPI = async () => {
    try {
      const response = await axios.get(`${urlUnitExport}`,{
        responseType: 'blob'
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  };
  export const importUnitAPI = async (formFile) => {
    try {
      const response = await axios.post(`${urlUnitImport}`,formFile, {
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