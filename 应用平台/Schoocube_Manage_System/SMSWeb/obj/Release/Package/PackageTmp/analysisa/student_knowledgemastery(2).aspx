﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="student_knowledgemastery(2).aspx.cs" Inherits="SMSWeb.analysisa.student_knowledgemastery_2_" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>掌握程度</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="../css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="../css/common.css"/>
    <link rel="stylesheet" type="text/css" href="../css/repository.css"/>
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css"/>
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
    <script src="../js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script type="text/javascript" src="../Scripts/FusionChart/js/fusioncharts.js"></script>
    <link rel="stylesheet" href="../css/Css.css">
    <script src="../js/jquery.kkPages.js"></script>
    <style>
        .wrap table tbody tr td a {
            display: inline-block;
            background: none;
            color: #5493d7;
        }

        .wrap table tbody tr td .icon {
            width: 16px;
            height: 16px;
            display: inline-block;
            font-size: 16px;
            line-height: 16px;
            cursor: pointer;
            margin: 0px 2px;
            vertical-align: middle;
            color: #5493d7;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <!--header-->
<header class="repository_header_wrap manage_header">
    <div class="width repository_header clearfix">
        <a href="../HZ_Index.aspx" class="logo fl"><img src="../images/logo.png" /></a>
        <nav class="navbar menu_mid fl">
            <ul>
                <li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                <li currentclass="active"><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                <li currentclass="active"><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
                <li currentclass="active"><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                <li currentclass="active"><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                <li currentclass="active"><a href="/analysisa/student_studyprocess(4).aspx">个人学习进度</a></li>
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
                            <h2><%=Name %>
                            </h2>
                    </a>
                </li>
            </ul>
            <div class="settings fl pr">
                <a href="javascript:;">
                    <i class="icon icon-cog"></i>
                </a>
                <div class="setting_none">
                    <a href="/Gopay/Gopay.aspx" target="_blank"><span>账户管理</span></a>
                    <a href="/PersonalSpace/PersonalSpace_Student.aspx"><span>个人中心</span></a>
                    <span onclick="logOut()">退出</span>
                </div>
            </div>
        </div>
    </div>
</header>
<div class="onlinetest_item width pt90 pr ">
    <div  class="bordshadrad" style="background: #fff;padding:20px;">
        <div class="stytem_select clearfix">
            <div class="stytem_select_left fl">
                <a href="student_studyprocess(4).aspx" >课时跟踪</a>
                <a href="student_knowledgemastery(2).aspx" class="on">掌握程度</a>
                <a href="Knowledge_track.aspx">知识点跟踪</a>
            </div>
        </div>
        <div class="wrap">
            <table>
                <thead>
                    <tr>
                        <th>课程名称</th>
                        <th>课程类别</th>
                        <th>上课场地</th>
                        <th>选课人数</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            python基础
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            大教室
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="student_knowledgemastery(2)1.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            MySQL入门
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            四号会议室
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="student_knowledgemastery(2)2.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            文学修养（人教版）
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            三号教师
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="student_knowledgemastery(2)3.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            初一英语上册（人教版）
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            小教室
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="student_knowledgemastery(2)4.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            CG绘画培训
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            小教室
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="student_knowledgemastery(2)5.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>
                </tbody>
            </table>
            </div>
        </div>
</div>
    <script src="../js/common.js"></script>
    <script>
        $('.wrap').kkPages({
            PagesClass: 'tbody tr', //需要分页的元素
            PagesMth: 10, //每页显示个数
            PagesNavMth: 4 //显示导航个数
        });

    </script>
    </div>
    </form>
</body>
</html>
