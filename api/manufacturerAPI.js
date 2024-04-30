import axios from 'axios'
import {urlManufacturerGetAll,urlCreateManufacturer,urlUpdateManufacturer,urlDeleteManufacturer} from './setupAPI.js'
export const manufacturerGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlManufacturerGetAll}`, {
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
  export const createManufacturerAPI = async (manufacture) => {
    try {
      const response = await axios.post(`${urlCreateManufacturer}`,manufacture, {
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
  export const updateManufacturerAPI = async (manufacture) => {
    try {
      const response = await axios.put(`${urlUpdateManufacturer}`,manufacture, {
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
  export const deleteManufacturerAPI = async (id) => {
    try {
      const response = await axios.delete(`${urlDeleteManufacturer}?id=${id}`, {
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