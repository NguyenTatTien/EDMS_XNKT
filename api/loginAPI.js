import axios from 'axios'
import {urlLoginApi} from './setupAPI.js'
export const loginAPi = async (userName,Password) => {
    try {
      const response = await axios.get(`${urlLoginApi}?UserName=${userName}&Password=${Password}`, {
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