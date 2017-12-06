<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_SelManag.aspx.cs" Inherits="SMSWeb.CourseManage.Course_SelManag" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>课程管理</title>
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
    <script src="Term.js"></script>

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
            <td class="checkradio pr">
                ${TermName}</td>
            <td>第${SelTime}次</td>
            <td>{{if SelType==1}}先到先得
                {{else}}优先级
                {{/if}}</td>
            <td>{{if Status==0}}待激活
                {{else Status==1}}激活
                {{else}}停止
                {{/if}}
            </td>
            <td>{{if WeekSet==0}}禁用
                {{else}}启用
                {{/if}}</td>
            <td>${SelMaxNum}</td>
            <td>${SelMinNum}</td>

            <td>${CreateTime}</td>
            <td>
                <a href="javascript:;" onclick="Edit(${ID})"><i class="icon icon-edit"></i>修改</a>
                {{if WeekSet==1}}
                <a href="javascript:;" onclick="Set(${ID})"><i class="icon icon-road"></i>周设置</a>
                {{/if}}</td>
        </tr>
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="ButtonCode" />
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>"/>
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                 <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/coursesystem.png" /></div>
                <nav class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                        <%-- <li><a href="CourseIndex.aspx">课程首页</a></li>
                        <li><a href="CourceManage.aspx">课程管理</a></li>
                        <li><a href="MyCourceManage.aspx">我的课程</a></li>
                        <li class="active"><a href="#">选课管理</a></li>--%>
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
                         <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">
                <%--<div class="crumbs">
					<a href="Course_SelManag.aspx">选课管理</a>
					<span>&gt;</span>
					<a href="#">周设置</a>
				</div>--%>
                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">学年学期：</label>
                        <select name="" class="select" id="StudyTerm" onchange="getData(1, 10)">
                            <option value="">请选择学期</option>
                        </select>
                    </div>
                    <%--<div class="clearfix fl course_select">
                        <label for="">课程状态：</label>
                        <select name="" class="select">
                            <option value="1">待审核</option>
                            <option value="2">审核通过</option>
                        </select>
                    </div>--%>
                    <div class="stytem_select_right fr">
                        <a href="javascript:;" onclick="Add()" class="newcourse"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <th class="pr checkall">                             
                                学年学期</th>
                            <th>批次</th>
                            <th>筛选方式</th>
                            <th>课程状态</th>
                            <th>周设置</th>
                            <th>最多选修课程数量</th>
                            <th>最少选修课程数量</th>
                            <th>创建时间</th>
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

<script>
    $('.checkall>input').click(function () {
        if ($(this).is(':checked')) {
            $('.checkradio>input').prop('checked', true);
        } else {
            $('.checkradio>input').prop('checked', false);
        }
    })

</script>
<script type="text/javascript">
    $(document).ready(function () {
        GetTerm();
        getData(1, 10);
        CourceMenu();
    });

    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        var StudyTerm = $("#StudyTerm").val();
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "CourseManage/CourseSet.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, StudyTerm: StudyTerm },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {

                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_Manage").html(html);

                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //修改设置
    function Edit(ID) {
        OpenIFrameWindow('修改设置', 'Course_SelAdd.aspx?ID=' + ID, '380px', '420px');
    }
    function Add() {
        OpenIFrameWindow('添加设置', 'Course_SelAdd.aspx', '380px', '420px');
    }
    function Set(ID) {
        window.location.href = 'Course_SelWeek.aspx?ID=' + ID + "&ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName;
    }
</script>
</html>
