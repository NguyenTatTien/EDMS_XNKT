export class Workflow{
    constructor(){
        this.id = 0;
        this.name = "";
        this.description = "";
        this.createdBy = null;
        this.createdByName = null;
        this.createdDate = null;
        this.updatedBy = null;
        this.updatedDate = null;
        this.objectTypeId = null;
        this.objectType = null;
        this.objectTypeName = null;
        this.isInternalWorkflow = false;
        this.re_assignUserId = null;
        this.re_assignUserName = null;
        this.isInternalWorkflow = false;
        this.isWorkflowFull = false;
        this.isHide = false;
    }
}