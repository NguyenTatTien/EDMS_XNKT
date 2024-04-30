import axios from 'axios'
import {urlDocumentTypeGetAll} from './setupAPI.js'
export const documentTypeGetAllAPI = async () => {
    try {
      const response = await axios.get(`${urlDocumentTypeGetAll}`, {
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