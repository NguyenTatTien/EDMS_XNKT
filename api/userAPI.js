import axios from 'axios'
import {urlUserGetAll,urlUpdateUser,urlDeleteUser,urlCreateUser} from './setupAPI.js'
export const userGetAllAPI = async () => {
     
    try {
      const response = await axios.get(`${urlUserGetAll}`, {
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
export const userUpdateAPI = async (user) =>{
    try{
      const response = await axios.put(`${urlUpdateUser}`,user, {
          headers: {
              'Content-Type': 'application/json',
          },
      });
      return await response.data;
    }catch (error) {
      throw error;
      // Handle network or other errors
    }
  };
export const userDeleteAPI = async (id) =>{
    try{
      const response = await axios.delete(`${urlDeleteUser}?id=${id}`, {
          headers: {
              'Content-Type': 'application/json',
          },
      });
      return await response.data;
    }catch (error) {
      throw error;
      // Handle network or other errors
    }
  }
  export const userCreateAPI = async (user) =>{
    try{
      const response = await axios.post(`${urlCreateUser}`,user, {
          headers: {
              'Content-Type': 'application/json',
          },
      });
      return await response.data;
    }catch (error) {
      throw error;
      // Handle network or other errors
    }
  }