<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseCommand.aspx.cs" Inherits="SMSWeb.CourseManage.CourseCommand" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/Common.js"></script>
    <script type="text/javascript">
        var GetUrlDate = new GetUrlDate();

        function Confim(id) {
            var Command = $("#Command").val();

            if (!Command.length) {
                layer.msg("请填写注册口令！");
            }
            else {
                parent.registSing(GetUrlDate.ID, Command);
                parent.CloseIFrameWindow();
            }
        }

    </script>

</head>
<body>
    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">课程口令：</label>
                            <input type="text" placeholder="请输入注册口令" class="text" id="Command" value="" />
                        </div>

                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a style="cursor: pointer" class="course_btn confirm_btn" onclick="Confim()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>


</body>
</html>
