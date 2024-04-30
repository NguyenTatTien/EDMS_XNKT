<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MSROrderList.aspx.cs" Inherits="EDMs.Web.Controls.Document.MSROrderList" %>

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
            /* parentWindow.refreshGrid();*/
            parentWindow.refreshWFAndInForMSR();
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
        div.RadGrid .rgPager .rgAdvPart {
            display: none;
        }
        #grdDocument_GridData {
            height: 95% !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="content">

            <telerik:RadScriptManager ID="RadScriptManager2" runat="server"></telerik:RadScriptManager>
            <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1"  Skin="Metro"/>
            <telerik:RadGrid RenderMode="Lightweight" ID="grdDocument" runat="server"  AutoGenerateColumns="False" PageSize="10" AllowMultiRowSelection="False" GridLines="None" AllowFilteringByColumn="true" AllowPaging="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" Skin="Metro" Height="100%" 
                AllowAutomaticUpdates="True"
                OnUpdateCommand="grdDocument_UpdateCommand" 
                OnDeleteCommand="grdDocument_DeleteCommand"
                 OnItemUpdated="grdDocument_ItemUpdated"
                OnInsertCommand="grdDocument_InsertCommand" 
                OnNeedDataSource="grdDocument_NeedDataSource" 
                OnItemCreated="grdDocument_ItemCreated"
                OnDetailTableDataBind="grdDocument_DetailTableDataBind">
                <PagerStyle Mode="NumericPages"></PagerStyle>
                <MasterTableView DataKeyNames="ID"  EditMode="InPlace"
                    Width="100%" CommandItemDisplay="Top" Name="Order">
                    <CommandItemSettings AddNewRecordText="Add new Order" />
                    <DetailTables>
                        <telerik:GridTableView DataKeyNames="ID" Width="100%" EditMode="InPlace"
                            runat="server" CommandItemDisplay="Top" Name="PO">
                            <CommandItemSettings AddNewRecordText="Add new PO" />
                            <DetailTables>
                                <telerik:GridTableView DataKeyNames="ID" Width="100%" runat="server" CommandItemDisplay="Top" EditMode="InPlace" Name="Details">
                                    <CommandItemSettings AddNewRecordText="Add new Item" />
                                    <Columns>
                                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn1" ButtonType="ImageButton" EditImageUrl="~/Images/edit.png" UpdateImageUrl="~/Images/ok.png" CancelImageUrl="~/Images/Cancel.png">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                            <ItemStyle CssClass="MyImageButton"></ItemStyle>
                                        </telerik:GridEditCommandColumn>

                                        <telerik:GridTemplateColumn DataField="ID" HeaderText="ID" UniqueName="ID" Display="False">
                                            <ItemTemplate>
                                                <%#DataBinder.Eval(Container.DataItem, "ID")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox runat="server" ID="txtPODetailID" Width="100%" Text='<%#DataBinder.Eval(Container.DataItem, "ID")%>' />

                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="Description" AllowFiltering="false" HeaderText="Description" UniqueName="Description">
                                            <HeaderStyle HorizontalAlign="Center" Width="150" />
                                            <ItemStyle HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <%#DataBinder.Eval(Container.DataItem, "Description")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox runat="server" ID="txtDescription1" Width="100%" />
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="DeliveryDeadline" AllowFiltering="false" HeaderText="Delivery deadline (Day)" UniqueName="DeliveryDeadline">
                                            <HeaderStyle HorizontalAlign="Center" Width="80" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <%#DataBinder.Eval(Container.DataItem, "DeliveryDeadline")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadNumericTextBox runat="server" NumberFormat-DecimalDigits="0" ID="txtDeliveryDeadline" Width="100%" RenderMode="Lightweight" MinValue="1" MaxValue="999" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDeliveryDeadline" ErrorMessage="*Required" runat="server" Display="Dynamic" />

                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="Deadline" HeaderText="Deadline" ReadOnly="true" AllowFiltering="false" UniqueName="Deadline">
                                            <HeaderStyle HorizontalAlign="Center" Width="120" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblIssueDatePO" runat="server" Text='<%#Bind("Deadline", "{0:dd-MM-yyyy}")%>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="ActualDate" HeaderText="Complete date" AllowFiltering="false" UniqueName="ActualDate">
                                            <HeaderStyle HorizontalAlign="Center" Width="120" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblActualDate" runat="server" Text='<%#Bind("ActualDate", "{0:dd-MM-yyyy}")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDatePicker ID="txtActualDate" runat="server"
                                                    ShowPopupOnFocus="True" Width="100%" Culture="English (United States)">
                                                    <DateInput runat="server" DisplayDateFormat="dd-MM-yy" DateFormat="dd-MM-yy" />
                                                </telerik:RadDatePicker>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridButtonColumn ConfirmText="Delete this Details?"
                                            CommandName="Delete" Text="Delete" UniqueName="DeleteColumn1" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton"></ItemStyle>
                                        </telerik:GridButtonColumn>
                                    </Columns>

                                </telerik:GridTableView>
                            </DetailTables>
                            <Columns>
                                <telerik:GridEditCommandColumn UniqueName="EditCommandColumn2" ButtonType="ImageButton" EditImageUrl="~/Images/edit.png" UpdateImageUrl="~/Images/ok.png" CancelImageUrl="~/Images/Cancel.png">
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                    <ItemStyle CssClass="MyImageButton"></ItemStyle>
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn DataField="ID" HeaderText="ID" UniqueName="ID" Display="False">
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "ID")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox runat="server" ID="txtPOID" Width="100%" Text='<%#DataBinder.Eval(Container.DataItem, "ID")%>' />

                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="PONo" HeaderText="PO No." AllowFiltering="false" UniqueName="PONo">
                                    <HeaderStyle HorizontalAlign="Center" Width="150" />
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "PONo")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox runat="server" ID="txtPONo" Width="100%" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Description" HeaderText="Description" AllowFiltering="false" UniqueName="Description">
                                    <HeaderStyle HorizontalAlign="Center" Width="150" />
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "Description")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox runat="server" ID="txtDescription" Width="100%" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="IssueDate" HeaderText="Create Date" AllowFiltering="false" UniqueName="IssueDate">
                                    <HeaderStyle HorizontalAlign="Center" Width="120" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblIssueDatePO" runat="server" Text='<%#Bind("IssueDate", "{0:dd-MM-yyyy}")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="txtIssueDatePO" runat="server"
                                            ShowPopupOnFocus="True" Width="100%" Culture="English (United States)">
                                            <DateInput runat="server" DisplayDateFormat="dd-MM-yy" DateFormat="dd-MM-yy" />
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtIssueDatePO" ErrorMessage="*Required" runat="server" Display="Dynamic" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmText="Delete this PO?"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn2" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton"></ItemStyle>
                                </telerik:GridButtonColumn>
                            </Columns>

                        </telerik:GridTableView>
                    </DetailTables>
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ButtonType="ImageButton" EditImageUrl="~/Images/edit.png" UpdateImageUrl="~/Images/ok.png" CancelImageUrl="~/Images/Cancel.png">
                            <HeaderStyle Width="20px"></HeaderStyle>
                            <ItemStyle CssClass="MyImageButton"></ItemStyle>
                        </telerik:GridEditCommandColumn>
                        <telerik:GridTemplateColumn DataField="No" HeaderText="Order No." ShowFilterIcon="False" FilterControlWidth="97%"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" UniqueName="orderNo">
                            <HeaderStyle HorizontalAlign="Center" Width="150" />
                            <ItemStyle HorizontalAlign="Left" />
                            <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem, "No")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox runat="server" ID="txtorderNo" Width="100%" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="IssueDate" HeaderText="Create Date" AllowFiltering="false" UniqueName="IssueDate">
                            <HeaderStyle HorizontalAlign="Center" Width="120" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblIssueDate" runat="server" Text='<%#Bind("IssueDate", "{0:dd-MM-yyyy}")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="txtIssueDate" runat="server"
                                    ShowPopupOnFocus="True" Width="100%" Culture="English (United States)">
                                    <DateInput runat="server" DisplayDateFormat="dd-MM-yy" DateFormat="dd-MM-yy" />
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtIssueDate" ErrorMessage="*Required" runat="server" Display="Dynamic" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn DataField="TransferDate" HeaderText="Delivery end date" AllowFiltering="false" UniqueName="TransferDate">
                            <HeaderStyle HorizontalAlign="Center" Width="120" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblTransferDate" runat="server" Text='<%#Bind("TransferDate", "{0:dd-MM-yyyy}")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="txtTransferDate" runat="server"
                                    ShowPopupOnFocus="True" Width="100%" Culture="English (United States)">
                                    <DateInput runat="server" DisplayDateFormat="dd-MM-yy" DateFormat="dd-MM-yy" />
                                </telerik:RadDatePicker>

                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn UniqueName="MSRList" HeaderText="MSR List" DataField="MSRList" ReadOnly="true" ShowFilterIcon="false" FilterControlWidth="98%" AutoPostBackOnFilter="true" AndCurrentFilterFunction="Contains">
                            <HeaderStyle HorizontalAlign="Center" Width="100" />
                            <ItemStyle HorizontalAlign="Center" />

                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn ConfirmText="Delete this order?"
                            CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                            <HeaderStyle Width="20px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton"></ItemStyle>
                        </telerik:GridButtonColumn>
                    </Columns>

                </MasterTableView>
                <ClientSettings Selecting-AllowRowSelect="true" AllowKeyboardNavigation="true">
                    <KeyboardNavigationSettings AllowSubmitOnEnter="true" />
                    <Selecting AllowRowSelect="true" />
                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                </ClientSettings>
            </telerik:RadGrid>
               <div style="width: 100%">
            <ul style="list-style-type: none">
                <li style="width: 100%; padding-top: 10px; padding-bottom: 3px; text-align: center">
                    <telerik:RadButton ID="btnCloseAndUpdate" runat="server" Text="Close And Update" OnClick="btnCloseAndUpdate_Click" Width="150px" style="text-align: center"
