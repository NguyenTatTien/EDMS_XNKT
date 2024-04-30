    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DocumentListProjectInfoEditForm_MSR.aspx.cs" Inherits="EDMs.Web.Controls.Document.DocumentListProjectInfoEditForm_MSR" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="~/Content/styles.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="~/CSS/bootstrap.min.css">

    <link rel="stylesheet" href="~/CSS/mdb-pro.css">
    <style type="text/css">
        html, body, form {
            overflow: visible;
        }

        .RadWindow div.rwExternalContent {
            height: 100% !important;
        }

        .RadButton_Default .rbDecorated {
            background-image: none !important;
            color: #FFF !important;
        }

        input[type=checkbox], input[type=radio] {
            margin: 4px !important;
        }

        /*.RadComboBoxDropDown .rcbScroll {
            height: 299px !important;
        }*/

        .RadComboBoxDropDown_Default .rcbHovered {
            background-color: #46A3D3;
            color: #fff;
        }
         .rtsLI {
            width:20% !important;
            margin:0 !important;
            padding:0 !important;
        }
         #grdMSRItem{
             width:100%;
         }
         @media screen and (max-height:800px) {
            #grdMSRComment_GridData{
                height:640px !important;
            }
            #grdMSRItem_GridData{
                height:600px !important;
            }
            #grdDocument_GridData{
                height:440px !important;
            }
        }
          @media screen and (max-height:700px) {
            #grdMSRComment_GridData{
                height:560px !important;
            }
            #grdMSRItem_GridData{
                height:520px !important;
            }
            #grdDocument_GridData{
                height:360px !important;
            }
        }
        @media screen and (max-height : 600px) {
            #grdMSRComment_GridData{
                height:420px !important;
            }
            #grdMSRItem_GridData{
                height:380px !important;
            }
            #grdDocument_GridData{
                height:210px !important;
            }
        }
       

        .RadComboBoxDropDown .rcbItem, .RadComboBoxDropDown .rcbHovered, .RadComboBoxDropDown .rcbDisabled, .RadComboBoxDropDown .rcbLoading, .RadComboBoxDropDown .rcbCheckAllItems, .RadComboBoxDropDown .rcbCheckAllItemsHovered {
            margin: 0 0px;
        }

        .RadComboBox .rcbInputCell .rcbInput {
            border-left-color: #46A3D3 !important;
            border-color: #8E8E8E #B8B8B8 #B8B8B8 #46A3D3;
            border-style: solid;
            border-width: 1px 1px 1px 5px;
            color: #000000;
            float: left;
            font: 12px "segoe ui";
            margin: 0;
            padding: 2px 5px 3px;
            vertical-align: middle;
            width: 399PX;
        }

        .RadComboBox table td.rcbInputCell, .RadComboBox .rcbInputCell .rcbInput {
            padding-left: 0px !important;
        }

        div.rgEditForm label {
            float: right;
            text-align: right;
            width: 72px;
        }

        .rgEditForm {
            text-align: right;
        }

        .RadComboBox {
            width: 399PX !important;
            border-bottom: none !important;
        }

        .RadComboBoxDropDown .rcbItem, .RadComboBoxDropDown .rcbHovered, .RadComboBoxDropDown .rcbDisabled, .RadComboBoxDropDown .rcbLoading, .RadComboBoxDropDown .rcbCheckAllItems, .RadComboBoxDropDown .rcbCheckAllItemsHovered {
            margin: 0 0px;
        }

        .RadComboBox .rcbInputCell .rcbInput {
            border-style: solid;
            border-width: 1px 1px 1px 5px;
            color: #000000;
            float: left;
            font: 12px "segoe ui";
            margin: 0;
            padding: 2px 5px 3px;
            vertical-align: middle;
            width: 399PX;
        }

        .RadComboBox .rcbInner {
            border: none !important;
            border-style: none !important;
            padding: unset !important;
        }

        .RadComboBox table td.rcbInputCell, .RadComboBox .rcbInputCell .rcbInput {
            padding-left: 0px !important;
        }

        div.rgEditForm label {
            float: right;
            text-align: right;
            width: 72px;
        }

        .rgEditForm {
            text-align: right;
            text-align: right;
        }

        .RadComboBox {
            border-bottom: none !important;
        }

        .RadUpload .ruFileWrap {
            overflow: visible !important;
        }

        .accordion dt a {
            /*letter-spacing: 0.1em;*/
            line-height: 1.2;
            margin: 0.5em auto 0.6em;
            padding: 0;
            text-align: left;
            text-decoration: none;
            display: block;
        }

        .accordion dt span {
            color: #085B8F;
            border-bottom: 1px solid #46A3D3;
            font-size: 1.0em;
            font-weight: bold;
            /*letter-spacing: 0.1em;*/
            line-height: 1.2;
            margin: 0.5em auto 0.6em;
            padding: 0;
            text-align: left;
            text-decoration: none;
            display: block;
        }

        #ddlParent_Input {
            width: 384px !important;
        }



        .RadTabStrip_Metro .rtsLink {
            text-transform: unset !important;
           
        }
        .RadTabStrip{
             position:fixed;
            z-index:1;
        }


        .linksPanel {
            position: absolute;
            right: 30px;
            bottom: 30px;
            width: 200px;
            height: 30px;
            text-align: right;
        }

        .RadPanelBar .rpFirst .rpTemplate {
            zoom: 1;
            height: 94px;
            width: 100%;
        }

        .linksPanel a {
            color: White;
        }

        /* styling of template contents */
        .rpTemplate .productList {
            padding: 0;
            width: 662px;
            margin: 0 auto;
            display: block;
        }

            .rpTemplate .productList:after {
                content: ".";
                display: block;
                visibility: hidden;
                font-size: 0;
                line-height: 0;
                overflow: hidden;
                height: 0;
                clear: both;
            }

            .rpTemplate .productList li {
                list-style-type: none;
                float: left;
                text-align: center;
                width: 220px;
                margin: 15px 0 0;
                padding: 0;
                border: unset;
            }

                .rpTemplate .productList li.last {
                    border-right-width: 0;
                }

                .rpTemplate .productList li div {
                    font: normal 12px Arial,sans-serif;
                    text-decoration: underline;
                    color: #333;
                }

        div.RadPanelBar .rpTemplate {
            /* background: #EDF9FE;*/
            border: unset !important;
            overflow: hidden !important;
        }

        .rpHeaderTemplate {
            overflow: hidden;
            height: 26px;
        }

        .RadPanelBar_Default .rpRootGroup {
            border-color: #ffffff !important;
        }
        .rtsUL{
            min-width:65%;
        }
        .rpItem .rpSlide, .rpItem .rpSlide .rpTemplate {
            height: 200px !important;
        }
         #diamond {
       display: flex;
    /*width: 150px;*/
    min-width:150px;
    height: 150px;
    float: left;
    /* margin-left: 120px !important; */
    /*margin-right:-106px !important;*/
    margin-left: 112px !important;
    margin-right: -35px !important;
    color: white;
    align-items: center;
    text-align: center;
    vertical-align: middle;
  /*  -webkit-transform: rotate(-90deg);
    -moz-transform: rotate(-90deg);
    -ms-transform: rotate(-90deg);
    -o-transform: rotate(-90deg);
    transform: rotate(-90deg);*/
    -webkit-transform-origin: 0 100%;
    -moz-transform-origin: 0 100%;
    -ms-transform-origin: 0 100%;
    -o-transform-origin: 0 100%;
    transform-origin: 0 100%;
    margin: 5px 5px 5px 5px;
    }
    .context{
        display: block;
        margin: auto;
      /*  -webkit-transform: rotate(90deg);
        -moz-transform: rotate(90deg);
        -ms-transform: rotate(90deg);
        -o-transform: rotate(90deg);
        transform: rotate(90deg);*/
    /* Rotate Origin */
    
    }
    #diamond::after{
        position: absolute;
 /*       top: -40px;
        left: 30px;*/
        width: 80px;
        height: 2px;
        content: "";
        background-color: rgba(0, 0, 0, 0.1);
       /* -webkit-transform: rotate(90deg);
        -moz-transform: rotate(90deg);
        -ms-transform: rotate(90deg);
        -o-transform: rotate(90deg);
        transform: rotate(90deg);*/
        margin-left: -80px !important;
    }
         /*#diamond {
    display: flex;
    width: 150px;
    height: 150px;
    float:left;
    margin-left:120px !important;
    color: white;
    align-items: center;
    text-align: center;
 
    vertical-align: middle;*/

    
    
