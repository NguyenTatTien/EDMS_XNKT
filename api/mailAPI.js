import axios from 'axios'
import {urlSendMail,urlgetObjcetMail} from './setupAPI.js'
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
export const getObjcetMailAPI = async () => {
  try {
    const response = await axios.get(`${urlgetObjcetMail}`, {
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