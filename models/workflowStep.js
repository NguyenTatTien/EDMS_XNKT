export class WorkflowStep{
    constructor(){
        this.id = 0;
        this.name = "New step";
        this.description = "";
        this.workflowID = null;
        this.workflowName = null;
        this.createdBy = null;
        this.createdDate = null;
        this.updatedBy = null;
        this.updatedDate = null;
        this.isFirst = null;
        this.canReject = true;
        this.canApprove = null;
        this.actionApplyCode = null;
        this.actionRejectCode = null; 
        this.isCreated = null;
        this.packageId = null;
        this.packageName = null;
        this.notChangeUser = false;
    }
}