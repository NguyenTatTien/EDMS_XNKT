import axios from 'axios'
import {urlDocumentGetAll,urlDocumentGetByFolder,urlDocumentGetByType,urlCopyFileToFolder,urlMoveFileToFolder,urlGetDocumentByTag,urlGetDocumentByTagAndType,urlCreateDocument,urlUpdateDocument,urlDeleteDocument,urlExportDocument,urlSearchDocument,urlImportDocument,urlDownload,urlDownloadMulti} from './setupAPI.js'
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
export const getDocumentByTagAPI = async (tagId) => {
  try {
    const response = await axios.get(`${urlGetDocumentByTag}?tagId=${tagId}`, {
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
export const getDocumentByTagAndTypeAPI = async (tagId, typeId) => {
  try {
    const response = await axios.get(`${urlGetDocumentByTagAndType}?tagId=${tagId}&typeId=${typeId}`, {
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
export const createDocumentAPI = async (formData) => {
 
  try {
    const response = await axios.post(`${urlCreateDocument}`,formData, {
        headers: {
            'Content-Type': 'multipart/form-data',
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
export const exportDocumentAPI = async (data) => {
  try {
    const response = await axios.post(`${urlExportDocument}`,data, {
      responseType: 'blob'
    });
    return await response;
  } catch (error) {
    throw error;
    // Handle network or other errors
  }
}
export const searchDocumentAPI = async (search) => {
  try {
    const response = await axios.get(`${urlSearchDocument}?search=${search}`, {
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
export const importDocumentAPI = async (data) => {
  try {
    const response = await axios.post(`${urlImportDocument}`,data, {
        headers: {
          'Content-Type': 'multipart/form-data'
        },
    });
    return await response.data;
  } catch (error) {
    throw error;
    // Handle network or other errors
  }
}
export const downloadDocumentAPI = async (data) => {
  try {
    const response = await axios.post(`${urlDownload}`,data, {
      headers: {
        'Content-Type': 'application/json'
      },
    },
    );
    return await response;
  } catch (error) {
    throw error;
    // Handle network or other errors
  }
}
export const downloadMultiDocumentAPI = async (documents) => {
  try {
    const response = await axios.post(`${urlDownloadMulti}`,documents, {
   
      headers: {
        'Content-Type': 'application/json; charset=utf-8'
      },
    },
    );
    return await response;
  } catch (error) {
     throw error;
  }
}

