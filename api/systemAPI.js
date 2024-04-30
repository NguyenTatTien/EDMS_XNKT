import axios from 'axios'
import {urlSystemGetAll} from './setupAPI.js'
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