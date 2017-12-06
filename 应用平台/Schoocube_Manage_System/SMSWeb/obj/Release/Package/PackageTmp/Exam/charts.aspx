<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="charts.aspx.cs" Inherits="SMSWeb.Exam.charts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>试卷管理</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    //<script src="../Scripts/echarts.js"></script>
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../CourseMenu.js"></script>

    <style>
</style>
</head>
<body>
    <div>
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

        <input type="hidden" id="hName" runat="server" />
        <input type="hidden" id="hSF" runat="server" />
        <input type="hidden" id="hClassID" runat="server" />
        <input id="HStatus" type="hidden" value="0" />
        <input id="nohIDCard" type="hidden" value="0" />
        <input id="hIDCard" type="hidden" runat="server" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../HZ_Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                         <img src="/images/testsystem.png" /></div>
                <nav id="teacher" class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                        <%-- <li currentclass="active"><a href="ExamQManager.aspx">题库管理</a></li>
                            <li currentclass="active"><a href="ExamManager.aspx">试卷管理</a></li>
                            <li currentclass="active"><a href="MyExam.aspx">我的试卷</a></li>
                            <li currentclass="active"><a href="charts.aspx">分析统计</a></li>--%>
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
        <div class="onlinetest_item width pt90 pr">
            <div style="padding: 10px; background: #fff;" class="bordshadrad clearfix">
                <div id="main1" style="width: 1160px; height: 500px;"></div>
            </div>
        </div>
</body>
</html>
<script src="../js/common.js"></script>
<script type="text/javascript">

    var name = "";
    var val = "";
    $(document).ready(function () {
        CourceMenu();
        getExamPaper();
        //echers();
        //chaxun(0,1);
    })
    function getExamPaper() {
        var html = "";
        var namee = $("#hIDCard").val();
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxunscore", "hCreateUID": namee
            },
            success: function (json) {
                val += "[";
                name += "[";
                html += "<table>";
                $.each(json.result.retData, function () {
                    val += this.Score + ",";
                    name += "'" + this.UserName + this.Title + "'";
                    name += ",";
                    html += "<tr><td>" + this.Title + "</td><td>" + this.Score + "</td></tr>";
                })
                html += "</table>";
                //$("#main2").html(html);
                val = val.substr(0, val.length - 1);
                val += "]";
                name = name.substr(0, name.length - 1);
                name += "]";
                var myChart = echarts.init(document.getElementById('main1'));
                option2 = {
                    title: {
                        text: '考试成绩',
                        // subtext: '纯属虚构',
                        x: 'center'
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : {c} "
                    },
                    calculable: true,
                    xAxis: [
                        {
                            type: 'category',
                            data: eval(name)
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value',
                            name: '分数',
                            axisLabel: {
                                formatter: '{value} 分数'
                            }
                        },

                    ],
                    series: [


                        {
                            name: '考试分数',
                            type: 'bar',
                            data: eval(val)
                        },
                      {
                          name: '考试分数',
                          type: 'line',
                          data: eval(val)
                      }

                    ]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option2);
            }

        });

    }
</script>

