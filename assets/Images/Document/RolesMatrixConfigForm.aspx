<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RolesMatrixConfigForm.aspx.cs" Inherits="EDMs.Web.Controls.Document.RolesMatrixConfigForm" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="~/Content/styles.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        html, body, form {
            overflow: auto;
        }

        div.rgEditForm label {
            float: right;
            text-align: right;
            width: 72px;
        }

        .rgEditForm {
            text-align: right;
        }

        .RadUpload .ruFileWrap {
            overflow: visible !important;
        }
        /*Hide change page size control*/
        div.RadGrid .rgPager .rgAdvPart {
            display: none;
        }

        .RadComboBox table td.rcbInputCell {
            padding: 0!important;
        }
    </style>
    <telerik:RadScriptBlock runat="server">
        <script src="../../Scripts/jquery-1.7.1.js" type="text/javascript"></script>

        <script type="text/javascript">
            function CloseAndRebind(args) {
                GetRadWindow().BrowserWindow.refreshGrid(args);
                GetRadWindow().close();
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

                return oWindow;
            }

            function CancelEdit() {
                GetRadWindow().close();
            }
        </script>
    </telerik:RadScriptBlock>

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager2" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel2" />

        <div style="width: 100%">
            <ul style="list-style-type: none">
                <div class="qlcbFormItem">
                    <div class="dnnFormMessage dnnFormInfo">
                        <div class="dnnFormItem dnnFormHelp dnnClear">
                            <p class="dnnFormRequired" style="float: left;">
                                <span style="text-decoration: underline;">Notes</span>: All fields marked with a red are required.
                            </p>
                            <br />
                        </div>
                    </div>
                </div>
            </ul>
        </div>
        <div style="width: 100%" runat="server" ID="Radiobutton">
            <ul style="list-style-type: none">
         <li style="width: 550px;">
                    <div>
                        <label style="width: 80px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                            <span style="color: #2E5689; text-align: right; ">Option
                            </span>
                        </label>
                        <div style="float: left; padding-top: 5px;" class="qlcbFormItem" runat="server" id="div7">
                            <asp:RadioButton runat="server" ID="rbtnDefault" Text="Add New" GroupName="GroupRole" OnCheckedChanged="rbtnDefault_CheckedChanged" Checked="true" AutoPostBack="true"/>
                            <asp:RadioButton runat="server" ID="rbtnCopy" OnCheckedChanged="rbtnCopy_CheckedChanged" Text="Copy from another Project" GroupName="GroupRole" AutoPostBack="true"/>
                        </div>
                    </div>
                    <div style="clear: both; font-size: 0;"></div>
                </li>
             <li style="width: 550px;" runat="server" id="LiProject" visible="false">
                    <div>
                        <label style="width: 80px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                            <span style="color: #2E5689; text-align: right; ">Project
                            </span>
                        </label>
                        <div style="float: left; padding-top: 5px;" class="qlcbFormItem" runat="server" id="div1">
                            <asp:DropDownList ID="ddlProject" runat="server" CssClass="min25Percent" Width="400px" style="max-width: 400px"/>
                        </div>
                    </div>
                    <div style="clear: both; font-size: 0;"></div>
                </li>
                </ul>
            </div>
        <div style="width: 100%" runat="server" id="divContent">
            <ul style="list-style-type: none">
                <li style="width: 550px;">
                    <div>
                        <label style="width: 80px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                            <span style="color: #2E5689; text-align: right;">Department
                            </span>
                        </label>
                        <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="min25Percent" Width="400px"
                                AutoPostBack="True" OnSelectedIndexChanged="ddlDepartment_OnSelectedIndexChanged" />
                        </div>
                    </div>
                    <div style="clear: both; font-size: 0;"></div>
                </li>

                <li style="width: 550px;">
                    <div>
                        <label style="width: 80px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                            <span style="color: #2E5689; text-align: right;">User
                            </span>
                        </label>
                        <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                            <telerik:RadComboBox ID="lbUser" runat="server" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Width="400"
                                Height="150px" Style="max-width: 500px !important">
                            </telerik:RadComboBox>
                        </div>
                    </div>
                    <div style="clear: both; font-size: 0;"></div>
                </li>
                
                <li style="width: 500px;">
                    <div>
                        <label style="width: 80px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                            <span style="color: #2E5689; text-align: right;"> Discipline</span>
                        </label>
                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                <telerik:RadDropDownList runat="server" ID="ddlDiscipline" CssClass="min25Percent" Width="400px"></telerik:RadDropDownList>
                            </div>
                    </div>
                    <div style="clear: both; font-size: 0;"></div>
                </li>
                <li style="width: 550px;">
                    <div>
                        <label style="width: 125px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                            <span style="color: #2E5689; text-align: right; ">
                            </span>
                        </label>
                        <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                            <asp:RadioButton runat="server" GroupName="Role" Text="Role ADM " ID="cbIadm"/>
                            <asp:RadioButton runat="server" GroupName="Role" Text="Role DC" ID="cbIsDC"/>
                            <asp:RadioButton runat="server" GroupName="Role" Text="Role Lead" ID="cbLeader"/>
                            <asp:RadioButton runat="server" GroupName="Role" Text="Role Engineer" ID="cbupdate"/>
                            <asp:RadioButton runat="server" GroupName="Role" Text="Role View" ID="cbview"/>
                        </div>
                    </div>
                    <div style="clear: both; font-size: 0;"></div>
                </li>
            </ul>
        </div>

        <div style="width: 100%">
            <ul style="list-style-type: none">
                <li style="width: 500px; padding-top: 5px; padding-bottom: 3px; text-align: center">
                    <div style="float:left; padding-top:10px; margin-left:50px;">
                    <div style=" float:left; padding-bottom: 2px;">
                    <telerik:RadButton ID="btnSave" runat="server" Text="Add User" OnClick="btnSave_Click" Width="130px" Style="text-align: center">
                        <Icon PrimaryIconUrl="../../Images/addNew.png" PrimaryIconLeft="4" PrimaryIconTop="4" PrimaryIconWidth="16" PrimaryIconHeight="16"></Icon>
                    </telerik:RadButton>
                        </div>
                        <div style="float:left; padding-left: 5px;">
                            <telerik:RadButton ID="btnExportCRS" runat="server" Text="Export Tempalate" OnClick="btnExportCRS_OnClick" Width="125px" style="text-align: center">
                                <Icon PrimaryIconUrl="../../Images/exexcel.png" PrimaryIconLeft="4" PrimaryIconTop="4" PrimaryIconWidth="16" PrimaryIconHeight="16"></Icon>
                            </telerik:RadButton>
                        </div>  
                        <div style="float:left; padding-left: 5px;">
                            <telerik:RadButton ID="btnImport" runat="server" Text="Import Template" AutoPostBack="False" OnClientClicked="ImportRoleMatrix"  Width="150px" style="text-align: center">
                                <Icon PrimaryIconUrl="../../Images/export.png" PrimaryIconLeft="4" PrimaryIconTop="4" PrimaryIconWidth="16" PrimaryIconHeight="16"></Icon>
                            </telerik:RadButton></div>
                    </div>
                    <div style="clear: both; font-size: 0;"></div>
                </li>
            </ul>
        </div>

        <telerik:RadGrid ID="grdPermission" runat="server" AllowPaging="True"
            AutoGenerateColumns="False" CellSpacing="0" CellPadding="0"
            PageSize="100" Height="300" GridLines="None"
            Skin="Windows7" AllowFilteringByColumn="True"
            OnNeedDataSource="grdPermission_OnNeedDataSource"
            OnDeleteCommand="grdPermission_OnDeteleCommand">
            <GroupingSettings CaseSensitive="False"></GroupingSettings>
            <MasterTableView DataKeyNames="ID" ClientDataKeyNames="ID" Width="100%">
                <PagerStyle AlwaysVisible="True" FirstPageToolTip="First page" LastPageToolTip="Last page" NextPagesToolTip="Next page" NextPageToolTip="Next page" PagerTextFormat="Change page: {4} &amp;nbsp;Page &lt;strong&gt;{0}&lt;/strong&gt; / &lt;strong&gt;{1}&lt;/strong&gt;, Total:  &lt;strong&gt;{5}&lt;/strong&gt; records." PageSizeLabelText="Row/page: " PrevPagesToolTip="Previous page" PrevPageToolTip="Previous page" />
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                <Columns>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete"
                        ConfirmText="Do you want to delete item?" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                        <HeaderStyle Width="30" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="UserFullName" HeaderText="Department - User Name" UniqueName="UserFullName"
                        ShowFilterIcon="False" FilterControlWidth="97%" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                        <HeaderStyle Width="200" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DisciplineName" HeaderText="Discipline" UniqueName="Discipline"
                                             ShowFilterIcon="False" FilterControlWidth="97%" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                        <HeaderStyle Width="80" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Role ADM" UniqueName="cbIsADM" AllowFiltering="False" Display="true">
                        <HeaderStyle Width="80" HorizontalAlign="Center" ></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/ok.png" Visible='<%# Eval("IsAdmin") %>'/>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn HeaderText="Role DC" UniqueName="cbIsDC" AllowFiltering="False" Display="true">
                                                <HeaderStyle Width="80" HorizontalAlign="Center" ></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/ok.png" Visible='<%# Eval("IsDC") %>'/>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Role Engineer" UniqueName="IsUpdate" AllowFiltering="False" Display="true">
                                            <HeaderStyle Width="80" HorizontalAlign="Center" ></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:Image ID="imgManager" runat="server" ImageUrl="~/Images/ok.png" Visible='<%# Eval("IsEngineer") %>'/>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Role Lead" UniqueName="IsLeader" AllowFiltering="False" Display="true">
                                                <HeaderStyle Width="80" HorizontalAlign="Center" ></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:Image ID="imgLeader" runat="server" ImageUrl="~/Images/ok.png" Visible='<%# Eval("IsLeader") %>'/>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Role View" UniqueName="IsView" AllowFiltering="False" Display="true">
                                                <HeaderStyle Width="80" HorizontalAlign="Center" ></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:Image ID="imgEngineer" runat="server" ImageUrl="~/Images/ok.png" Visible='<%# Eval("IsView") %>'/>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                </Columns>
                <CommandItemStyle Height="25px"></CommandItemStyle>
            </MasterTableView>
            <ClientSettings>
                <Selecting AllowRowSelect="true"></Selecting>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True" ScrollHeight="500"></Scrolling>
            </ClientSettings>
        </telerik:RadGrid>
    
    <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification" runat="server" Text="text"  Position="Center" 
                            AutoCloseDelay="0" Width="250" Height="110" Title="Message"  EnableRoundedCorners="true">
    </telerik:RadNotification>
        <asp:HiddenField runat="server" ID="docUploadedIsExist" />
        <asp:HiddenField runat="server" ID="docIdUpdateUnIsLeaf" />
    <asp:HiddenField runat="server" ID="lbProject" />

        <telerik:RadAjaxManager runat="Server" ID="ajaxDocument" OnAjaxRequest="ajaxDocument_OnAjaxRequest">
            <ClientEvents OnRequestStart="onRequestStart"></ClientEvents>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ajaxDocument">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divContent" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="Radiobutton" />
                          <telerik:AjaxUpdatedControl ControlID="LiProject" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rbtnDefault">
                    <UpdatedControls>
                         <telerik:AjaxUpdatedControl ControlID="divContent" />
                          <telerik:AjaxUpdatedControl ControlID="LiProject" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                 <telerik:AjaxSetting AjaxControlID="rbtnCopy">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divContent" />
                          <telerik:AjaxUpdatedControl ControlID="LiProject" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSave">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlDepartment" LoadingPanelID="RadAjaxLoadingPanel2" />
                        <telerik:AjaxUpdatedControl ControlID="lbUser" LoadingPanelID="RadAjaxLoadingPanel2" />
                        <telerik:AjaxUpdatedControl ControlID="grdPermission" LoadingPanelID="RadAjaxLoadingPanel2" />
                        <telerik:AjaxUpdatedControl ControlID="RadNotification"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="grdPermission">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlDepartment" LoadingPanelID="RadAjaxLoadingPanel2" />
                        <telerik:AjaxUpdatedControl ControlID="lbUser" LoadingPanelID="RadAjaxLoadingPanel2" />
                        <telerik:AjaxUpdatedControl ControlID="grdPermission" LoadingPanelID="RadAjaxLoadingPanel2" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="ddlDepartment">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lbUser" LoadingPanelID="RadAjaxLoadingPanel2" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true" >
        <Windows>
        <telerik:RadWindow runat="server" ID="ImportTemplate" Title="Import Role Matrix Template" VisibleStatusbar="false" Height="300" Width="450" Left="20px" ReloadOnShow="False" OnClientClose="refreshGrid" ShowContentDuringLoad="false" Modal="true"></telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
        <telerik:RadScriptBlock runat="server">
            <script src="../../Scripts/jquery-1.7.1.js"></script>
            <script type="text/javascript">
                var ajaxManager;
                function pageLoad() {
                    ajaxManager = $find("<%=ajaxDocument.ClientID %>");
                }
                
                function refreshGrid() {
                    var masterTable = $find("<%=grdPermission.ClientID%>").get_masterTableView();
                    masterTable.rebind();
                }

                function ImportRoleMatrix() {
                    var owd = $find("<%=ImportTemplate.ClientID %>");
                    owd.setSize(450, 200);
                    owd.Show();
                    owd.setUrl("RoleMatrixImportData.aspx", "ImportTemplate");
                }

                function onRequestStart(sender, args) {
                   // alert(args.get_eventTarget());
                    if (args.get_eventTarget().indexOf("ExportTo") >= 0  ||
                        args.get_eventTarget().indexOf("ajaxCustomer") >= 0) {
                        args.set_enableAjax(false);
                    }
                }
            </script>
        </telerik:RadScriptBlock>
    </form>
</body>
</html>
