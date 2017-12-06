<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="common_question2.aspx.cs" Inherits="SMSWeb.analysisa.common_question2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>《MySQL入门》常见问题</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="/css/common.css"/>

    <link rel="stylesheet" type="text/css" href="/css/repository.css"/>
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css"/>
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
    <script src="/js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script type="text/javascript" src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="/Scripts/echarts-all.js"></script>
    <link rel="stylesheet" href="/css/Css.css">
    <script src="/js/jquery.kkPages.js"></script>
     <script src="/Scripts/tableExport/tableExport.js"></script>
    <script src="/Scripts/tableExport/jquery.base64.js"></script>
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
          .wrap table tbody tr td{text-align:left;text-indent:20px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" />
            </a>
            <div class="wenzi_tips fl">
                <img src="/images/zuoyepigai.png" />
            </div>
            <nav id="teacher" class="navbar menu_mid fl">
                <ul>
                    <li currentclass="active"> <a href="work_quality.aspx">作业整体质量</a></li>
                    <li currentclass="active" ><a href="knowledge_line.aspx">知识点掌握程度</a></li>
                     <li currentclass="active" class="active"><a href="common_question.aspx">常见问题</a></li>
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
        <div class="stytem_select clearfix">
           
            <div class="stytem_select_right fr">
                <a href="common_question.aspx">
                    <i class="icon icon-reply"></i>
                    <span>返回上级</span>
                </a>
            </div>
        </div>
        <div class="wrap">
            <div class="distributed fr">
                    <a href="javascript:void(0);" onclick="$('#table').tableExport({ type: 'excel', escape: 'true'});">备份数据</a>
                </div>
            <table id="table">
                <caption style="line-height: 40px;text-align:center;font-weight: bold;">《MySQL入门》常见问题</caption>
                <tbody>
                   <tr>
                       <td>解释一下python的 and-or 语法</td>
                   </tr>
                   <tr>
                       <td>Python里面如何拷贝一个对象？</td>
                   </tr>
                     <tr>
                       <td>什么是lambda函数？它有什么好处?</td>
                   </tr>
                     <tr>
                       <td>python中如何判断对象相等</td>
                   </tr>
                     <tr>
                       <td>请写出一段Python代码实现删除一个list里面的重复元素</td>
                   </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
    <script src="/js/common.js"></script>
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
