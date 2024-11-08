//const api_base_url = "http://192.168.177.62:9001";
const api_base_url = "http://localhost:7122";
//const api_base_url = "https://spf-edms.vietsov.com.vn:9001"
export const urlLoginApi = api_base_url+"/api/User/login";
export const urlMenuGetAll = api_base_url+"/api/Menu/getAll";
export const urlMenuGetByUser = api_base_url+"/api/Menu/getAllByUser";
export const urlMenuGetByRole = api_base_url+"/api/Menu/getAllByRole";
export const urlMenuInsert = api_base_url+"/api/Menu/create";
export const urlMenuDelete = api_base_url+"/api/Menu/delete";
//group
export const urlGroupGetAll = api_base_url+"/api/Group/getAll";
export const urlUpdateGroup = api_base_url+"/api/Group/update";
export const urlCreateGroup = api_base_url+"/api/Group/create";
export const urlDeleteGroup = api_base_url+"/api/Group/delete";
export const urlExportGroup = api_base_url+"/api/Group/export";
export const urlImportGroup = api_base_url+"/api/Group/import";
//model
export const urlModelGetAll = api_base_url+"/api/Model/getAll";
export const urlUpdateModel = api_base_url+"/api/Model/update";
export const urlCreateModel = api_base_url+"/api/Model/create";
export const urlDeleteModel = api_base_url+"/api/Model/delete";
export const urlExportModel = api_base_url+"/api/Model/export";
export const urlImportModel = api_base_url+"/api/Model/import";                                                                         
export const urlModelGetById = api_base_url+"/api/Model/getById";
//manufacturer
export const urlManufacturerGetAll = api_base_url+"/api/Manufacturer/getAll";
export const urlUpdateManufacturer = api_base_url+"/api/Manufacturer/update";
export const urlCreateManufacturer = api_base_url+"/api/Manufacturer/create";
export const urlDeleteManufacturer = api_base_url+"/api/Manufacturer/delete";
export const urlExportManufacturer = api_base_url+"/api/Manufacturer/export";
export const urlImportManufacturer = api_base_url+"/api/Manufacturer/import";
export const urlManufacturerGetById = api_base_url+"/api/Manufacturer/getById";
//document
export const urlDocumentGetAll = api_base_url+"/api/Document/getAll";
export const urlDocumentGetByFolder = api_base_url+"/api/Document/getAllByFolder";
export const urlDocumentGetByType = api_base_url+"/api/Document/getAllByType";
export const urlCopyFileToFolder = api_base_url+"/api/Document/copyFileToFolder";
export const urlMoveFileToFolder = api_base_url+"/api/Document/moveFileToFolder";
export const urlGetDocumentByTag = api_base_url+"/api/Document/getDoucumentByTag";
export const urlGetDocumentByTagAndType = api_base_url+"/api/Document/getDocumentByTagAndType";
export const urlCreateDocument = api_base_url+"/api/Document/create";
export const urlUpdateDocument = api_base_url+"/api/Document/update";
export const urlDeleteDocument = api_base_url+"/api/Document/delete";
export const urlExportDocument = api_base_url+"/api/Document/exportData";
export const urlSearchDocument = api_base_url+"/api/Document/search";
export const urlImportDocument = api_base_url+"/api/Document/importData";
export const urlDownload = api_base_url+"/api/Document/download";
export const urlDownloadMulti = api_base_url+"/api/Document/downloadMulti";
export const urlSearchDocumentByCategory = api_base_url+"/api/Document/searchByCategory";
export const urlDocumentGetByID = api_base_url+"/api/Document/getByID";
export const urlDocumentUpload = api_base_url+"/api/Document/upload";
export const urlDocumentDeleteFile = api_base_url+"/api/Document/deleteFile";
export const urlDocumentViewFile = api_base_url+"/api/Document/viewFile";
export const urlGetDocumentsByListFolder = api_base_url+"/api/Document/getDocumentsByListFolder";
export const urlGetAllDocumentsByListFolder = api_base_url+"/api/Document/getAllDocumentsByListFolder";
export const urlGet500Items = api_base_url+"/api/Document/get500Items";
export const urlSearchName = api_base_url+"/api/Document/searchName";
export const urlSearchTitle = api_base_url+"/api/Document/searchTitle";
export const urlSearchDocNumber = api_base_url+"/api/Document/searchDocNumber"; 
export const urlUploadDocument = api_base_url+"/api/Document/upload";
export const urlGetCountDocuments = api_base_url+"/api/Document/getCountDocuments";
export const urlDocumentUploadInsDocument= api_base_url + "/api/Document/uploadInsDocument";
//search FormTo
export const urlSearchFormTo = api_base_url+"/api/Document/searchFormTo";
//search PlatForm
export const urlSearchPlatForm = api_base_url+"/api/Document/searchPlatForm";
//search DocType
export const urlSearchDocType = api_base_url+"/api/Document/searchDocType";
//searchSubType
export const urlSearchSubType = api_base_url+"/api/Document/searchSubType";
//searchTag
export const urlSearchTag = api_base_url+"/api/Document/searchTag";
//searchModel
export const urlSearchModel = api_base_url+"/api/Document/searchModel";
//searchContractor
export const urlSearchContractor = api_base_url+"/api/Document/searchContractor";
//searchRemark
export const urlSearchRemark = api_base_url+"/api/Document/searchRemark";
//getCountAll
export const urlGetCountAll = api_base_url+"/api/Document/getCountAll";
export const urlDeleteMulti = api_base_url+"/api/Document/deleteMulti";
//use
export const urlUserGetAll = api_base_url+"/api/User/getAll";
export const urlUpdateUser = api_base_url+"/api/User/update";
export const urlDeleteUser = api_base_url+"/api/User/delete";
export const urlCreateUser = api_base_url+"/api/User/create";
export const urlExportUser = api_base_url+"/api/User/export";
export const urlImportUser = api_base_url+"/api/User/import";
export const urlLogin = api_base_url+"/api/User/login";
export const urlChangePassword = api_base_url+"/api/User/changePassword";
export const urlLogOut = api_base_url+"/api/User/logOut";
export const urlRefreshToken = api_base_url+"/api/User/refreshToken";
export const urlLoginAdminUser = api_base_url+"/api/User/loginAdminUser";
export const urlResetPassword = api_base_url+"/api/User/resetPassword";
//
export const urlCategoriesGetAll = api_base_url+"/api/Categories/getAll";
export const urlCategoriesGetAllByPermission = api_base_url+"/api/Categories/getAllByPermission";
export const urlCategoriesCreate = api_base_url+"/api/Categories/create";
export const urlCategoriesUpdate = api_base_url+"/api/Categories/update";
export const urlCategoriesDelete = api_base_url+"/api/Categories/delete";
export const urlCategoriesExport = api_base_url+"/api/Categories/export";
export const urlCategoriesImport = api_base_url+"/api/Categories/import";
// Folder
export const urlFolderGetNotParentByCategory = api_base_url+"/api/Folder/getNotParentByCategory";
export const urlFolderGetByParentAndCategory = api_base_url+"/api/Folder/getByParentAndCategory";
export const urlMoveFolderToFolder = api_base_url+"/api/Folder/moveFolderToFolder";
export const urlCretateFolder = api_base_url+"/api/Folder/create";
export const urlUpdateFolder = api_base_url+"/api/Folder/update";
export const urlDeleteFolder = api_base_url+"/api/Folder/delete";
export const urlCopyFolder = api_base_url+"/api/Folder/copyFolder";
export const urlSearchFolder = api_base_url+"/api/Folder/search";
export const urlGetFolderByName = api_base_url+"/api/Folder/getFolderByName";
export const urlDownloadFolder = api_base_url+"/api/Folder/download";
export const urlGetAllFolderByCategory = api_base_url+"/api/Folder/getAllFolderByCategory";
export const urlSearchFolderByCategory = api_base_url+"/api/Folder/searchByCategory";
export const urlGetListParentFolder = api_base_url +"/api/Folder/getListParentFolder";
export const urlGetByParentAndCategoryNotPermission = api_base_url+"/api/Folder/getByParentAndCategoryNotPermission";
export const urlDeleteMultiFolder = api_base_url+"/api/Folder/deleteMulti";
// Tab
export const urlTagGetAll = api_base_url+"/api/Tag/getAll";
export const urlCreateTag = api_base_url+"/api/Tag/create";
export const urlUpdateTag = api_base_url+"/api/Tag/update";
export const urlDeleteTag = api_base_url+"/api/Tag/delete";
export const urlExportTag = api_base_url+"/api/Tag/export";
export const urlImportTag = api_base_url+"/api/Tag/import";
export const urlTagGetById = api_base_url+"/api/Tag/getById";
export const urlTagGetByInfor = api_base_url+"/api/Tag/getByInfor";
export const urlGetByPlatForm = api_base_url+"/api/Tag/getByPlatForm";
export const urlExportDataTag = api_base_url+"/api/Tag/exportData";
export const urlImportDataTag  = api_base_url+"/api/Tag/importData";
//disciplines
export const urlDisciplinesGetAll = api_base_url+"/api/Disciplines/getAll";
export const urlDisciplinesCreate = api_base_url+"/api/Disciplines/create";
export const urlDisciplinesUpdate = api_base_url+"/api/Disciplines/update";
export const urlDisciplinesDelete = api_base_url+"/api/Disciplines/delete";
export const urlDisciplinesExport = api_base_url+"/api/Disciplines/export";
export const urlDisciplinesImport = api_base_url+"/api/Disciplines/import";
//permission folder
export const urlPermissionGetByFolder = api_base_url+"/api/FolderPermission/getPermissionByFolder";
export const urlCreateFolderPermission = api_base_url+"/api/FolderPermission/create";
export const urlDeleteFolderPermission = api_base_url+"/api/FolderPermission/delete";
export const urlUpdateFolderPermission = api_base_url+"/api/FolderPermission/update";
export const urlGetPermissionByFolder = api_base_url+"/api/FolderPermission/getJsonPermissionByFolder";
//system
export const urlSystemGetAll = api_base_url+"/api/System/getAll";
export const urlSystemUpdate = api_base_url+"/api/System/update";
export const urlSystemCreate = api_base_url+"/api/System/create";
export const urlSystemDelete = api_base_url+"/api/System/delete";
export const urlSystemExport = api_base_url+"/api/System/export";
export const urlSystemImport = api_base_url+"/api/System/import";
//sendMail
export const urlSendMail = api_base_url+"/api/Mail/SendMail";
export const urlgetInforMail = api_base_url+"/api/Mail/getInforMail";
//document type
export const urlDocumentTypeGetAll = api_base_url+"/api/DocumentType/getAll";
export const urlDocumentTypeByParent = api_base_url+"/api/DocumentType/getDocumentTypeByParent";
export const urlDocumentTypeNotParent = api_base_url+"/api/DocumentType/getDocumentTypeNotParent";
export const urlDocumentTypeCreate = api_base_url+"/api/DocumentType/create";
export const urlDocumentTypeUpdate = api_base_url+"/api/DocumentType/update";
export const urlDocumentTypeDelete = api_base_url+"/api/DocumentType/delete";
export const urlDocumentTypeExport = api_base_url+"/api/DocumentType/export";
export const urlDocumentTypeImport = api_base_url+"/api/DocumentType/import";
export const urlDocumentTypeAllParent = api_base_url+"/api/DocumentType/getDocumentTypeAllParent";
//plant
export const urlPlatFormGetAll = api_base_url+"/api/PlatForm/getAll";
export const urlPlatFormCreate = api_base_url+"/api/PlatForm/create";
export const urlPlatFormUpdate = api_base_url+"/api/PlatForm/update";
export const urlPlatFormDelete = api_base_url+"/api/PlatForm/delete";
export const urlPlatFormExport = api_base_url+"/api/PlatForm/export";
export const urlPlatFormImport = api_base_url+"/api/PlatForm/import";
//syncfolder
export const urlSyncFolderGetAll = api_base_url+"/api/SyncFolder/getAll";
export const urlSyncFolder = api_base_url+"/api/SyncFolder/syncFolder";
//unit
export const urlUnitGetAll = api_base_url+"/api/Unit/getAll";
export const urlUnitCreate = api_base_url+"/api/Unit/create";
export const urlUnitUpdate = api_base_url+"/api/Unit/update";
export const urlUnitDelete = api_base_url+"/api/Unit/delete";
export const urlUnitExport = api_base_url+"/api/Unit/export";
export const urlUnitImport = api_base_url+"/api/Unit/import";
//dashboard
export const urlGetDBDataDocument = api_base_url+"/api/Dashboard/getDBDataDocument";
export const urlGetDBNewDocument = api_base_url+"/api/Dashboard/getDBNewDocument";
//getNewUser
export const urlGetDBNewUser = api_base_url+"/api/Dashboard/getDBNewUser";
//getNewDocumentLog
export const urlGetNewDocumentLog = api_base_url+"/api/DocumentLogHistory/getNewDocumentLog";
//getDBDocumentALLCategory
export const urlGetDBDocumentALLCategory = api_base_url+"/api/Dashboard/getDBDocumentALLCategory";
//getDBDocumentAllMothInYear
export const urlGetDBDocumentAllMothInYear = api_base_url+"/api/Dashboard/getDBDocumentAllMothInYear";
// use login history
//get all
export const urlGetAllLoginHistory = api_base_url+"/api/UserLoginHistory/getAll";
// doc properties view
//get by category
export const urlGetDocPropertiesByCategory = api_base_url+"/api/DocPropertiesView/getByCategory";
export const urlDocPropertiesUpdate = api_base_url+"/api/DocPropertiesView/update";
//
export const urlBinGetAll = api_base_url+"/api/RecycleBin/getAll";
export const urlBinDelete = api_base_url+"/api/RecycleBin/delete";
export const urlBinRestore = api_base_url+"/api/RecycleBin/restore";
//
export const urlTaskGetAll= api_base_url+"/api/Task/getAll";
export const urlTaskGetTasksNotAttachByDocument= api_base_url+"/api/Task/getTasksNotAttachByDocument";
export const urlTaskGetTasksAttachedByDocument= api_base_url+"/api/Task/getTasksAttachedByDocument";
export const urlDocumentSearchAllChild = api_base_url+"/api/Document/searchAllChild";
export const urlMailHistoryGetByUser = api_base_url+"/api/MailHistory/getByUser";
export const urlMailHistoryCreate = api_base_url+"/api/MailHistory/create";
export const urlMailHistoryUpdate = api_base_url+"/api/MailHistory/update";
export const urlMailHistoryDelete = api_base_url+"/api/MailHistory/delete";
export const urlFolderSetPrivate = api_base_url+"/api/Folder/setPrivate";
export const urlPhaseGetAllByProject= api_base_url+"/api/Phase/getAllByProject";
export const urlPhaseUpdate= api_base_url+"/api/Phase/update";
export const urlProjectCreate= api_base_url+"/api/Project/create";
export const urlProjectUpdate= api_base_url+"/api/Project/update";
export const urlProjectDelete= api_base_url+"/api/Project/delete";
export const urlProjectGetAll= api_base_url+"/api/Project/getAll";
export const urlPhaseCreate= api_base_url+"/api/Phase/create";
export const urlTaskCreate= api_base_url+"/api/Task/create";
export const urlTaskUpdate= api_base_url+"/api/Task/update";
export const urlPhaseDelete= api_base_url+"/api/Phase/delete";
export const urlTaskDelete= api_base_url+"/api/Task/delete";
export const urlTaskGetAllByPhase= api_base_url+"/api/Task/getAllByPhase";
export const urlPhaseRequestApprove = api_base_url+"/api/Phase/requestApprove";
export const urlPhaseApprove = api_base_url+"/api/Phase/approve";
export const urlProjectApprove = api_base_url+"/api/Project/approve";
export const urlProjectRequestApprove = api_base_url+"/api/Project/requestApprove";
export const urlPhaseGetByID = api_base_url+"/api/Phase/getByID";
export const urlProjectGetByID = api_base_url+"/api/Project/getByID";
export const urlTaskGetListPhaseID = api_base_url+"/api/Task/getByListPhaseID";
export const urlPhaseByListProjectID = api_base_url+"/api/Phase/getByListProjectID";
export const urlProjectGetAllTask = api_base_url+"/api/Project/getAllTask";
export const urlAttachDocumentGetByDocument = api_base_url+"/api/AttachDocument/getByDocument";
export const urlAttachDocumentCreate = api_base_url+"/api/AttachDocument/create";
export const urlAttachGetDocumentDocumentAttachToProject = api_base_url+"/api/AttachDocument/getDocumentAttachToProject";
export const urlAttachGetDocumentDocumentAttachToPhase = api_base_url+"/api/AttachDocument/getDocumentAttachToPhase";
export const urlAttachGetDocumentDocumentAttachToTask = api_base_url+"/api/AttachDocument/getDocumentAttachToTask";
export const urlTaskGetAllByProject = api_base_url+"/api/Task/getAllByProject";
export const urlTaskGetAllProject = api_base_url+"/api/Task/getAllProject";
export const urlTaskCancel = api_base_url+"/api/Task/cancel";
export const urlPhaseCancel = api_base_url+"/api/Phase/cancel";
export const urlProjectCancel = api_base_url+"/api/Project/cancel";
export const urlProjectReport = api_base_url+"/api/Project/report";
export const urlTaskRestore = api_base_url+"/api/Task/restore";
export const urlWorkflowGetAll = api_base_url+"/api/Workflow/getAll";
export const urlWorkflowCreate = api_base_url+"/api/Workflow/create";
export const urlWorkflowUpdate = api_base_url+"/api/Workflow/update";
export const urlWorkflowDelete = api_base_url+"/api/Workflow/delete";
export const urlWorkflowStepGetByWorkflow = api_base_url+"/api/WorkflowStep/getByWorkflow";
export const urlWorkflowStepCreate = api_base_url+"/api/WorkflowStep/create";
export const urlWorkflowStepUpdate = api_base_url+"/api/WorkflowStep/update";
export const urlWorkflowStepDelete = api_base_url+"/api/WorkflowStep/delete";
export const urlWorkflowDetailGetByWorkflow = api_base_url+"/api/WorkflowDetail/getByWorkflow";
export const urlWorkflowDetailCreate = api_base_url+"/api/WorkflowDetail/create";
export const urlWorkflowDetailUpdate = api_base_url+"/api/WorkflowDetail/update";
export const urlWorkflowDetailDelete = api_base_url+"/api/WorkflowDetail/delete";
export const urlWorkflowAttachWorkflow = api_base_url+"/api/Workflow/attachWorkflow";
export const urlObjectAssginUserGetByProject = api_base_url+"/api/ObjectAssginUser/getByProject";
export const urlObjectAssignUserApprove = api_base_url+"/api/ObjectAssginUser/approve";
export const urlObjectAssginUserUpdate = api_base_url+"/api/ObjectAssginUser/update";
export const urlObjectAssginUserReject = api_base_url+"/api/ObjectAssginUser/reject";
export const urlWorkflowDeleteWorkflow = api_base_url+"/api/Workflow/deleteWorkflow";
export const urlCustomizeWorkflowDetailsGetByWorkflowAndProject = api_base_url+"/api/CustomizeWorkflowDetails/getByWorkflowProject";
export const urlCustomizeWorkflowDetialsUpdateAllByProject = api_base_url+"/api/CustomizeWorkflowDetails/updateAllByProject";
export const urlObjectAssginUserGetByID = api_base_url+"/api/ObjectAssginUser/getByID";
export const urlObjectAssginUserGetNextStepID = api_base_url+"/api/ObjectAssginUser/getByNextStepID";
export const urlWorkflowHistoryGetByProject = api_base_url+"/api/WorkflowHistory/getByProject";
export const urlProjectUpFileApprove = api_base_url+"/api/Project/upFileApprove";
export const urlTypeGetAll = api_base_url + "/api/Type/getAll";
export const urlTypeCreate = api_base_url + "/api/Type/create";
export const urlTypeUpdate = api_base_url+"/api/Type/Update";
export const urlTypeDelete = api_base_url+"/api/Type/Delete";
export const urlTaskGetWorkHourInYear = api_base_url+"/api/Task/getWorkHourInYear";
export const urlWorkflowDetailUpdateStep = api_base_url+"/api/WorkflowDetail/updateStep";
export const urlPhaseRestore = api_base_url+"/api/Phase/restore";
export const urlProjectRestore = api_base_url+"/api/Project/restore";
export const urlChatGetByProject = api_base_url + "/api/Chat/getByProject";
export const urlChatCreate = api_base_url + "/api/Chat/Create";
export const urlChatStatusGetUnRead = api_base_url + "/api/ChatStatus/getCountUnRead";
export const urlChatStatusUpdateReadByProject = api_base_url + "/api/ChatStatus/updateReadAllProject";
export const urlChatMembersGetAllByProject = api_base_url + "/api/ChatMembers/getAllByProject";
export const urlChatMembersCreate = api_base_url + "/api/ChatMembers/create";
export const urlChatMembersDelete = api_base_url + "/api/ChatMembers/delete";
export const urlProjectGetChatMembers = api_base_url + "/api/Project/getChatMembers";
export const urlChatDelete = api_base_url + "/api/Chat/delete";
export const urlChatSendMail = api_base_url + "/api/Chat/sendMail";
export const urlFolderGetAllPermissionWrite = api_base_url + "/api/Folder/getAllPermissionWrite";
export const urlFolderGetByID = api_base_url + "/api/Folder/getByID";


