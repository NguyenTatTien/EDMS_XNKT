<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransmittalDocumentList.aspx.cs" Inherits="EDMs.Web.Controls.Document.TransmittalDocumentList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../Content/styles.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <style type="text/css">
        html, body, form {
            overflow: auto;
        }
         .RadGrid .rgSelectedRow
        {
            background-image : none !important;
            background-color: darkseagreen !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="content">
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <telerik:RadGrid ID="grdDocument" runat="server" AllowPaging="True" Height="545"
                AutoGenerateColumns="False" CellPadding="0" CellSpacing="0"
                GridLines="None"
                Skin="Windows7"
                OnNeedDataSource="grdDocument_OnNeedDataSource"
                OnDetailTableDataBind="grdDocument_DetailTableDataBind"
                OnDeleteCommand="grdDocument_DeleteCommand"
                PageSize="30" Style="outline: none">
                <MasterTableView ClientDataKeyNames="ID" DataKeyNames="ID" Width="100%">
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
                        <telerik:GridColumnGroup HeaderText="First Issue Info" Name="FirstIssueInfo"
                            HeaderStyle-HorizontalAlign="Center" />
                        <telerik:GridColumnGroup HeaderText="Final Issue Info" Name="FinalIssueInfo"
                            HeaderStyle-HorizontalAlign="Center" />
                        <telerik:GridColumnGroup HeaderText="INCOMING TRANSMITTAL" Name="IncomingTrans"
                            HeaderStyle-HorizontalAlign="Center" />
                        <telerik:GridColumnGroup HeaderText="ICA REVIEW DETAILS" Name="ICAReviews"
                            HeaderStyle-HorizontalAlign="Center" />
                    </ColumnGroups>
                    <Columns>
                        <telerik:GridBoundColumn DataField="ID" UniqueName="ID" Visible="False" />
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" HeaderTooltip="Delete document"
                            ConfirmText="Do you want to move this document out of transmittal?" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                            <HeaderStyle Width="30" />
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridButtonColumn>
                        <telerik:GridTemplateColumn HeaderText="No." Groupable="False">
                            <HeaderStyle HorizontalAlign="Center" Width="30" VerticalAlign="Middle"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <ItemTemplate>
                                <asp:Label ID="lblSoTT" runat="server" Text='<%# grdDocument.CurrentPageIndex * grdDocument.PageSize + grdDocument.Items.Count+1 %>'>
                                </asp:Label>

                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                       <telerik:GridTemplateColumn HeaderText="DOC. Num." UniqueName="DocNum">
                            <HeaderStyle HorizontalAlign="Center" Width="180" />
                            <ItemStyle HorizontalAlign="Left"/>
                            <ItemTemplate>
                                <%# Eval("DocNo") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField ID="DocNo" runat="server" Value='<%# Eval("DocNo") %>'/>
                                <asp:Label runat="server" ID="lbldocNo"></asp:Label>
                                <%--<asp:TextBox ID="txtDocNo" runat="server" Width="100%"></asp:TextBox>--%>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                                            
                        <telerik:GridTemplateColumn HeaderText="DOC. Title" UniqueName="DocTitle">
                            <HeaderStyle HorizontalAlign="Center" Width="250" />
                            <ItemStyle HorizontalAlign="Left" />
                            <ItemTemplate>
                                <%# Eval("DocTitle") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField ID="DocTitle" runat="server" Value='<%# Eval("DocTitle") %>'/>
                                <asp:TextBox ID="txtDocTitle" runat="server" Width="98%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                                        
                        <telerik:GridTemplateColumn HeaderText="Rev." UniqueName="Rev">
                            <HeaderStyle HorizontalAlign="Center" Width="60" />
                            <ItemStyle HorizontalAlign="Center"/>
                            <ItemTemplate>
                                <%# Eval("Revision") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField ID="Revision" runat="server" 
                                    Value='<%# Eval("Revision") %>'/>
                                <telerik:RadComboBox ID="RadComboBox1" runat="server"  
                                    DropDownWidth="100px" MaxHeight="300px" Width="98%" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                       <%-- <telerik:GridTemplateColumn HeaderText="Original Document No." UniqueName="Contractor">
                            <HeaderStyle HorizontalAlign="Center" Width="180" />
                            <ItemStyle HorizontalAlign="Left" />
                            <ItemTemplate>
                                <%# Eval("OriginalDocumentNumber") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField ID="Contractor" runat="server" Value='<%# Eval("OriginalDocumentNumber") %>'/>
                                <asp:TextBox ID="txtContractor" runat="server" Width="98%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                    </Columns>
                </MasterTableView>
                <ClientSettings>
                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="false"></Resizing>
                    <Selecting AllowRowSelect="true" />
                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>

        <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel2" />
        <telerik:RadAjaxManager runat="Server" ID="ajaxCustomer">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ajaxCustomer">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grdDocument" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadCodeBlock runat="server">
        </telerik:RadCodeBlock>
    </form>
</body>
</html>
