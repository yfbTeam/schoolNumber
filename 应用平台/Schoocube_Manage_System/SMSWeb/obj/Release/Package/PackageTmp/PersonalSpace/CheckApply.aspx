<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckApply.aspx.cs" Inherits="SMSWeb.PersonalSpace.CheckApply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>证书申请审核</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
    <input type="hidden" id="HUserName" runat="server" />
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="clearfix">

                        <div style="clear: both"></div>
                        <div class="course_form_select">
                            <label for="">审核意见：</label>
                            <textarea name="" rows="" cols="" id="area_Contents"></textarea>
                        </div>
                        <div class="course_form_select fl" id="IsTop">
                            <label for="">是否通过：</label>
                            <input type="radio" name="radio_isPass" id="" value="2" checked="checked" />
                            <label for="">否</label>
                            <input type="radio" name="radio_isPass" id="" value="1" />
                            <label for="">是</label>
                        </div>
                        <div class="course_form_select clearfix">
                            <span class="course_btn confirm_btn" onclick="SaveCheck();" style="cursor: pointer;">确定</span>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script>
        var GetUrlDate = new GetUrlDate();

        //操作课程通知数据
        function SaveCheck() {
            var ID = GetUrlDate.ID;

            var CheckMessage = $("#txt_CheckMessage").val();
            var isPass = $("input[name='radio_isPass']:checked").val();

            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "CheckApply",
                    ID: ID,
                    CheckMessage: CheckMessage,
                    isPass: isPass,
                    UserIdCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        parent.Certificate(1, 10);
                        parent.CloseIFrameWindow();
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }

    </script>
</body>
</html>

