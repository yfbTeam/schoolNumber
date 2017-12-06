<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_Statistical.aspx.cs" Inherits="SMSWeb.Analysis.Course_Statistical" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>统计分析</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />

    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../CourseMenu.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../CourseManage/Term.js"></script>
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
            <td class="checkradio pr">${Name}</td>
            <td>${CourseEvalue}分</td>
            <td>${EvalueTimes}次</td>
            <td>${Evalue}分</td>
            <td>${Num}次</td>
            <td>${CreateTime}</td>
            <td><a onclick="Detail(${ID},'${Name}')"><i class="icon icon-random"></i>评价详情</a>
            </td>
        </tr>
    </script>


</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <form id="form1" runat="server">
        <input id="option" type="hidden" value=">" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
               <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
                <div class="coursesystem  fl"></div>
                <nav class="navbar menu_mid fl">

                    <ul id="CourceMenu">
                    </ul>
                </nav>
                <div class="search_account fr clearfix">
                      <ul class="account_area fl">
                        <li>
                            <a href="javascript:;" class="dropdown-toggle">
                                <i class="icon icon-envelope"></i>
                                <span class="badge">3</span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=PhotoURL %>" />
                                </div>
                                <h2><%=Name %></h2>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr ">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on" onclick="History('>',this)">课程评价</a>
                        <%-- <a href="javascript:;" onclick="History('<',this)">历史课程</a>
                        <a href="javascript:;" onclick="History('',this)">模版管理</a>--%>
                    </div>
                </div>
                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">学年学期：</label>
                        <select name="" class="select" id="StudyTerm" onchange="getData(1, 10)">
                            <option value="">==请选择==</option>
                        </select>
                    </div>

                    <%--<div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" onclick="AddCource()" id="icon-plus">
                            <i class="icon icon-plus"></i>新建课程
                        </a>
                    </div>--%>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th class="pr checkall">课程名称</th>
                            <th>综合评分</th>
                            <th>评价总次数</th>
                            <th>分值</th>
                            <th>出现次数</th>
                            <th>课程创建时间</th>
                            <th>操作</th>
                        </thead>
                        <tbody id="tb_Manage">
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
        <script src="../js/common.js"></script>
    </form>
</body>


<script type="text/javascript">
    $(document).ready(function () {
        getData(1, 10);
        CourceMenu();
        GetTerm();
    });

    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "CourseManage/CourceManage.ashx", "Func": "Course_EvalueStatistical", PageIndex: startIndex, pageSize: pageSize, StudyTerm: $("#StudyTerm").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_Manage").html(html);
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function Detail(id, Name) {
        OpenIFrameWindow('评价详情', 'Course_EvaluDetail.aspx?ID=' + id + "&CourseName="+Name, '430px', '400px');
    }
</script>
</html>
