import axios from 'axios'
import {urlGroupGetAll,urlUpdateGroup,urlCreateGroup,urlDeleteGroup} from './setupAPI.js'
export const groupGetAllAPI = async () => {
     
    try {
      const response = await axios.get(`${urlGroupGetAll}`, {
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
  export const createGroupAPI = async (group) => {
     
    try {
      const response = await axios.post(`${urlCreateGroup}`,group, {
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
  export const deleteGroupAPI = async (id) => {
     
    try {
      const response = await axios.delete(`${urlDeleteGroup}?id=${id}`, {
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
  export const updateGroupAPI = async (group) => {
     
    try {
      const response = await axios.put(`${urlUpdateGroup}`,group, {
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