<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EvalueContent.aspx.cs" Inherits="SMSWeb.OnlineLearning.EvalueContent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                        <label for="">评价内容：</label>
                    </div>
                    <div class="mb20 clearfix pr">
                        <div style="width: 99%; height: 260px; float: left;">
                            <textarea id="content" name="content" style="width: 100%; height: 260px;">
                                </textarea>
                        </div>
                    </div>
                    <div style="clear: both"></div>

                    <div class="course_form_select clearfix">
                        <a class="course_btn confirm_btn" onclick="Sava()" id="btnCreate">确定</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        function Sava() {
            var ID = UrlDate.ID;
            var Evalue = UrlDate.Evalue;

            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "/OnlineLearning/MyLessonsHandler.ashx",
                    "Func": "Evalue",
                    "ID": ID,
                    "IDCard": $("#HUserIdCard").val(),
                    "Evalue": Evalue,
                    "Content": $("#content").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        parent.CloseIFrameWindow();
                        parent.layer.msg("评价成功");
                        parent.getData(1, 10);
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
    </script>
</body>
</html>