/* Rotate */
    /*-webkit-transform: rotate(-45deg);
    -moz-transform: rotate(-45deg);
    -ms-transform: rotate(-45deg);
    -o-transform: rotate(-45deg);
    transform: rotate(-45deg);*/
/* Rotate Origin */
    /*-webkit-transform-origin: 0 100%;
    -moz-transform-origin: 0 100%;
    -ms-transform-origin: 0 100%;
    -o-transform-origin: 0 100%;
    transform-origin: 0 100%;
    margin: 60px 0 10px 195px;
}
.context{
    display: block;
    margin: auto;
    -webkit-transform: rotate(45deg);
    -moz-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    -o-transform: rotate(45deg);
    transform: rotate(45deg);*/
/* Rotate Origin */
    
/*}
#diamond::after{
    position: absolute;
    top:-20px;
    left:-50px;
    width: 60px;
    height: 2px;
    content: "";
    background-color: rgba(0, 0, 0, 0.1);
    -webkit-transform: rotate(45deg);
    -moz-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    -o-transform: rotate(45deg);
    transform: rotate(45deg);
}*/
.csli::after{
    content:none;
}
.wf{
    margin-top:-3px;
}
.rcCalPopup{
    z-index:0 !important;
}
.RadComboBox{
    height:22.6px;
 }
