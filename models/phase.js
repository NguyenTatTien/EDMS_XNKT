export class Phase {
  constructor() {
        this.id = 0,
        this.name = 'Phase mới',
        this.description = 'Phase mới',
        this.process_Percent= 0,
        this.process_Weight= 0,
        this.createdBy = null,
        this.createdByName = null,
        this.startDate= new Date(),
        this.endDate= null,
        this.estimatedDate= new Date(),
        this.projectID = null,
        this.mainManagerID = null,
        this.mainManagerName = null,
        this.isDelete = false,
        this.isApprove = false,
        this.isProcess = false,
        this.isComplete = false,
        this.isLate = false,
        this.isCancel = false,
        this.secondApproveBy = null,
        this.secondApproveByName = null,
        this.isEditPercent = false,
        this.departmentID = null,
        this.departmentName = null,
        this.subManagerIDs = null,
        this.subManagerNames = null,
        this.remark = null,
        this.approvals = [],
        this.tasks = [],
        this.subManagers = [],
        this.folderID = null,
        this.folderName = "",
        this.approveComment = null,
        this.cancelComment = null
  }
}