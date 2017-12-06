<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.Master" AutoEventWireup="true" CodeBehind="UploadPhoto2.aspx.cs" Inherits="SMSWeb.Association.UploadPhoto2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<script type="text/javascript" src="/_layouts/15/Script/jquery-1.8.0.js"></script>
    <link rel="stylesheet" type="text/css" href="/_layouts/15/Stu_upload/upstyle.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/15/Stu_upload/webuploader.css" />
    <script type="text/javascript" src="/_layouts/15/Stu_upload/webuploader.min.js"></script>
    <script type="text/javascript" src="/_layouts/15/Stu_upload/upload.js"></script>--%>

    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../Stu_upload2/upstyle.css" rel="stylesheet" />
    <link href="../Stu_upload2/webuploader.css" rel="stylesheet" />
    <script src="../Stu_upload2/webuploader.min.js"></script>
    <script src="../Stu_upload2/upload.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="container">
            <!--头部，相册选择和格式选择-->
            <div id="setting" style="width: 100%; border-bottom: 1px solid #dadada; text-align: center">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always" RenderMode="Block">
                    <ContentTemplate>
                        <asp:DropDownList runat="server" ID="DDP_Album" AutoPostBack="true" OnSelectedIndexChanged="DDP_Album_SelectedIndexChanged" />
                        <asp:HiddenField runat="server" ID="hid_Album" ClientIDMode="Static" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div id="uploader">
                <div class="queueList">
                    <div id="dndArea" class="placeholder">
                        <div id="filePicker"></div>
                    </div>
                </div>
                <div class="statusBar" style="display: none;">
                    <div class="progress">
                        <span class="text">0%</span>
                        <span class="percentage"></span>
                    </div>
                    <div class="info"></div>
                    <div class="btns">
                        <div id="filePicker2"></div>
                        <div class="uploadBtn">开始上传</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
