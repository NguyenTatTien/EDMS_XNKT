import axios from 'axios'
import {urlSendMail,urlgetInforMail} from './setupAPI.js'

export const sendMailAPI = async (objMail) => {
    try {
      const response = await axios.post(`${urlSendMail}`,objMail, {
          headers: {
              'Content-Type': 'application/json',
          },
      });
      return await response.data;
    } catch (error) {
      throw error;
      // Handle network or other errors
    }
}
export const getInforMailAPI = async (data) => {
  try {
    const response = await axios.post(`${urlgetInforMail}?type=${data.type}`,data.documents, {
        headers: {
            'Content-Type': 'application/json',
        },
    });
    return await response.data;
  } catch (error) {
    throw error;
    // Handle network or other errors
  }
}