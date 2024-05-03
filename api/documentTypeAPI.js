import axios from 'axios'
import {urlDocumentTypeGetAll,urlDocumentTypeByParent} from './setupAPI.js'
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
export const documentTypeByParentAPI = async (parentId) => {
  try {
    const response = await axios.get(`${urlDocumentTypeByParent}?parentId=${parentId}`, {
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