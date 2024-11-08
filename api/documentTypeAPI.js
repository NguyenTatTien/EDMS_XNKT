import axios from 'axios'
import {urlDocumentTypeGetAll,urlDocumentTypeByParent,urlDocumentTypeNotParent,urlDocumentTypeCreate,urlDocumentTypeDelete,urlDocumentTypeUpdate,urlDocumentTypeExport,urlDocumentTypeImport,urlDocumentTypeAllParent} from './setupAPI.js'
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
export const documentTypeAllParentAPI = async () => {
  try {
    const response = await axios.get(`${urlDocumentTypeAllParent}`, {
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
export const documentTypeNotParentAPI = async () => {
  try {
    const response = await axios.get(`${urlDocumentTypeNotParent}`, {
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
export const createDocumentTypeAPI = async (documentType) => {
     
  try {
   
    const response = await axios.post(`${urlDocumentTypeCreate}`,documentType, {
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
export const deleteDocumentTypeAPI = async (id) => {
   
  try {
    const response = await axios.delete(`${urlDocumentTypeDelete}?id=${id}`, {
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
export const updateDocumentTypeAPI = async (documentType) => {
   
  try {
    const response = await axios.put(`${urlDocumentTypeUpdate}`,documentType, {
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
export const exportDocumentTypeAPI = async () => {
  try {
    const response = await axios.get(`${urlDocumentTypeExport}`,{
      responseType: 'blob'
    });
    return await response.data;
  } catch (error) {
    throw error;
    // Handle network or other errors
  }
};
export const importDocumentTypeAPI = async (formFile) => {
  try {
    const response = await axios.post(`${urlDocumentTypeImport}`,formFile, {
        headers: {
            'Content-Type': 'multipart/form-data',
        },
    });
    return await response.data;
  } catch (error) {
    throw error;
    // Handle network or other errors
  }
};