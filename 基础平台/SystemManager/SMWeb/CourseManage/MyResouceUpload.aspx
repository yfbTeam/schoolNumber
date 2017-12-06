<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyResouceUpload.aspx.cs" Inherits="SMSWeb.CourseManage.MyResouceUpload" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <script src="../Scripts/Uploadyfy/Upload.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <input type="file" name="uploadify" id="uploadify" />
        <div class="fileup_w">
            <a href="javascript:$('#uploadify').uploadify('upload', '*')" class="fileup">开始上传</a>
            <a href="javascript:jQuery('#uploadify').uploadify('cancel')" class="fileup">取消上传</a>
        </div>
        <div class="T_list">
            <div id="fileQueue" style="width: 100%; height: auto; border: 2px solid #5493d7;"></div>
        </div>

    </form>
</body>
</html>
