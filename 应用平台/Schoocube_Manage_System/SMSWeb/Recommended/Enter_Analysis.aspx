<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Enter_Analysis.aspx.cs" Inherits="SMSWeb.Recommended.Enter_Analysis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <title>就业信息统计</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script type="text/javascript" src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="/Scripts/echarts-all.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }

        .enable_wrap {
            border-radius: 12px;
            background: #dcdcdc;
            font-size: 14px;
            display: inline-block;
            height: 26px;
            color: #fff;
            vertical-align: middle;
            line-height: 26px;
        }

        .wrap table tbody tr td .enable_wrap a {
            width: 40px;
            color: #fff;
            font-size: 14px;
            display: block;
            float: left;
            border-radius: 12px;
            height: 26px;
            margin: 0;
            padding: 0;
            background: none;
        }

            .wrap table tbody tr td .enable_wrap a.enable {
                background: #00B400;
            }

            .wrap table tbody tr td .enable_wrap a.disable {
                background: #D84926;
            }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_MyDoc" type="text/x-jquery-tmpl">
        <tr>
            <td>${Name}</td>
            <td>${Sex}</td>
            <td>${IDCart}</td>
            <td>${Origion}</td>
            <td>${PoliticalStatus}</td>
            <td>${HalfEdudate}</td>
            <td>${Major}</td>
            <td>${JobTime}</td>
            <td>￥${salary}
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

        <input id="option" type="hidden" value=">" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/HZ_Index.aspx">
                    <img src="/images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="/images/tuijianjiuye.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                        <li currentclass="active"><a href="EnterManage.aspx">推荐就业</a></li>
                        <li currentclass="active"><a href="Enter_Analysis.aspx">就业信息统计</a></li>
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
                
                <div class="spacecenter">

                    <div class="wrap">
                        <table class="mt10">
                            <thead>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>身份证号</th>
                                <th>籍贯</th>
                                <th>政治面貌</th>
                                <th>文化程度</th>
                                <th>所学专业</th>
                                <th>参加工作时间</th>
                                <th>就业薪资</th>
                            </thead>
                            <tbody id="tb_MyDoc">
                            </tbody>
                        </table>
                        <div class="page" id="page1">
                            <span id="pageBar"></span>
                        </div>
                        <div class="charts">
                            <div>
                                <div class="clearfix" style="margin-top: 5px;">
                                    <label style="float: left; line-height: 38px; display: block;">图表类型：</label>
                                    <select class="select" id="select_type1">
                                        <option value="1" selected>3D</option>
                                        <option value="2">2D</option>
                                    </select>
                                </div>
                                <div id="divPieChart1" align="center" style="width: 1000px; height: 600px; margin: 0 auto;"></div>
                            </div>
                        </div>
                    </div>
                   
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar2"></span>
        </div>
    </form>
</body>
    <script type="text/javascript" src="/js/common.js"></script>
<script>
    function initChart1() {
        var xml1 = "<graph  caption='就业信息统计' formatNumberScale='0' numberSuffix='元'>"
                + "<categories >"
                 + "<category name='2016/08/03' />"
                + "<category name='2016/07/14' />"
                + "<category name='2013/03/02' />"
                + "</categories>"
                + "<dataset seriesName='蓝颜依' color='1D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='5500' />"
                        + "<set value='' />"
                         + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='王小明' color='1D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                + "<set value='' />"
                        + "<set value='6500' />"
                        + "<set value='' />"
                + "</dataset>"
                 + "<dataset seriesName='方晓' color='1D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='' />"
                        + "<set value='7500' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='林彤' color='1D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                + "<set value='' />"
                        + "<set value='1000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='郝旭' color='4D6781' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='' />"
                        + "<set value='2000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='唐叶' color='5D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                         + "<set value='' />"
                        + "<set value='4000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='袁熙' color='6D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='' />"
                        + "<set value='8000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='左义' color='9D6tD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='' />"
                        + "<set value='6000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='王丽' color='8D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='' />"
                        + "<set value='5000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='韩寒' color='9D33D1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='' />"
                        + "<set value='8000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='石琳' color='9D33D1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='' />"
                        + "<set value='9000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='张琳' color='178sD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='' />"
                        + "<set value='1000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='胡歌' color='1D8sD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='' />"
                        + "<set value='10000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='张红' color='1D8Bl1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='' />"
                        + "<set value='5000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='谢章峰' color='1g8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='' />"
                        + "<set value='6000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='赵灵可' color='2D8mD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='' />"
                        + "<set value='4000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='罗秋香' color='2D8mD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                + "<set value='' />"
                 + "<set value='' />"
                        + "<set value='4000' />"
                + "</dataset>"
                 + "</graph>";
        var myChart = new FusionCharts("/FusionCharts/Swf/MSColumnLine3D.swf", "myChartId_03", '1000', "600");
        myChart.setDataXML(xml1);
        myChart.render("divPieChart1");
    }
    initChart1();
    $('#select_type1').change(function () {
        var val = $(this).val();
        if (val == 1) {
            initChart1();
        } else if (val == 2) {
            var myChart = echarts.init(document.getElementById('divPieChart1'));
            option1 = {
                title: {
                    text: '就业信息统计',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis'
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: ['2016/08/03', '2014/07/14','2012/03/02']
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        axisLabel: {
                            formatter: '{value} 元'
                        }
                    }
                ],
                series: [
                    {
                        name: '蓝颜依',
                        type: 'bar',
                        data: ['5500', '',''],
                    },
                    {
                        name: '王小明',
                        type: 'bar',
                        data: ['', '6500', ''],
                    },
                    {
                        name: '方晓',
                        type: 'bar',
                        data: ['', '7500', ''],
                    },
                    {
                        name: '林彤',
                        type: 'bar',
                        data: ['', '1000', ''],
                    },
                    {
                        name: '郝旭',
                        type: 'bar',
                        data: ['','2000', ''],
                    },
                    {
                        name: '唐叶',
                        type: 'bar',
                        data: ['','4000', ''],
                    },
                    {
                        name: '袁熙',
                        type: 'bar',
                        data: ['','8000', ''],
                    },
                    {
                        name: '左义',
                        type: 'bar',
                        data: ['','6000', ''],
                    },
                    {
                        name: '王丽',
                        type: 'bar',
                        data: ['','5000', ''],
                    },
                    {
                        name: '韩寒',
                        type: 'bar',
                        data: ['','8000', ''],
                    },
                    {
                        name: '石琳',
                        type: 'bar',
                        data: ['','9000', ''],
                    },
                    {
                        name: '张琳',
                        type: 'bar',
                        data: ['','1000', ''],
                    },
                    {
                        name: '胡歌',
                        type: 'bar',
                        data: ['','10000', ''],
                    },
                    {
                        name: '张红',
                        type: 'bar',
                        data: ['','5000', ''],
                    },
                    {
                        name: '谢章峰',
                        type: 'bar',
                        data: ['','6000', ''],
                    },
                    {
                        name: '赵灵可',
                        type: 'bar',
                        data: ['','4000', ''],
                    },
                    {
                        name: '罗秋香',
                        type: 'bar',
                        data: ['', '', '5000'],
                    },
                ]
            };
            myChart.setOption(option1);
        }
    })
