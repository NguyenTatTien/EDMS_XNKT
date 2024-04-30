import axios from 'axios'
import {urlDocumentGetAll,urlDocumentGetByFolder,urlDocumentGetByType,urlCopyFileToFolder,urlMoveFileToFolder,urlGetDocumentByTab,urlGetDocumentByTabAndType,urlCreateDocument,urlUpdateDocument,urlDeleteDocument} from './setupAPI.js'
export const documentGetAllAPI = async () => {
     
    try {
      const response = await axios.get(`${urlDocumentGetAll}`, {
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

export const documentGetByFolderAPI = async (folderId) => {
  try {
    const response = await axios.get(`${urlDocumentGetByFolder}?FolderId=${folderId}`, {
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
export const documentGetByTypeAPI = async (typeId) => {
  try {
    const response = await axios.get(`${urlDocumentGetByType}?typeId=${typeId}`, {
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
export const copyFileToFolder = async (fileId, folderId) => {
  try {
    const response = await axios.post(`${urlCopyFileToFolder}?fileId=${fileId}&folderId=${folderId}`, {
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
export const moveFileToFolder = async (fileId, folderId) => {
  try {
    const response = await axios.post(`${urlMoveFileToFolder}?fileId=${fileId}&folderId=${folderId}`, {
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
export const getDocumentByTabAPI = async (tabId) => {
  try {
    const response = await axios.get(`${urlGetDocumentByTab}?tabId=${tabId}`, {
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
export const getDocumentByTabAndTypeAPI = async (tabId, typeId) => {
  try {
    const response = await axios.get(`${urlGetDocumentByTabAndType}?tabId=${tabId}&typeId=${typeId}`, {
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
export const createDocumentAPI = async (document) => {
  try {
    const response = await axios.post(`${urlCreateDocument}`,document, {
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
export const updateDocumentAPI = async (document) => {
  try {
    const response = await axios.put(`${urlUpdateDocument}`,document, {
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
export const deleteDocumentAPI = async (Id) => {
  try {
    const response = await axios.delete(`${urlDeleteDocument}?Id=${Id}`, {
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
