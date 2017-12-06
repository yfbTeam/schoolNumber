<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModolAdd.aspx.cs" Inherits="SMSWeb.CourseManage.ModolAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>创建课程</title>
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

        function ModolAdd(id) {
            var ModoleName = $("#ModelName").val();
            var ModelMes = $("#ModelMes").val();

            if (!ModoleName.length && !ModelMes.length) {
                layer.msg("请填写完模版名称！");
            }
            else {
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "CourseManage/CourceManage.ashx",
                        "Func": "ModoleAdd",
                        CourceID: GetUrlDate.CourceID,
                        ModoleName: ModoleName,
                        ModelMes: ModelMes,
                        CreateUID: $("#HUserIdCard").val(),
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            parent.layer.msg('模版生成成功!');
                            parent.getData(1, 10);
                            parent.CloseIFrameWindow();
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }
        }

    </script>

</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HClassID" runat="server" />

    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">模版名称：</label>
                            <input type="text" placeholder="模版名称" class="text" id="ModelName" value="" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">模版描述：</label>
                            <input type="text" placeholder="模版描述" class="text" id="ModelMes" />
                            <i class="stars"></i>
                        </div>


                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a href="javscript:;" class="course_btn confirm_btn" onclick="ModolAdd()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>


</body>
</html>
