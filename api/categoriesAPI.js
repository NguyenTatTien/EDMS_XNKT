import axios from 'axios'
import {urlCategoriesGetAll} from './setupAPI.js'
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