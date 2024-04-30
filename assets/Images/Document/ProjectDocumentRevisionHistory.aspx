﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectDocumentRevisionHistory.aspx.cs" Inherits="EDMs.Web.Controls.Document.ProjectDocumentRevisionHistory" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="~/Content/styles.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        
        function CloseAndRefreshGrid() {
            var oWin = GetRadWindow();
            var parentWindow = oWin.BrowserWindow;
            $(oWin).ready(function () {
                oWin.close();
            });
            parentWindow.refreshGrid();
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including classic dialog
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

            return oWindow;
        }


    </script>
    <style type="text/css">
        .RadGrid .rgRow td, .RadGrid .rgAltRow td, .RadGrid .rgEditRow td, .RadGrid .rgFooter td, .RadGrid .rgFilterRow td, .RadGrid .rgHeader, .RadGrid .rgResizeCol, .RadGrid .rgGroupHeader td {
            padding-left: 1px !important;
            padding-right: 1px !important;
        }

        /*Hide change page size control*/
        div.RadGrid .rgPager .rgAdvPart     
        {     
        display:none;        
        }    
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="content">
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <telerik:RadGrid AllowCustomPaging="False" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" CellPadding="0" CellSpacing="0" GridLines="None" 
                ID="grdDocument" Skin="Windows7" Height="500"
                OnDeleteCommand="grdDocument_DeleteCommand" 
                OnNeedDataSource="grdDocument_OnNeedDataSource" 
                OnDetailTableDataBind="grdDocument_DetailTableDataBind"
                PageSize="100" runat="server"  Width="100%">
                <SortingSettings SortedBackColor="#FFF6D6"></SortingSettings>
                <GroupingSettings CaseSensitive="False"></GroupingSettings>
                <MasterTableView AllowMultiColumnSorting="false" 
                    ClientDataKeyNames="ID" DataKeyNames="ID" Font-Size="8pt">
                        <%--<GroupByExpressions>
                                <telerik:GridGroupByExpression>
                                    <SelectFields>
                                        <telerik:GridGroupByField FieldAlias="-" FieldName="DocumentTypeName" FormatString="{0:D}"
                                            HeaderValueSeparator=""></telerik:GridGroupByField>
                                    </SelectFields>
                                    <GroupByFields>
                                        <telerik:GridGroupByField FieldName="DocumentTypeName" SortOrder="Ascending" ></telerik:GridGroupByField>
                                    </GroupByFields>
                                </telerik:GridGroupByExpression>
                            </GroupByExpressions>  --%>  
                        <PagerStyle AlwaysVisible="True" FirstPageToolTip="First page" LastPageToolTip="Last page" NextPagesToolTip="Next page" NextPageToolTip="Next page" PagerTextFormat="Change page: {4} &amp;nbsp;Page &lt;strong&gt;{0}&lt;/strong&gt; / &lt;strong&gt;{1}&lt;/strong&gt;, Total:  &lt;strong&gt;{5}&lt;/strong&gt; Documents." PageSizeLabelText="Row/page: " PrevPagesToolTip="Previous page" PrevPageToolTip="Previous page" />
                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ColumnGroups>
                           <%-- <telerik:GridColumnGroup HeaderText="First Issue Info" Name="FirstIssueInfo"
                                    HeaderStyle-HorizontalAlign="Center"/>
                            <telerik:GridColumnGroup HeaderText="Final Issue Info" Name="FinalIssueInfo"
                                    HeaderStyle-HorizontalAlign="Center"/>
                            <telerik:GridColumnGroup HeaderText="INCOMING TRANSMITTAL" Name="IncomingTrans"
                                    HeaderStyle-HorizontalAlign="Center"/>
                            <telerik:GridColumnGroup HeaderText="ICA REVIEW DETAILS" Name="ICAReviews"
                                    HeaderStyle-HorizontalAlign="Center"/>--%>
                        </ColumnGroups>
                                    
                        <DetailTables>
                            <telerik:GridTableView DataKeyNames="ID" Name="DocDetail" Width="700px"
                                AllowPaging="True" PageSize="10">
                                <PagerStyle AlwaysVisible="True" FirstPageToolTip="First page" LastPageToolTip="Last page" NextPagesToolTip="Next page" NextPageToolTip="Next page" PagerTextFormat="Change page: {4} &amp;nbsp;Page &lt;strong&gt;{0}&lt;/strong&gt; / &lt;strong&gt;{1}&lt;/strong&gt;, Total:  &lt;strong&gt;{5}&lt;/strong&gt; Documents." PageSizeLabelText="Row/page: " PrevPagesToolTip="Previous page" PrevPageToolTip="Previous page" />
                                <Columns>
                                    <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="DownloadColumn">
                                    <HeaderStyle Width="3%" />
                                    <ItemStyle HorizontalAlign="Center" Width="3%"/>
                                    <ItemTemplate>
                                        <a href='../../DownloadFileHandler.ashx?DownloadFile=Owner&DocId=<%# DataBinder.Eval(Container.DataItem, "ID") %>'
                                           download='<%# DataBinder.Eval(Container.DataItem, "FileName") %>' target="_blank">
                                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ExtensionIcon") %>'
                                                Style="cursor: pointer;" ToolTip="Download document" /> 
                                        </a>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                            
                                                 <telerik:GridBoundColumn DataField="FileName" HeaderText="File name" UniqueName="FileName">
                                        <HeaderStyle HorizontalAlign="Center" Width="35%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                    
                                    <telerik:GridBoundColumn DataField="TypeName" HeaderText="Type" UniqueName="TypeName">
                                        <HeaderStyle HorizontalAlign="Center" Width="25%" />
                                        <ItemStyle HorizontalAlign="Left"/>
                                    </telerik:GridBoundColumn>
                                
                                    <telerik:GridBoundColumn DataField="CreatedByName" HeaderText="Upload by" UniqueName="CreatedByName">
                                        <HeaderStyle HorizontalAlign="Center" Width="15%" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                
                                    <telerik:GridBoundColumn DataField="CreatedDate" HeaderText="Upload time" UniqueName="CreatedDate"
                                        DataFormatString="{0:dd/MM/yyyy hh:mm tt}" >
                                        <HeaderStyle HorizontalAlign="Center" Width="15%" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridBoundColumn>
                                
                                    <telerik:GridBoundColumn DataField="FileSize" HeaderText="File size(Kb)" UniqueName="FileSize" DataFormatString="{0:0,0.00}">
                                        <HeaderStyle HorizontalAlign="Center" Width="13%" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </telerik:GridTableView>
                        </DetailTables>

                        <Columns>
                                <telerik:GridBoundColumn DataField="ID" UniqueName="ID" Visible="False" />
                                <telerik:GridTemplateColumn HeaderText="No." Groupable="False">
                                    <HeaderStyle HorizontalAlign="Center" Width="2%" VerticalAlign="Middle"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center" Width="2%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblSoTT" runat="server" Text='<%# grdDocument.CurrentPageIndex * grdDocument.PageSize + grdDocument.Items.Count+1 %>'>
                                        </asp:Label>
                                      
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%--<telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/Images/edit.png" 
                                    UpdateImageUrl="~/Images/ok.png" CancelImageUrl="~/Images/delete.png" UniqueName="EditColumn">
                                    <HeaderStyle HorizontalAlign="Center" Width="2%"  />
                                    <ItemStyle HorizontalAlign="Center" Width="2%"/>
                                </telerik:GridEditCommandColumn>--%>
                            <%--<telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" HeaderTooltip="Delete document"
                                    ConfirmText="Do you want to delete document?" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                                    <HeaderStyle Width="1%" />
                                        <ItemStyle HorizontalAlign="Center" Width="1%"  />
                                </telerik:GridButtonColumn>
                                --%>
                               
                                    <telerik:GridTemplateColumn HeaderText="Document Number" UniqueName="DocNo" DataField="DocNo"
                                         ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                        <HeaderStyle HorizontalAlign="Center" Width="160" />
                                        <ItemStyle HorizontalAlign="Left" Width="160" />
                                        <ItemTemplate>
                                             <%# Eval("DocNo") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                            
                                    <telerik:GridTemplateColumn HeaderText="Document Title" UniqueName="DocTitle" DataField="DocTitle"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                        <HeaderStyle HorizontalAlign="Center" Width="220" />
                                        <ItemStyle HorizontalAlign="Left" Width="220" />
                                        <ItemTemplate>
                                            <%# Eval("DocTitle") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderText="Revision" UniqueName="MajorRev"
                                        ShowFilterIcon="False" FilterControlWidth="97%"  DataField="Revision"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="50" />
                                        <ItemStyle HorizontalAlign="Center" Width="50"/>
                                        <ItemTemplate>
                                            <%# Eval("Revision") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                 <%--   <telerik:GridTemplateColumn HeaderText="Confidentiality" UniqueName="ConfidentialityName"
                                        ShowFilterIcon="False" FilterControlWidth="97%"  DataField="ConfidentialityName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("ConfidentialityName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Document Type" UniqueName="DocTypeCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%"  DataField="DocTypeCode"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("DocTypeCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Originating Organisation" UniqueName="OriginatingOrganisationName"
                                        ShowFilterIcon="False" FilterControlWidth="97%"  DataField="OriginatingOrganisationName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("OriginatingOrganisationName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                     <%--   <telerik:GridTemplateColumn HeaderText="Receiving Organisation" UniqueName="ReceivingOrganisationName"
                                        ShowFilterIcon="False" FilterControlWidth="97%"  DataField="ReceivingOrganisationName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("ReceivingOrganisationName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>
                                        
                                     <%--   <telerik:GridTemplateColumn HeaderText="Year" UniqueName="Year"
                                        ShowFilterIcon="False" FilterControlWidth="97%"  DataField="Year"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="50" />
                                        <ItemStyle HorizontalAlign="Center" Width="50"/>
                                        <ItemTemplate>
                                            <%# Eval("Year") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="GroupCode" UniqueName="GroupCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%"  DataField="GroupCode"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="50" />
                                        <ItemStyle HorizontalAlign="Center" Width="50"/>
                                        <ItemTemplate>
                                            <%# Eval("GroupCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>

                                     <telerik:GridTemplateColumn HeaderText="Original Doc No." UniqueName="OriginalDocumentNumber" DataField="OriginalDocumentNumber"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="160" />
                                        <ItemStyle HorizontalAlign="Left" Width="160" />
                                        <ItemTemplate>
                                            <%# Eval("OriginalDocumentNumber") %>
                                        </ItemTemplate>
                                     </telerik:GridTemplateColumn> 
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Issue Date" UniqueName="Date" DataField="Date"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="false">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn> 
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Response Required Date" UniqueName="ResponseRequiredDate" DataField="ResponseRequiredDate"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>  

                                        <telerik:GridTemplateColumn HeaderText="Response To" UniqueName="ResponseToName" DataField="ResponseToName"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="150"/>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("ResponseToName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Carbon Copy" UniqueName="CarbonCopyName" DataField="CarbonCopyName"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="70" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("CarbonCopyName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Related CS/Letter" UniqueName="RelatedCSLNo" DataField="RelatedCSLNo"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("RelatedCSLNo") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Need Reply" UniqueName="IsNeedReply" AllowFiltering="False" Display="False">
                                             <HeaderStyle Width="60" HorizontalAlign="Center"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/ok.png" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "IsNeedReply"))%>'/>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="200" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("Description") != null ? Eval("Description").ToString().Replace(Environment.NewLine, "<br/>") : string.Empty %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Treatment" UniqueName="Treatment" DataField="Treatment"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("Treatment") != null ? Eval("Treatment").ToString().Replace(Environment.NewLine, "<br/>") : string.Empty %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                         <telerik:GridTemplateColumn HeaderText="Proposed By" UniqueName="ProposedBy" DataField="ProposedBy"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("ProposedBy") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Proposed Date" UniqueName="ProposedDate" DataField="ProposedDate"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>    

                                        <telerik:GridTemplateColumn HeaderText="Reviewed By" UniqueName="ReviewedBy" DataField="ReviewedBy"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("ReviewedBy") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Reviewed Date" UniqueName="ReviewedDate" DataField="ReviewedDate"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>

                                        <telerik:GridTemplateColumn HeaderText="Approved By" UniqueName="ApprovedBy" DataField="ApprovedBy"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("ApprovedBy") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Approved Date" UniqueName="ApprovedDate" DataField="ApprovedDate"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Issued Date (FROM)" UniqueName="IssuedDateFrom" DataField="IssuedDateFrom"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Received Date (TO)" UniqueName="ReceivedDateTo" DataField="ReceivedDateTo"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Received Date (CC)" UniqueName="ReceivedDateCC" DataField="ReceivedDateCC"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>

                                        <telerik:GridTemplateColumn HeaderText="Area" UniqueName="AreaCode" DataField="AreaCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("AreaCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                       <%-- <telerik:GridTemplateColumn HeaderText="Unit" UniqueName="UnitCode" DataField="UnitCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("UnitCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="System" UniqueName="SystemCode" DataField="SystemCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("SystemCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Sub-System" UniqueName="SubsystemCode" DataField="SubsystemCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("SubsystemCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="KKS Code" UniqueName="KKSCode" DataField="KKSCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("KKSCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>
                                        
                                      <%--  <telerik:GridTemplateColumn HeaderText="Train No" UniqueName="TrainNo" DataField="TrainNo"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("TrainNo") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Discipline" UniqueName="DisciplineCode" DataField="DisciplineCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("DisciplineCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Sheet No." UniqueName="SheetNo" DataField="SheetNo"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("SheetNo") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Planned Date" UniqueName="PlannedDate" DataField="PlannedDate"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>
                                        
                                        <telerik:GridDateTimeColumn HeaderText="Actual Date" UniqueName="ActualDate" DataField="ActualDate"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>
                                        
                                         <telerik:GridTemplateColumn HeaderText="Remarks" UniqueName="Remarks" DataField="Remarks"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("Remarks").ToString().Replace(Environment.NewLine, "<br/>") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn> 
                                        
                                       
                                        
                                        <telerik:GridTemplateColumn HeaderText="Revision Schema" UniqueName="RevisionSchemaName" DataField="RevisionSchemaName" ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("RevisionSchemaName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Minor Rev." UniqueName="MinorRev" DataField="MinorRev" ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("MinorRev") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                         <telerik:GridDateTimeColumn HeaderText="Rev Date" UniqueName="RevDate" DataField="RevDate"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Rev. Status" UniqueName="RevStatusName" DataField="RevStatusName"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="120" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("RevStatusName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        
                                         <telerik:GridTemplateColumn HeaderText="Rev. Remarks" UniqueName="RevRemarks" DataField="RevRemarks"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("RevRemarks").ToString().Replace(Environment.NewLine, "<br/>") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn> 
                                        
                                      <%--  <telerik:GridTemplateColumn HeaderText="Document Action Code" UniqueName="DocActionCode" DataField="DocActionCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="100" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("DocActionCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>
                                        
                                         <telerik:GridTemplateColumn HeaderText="Document Review Status" UniqueName="DocReviewStatusCode" DataField="DocReviewStatusCode"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="False">
                                        <HeaderStyle HorizontalAlign="Center" Width="100" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("DocReviewStatusCode") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                         <telerik:GridTemplateColumn HeaderText="Incoming Transmittal" UniqueName="IncomingTransNo" DataField="IncomingTransNo"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("IncomingTransNo") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn> 

                                        <telerik:GridTemplateColumn HeaderText="Outgoing Transmittal" UniqueName="OutgoingTransNo" DataField="OutgoingTransNo"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Display="true">
                                        <HeaderStyle HorizontalAlign="Center" Width="150" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%# Eval("OutgoingTransNo") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn> 
                                      <telerik:GridTemplateColumn HeaderText="Created By" UniqueName="CreatedByName"
                                        ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"  />
                                        <ItemTemplate>
                                            <%# Eval("CreatedByName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridDateTimeColumn HeaderText="Date Created" UniqueName="CreatedDate" DataField="CreatedDate"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True">
                                        <HeaderStyle HorizontalAlign="Center" Width="120" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>    
                                     <telerik:GridTemplateColumn HeaderText="Last Update By" UniqueName="LastUpdatedByName" ShowFilterIcon="False" FilterControlWidth="97%" 
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                        <HeaderStyle HorizontalAlign="Center" Width="80" />
                                        <ItemStyle HorizontalAlign="Center"  />
                                        <ItemTemplate>
                                            <%# Eval("LastUpdatedByName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                         <telerik:GridDateTimeColumn HeaderText="Last Update Date" UniqueName="LastUpdatedDate" DataField="LastUpdatedDate"
                                            DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="80%" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="True">
                                        <HeaderStyle HorizontalAlign="Center" Width="120" />
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>   
                        </Columns>
                    </MasterTableView>
                    <ClientSettings Selecting-AllowRowSelect="true" AllowColumnHide="True">
                    <Scrolling AllowScroll="True" SaveScrollPosition="True" ScrollHeight="500" UseStaticHeaders="True" />
                    </ClientSettings>
            </telerik:RadGrid>
            
            <telerik:GridDropDownListColumnEditor ID="ddlRevision" runat="server"
                    DropDownStyle-Width="110px">
            </telerik:GridDropDownListColumnEditor>

        <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel2" />
        <telerik:RadAjaxManager runat="Server" ID="ajaxCustomer" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
            <ClientEvents OnRequestStart="onRequestStart"></ClientEvents>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ajaxCustomer">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grdDocument" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
            

            <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true" >
            <Windows>
                
            <telerik:RadWindow ID="AttachDoc" runat="server" Title="Attach document files" 
                VisibleStatusbar="false" Height="500" Width="500" MinHeight="500" MinWidth="500" MaxHeight="500" MaxWidth="500" 
                Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
        </div>
        <telerik:RadCodeBlock runat="server">
            <script type="text/javascript">
                
                function RowDblClick(sender, eventArgs) {
                    sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
                }

                var ajaxManager;

                function pageLoad() {
                ajaxManager = $find("<%=ajaxCustomer.ClientID %>");
            }

                function onRequestStart(sender, args) {
                    if (args.get_eventTarget().indexOf("btnDownloadPackage") >= 0) {
                        args.set_enableAjax(false);
                    }
                }

                function ShowUploadForm(id) {
                    var owd = $find("<%=AttachDoc.ClientID %>");
                    owd.Show();
                    owd.setUrl("UploadDragDrop.aspx?docId=" + id, "AttachDoc");
                    // window.parent.radopen("Controls/Document/DocumentInfoEditForm.aspx?docId=" + id, "DocDialog");
                    // return false;
                }
                
                function ShowInsertForm() {
                    window.radopen("Controls/Customers/CustomerEditForm.aspx", "DocDialog");
                    return false;
                }
                
                function refreshGrid(arg) {
                    //alert(arg);
                    if (!arg) {
                        ajaxManager.ajaxRequest("Rebind");
                    }
                    else {
                        ajaxManager.ajaxRequest("RebindAndNavigate");
                    }
                }
            </script>
        </telerik:RadCodeBlock>
    </form>
</body>
</html>
