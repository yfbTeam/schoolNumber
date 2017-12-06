<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="knowledge_line(1).aspx.cs" Inherits="SMSWeb.analysisa.knowledge_line_1_" %>

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
            <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" />
            </a>
            <div class="wenzi_tips fl">
                <img src="/images/xuexixiaoguo.png" />
            </div>
            <nav id="teacher" class="navbar menu_mid fl">
                <ul id="CourceMenu">
                    <li currentclass="active">
                        <a href="knowledge_line(1).aspx">知识点掌握统计</a>
                    </li>
                    <li currentclass="active">
                        <a href="test_markline(11).aspx">考试成绩</a>
                    </li>
                    <li currentclass="active"><a href="work_finishline(13).aspx">作业完成情况</a></li>
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
<div class="onlinetest_item width pt90 pr ">
    <div  class="bordshadrad" style="background: #fff;padding:20px;">
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
                            <a href="knowledge_line(1)1.aspx"><i class="icon icon-eye-open"></i></a>
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
                            <a href="knowledge_line(1)2.aspx"><i class="icon icon-eye-open"></i></a>
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
                            <a href="knowledge_line(1)3.aspx"><i class="icon icon-eye-open"></i></a>
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
                            <a href="knowledge_line(1)4.aspx"><i class="icon icon-eye-open"></i></a>
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
                            <a href="knowledge_line(1)5.aspx"><i class="icon icon-eye-open"></i></a>
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
