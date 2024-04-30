import axios from 'axios'
import {urlTabGetAll} from './setupAPI.js'
export const tabGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlTabGetAll}`, {
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