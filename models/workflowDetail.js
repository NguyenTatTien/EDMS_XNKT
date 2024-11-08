export class WorkflowDetail {
    constructor() {
      this.id = 0; // int
      this.workflowId = null; // int?
      this.workflowName = null; // string?
      this.currentWorkflowStepId = null; // int?
      this.currentWorkflowStepName = null; // string?
      this.stepDefinitionId = null; // int?
      this.stepDefinitionName = null; // string?
      this.duration = null; // double?
      this.assignTitleIds = null; // string?
      this.assignUserIds = null; // string?
      this.reviewUserIds = null; // string?
      this.consolidateUserIds = null; // string?
      this.commentUserIds = null; // string?
      this.approveUserIds = '';
      this.approveUserNames = '' // string?
      this.informationOnlyUserIds = null; // string?
      this.managementUserIds = null; // string?
      this.assignRoleIds = null; // string?
      this.informationOnlyRoleIds = null; // string?
      this.recipients = null; // string?
      this.nextWorkflowStepId = null; // int?
      this.nextWorkflowStepName = null; // string?
      this.rejectWorkflowStepId = null; // int?
      this.rejectWorkflowStepName = null; // string?
      this.createdBy = null; // int?
      this.createdDate = null; // DateTime?
      this.updatedBy = null; // int?
      this.updatedDate = null; // DateTime?
      this.projectId = null; // int?
      this.projectName = null; // string?
      this.isFirst = null; // bool?
      this.canReject = null; // bool?
      this.isOnlyWorkingDay = null; // bool?
      this.actionApplyCode = null; // string?
      this.actionApplyName = null; // string?
      this.isCreated = null; // bool?
    }
  }