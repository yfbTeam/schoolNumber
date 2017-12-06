<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourceWeekAdd.aspx.cs" Inherits="SMSWeb.CourseManage.CourceWeekAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>选修课设置</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>

</head>
<body>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />

        <!--创建课程dialog-->
        <div style="background: #fff; padding-bottom: 255px;">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_select clearfix">
                        <label for="">当前周：</label>
                        <select id="WeekName">
                            <option value="0">请选择</option>
                            <option value="1">周一</option>
                            <option value="2">周二</option>
                            <option value="3">周三</option>
                            <option value="4">周四</option>
                            <option value="5">周五</option>
                            <option value="6">周六</option>
                            <option value="7">周日</option>
                        </select>
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_select clearfix">
                        <label for="">互斥周：</label>
                        <select id="ExcWeek">
                            <option value="0">请选择</option>
                            <option value="1">周一</option>
                            <option value="2">周二</option>
                            <option value="3">周三</option>
                            <option value="4">周四</option>
                            <option value="5">周五</option>
                            <option value="6">周六</option>
                            <option value="7">周日</option>
                        </select>
                    </div>
                    <div style="margin-top: 20px; text-align: center">
                        <input id="Button1" type="button" value="确定" onclick="Add()" style="border-radius: 3px; text-decoration: none; font-size: 14px; background-color: #0DA6EC; color: white; border: 0px; padding: 6px 15px; cursor: pointer;" />
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script>
        var GetUrlDate = new GetUrlDate();

        //添加数据
        function Add() {
            var WeekName = $("#WeekName").find("option:selected").text(); //$("#WeekName").val();

            var ExcWeek = $("#ExcWeek").find("option:selected").text();// $("#ExcWeek").val();

            if (WeekName.length == "请选择") {
                layer.msg("请填写完整信息！");
                return;
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "CourseManage/CourseSet.ashx", func: "AddWeekSet", WeekName: WeekName, ExcWeek: ExcWeek, SetID: GetUrlDate.ID, UserIdCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        parent.getData(1, 10);
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
