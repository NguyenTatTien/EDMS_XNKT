export class FolderPermission{
    constructor(){
        this.id = 0,
        this.categoryId= null,
        this.folderId= null,
        this.objectId= null,
        this.objectIdName= "",
        this.typeID= null,
        this.typeName= "",
        this.createdBy= null,
        this.createdDate= null,
        this.lastUpdatedBy= null,
        this.lastUpdatedDate= null,
        this.folder_IsFullPermission= false,
        this.folder_ChangePermission= false,
        this.folder_CreateSubFolder= false,
        this.folder_Delete= false,
        this.folder_Read= false,
        this.folder_Write= false,
        this.file_FullPermission= false,
        this.file_ChangePermission= false,
        this.file_Create= false,
        this.file_Read= false,
        this.file_Delete= false,
        this.file_Write= false,
        this.file_NoAccess= false
    }
}