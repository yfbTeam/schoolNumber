<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StuDetail.aspx.cs" Inherits="SMSWeb.PersonalSpace.StuDetail" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>课程管理</title>
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

    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_Certificate" type="text/x-jquery-tmpl">
        <tr>
            <td>${CreateName}</td>
            <td>${IDCard}</td>
            <td>${CompleteTime}</td>

        </tr>
    </script>


</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

    <input type="hidden" id="HStuIDCard" value="" runat="server" />
    <form id="form1" runat="server">
        <input id="option" type="hidden" value=">" />
        <!--header-->

        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">

                <div class="newcourse_select clearfix">
                    <%--<div class="clearfix fl course_select">
                        <label for="">学年学期：</label>
                        <select name="" class="select" id="StudyTerm" onchange="getData(1, 10)">
                            <option value="">==请选择==</option>
                        </select>
                    </div>--%>
                    <%--<div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" onclick="AddCource()" id="icon-plus">
                            <i class="icon icon-plus"></i>新建课程
                        </a>
                    </div>--%>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th>学员姓名</th>
                            <th>学员身份证号</th>
                            <th>取证时间</th>
                        </thead>
                        <tbody id="tbCertificate">
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
    </form>
</body>
<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        getStuData(1, 10);
    });
    var UrlDate = new GetUrlDate();
    //获取数据
    function getStuData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: {
                PageName: "/Certificate/Certificate.ashx",
                Func: "GetCertificates",
                Ispage: true,
                CertificateID: UrlDate.CertiID,
                PageIndex: startIndex,
                pageSize: pageSize
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(".page").show();
                    $("#tbCertificate").html('');
                    $("#tr_Certificate").tmpl(json.result.retData.PagedData).appendTo("#tbCertificate");
                    makePageBar(getStuData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                }
                else {
                    $(".page").hide();
                    $("#tbCertificate").html("暂无取得证书的学生！");
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
</script>
</html>
