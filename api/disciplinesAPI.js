import axios from 'axios'
import {urlDisciplinesGetAll} from './setupAPI.js'
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