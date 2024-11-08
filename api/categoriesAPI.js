import axios from 'axios'
import {urlCategoriesGetAll,urlCategoriesCreate,urlCategoriesDelete,urlCategoriesExport,urlCategoriesImport,urlCategoriesGetAllByPermission } from './setupAPI.js'
export const cateogriesGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlCategoriesGetAll}`, {
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
  export const cateogriesGetAllByPermissionAPI = async (userId) => {
    try {
      const response = await axios.get(`${urlCategoriesGetAllByPermission}?userId=${userId}`, {
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
  export const createCategoriesAPI = async (Categories) => {
     
    try {
      const response = await axios.post(`${urlCategoriesCreate}`,Categories, {
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
  export const deleteCategoriesAPI = async (id) => {
     
    try {
      const response = await axios.delete(`${urlCategoriesDelete}?id=${id}`, {
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
  export const updateCategoriesAPI = async (Categories) => {
     
    try {
      const response = await axios.put(`${urlCategoriesDelete}`,Categories, {
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
  export const exportCategoriesAPI = async () => {
    try {
      const response = await axios.get(`${urlCategoriesExport}`,{
        responseType: 'blob'
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
  };
  export const importCategoriesAPI = async (formFile) => {
    try {
      const response = await axios.post(`${urlCategoriesImport}`,formFile, {
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