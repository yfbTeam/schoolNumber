<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadPhoto.aspx.cs" Inherits="SMSWeb.Association.UploadPhoto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title> 
    <script type="text/javascript" src="../Stu_js/jquery-1.8.0.js"></script>
            <link rel="stylesheet" type="text/css" href="../Stu_upload/upstyle.css" />
            <link rel="stylesheet" type="text/css" href="../Stu_upload/webuploader.css" />
            <script type="text/javascript" src="../Stu_upload/webuploader.min.js"></script>
            <script type="text/javascript" src="../Stu_upload/upload.js"></script>
            <script type="text/javascript">
                function getValue() {
                    var member = $("select[id$='DDL_SecLeader']").val();
                    $("input[id$='Hid_SecLeader']").val(member);
                    return true;
                }
            </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           
                                <asp:HiddenField runat="server" ID="activeid" ClientIDMode="Static" />
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div id="wrapper">
                <div id="container">
                    <!--头部，相册选择和格式选择-->
                    <div id="setting" style="width: 100%; border-bottom: 1px solid #dadada; text-align: center">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always" RenderMode="Block">
                            <ContentTemplate>
                                <span>相册名:</span>
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
                                <div class="uploadBtn" >开始上传</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    function AddActive() {
        //var FirstUrl = window.location.hostname;
        //port = "44275";
        //FirstUrl = FirstUrl + ":" + port;
        //$.ajax({
        //    type: "Post",
        //    url: FirstUrl + "/AssoHandlers/AssoHandler.ashx?action=addactive",
        //    dataType: "text",
        //    success: function (returnVal) {
        //        alert(returnVal);
        //        if (returnVal>0) {
        //            $('#activeid').val(returnVal);
        //            return true;
        //        }
        //    },
        //    error: function (errMsg) {
        //        alert('上传失败！');
        //        return false;
        //    }
        //});
    }
</script>
