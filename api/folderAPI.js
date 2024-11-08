import axios from 'axios'
import {urlFolderGetNotParentByCategory,urlFolderGetByParentAndCategory,urlMoveFolderToFolder,urlCretateFolder,urlUpdateFolder,urlDeleteFolder,urlCopyFolder,urlSearchFolder,urlGetFolderByName,urlDownloadFolder} from './setupAPI.js'
export const folderGetNotParentByCategoryAPI = async (categoryId) => {
    try {
      const response = await axios.get(`${urlFolderGetNotParentByCategory}?categoryId=${categoryId}`, {
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
  export const folderGetByParentAndCategoryAPI = async (parentId,categoryId,userId) => {
    try {
      const response = await axios.get(`${urlFolderGetByParentAndCategory}?parentId=${parentId}&categoryId=${categoryId}&userId=${userId}`, {
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
  export const moveFolderToFolderAPI = async (folderMoveId,folderPasteId) => {
    try {
      const response = await axios.post(`${urlMoveFolderToFolder}?folderMoveId=${folderMoveId}&folderPasteId=${folderPasteId}`, {
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
  export const createFolderAPI = async (folder) => {
    try {
      const response = await axios.post(`${urlCretateFolder}`,folder, {
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
  export const updateFolderAPI = async (folder) => {
    try {
      const response = await axios.put(`${urlUpdateFolder}`,folder, {
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
  export const deleteFolderAPI = async (id) => {
    try {
      const response = await axios.delete(`${urlDeleteFolder}?Id=${id}`, {
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
  export const copyFolderAPI = async (folderCopyID,folderPasteID) => {
    try {
      const response = await axios.post(`${urlCopyFolder}?folderCopyID=${folderCopyID}&folderPasteID=${folderPasteID}`, {
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
  export const searchFolderAPI = async (search) => {
    try {
      const response = await axios.get(`${urlSearchFolder}?search=${search}`, {
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
  export const getFolderByNameAPI = async (name,parentID,categoryID) => {
    try {
      const response = await axios.get(`${urlGetFolderByName}?name=${name}&parentID=${parentID}&categoryID=${categoryID}`, {
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
  export const downloadFolderAPI = async (folderID, categoryID) => {
    try {
      const response = await axios.get(`${urlDownloadFolder}?selectfolder=${folderID}&categoryID=${categoryID}`, {
        responseType: 'blob',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/zip'
        }
      });
      return await response;
    } catch (error) {
      console.log(error);
      // Handle network or other errors
    }
  }

  