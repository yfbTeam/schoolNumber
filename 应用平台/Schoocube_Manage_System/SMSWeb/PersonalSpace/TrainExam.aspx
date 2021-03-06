﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrainExam.aspx.cs" Inherits="SMSWeb.PersonalSpace.TrainExam" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>培训考试</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />

    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/CourseMenu.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="Term.js"></script>
    <%--<script src="/Scripts/Power.js"></script>--%>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td class="checkradio pr">${Title}</td>
            <td>${Score}</td>
            <td>${AnswerBeginTime}</td>
            <td>${AnswerEndTime}</td>

        </tr>
    </script>


</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <form id="form1" runat="server">
        <input id="option" type="hidden" value=">" />
        <!--header-->

        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <div class="newcourse_select clearfix" id="CourseSel">
                    <div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" onclick="ExportExam()" id="icon-plus">
                           数据导出
                        </a>
                    </div>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th class="pr checkall">试卷名称</th>
                            <th>考试分数</th>
                            <th>答题开始时间</th>
                            <th>答题结束时间</th>
                        </thead>
                        <tbody id="tb_Manage">
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">
    var UrlDate = new GetUrlDate();

    $(document).ready(function () {
        getData();
    });
    //获取数据
    function getData() {

        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "CourseManage/PersonSpaceStu.ashx", "Func": "GetTrainExam", "trainID": UrlDate.trainID
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData).appendTo("#tb_Manage");
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background:#fff url(/images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //导出
    function ExportExam() {
        window.open('/PersonalSpace/ToExcelHandler.ashx?Func=ExamDoc&trainID=' + UrlDate.trainID, "myIframe");
    }
</script>
</html>