.rcbInput{
    height:22.6px !important;
}
.labelName{
     inline-size: 150px;
    overflow-wrap: break-word;
}
#txtNote{
    border:none;
}
    </style>
    <script src="../../Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        function CloseAndRebind(args) {
            GetRadWindow().BrowserWindow.refreshGrid(args);
            GetRadWindow().close();
        }
        function loadMain() {
            parent.location.href = "../../CustomProjectList.aspx";
        }
        function loadData(url) {
            parent.location.href = url;
        }
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)
            return oWindow;
        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager2" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel2" />
        <telerik:RadTabStrip ID="RadTabStrip1" Skin="Metro" RenderMode="Native" runat="server" Width="100%" MultiPageID="RadMultiPage1"
            SelectedIndex="0" OnClientTabSelected="OnClientTabSelect">
            <Tabs>
                <telerik:RadTab Text="MSR Workflow">
                </telerik:RadTab>
                <telerik:RadTab Text="MSR Information">
                </telerik:RadTab>
                <telerik:RadTab Text="Attach File">
                </telerik:RadTab>
                <telerik:RadTab Text="Package for MSR">
                </telerik:RadTab>
                <telerik:RadTab Text="Comment">
                </telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" Height="100%" Width="100%">
             <telerik:RadPageView runat="server" ID="Workflow" CssClass="wf">
                <div class="container-fluid">
                    <div class="row mt-1">
                        <div class="col-md-12">
                            <ul class="stepper stepper-vertical" runat="server" id="ul_Workflow">


                                <%--                                <li class="completed">
                                    <a href="#!">
                                        <span class="circle">1</span>
                                        <span class="label">Người Tạo</span>
                                    </a>
                                    <div class="step-content grey lighten-3">
                                        <div class="col-md-12">


                                            <ul class="stepper stepper-vertical">
                                                <li class="completed">

                                                    <a href="#!">
                                                        <span class="label">Nguyễn Đức Nhân</span>
                                                        <br />
                                                    </a>
                                                    <a href="#!">
                                                        <span class="badge badge-pill badge-primary">Duyệt</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>

                                        <p>
                                            <span style="color: #2E5689; text-align: right;">Noted:
                                            </span>

                                        </p>
                                    </div>
                                </li>


                                <li class="completed">
                                    <a href="#!">
                                        <span class="circle">2</span>
                                        <span class="label">Người phê duyệt</span>
                                    </a>
                                    <div class="step-content grey lighten-3">
                                        <div class="col-md-12">
                                            <ul class="stepper stepper-vertical">
                                                <li class="completed">

                                                    <a href="#!">
                                                        <span class="label">Nguyễn Văn A</span>
                                                        <br />
                                                    </a>
                                                    <a href="#!">
                                                        <span class="badge badge-pill badge-primary">Duyệt</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>

                                        <p>
                                            <span style="color: #2E5689; text-align: right;">Noted:
                                            </span>
                                            Đồng ý 
                                        </p>
                                    </div>
                                </li>
                                <li class="Current">
                                    <a href="#!">
                                        <span class="circle">3<i class="fas fa-exclamation"></i></span>
                                        <span class="label" style="color: dimgrey !important;">Người Xữ lý</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#!">
                                        <span class="circle">4</span>
                                        <span class="label" style="color: dimgrey !important;">Người nhận</span>
                                    </a>
                                </li>--%>
                            </ul>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView runat="server" ID="Information" >
                <div class="container-fluid">
                    <div class="row">

                        <div class="col-xl-6">
                            <div class="tm-text-container" style="margin-top:40px">
                                <ul style="list-style-type: none">
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">JOB TITLE / EQUIPMENT:
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem" runat="server" id="divDocNo">
                                                <asp:TextBox ID="txtJOB" ReadOnly="false" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                                <asp:CustomValidator runat="server" ID="CustomValidatorJob" ValidateEmptyText="True" CssClass="dnnFormMessage dnnFormErrorModule"
                                                   OnServerValidate="CustomValidatorJob_ServerValidate" Display="Dynamic" ControlToValidate="txtJOB"/>
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">JUSTIFICATION:
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem" runat="server" id="divJus">
                                                <asp:TextBox ID="txtJustification" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                                 <asp:CustomValidator runat="server" ID="CustomValidatorJus" ValidateEmptyText="True" CssClass="dnnFormMessage dnnFormErrorModule"
                                                   OnServerValidate="CustomValidatorJus_ServerValidate" Display="Dynamic" ControlToValidate="txtJOB"/>
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>

                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">SYSTEM / SUBSYSTEM:
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                           <%--     <asp:TextBox ID="TextSystem" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />--%>
                                                     <telerik:RadComboBox ID="ddlSystem" runat="server" Style="width: 400px" CssClass="form-control rounded-0 " AllowCustomText="True" MarkFirstMatch="True" Width="25px" />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Supplier / Vendor:
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextSupplier" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Contact:
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextContact" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                     <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">MSR No.
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem" runat="server" id="div1">
                                                <asp:TextBox ID="TextMSRNo" ReadOnly="false" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                                  <asp:CustomValidator runat="server" ID="CustomValidatorMSRNo" ValidateEmptyText="True" CssClass="dnnFormMessage dnnFormErrorModule"
                                                   OnServerValidate="CustomValidatorMSRNo_ServerValidate" Display="Dynamic" ControlToValidate="TextMSRNo"/>
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">WO No.
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextWono" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Account Code
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextAccountcode" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Project code
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="Textprojectcode" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;"></span>
                                            </label>
                                            <div style="float: left; padding-top: 5px; display: flex;" class="qlcbFormItem">
                                                <div>
                                                    <asp:CheckBox runat="server" ID="Cb_Local" Visible="true" Text="Local procurement preference"></asp:CheckBox>
                                                </div>
                                                <div>
                                                    <asp:CheckBox runat="server" CssClass="custom-control custom-checkbox" ID="Cb_MSDS" Text="MSDS required before procurement (For new kind of chemical only)"></asp:CheckBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width:600px ;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Please obtain the following - (tick applicable box) / Decription & Specification
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 10px; padding-bottom: 10px;" class="qlcbFormItem">
                                                <table>
                                                    <tr>
                                                        <td style="padding-right: 3px;">
                                                            <asp:CheckBox CssClass="custom-control custom-checkbox" ID="Cb_Spare" runat="server" Text="Spare Part" />
                                                        </td>
                                                        <td style="padding-right: 3px;">
                                                            <asp:CheckBox CssClass="custom-control custom-checkbox" ID="Cb_Fabrications" runat="server" Text="Fabrications (Material/Services)" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="Cb_ConsumeSa" runat="server" CssClass="custom-control custom-checkbox" Text="Consume-Safety/PPE" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-right: 3px;">
                                                            <asp:CheckBox CssClass="custom-control custom-checkbox" ID="Cb_Warranty" runat="server" Text="Warranty / Replacement" />
                                                        </td>
                                                        <td style="padding-right: 3px;">
                                                            <asp:CheckBox CssClass="custom-control custom-checkbox" ID="Cb_Onshore" runat="server" Text="Onshore workshop repair" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="Cb_ConsumeSt" runat="server" CssClass="custom-control custom-checkbox" Text="Consume-Store" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-right: 3px;">
                                                            <asp:CheckBox CssClass="custom-control custom-checkbox" ID="Cb_Equipments" runat="server" Text="Equipments Hire" />
                                                        </td>
                                                        <td style="padding-right: 3px;">
                                                            <asp:CheckBox CssClass="custom-control custom-checkbox" ID="Cb_Contractor" runat="server" Text="Contractor Services" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="Cb_Others" runat="server" CssClass="custom-control custom-checkbox" Text="Others" />
                                                        </td>
                                                    </tr>

                                                </table>
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px; display: none;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Complete
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="min25Percent" Width="416px" />
                                            </div>

                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>

                                </ul>
                            </div>
                        </div>
                        <div class="col-xl-6">
                            <div class="tm-text-container" style="margin-top:40px">
                                <ul style="list-style-type: none">
                                   
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">PRIORITY LEVEL (Select one)
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:RadioButton runat="server" GroupName="Role" Text="SOS" ID="rdSOS" />
                                                <asp:RadioButton runat="server" GroupName="Role" Text="AAA" ID="rdAAA" />
                                                <asp:RadioButton runat="server" GroupName="Role" Text="BBB" ID="rdBBB" />
                                                <asp:RadioButton runat="server" GroupName="Role" Text="CCC" ID="rdCCC" />
                                                <asp:RadioButton runat="server" GroupName="Role" Text="DDD" ID="rdDDD" />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">DATE REQUIRED:
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <telerik:RadDatePicker ID="txtDaterequst" runat="server"
                                                    ShowPopupOnFocus="True" CssClass="qlcbFormNonRequired">
                                                    <DateInput runat="server" DateFormat="dd/MM/yyyy" CssClass="qlcbFormNonRequired" />
                                                </telerik:RadDatePicker>
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="">

                                        <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                            <span style="color: #2E5689; text-align: right;"></span>
                                        </label>
                                        <div style="float: left; padding-top: 5px; display: flex;" class="qlcbFormItem">
                                            <div style="padding-right: 5px">
                                                <asp:CheckBox runat="server" ID="Cb_Material" Visible="true" Text="Material Certificate"></asp:CheckBox>
                                            </div>
                                            <div style="padding-right: 5px">
                                                <asp:CheckBox runat="server" CssClass="custom-control custom-checkbox" ID="Cb_Letter" Text="Letter of Conformity"></asp:CheckBox>
                                            </div>
                                            <div>
                                                <asp:CheckBox runat="server" CssClass="custom-control custom-checkbox" ID="Cb_QA" Text="QA / QC"></asp:CheckBox>
                                            </div>
                                        </div>

                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="">
                                        <div style="display: inline;">
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">MSR's Plan</span>
                                            </label>
                                            <div style="float: left; padding-top: 5px; display: flex;" class="qlcbFormItem">
                                                <div style="padding-right: 15px;">
                                                    <asp:CheckBox runat="server" ID="Cb_Planned" CssClass="custom-control custom-checkbox" Visible="true" Text="planned" AutoPostBack="true" OnCheckedChanged="Cb_Planned_CheckedChanged"></asp:CheckBox>
                                                </div>
                                                  <div style="display: flex; width: 120px;">
                                                    <span style="color: #2E5689; margin-right: 5px; text-align: right;">Year:</span>
                                                    <asp:TextBox ID="TextYear" TextMode="Number"  ReadOnly="true" runat="server" Style="width: 80px; border-width: 1px !important; border-color: rgb(142, 142, 142) !important;" CssClass="form-control rounded-0 " />
                                                </div>
                                                <div style="padding-right: 5px">
                                                    <asp:CheckBox runat="server" CssClass="custom-control custom-checkbox" ID="Cb_UnPlanned" Text="Unplanned"></asp:CheckBox>
                                                </div>
                                                <div style="display: flex; width: 240px;">
                                                    <span style="color: #2E5689; margin-right: 5px; text-align: right;">Explanation (If Unplanned):</span>
                                                    <asp:TextBox ID="TextExplanation" ReadOnly="false" runat="server" Style="width: 180px; border-width: 1px !important; border-color: rgb(142, 142, 142) !important;" CssClass="form-control rounded-0 " />
                                                </div>
                                            </div>

                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                     <li style="width: 600px;display:none">
                                         <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Department
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <telerik:RadComboBox ID="ddlDepartment" runat="server" Skin="Metro" AllowCustomText="True" MarkFirstMatch="True" />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Order No.
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <telerik:RadComboBox ID="ddlOrder" runat="server" Skin="Metro" AllowCustomText="True" MarkFirstMatch="True" />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px; display: none;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">CHECK BY
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextCheckby" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">PREPARED BY
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextPreparedby" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">ORIGINATOR
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="Textorginator" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                      <li style="width: 600px;">
                                          <div class="row">
                                          </div>
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Mục tài chính đơn hàng
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextTCNH" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                     <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Phòng thực hiện(Executing dept)
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextExecuting_dept" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                     <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Người thực hiện(Executor)
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextExecutor" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                     <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Hình thức mua sắm(Procurement methods)
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:TextBox ID="TextProcurement_methods" runat="server" Style="width: 400px;" CssClass="form-control rounded-0 " />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                      <li style="width: 600px;">
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Categories.
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <telerik:RadComboBox ID="ddlCategories" runat="server" Skin="Metro" AllowCustomText="True" MarkFirstMatch="True" />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                      <li style="width: 600px;">
                                         
                                        <div>
                                            <label style="width: 130px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Material supply for Operation /Shutdown Job
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <telerik:RadComboBox ID="ddlMOSJ" runat="server" Skin="Metro" AllowCustomText="True" MarkFirstMatch="True" />
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    
                                   <li style="">
                                        <div style="display: inline;">
                                           
                                            <div style="float: left; padding-top: 5px; display: flex;" class="qlcbFormItem">
                                               <div>
                                                <asp:CheckBox runat="server" Enabled="false" CssClass="custom-control custom-checkbox" ID="CBStatus" Text="Status"></asp:CheckBox>
                                         </div>
                                                <div style="padding-right: 15px">
                                                    <asp:CheckBox runat="server" CssClass="custom-control custom-checkbox" ID="cbCancel" Text="Cancel"></asp:CheckBox>
                                                </div>
                                                <div style="display: flex; width: 240px;">
                                                    <span style="color: #2E5689; margin-right: 5px; text-align: right;">Lý do</span>
                                                    <asp:TextBox ID="TextComment_Cancel" ReadOnly="false" runat="server" Style="width: 180px; border-width: 1px !important; border-color: rgb(142, 142, 142) !important;" CssClass="form-control rounded-0 " />
                                                </div>
                                            </div>

                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-md-12 text-center">
                        <%-- <button class="btn btn-primary btn-sm">Save</button>--%>
                        <div style="width: 100%; text-align: center; padding-top: 10px">
                            <telerik:RadButton ID="bt_MsrSave" runat="server" CssClass="btn btn-primary btn-sm" Text="Save" OnClick="bt_MsrSave_Click" Width="100px" Style="text-align: center; background-image: none !important;" AutoPostBack="true">
                            </telerik:RadButton>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView runat="server" ID="AttachFile" >
                <div class="container-fluid">
                    <div class="row">
                        <div class="col">
                            <div style="width: 100%;margin-top:40px">
                                <ul style="list-style-type: none">
                                    <li style="width: 100%;" runat="server" id="UploadControl">
                                        <div>
                                            <label style="width: 150px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Upload multiple file
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <telerik:RadAsyncUpload runat="server" ID="docuploader"
                                                    MultipleFileSelection="Automatic" TemporaryFileExpiration="05:00:00"
                                                    EnableInlineProgress="true" Width="350px"
                                                    Localization-Cancel="Cancel" CssClass="min25Percent "
                                                    Localization-Remove="Remove" Localization-Select="Select" Skin="Windows7">
                                                </telerik:RadAsyncUpload>
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 100%;" runat="server" id="SelectType">
                                        <div>
                                            <label style="width: 150px; float: left; padding-top: 5px; padding-right: 10px; text-align: right;">
                                                <span style="color: #2E5689; text-align: right;">Type
                                                </span>
                                            </label>
                                            <div style="float: left; padding-top: 5px;" class="qlcbFormItem">
                                                <asp:DropDownList ID="ddlType" runat="server" CssClass="min25Percent" Width="416px">
                                                    <Items>
                                                        <asp:ListItem Value="1" Text="MSR Files"></asp:ListItem>
                                                        <asp:ListItem Value="2" Text="Other Files"></asp:ListItem>
                                                        <asp:ListItem Value="3" Enabled="false" Text="Document Markup/Comment Consolidate Files"></asp:ListItem>
                                                        <asp:ListItem Value="4" Enabled="false" Text="Comment Response Sheet (CRS)"></asp:ListItem>
                                                        <asp:ListItem Value="5" Enabled="false" Text="Comment  Sheet (CS)"></asp:ListItem>
                                                    </Items>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div style="clear: both; font-size: 0;"></div>
                                    </li>
                                    <li style="width: 100%; text-align: center; padding-top: 10px">
                                        <telerik:RadButton ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" OnClick="btnSave_Click" Width="70px" Style="text-align: center; background-image: none !important;" AutoPostBack="true">
                                        </telerik:RadButton>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <telerik:RadButton ID="btnDownAll" runat="server" Text="Download All" CssClass="btn btn-primary btn-sm" OnClick="btnDownAll_Click" Width="90px" Style="text-align: center; background-image: none !important;" AutoPostBack="true">
                          </telerik:RadButton>
                    <div class="row">
                        <div class="col">
                            <div style="width: 100%;height:100%;position: relative;">
                                <telerik:RadGrid ID="grdDocument" runat="server" AllowPaging="True"
                                    AutoGenerateColumns="False" CellPadding="0" CellSpacing="0"
                                    GridLines="None" Width="100%" Skin="Metro" RenderMode="Lightweight"
                                    OnDeleteCommand="grdDocument_DeleteCommand"
                                    OnNeedDataSource="grdDocument_NeedDataSource"
                                    AllowFilteringByColumn="true"
                                    PageSize="10" Style="outline: none;">
                                    <MasterTableView ClientDataKeyNames="ID" DataKeyNames="ID" Width="100%">
                                        <PagerStyle AlwaysVisible="True" FirstPageToolTip="First page" LastPageToolTip="Last page" NextPagesToolTip="Next page" NextPageToolTip="Next page" PagerTextFormat="Change page: {4} &amp;nbsp;Page &lt;strong&gt;{0}&lt;/strong&gt; / &lt;strong&gt;{1}&lt;/strong&gt;, Total:  &lt;strong&gt;{5}&lt;/strong&gt; Documents." PageSizeLabelText="Row/page: " PrevPagesToolTip="Previous page" PrevPageToolTip="Previous page" />
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="ID" UniqueName="ID" Visible="False" />
                                            <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ConfirmText="Do you want to delete document file?" ButtonType="ImageButton" ImageUrl="~/Images/delete.png" Display="False">
                                                <HeaderStyle Width="5%" />
                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                            </telerik:GridButtonColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="False" UniqueName="DeleteColumn">
                                                <HeaderStyle Width="30" />
                                                <ItemStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <div>
                                                        <a href='javascript:DeleteAttachFile("<%# DataBinder.Eval(Container.DataItem, "ID") %>")' style="text-decoration: none; color: blue">
                                                            <asp:Image ID="delete" runat="server" ImageUrl="~/Images/delete.png" Style="cursor: pointer;" ToolTip="Delete File" Visible='<%# DataBinder.Eval(Container.DataItem, "IsCanDelete") %>' />
                                                            <a />
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewColumn">
                                                <HeaderStyle Width="5%" />
                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                <ItemTemplate>
                                                  <%--  <a href='../../DownloadFileHandler.ashx?DownloadFile=Owner&DocId=<%# DataBinder.Eval(Container.DataItem, "ID") %>'
                                                        download='<%# DataBinder.Eval(Container.DataItem, "FileName") %>' target="_blank">
                                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ExtensionIcon") %>'
                                                            Style="cursor: pointer;" ToolTip="Download document" />
                                                    </a>--%>
                                                     <a href='javascript:FileView("<%# DataBinder.Eval(Container.DataItem, "ID") %>")' style="text-decoration: none; color: blue">
                                                        <asp:Image ID="CallLink2" runat="server" ImageUrl="~/Images/expview.png" Style="cursor: pointer; border-color: transparent" AlternateText="Viewer File PDF" ToolTip="View file" visible='<%# DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!= ".exe" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".dwg" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".rar" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".inf" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".zip" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".zip" && Convert.ToBoolean(System.IO.File.Exists(ConfigurationManager.AppSettings["pathEAM"].ToString() + DataBinder.Eval(Container.DataItem,"FilePath").ToString()))%>'/>
                                                        <a />
                                                         <a style="text-decoration: none; color: blue">
                                                        <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/sync-16.png" Style="cursor: pointer; border-color: transparent" AlternateText="Wait for sync" ToolTip="Wait for sync" visible='<%# DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!= ".exe" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".dwg" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".rar" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".inf" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".zip" &&
                                        DataBinder.Eval(Container.DataItem,"Extension").ToString().ToLower()!=".zip" && !Convert.ToBoolean(System.IO.File.Exists(ConfigurationManager.AppSettings["pathEAM"].ToString() + DataBinder.Eval(Container.DataItem,"FilePath").ToString()))%>'/>
                                                        <a />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                             <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="DownloadColumn">
                                                <HeaderStyle Width="5%" />
                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                <ItemTemplate>
                                                    <a href='../../DownloadFileHandler.ashx?DownloadFile=Owner&DocId=<%# DataBinder.Eval(Container.DataItem, "ID") %>'
                                                        download='<%# DataBinder.Eval(Container.DataItem, "FileName") %>' target="_blank">
                                                        <asp:Image ID="Image1" runat="server" Visible='<%#Convert.ToBoolean(System.IO.File.Exists(ConfigurationManager.AppSettings["pathEAM"].ToString() + DataBinder.Eval(Container.DataItem, "FilePath").ToString()))%>' ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ExtensionIcon") %>'
                                                            Style="cursor: pointer;" ToolTip="Download document" />
                                                    </a>
                                                     <a 
                                                         >
                                                        <asp:Image ID="Image3" runat="server" Visible='<%# !Convert.ToBoolean(System.IO.File.Exists(ConfigurationManager.AppSettings["pathEAM"].ToString() + DataBinder.Eval(Container.DataItem, "FilePath").ToString()))%>' ImageUrl="~/Images/sync-16.png"
                                                            Style="cursor: pointer;" ToolTip="Wait for sync" />
                                                    </a>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="FileName" HeaderText="File name" UniqueName="FileName" ShowFilterIcon="False" FilterControlWidth="97%"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                <HeaderStyle HorizontalAlign="Center" Width="35%" />
                                                <ItemStyle HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <%# Eval("FileName") %>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="TypeName" HeaderText="Type" UniqueName="TypeName" ShowFilterIcon="False" FilterControlWidth="97%"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                <HeaderStyle HorizontalAlign="Center" Width="25%" />
                                                <ItemStyle HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <%# Eval("TypeName") %>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridDateTimeColumn DataField="CreatedByName" AllowFiltering="false" HeaderText="Upload by" UniqueName="CreatedByName">
                                                <HeaderStyle HorizontalAlign="Center" Width="15%" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </telerik:GridDateTimeColumn>
                                            <telerik:GridDateTimeColumn DataField="CreatedDate" AllowFiltering="false" HeaderText="Upload time" UniqueName="CreatedDate"
                                                DataFormatString="{0:dd/MM/yyyy hh:mm tt}">
                                                <HeaderStyle HorizontalAlign="Center" Width="15%" />
                                                <ItemStyle HorizontalAlign="Center" />
                                            </telerik:GridDateTimeColumn>
                                            <telerik:GridBoundColumn DataField="FileSize" AllowFiltering="false" HeaderText="File size(Kb)" UniqueName="FileSize" DataFormatString="{0:0,0.00}">
                                                <HeaderStyle HorizontalAlign="Center" Width="13%" />
                                                <ItemStyle HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings Selecting-AllowRowSelect="true" AllowColumnHide="True">
                                        <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="false"></Resizing>
                                        <Scrolling AllowScroll="True" SaveScrollPosition="True" ScrollHeight="200" UseStaticHeaders="True" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </div>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView runat="server" ID="Package">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col">
                             <div style="width: 100%;margin-top:40px">
                <%-- <telerik:RadSplitter RenderMode="Lightweight" ID="RadSplitter2" runat="server" Height="100%" Width="100%" Orientation="Horizontal" Skin="Metro">
                    <telerik:RadPane ID="Radpane6" runat="server" Width="100%" Height="100%" CssClass="overflow-hiden" ShowContentDuringLoad="False">
                --%>
                <%--  <telerik:RadButton ID="btImportItem" runat="server" CssClass="btn btn-primary btn-sm" Text="Import Items" OnClientClicked="ImportItem()" Width="100px"  Style="text-align: center; font: normal 12px 'Segoe UI',Arial,Helvetica,sans-serif !important; padding-left: unset !important
    line-height: 16px !important; margin-bottom:-70px !important; margin-left: 120px; ">
                            </telerik:RadButton>--%>
                <a href="javascript:ImportItem()" runat="server" id="btImportItems" style="margin-top: 10px; padding-bottom:5px; padding-top:5px; margin-left: 10px; font: normal 12px 'Segoe UI',Arial,Helvetica,sans-serif !important; padding-left: 5px !important;   border:1px solid #c2ddf9; background-color:aliceblue;padding-right:5px;
    line-height: 30px !important; color: black !important;">Import Items</a>
               <%--   <asp:LinkButton runat="server" Height="100%" ID="linkExport" OnClick="linkExport_Click" style="border:1px solid black;padding:5px;float:left;color:black">
                            <asp:Image runat="server" ImageUrl="~/Images/exexcel.png" Style="float: left;" />
                            <asp:Label runat="server" Text="Export file" Style="margin: 0px 0px 0px 5px; float: left;" />
                            
                   </asp:LinkButton>--%>
                                  <a href='../../Exports/Template/TemplatePackageMSR.xlsx'
                                                        download='TemplatePackageMSR.xlsx' target="_blank" style="border:1px solid black;padding:5px;float:left;color:black">
                                       <asp:Image runat="server" ImageUrl="~/Images/exexcel.png" Style="float: left;" />
                                        <asp:Label runat="server" Text="Export file" Style="margin: 0px 0px 0px 5px; float: left;" />
                                  </a>
                                  <%--  <a href="javascript:ImportItem()" runat="server" id="A1" style="margin-top: 10px; padding-bottom:5px; padding-top:5px; margin-left: 10px; font: normal 12px 'Segoe UI',Arial,Helvetica,sans-serif !important; padding-left: unset !important;  border-radius: 25px;
    line-height: 30px !important; color: blue !important;">Import Imtems</a>--%>
                                 </div>
                     
                <telerik:RadGrid RenderMode="Lightweight" ID="grdMSRItem" GridLines="None" runat="server" AllowAutomaticDeletes="True" Skin="Metro" CssClass="grdItem"
                    AllowAutomaticInserts="False" PageSize="50" AllowAutomaticUpdates="False" AllowPaging="False"
                    AutoGenerateColumns="False"
                    OnBatchEditCommand="grdMSRItem_BatchEditCommand"
                    OnDataBound="grdMSRItem_DataBound"
                    OnNeedDataSource="grdMSRItem_NeedDataSource"
                    OnItemCommand="grdMSRItem_ItemCommand"
                    OnInsertCommand="grdMSRItem_InsertCommand"
                    OnUpdateCommand="grdMSRItem_UpdateCommand"
                    OnDeleteCommand="grdMSRItem_DeleteCommand"
                    OnItemInserted="grdMSRItem_ItemInserted"
                    OnItemUpdated="grdMSRItem_ItemUpdated"
                    OnItemDataBound="grdMSRItem_ItemDataBound" OnPreRender="grdMSRItem_PreRender">
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="ID" HorizontalAlign="NotSet" EditMode="InPlace" AutoGenerateColumns="False" TableLayout="Fixed">
                        <PagerStyle AlwaysVisible="True" FirstPageToolTip="First page" LastPageToolTip="Last page" NextPagesToolTip="Next page" NextPageToolTip="Next page" PagerTextFormat="Change page: {4} &amp;nbsp;Page &lt;strong&gt;{0}&lt;/strong&gt; / &lt;strong&gt;{1}&lt;/strong&gt;, Total:  &lt;strong&gt;{5}&lt;/strong&gt; Documents." PageSizeLabelText="Row/page: " PrevPagesToolTip="Previous page" PrevPageToolTip="Previous page" />
                     
                        <CommandItemSettings AddNewRecordText="Add new Item" />
                        <ColumnGroups>
                            <telerik:GridColumnGroup HeaderText="Thông Tin Tồn Kho CDC" Name="Group1" HeaderStyle-HorizontalAlign="Center">
                                <HeaderStyle BackColor="brown"></HeaderStyle>
                            </telerik:GridColumnGroup>
                        </ColumnGroups>
                        <Columns>
                            <telerik:GridTemplateColumn DataField="ID" HeaderText="ID" UniqueName="ID" Display="False">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "ID")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="1" ID="txtID" Width="100%" Text='<%#DataBinder.Eval(Container.DataItem, "ID")%>' />

                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="No." Groupable="False" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" Width="30" VerticalAlign="Middle"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Width="30"></ItemStyle>
                                <ItemTemplate>
                                   <%-- <asp:Label ID="lblSoTT" runat="server" Text='<%# grdMSRItem.CurrentPageIndex * grdMSRItem.PageSize + grdMSRItem.Items.Count+1 %>'>
                                    </asp:Label>--%>
                                     <asp:Label ID="lblSoTT" runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ButtonType="ImageButton" EditImageUrl="~/Images/edit.png" UpdateImageUrl="~/Images/ok.png" CancelImageUrl="~/Images/Cancel.png">
                                <HeaderStyle Width="40" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ConfirmText="Do you want to delete Document" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                                <HeaderStyle Width="40" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridButtonColumn>

                            <telerik:GridTemplateColumn DataField="Quantity" HeaderText="Quantity" UniqueName="Quantity">
                                <HeaderStyle HorizontalAlign="Center" Width="80" />
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Quantity")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox runat="server" NumberFormat-DecimalDigits="0" ID="txtQuantity" Width="100%" RenderMode="Lightweight" MinValue="1" />
                              
                                    
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Unit" HeaderText="Unit" UniqueName="Unit">
                                <HeaderStyle HorizontalAlign="Center" Width="100" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Unit")%>
                                </ItemTemplate>
                             
                                 <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtUnit" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="PartNo" HeaderText="Inventory Code / Part No." UniqueName="PartNo">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "PartNo")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtPartNo" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Including" HeaderText="Full service package for MSR management system, including :" UniqueName="Including">
                                <HeaderStyle HorizontalAlign="Center" Width="300" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                   <%#DataBinder.Eval(Container.DataItem, "Including").ToString().Replace("\r\n", "<br/>")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="3" ID="txtIncluding" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="MaterialID" HeaderText="Material ID" UniqueName="MaterialID">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "MaterialID")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtMaterialID" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField=" " HeaderText="FPSO Inventory" UniqueName="Inventory">
                                <HeaderStyle HorizontalAlign="Center" Width="100" />
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Inventory")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                       <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtInventory" Width="100%" />
                               
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                              <telerik:GridTemplateColumn DataField="MaterialReceived" HeaderText="Material Received" UniqueName="MaterialReceived">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "MaterialReceived")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="1" ID="txtMaterialReceived" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Remark" HeaderText="Remark" UniqueName="Remark">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Remark")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="1" ID="txtRemark" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                       <telerik:GridTemplateColumn DataField="IsNote" HeaderText="Note" UniqueName="IsNote">
                                <HeaderStyle HorizontalAlign="Center" Width="100" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" TextMode="MultiLine" Rows="1" Width="100%" Checked=' <%#DataBinder.Eval(Container.DataItem, "IsNote") != null ?DataBinder.Eval(Container.DataItem, "IsNote"):false %>' />
                                   
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox runat="server" TextMode="MultiLine" Rows="1" ID="cbIsNote" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                         
                        </Columns>
                    </MasterTableView>
                    <ClientSettings Selecting-AllowRowSelect="true" AllowKeyboardNavigation="true">
                                    <KeyboardNavigationSettings AllowSubmitOnEnter="true" />
                                    <Selecting AllowRowSelect="true" />
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>
                </telerik:RadGrid>
                          <%--   <telerik:RadGrid RenderMode="Lightweight" ID="grdMSRItem" runat="server"  GridLines="None" AllowAutomaticDeletes="True" Skin="Metro" Height="500"
                    AllowAutomaticInserts="False" PageSize="50" AllowAutomaticUpdates="False" AllowPaging="true"
                    AutoGenerateColumns="False"
                
              OnBatchEditCommand="grdMSRItem_BatchEditCommand"
                    OnNeedDataSource="grdMSRItem_NeedDataSource"
                    OnItemCommand="grdMSRItem_ItemCommand"
                    OnInsertCommand="grdMSRItem_InsertCommand"
                    OnUpdateCommand="grdMSRItem_UpdateCommand"
                    OnDeleteCommand="grdMSRItem_DeleteCommand"
                    OnItemInserted="grdMSRItem_ItemInserted"
                    OnItemUpdated="grdMSRItem_ItemUpdated"
                    OnItemDataBound="grdMSRItem_ItemDataBound" OnPreRender="grdMSRItem_PreRender"
                OnDetailTableDataBind="grdMSRItem_DetailTableDataBind">
                <PagerStyle Mode="NumericPages"></PagerStyle>
                <MasterTableView DataKeyNames="ID"  EditMode="InPlace"
                    Width="100%" CommandItemDisplay="Top" Name="Item">
                    <CommandItemSettings AddNewRecordText="Add new Item" />
                    <DetailTables>
                        <telerik:GridTableView DataKeyNames="ID" Width="100%" EditMode="InPlace"
                            runat="server" CommandItemDisplay="Top" Name="SubItem">

                            <CommandItemSettings AddNewRecordText="Add new sub Item" />
                          
                            <Columns>
                                <telerik:GridTemplateColumn DataField="ID" HeaderText="ID" UniqueName="ID" Display="False">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "ID")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="1" ID="txtSubID" Width="100%" Text='<%#DataBinder.Eval(Container.DataItem, "ID")%>' />

                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                          

                            <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ButtonType="ImageButton" EditImageUrl="~/Images/edit.png" UpdateImageUrl="~/Images/ok.png" CancelImageUrl="~/Images/Cancel.png">
                                <HeaderStyle Width="40" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ConfirmText="Do you want to delete Document" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                                <HeaderStyle Width="40" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridButtonColumn>

                            <telerik:GridTemplateColumn DataField="Quantity" HeaderText="Quantity" UniqueName="Quantity">
                                <HeaderStyle HorizontalAlign="Center" Width="80" />
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Quantity")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox runat="server" NumberFormat-DecimalDigits="0" ID="txtQuantity" Width="100%" RenderMode="Lightweight" MinValue="1" />
                              
                                    
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>



                            <telerik:GridTemplateColumn DataField="Unit" HeaderText="Unit" UniqueName="Unit">
                                <HeaderStyle HorizontalAlign="Center" Width="100" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Unit")%>
                                </ItemTemplate>
                             
                                 <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtUnit" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="PartNo" HeaderText="Inventory Code / Part No." UniqueName="PartNo">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "PartNo")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtPartNo" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Including" HeaderText="Full service package for MSR management system, including :" UniqueName="Including">
                                <HeaderStyle HorizontalAlign="Center" Width="300" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                   <%#DataBinder.Eval(Container.DataItem, "Including").ToString().Replace("\r\n", "<br/>")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="3" ID="txtIncluding" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="MaterialID" HeaderText="Material ID" UniqueName="MaterialID">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "MaterialID")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtMaterialID" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Inventory" HeaderText="FPSO Inventory" UniqueName="Inventory">
                                <HeaderStyle HorizontalAlign="Center" Width="100" />
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Inventory")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                       <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtInventory" Width="100%" />
                               
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Remark" HeaderText="Remark" UniqueName="Remark">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Remark")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="1" ID="txtRemark" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                          
                            </Columns>

                        </telerik:GridTableView>
                    </DetailTables>
                    <Columns>
                 
                            <telerik:GridTemplateColumn HeaderText="No." Groupable="False" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" Width="30" VerticalAlign="Middle"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Width="30"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblSoTT" runat="server" Text='<%# grdMSRItem.CurrentPageIndex * grdMSRItem.PageSize + grdMSRItem.Items.Count+1 %>'>
                                    </asp:Label>

                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ButtonType="ImageButton" EditImageUrl="~/Images/edit.png" UpdateImageUrl="~/Images/ok.png" CancelImageUrl="~/Images/Cancel.png">
                                <HeaderStyle Width="40" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ConfirmText="Do you want to delete Document" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                                <HeaderStyle Width="40" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridButtonColumn>

                            <telerik:GridTemplateColumn DataField="Quantity" HeaderText="Quantity" UniqueName="Quantity">
                                <HeaderStyle HorizontalAlign="Center" Width="80" />
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Quantity")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox runat="server" NumberFormat-DecimalDigits="0" ID="txtQuantity" Width="100%" RenderMode="Lightweight" MinValue="1" />
                              
                                    
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>



                            <telerik:GridTemplateColumn DataField="Unit" HeaderText="Unit" UniqueName="Unit">
                                <HeaderStyle HorizontalAlign="Center" Width="100" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Unit")%>
                                </ItemTemplate>
                             
                                 <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtUnit" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="PartNo" HeaderText="Inventory Code / Part No." UniqueName="PartNo">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "PartNo")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtPartNo" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Including" HeaderText="Full service package for MSR management system, including :" UniqueName="Including">
                                <HeaderStyle HorizontalAlign="Center" Width="300" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                   <%#DataBinder.Eval(Container.DataItem, "Including").ToString().Replace("\r\n", "<br/>")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="3" ID="txtIncluding" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="MaterialID" HeaderText="Material ID" UniqueName="MaterialID">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "MaterialID")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtMaterialID" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Inventory" HeaderText="FPSO Inventory" UniqueName="Inventory">
                                <HeaderStyle HorizontalAlign="Center" Width="100" />
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Inventory")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                       <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtInventory" Width="100%" />
                               
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Remark" HeaderText="Remark" UniqueName="Remark">
                                <HeaderStyle HorizontalAlign="Center" Width="150" />
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Remark")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="1" ID="txtRemark" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                        
                    </Columns>

                </MasterTableView>
                <ClientSettings Selecting-AllowRowSelect="true" AllowKeyboardNavigation="true">
                    <KeyboardNavigationSettings AllowSubmitOnEnter="true" />
                    <Selecting AllowRowSelect="true" />
                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                </ClientSettings>
            </telerik:RadGrid>--%>
                <%--                  </telerik:RadPane>
                </telerik:RadSplitter>--%>

                     </div></div></div>
            </telerik:RadPageView>
             <telerik:RadPageView runat="server" ID="radViewComment">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col">
                             <div style="width: 100%;margin-top:40px;">

            <telerik:RadGrid RenderMode="Lightweight" ID="grdMSRComment" GridLines="None" runat="server" AllowAutomaticDeletes="True" Skin="Metro"
                    AllowAutomaticInserts="False" PageSize="10" AllowAutomaticUpdates="False" AllowPaging="False"
                    AutoGenerateColumns="False"
                     OnDataBound="grdMSRComment_DataBound"
                   OnInsertCommand="grdMSRComment_InsertCommand"
                    OnUpdateCommand="grdMSRComment_UpdateCommand"
                    OnDeleteCommand="grdMSRComment_DeleteCommand"
                    OnItemInserted="grdMSRComment_ItemInserted"
                    OnItemUpdated="grdMSRComment_ItemUpdated"
                OnItemCommand="grdMSRComment_ItemCommand"
                  OnItemDataBound="grdMSRComment_ItemDataBound"
                  OnPreRender="grdMSRComment_PreRender"
                    OnNeedDataSource="grdMSRComment_NeedDataSource">
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="ID" HorizontalAlign="NotSet" EditMode="InPlace" AutoGenerateColumns="False" TableLayout="Fixed" BorderStyle="Solid" BorderColor="#e5e5e5" BorderWidth="1">
                        <PagerStyle AlwaysVisible="True" FirstPageToolTip="First page" LastPageToolTip="Last page" NextPagesToolTip="Next page" NextPageToolTip="Next page" PagerTextFormat="Change page: {4} &amp;nbsp;Page &lt;strong&gt;{0}&lt;/strong&gt; / &lt;strong&gt;{1}&lt;/strong&gt;, Total:  &lt;strong&gt;{5}&lt;/strong&gt; Documents." PageSizeLabelText="Row/page: " PrevPagesToolTip="Previous page" PrevPageToolTip="Previous page" />
                        <CommandItemSettings AddNewRecordText="Add new Item" />
                        <Columns>
                             <telerik:GridTemplateColumn DataField="ID" HeaderText="ID" UniqueName="ID" Display="False">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "ID")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox runat="server" TextMode="MultiLine" Rows="1" ID="txtID" Width="100%" Text='<%#DataBinder.Eval(Container.DataItem, "ID")%>' />

                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <%--<telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ButtonType="ImageButton" EditImageUrl="~/Images/edit.png" UpdateImageUrl="~/Images/ok.png" CancelImageUrl="~/Images/Cancel.png">
                                <HeaderStyle Width="20" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ConfirmText="Do you want to delete Document" ButtonType="ImageButton" ImageUrl="~/Images/delete.png">
                                <HeaderStyle Width="20" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridButtonColumn>--%>
                          <%-- <telerik:GridDateTimeColumn HeaderText="Created Date" UniqueName="ActualDate" DataField="ActualDate"
                                        DataFormatString="{0:HH:mm dd/MM/yyyy}">
                                    <HeaderStyle HorizontalAlign="Center" Width="100" />
                                    <ItemStyle HorizontalAlign="Center"/>
                                    </telerik:GridDateTimeColumn>--%>
                              <telerik:GridTemplateColumn DataField="CreatedDate" HeaderText="Created Date" UniqueName="CreatedDate">
                                <HeaderStyle HorizontalAlign="Center" Width="60" />
                                <ItemStyle HorizontalAlign="Left" Font-Size="Medium"/>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "CreatedDate","{0:HH:mm dd/MM/yyyy}")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn DataField="UserFullName" HeaderText="User Full Name" UniqueName="UserFullName">
                                <HeaderStyle HorizontalAlign="Center" Width="80" />
                                <ItemStyle HorizontalAlign="Left" Font-Size="Medium"/>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "UserFullName")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Comment" HeaderText="Comment" UniqueName="Comment">
                                <HeaderStyle HorizontalAlign="Center" Width="200" />
                                <ItemStyle HorizontalAlign="Left" Font-Size="Medium"/>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Comment")%>
                                </ItemTemplate>
                                 <EditItemTemplate>
                                    <telerik:RadTextBox TextMode="MultiLine" Rows="1" runat="server" ID="txtComment" Width="100%" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                     </MasterTableView>
                   <ClientSettings Selecting-AllowRowSelect="true" AllowKeyboardNavigation="true">
                                    <KeyboardNavigationSettings AllowSubmitOnEnter="true" />
                                    <Selecting AllowRowSelect="true" />
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>
                  </telerik:RadGrid>
            
                             </div>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
        <asp:HiddenField runat="server" ID="docUploadedIsExist" />
        <asp:HiddenField runat="server" ID="docIdUpdateUnIsLeaf" />
         <asp:HiddenField runat="server" ID="IdMSR" />
        <telerik:RadAjaxManager runat="Server" EnablePageHeadUpdate="false" ID="ajaxDocument" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
            <ClientEvents OnResponseEnd="test" OnRequestStart="onRequestStart"/>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ajaxDocument">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divContent" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="grdDocument">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grdDocument" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                 <telerik:AjaxSetting AjaxControlID="grdMSRItem">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grdMSRItem" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                  <telerik:AjaxSetting AjaxControlID="grdMSRComment">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grdMSRComment" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="ddlArea">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlUnit" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                 <telerik:AjaxSetting AjaxControlID="Cb_Planned">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="textYear" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="ddlSystem">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlSubSystem" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSave">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divContent" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="ddlDiscipline">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlEngineer" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="ddlSystem">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="txtOriginator" />
                        <telerik:AjaxUpdatedControl ControlID="txtOriginating" />
                        <telerik:AjaxUpdatedControl ControlID="txtReceiving" />
                        <telerik:AjaxUpdatedControl ControlID="txtDocumenType" />
                        <telerik:AjaxUpdatedControl ControlID="txtDiscipline" />
                        <telerik:AjaxUpdatedControl ControlID="txtMaterial" />
                        <telerik:AjaxUpdatedControl ControlID="txtWork" />
                        <telerik:AjaxUpdatedControl ControlID="txtDrawing" />
                        <telerik:AjaxUpdatedControl ControlID="txtEquipmentTagNumber" />
                        <telerik:AjaxUpdatedControl ControlID="txtDepartmentcode" />
                        <telerik:AjaxUpdatedControl ControlID="txtMRSequenceNo" />
                        <telerik:AjaxUpdatedControl ControlID="txtDocumentSequenceNo" />
                        <telerik:AjaxUpdatedControl ControlID="txtsheetno" />
                        <telerik:AjaxUpdatedControl ControlID="txtPlant" />
                        <telerik:AjaxUpdatedControl ControlID="txtArea" />
                        <telerik:AjaxUpdatedControl ControlID="txtUnit" />
                        <telerik:AjaxUpdatedControl ControlID="txtDocumentTitle" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
         <telerik:RadWindowManager ID="RadWindowManager1" runat="server"  Skin="Metro" RenderMode="Lightweight" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="CustomerDialog" runat="server" Title="Import Items List"
                VisibleStatusbar="false" Height="300" Width="400"
                Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
            <telerik:RadWindow ID="ViewerFile" runat="server" Title="Viewer File" OnClientClose="OnClientClose"
                VisibleStatusbar="false" Height="500" Width="600" MaxHeight="630" MaxWidth="1250"
                Left="10px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
            </Windows>
             </telerik:RadWindowManager>
        <telerik:RadScriptBlock runat="server">
            <script type="text/javascript">
                var ajaxManager;
                function OnClientFilesUploaded(sender, args) {
                    var name = args.get_fileName();
                    //document.getElementById("txtName").value = name;
                    $find('<%=ajaxDocument.ClientID %>').ajaxRequest();
                }
                function ImportItem() {
                    var docId = document.getElementById("<%= IdMSR.ClientID %>").value;
                    if (docId != null) { 
                    var owd = $find("<%=CustomerDialog.ClientID %>");
                    owd.Show();
                        owd.setUrl("ImportMSRItem.aspx?tranId=" + docId , "CustomerDialog");}
                }
                function pageLoad() {
                    ajaxManager = $find("<%=ajaxDocument.ClientID %>");
                }
                function test(sender, args) {
                    //alert(args.get_eventTarget());
                    if (args.get_eventTarget().indexOf("ajaxDocument") >= 0) {
                        var masterTable = $find("<%=grdDocument.ClientID%>").get_masterTableView();
                        masterTable.rebind();
                    }
                    
                }
                function refreshGrid() {
                    var masterTable = $find("<%=grdMSRItem.ClientID%>").get_masterTableView();
                    masterTable.rebind();
                }
                function fileUploading(sender, args) {
                    var name = args.get_fileName();
                    document.getElementById("txtName").value = name;

                    ajaxManager.ajaxRequest("CheckFileName$" + name);
                }
                function FileView(docId) {
            
                    var owd = $find("<%= ViewerFile.ClientID %>");
                  //  owd.Show();
                    //owd.moveTo(10, 3);
                   // owd.maximize(true);
                    // owd.setUrl("../../ViewerFile.aspx?IndexId=" + docId, "ViewerFile");
                    window.open("../../ViewerFile.aspx?IndexId=" + docId);
                }
                function OnClientClose() {
               <%-- var oWnd = $find("<%= RadWindowManager1.ClientID %>").getWindowByName("ViewerFile");--%>
                     var oWnd = $find("<%= ViewerFile.ClientID %>");
                     oWnd.setUrl("about:blank"); // Sets url to blank  
                 }
                function OnClientTabSelect(sender, eventArgs) {
                    var tab = eventArgs.get_tab();
                    var navigateUrl = tab.get_text();
                    if (navigateUrl == "Outgoing Transmittals") {
                        refreshOutgoingGrid();
                    }
                    else if (navigateUrl == "Package for MSR") {
                        <%--var masterTable = $find("<%=grdMSRItem.ClientID%>").get_masterTableView();
                        masterTable.rebind();--%>
                    }
                    else if (navigateUrl == "") {
                       <%-- var masterTable = $find("<%=grdIncomingTrans.ClientID%>").get_masterTableView();
                         masterTable.rebind();--%>
                    }
                }
                function DeleteAttachFile(id) {
                    if (confirm("Do you want delete the file?") == false) return;
                    ajaxManager.ajaxRequest("FileDelete_" + id);
                }
                function onRequestStart(sender, args) {
                    //alert(args.get_eventTarget());
                    if (args.get_eventTarget().indexOf("ExportTo") >= 0 || args.get_eventTarget().indexOf("btnDownloadPackage") >= 0) {
                        args.set_enableAjax(false);
                    }
                }
                function StopPropagation(e) {
                    if (!e) {
                        e = window.event;
                    }

                    e.cancelBubble = true;
                }

                function nodeClicked(sender, args) {
                    var node = args.get_node();
                    if (node.get_checked()) {
                        node.uncheck();
                    } else {
                        node.check();
                    }
                    nodeChecked(sender, args)

                }
                function onblurTXTNote(id) {
                    var comment = document.getElementById(id).value;
                   
                    ajaxManager.ajaxRequest("UpdateNote_" + id+"_"+comment);
                }
            </script>
        </telerik:RadScriptBlock>
    </form>
</body>
</html>