>
                        <Icon PrimaryIconUrl="../../Images/Cancel.png" PrimaryIconLeft="4" PrimaryIconTop="4" PrimaryIconWidth="16" PrimaryIconHeight="16"></Icon>
                    </telerik:RadButton>
                    <%--<telerik:RadButton ID="btncancel" runat="server" Text="Cancel" Width="70px" style="text-align: center"
                        OnClick="btncancel_Click">
                        <Icon PrimaryIconUrl="../../Images/Cancel.png" PrimaryIconLeft="4" PrimaryIconTop="4" PrimaryIconWidth="16" PrimaryIconHeight="16"></Icon>
                    </telerik:RadButton>--%>

                </li>
            </ul>
        </div>


            <telerik:RadAjaxManager runat="Server" ID="ajaxCustomer" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
                <ClientEvents OnRequestStart="onRequestStart"></ClientEvents>
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="ajaxCustomer">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdDocument" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                           
                        </UpdatedControls>
                    
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="grdDocument">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdDocument" ></telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>


            <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
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
                   // alert(args.get_eventTarget());
                    if (args.get_eventTarget().indexOf("btnDownloadPackage") >= 0) {
                        args.set_enableAjax(false);
                    }
                }

               <%-- function ShowUploadForm(id) {
                    var owd = $find("<%=AttachDoc.ClientID %>");
                    owd.Show();
                    owd.setUrl("UploadDragDrop.aspx?docId=" + id, "AttachDoc");
                    // window.parent.radopen("Controls/Document/DocumentInfoEditForm.aspx?docId=" + id, "DocDialog");
                    // return false;
                }

                function ShowInsertForm() {
                    window.radopen("Controls/Customers/CustomerEditForm.aspx", "DocDialog");
                    return false;
                }--%>

                function refreshGrid(arg) {
                   // alert(arg);
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