</script>
<script type="text/javascript">
    $(function () {
        $('.stytem_select_left a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            $('.charts>div').eq(n).show().siblings().hide();
        })
        getMyDoc(1, 10);
        GetTrainDoc(1, 10);
    })
    function ChangeType(n) {
        $('.spacecenter .wrap').eq(n).show().siblings().hide();
        $("#" + n).addClass("active").siblings().removeClass("active");
    }
    //根据基础数据增加个人档案
    function UpdateDoc() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: {
                PageName: "/Certificate/Certificate.ashx",
                Func: "AddDocList"
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    layer.msg("数据更新成功");
                    getMyDoc(1, 10);
                }
                else {
                    layer.msg("数据更新失败");
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }

    //获取数据
    function getMyDoc(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            dataType: "json",
            data: {
                PageName: "/Certificate/Certificate.ashx",
                Func: "PersonDocument",
                Ispage: true,
                PageIndex: startIndex,
                pageSize: pageSize,
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#page1").show();
                    $("#tb_MyDoc").html('');
                    $("#tr_MyDoc").tmpl(json.result.retData.PagedData).appendTo("#tb_MyDoc");
                    makePageBar(getMyDoc, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                }
                else {
                    $("#page1").hide();
                    var html = '<tr><td colspan="1000"><div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_MyDoc").html(html);
                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                $("#page1").hide();
                layer.msg(errMsg);
            }
        });
    }

    function MyDocDetail(IDCard) {
        OpenIFrameWindow('个人档案详情', 'MyDocDetail.aspx?IDCard=' + IDCard, '800px', '90%');
    };
    function MyDocUpdate(IDCard) {
        OpenIFrameWindow('个人档案修改', 'MyDocEdit.aspx?IDCard=' + IDCard, '800px', '90%');
    };
    function GetTrainDoc(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $("#tbTran").html("");
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: {
                PageName: "/CourseManage/PersonSpaceStu.ashx",
                Func: "GetPageList",
                Ispage: true,
                PageIndex: startIndex,
                pageSize: pageSize,

            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#page2").show();
                    var data = json.result.retData.PagedData;
                    $("#trTran").tmpl(data).appendTo("#tbTran");
                    makePageBar(GetTrainDoc, document.getElementById("pageBar1"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);

                }
                else {
                    $("#page2").hide();
                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                $("#page2").hide();
                layer.msg(errMsg);
            }
        });


    }
    //档案归档
    function ChangeStatus(id, Status, TableName) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: { PageName: "/Certificate/Certificate.ashx", Func: "EditDoc", EditID: id, Status: Status, TableName: TableName },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    layer.msg("状态修改成功");
                    if (TableName == "PersonDocument") {
                        getMyDoc(1, 10);
                    }
                    else {
                        GetTrainDoc(1, 10);
                    }
                }
                else {
                    layer.msg("状态修改失败");
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
</script>
</html>
