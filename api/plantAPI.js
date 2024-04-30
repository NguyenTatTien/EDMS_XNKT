import axios from 'axios'
import {urlPlantGetAll} from './setupAPI.js'
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