import axios from 'axios'
import {urlMenuGetAll} from './setupAPI.js'
export const menuGetAllAPI = async () => {
     
    try {
      const response = await axios.get(`${urlMenuGetAll}`, {
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