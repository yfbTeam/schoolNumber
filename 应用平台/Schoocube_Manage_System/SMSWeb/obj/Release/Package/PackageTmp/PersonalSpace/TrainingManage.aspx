<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrainingManage.aspx.cs" Inherits="SMSWeb.PersonalSpace.TrainingManage" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>档案管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <%--<script type="text/javascript" src="../js/menu_top.js"></script>--%>
    <script type="text/javascript" src="../Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="../Scripts/echarts-all.js"></script>
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
            <td>
                <span class="enable_wrap">{{if Status == 0}}
                    <a href="javascript:void(0);;" onclick="ChangeStatus(${ID},'0')" class="enable">启用</a>
                    <a href="javascript:void(0);;" onclick="ChangeStatus(${ID},'1')">归档</a>
                    {{else}}
                    <a href="javascript:void(0);;" onclick="ChangeStatus(${ID},'0')">启用</a>
                    <a href="javascript:void(0);;" onclick="ChangeStatus(${ID},'1')" class="disable">归档</a>
                    {{/if}}
                </span>
            </td>
            <td><a onclick="MyDocDetail('${IDCart}')" style="cursor: pointer;">详情</a>&nbsp;
                <a onclick="MyDocUpdate('${IDCart}')" style="cursor: pointer;">修改</a></td>
        </tr>
    </script>
    <script id="trTran" type="text/x-jquery-tmpl">
        <tr>
            <td>${GroupName}</td>
            <td>${TrainName}</td>
            <td>${DateTimeConvert(BeginTime, 'yyyy-MM-dd')}</td>
            <td>${DateTimeConvert(EndTime, 'yyyy-MM-dd')}</td>
            <td>${ClassHour}</td>
            <td>${TrainMan}</td>
            <td>￥${TrainFee}</td>
            <td>${TrainResult}</td>
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
                <a class="logo fl" href="../HZ_Index.aspx">
                    <img src="../images/logo.png" /></a>
                <%--<div class="wenzi_tips fl">
                    <img src="../images/danganguanli.png" />
                </div><div class="coursesystem  fl"></div>--%>
                <nav class="navbar menu_mid fl">

                    <ul id="CourceMenu">
                        <li><a>学员档案</a></li>
                        <li class="active" id="0"><a href="#" onclick="ChangeType(0)">个人档案</a></li>
                        <li id="1"><a href="#" onclick="ChangeType(1)">培训档案</a></li>
                        <%--<li><a href="Course_SelManag.aspx">选课管理</a></li>--%>
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
                <%--<div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on">个人档案</a>
                        <a href="javascript:;">培训档案</a>

                    </div>
                </div>--%>

                <div class="spacecenter">

                    <div class="wrap">
                        <div class="newcourse_select clearfix">
                            <div class="fl" style="margin-top: 5px;">
                                <label style="float: left; line-height: 38px; display: block;">图表类型：</label>
                                <select class="select" id="select_type1">
                                    <option value="1" selected>3D</option>
                                    <option value="2">2D</option>
                                </select>
                            </div>
                            <div class="stytem_select_right fr" style="height: auto;">
                                <%-- <div onclick="$('#uploadify').click();" style="border-radius: 2px; background: #1472b9; top: 138px; width: 90px; height: 30px; text-align: center; right: 130px; color: rgb(255, 255, 255); font-size: 12px; display: block; z-index: 2; cursor: pointer;" class="un_reposity">

                                    <input name="uploadify" id="uploadify" style="display: none;" type="file" multiple="multiple">
                                </div>
                                <style>
                                    .un_reposity .uploadify-button {
                                        border: none;
                                        background: #1472b9;
                                        font-size: 14px;
                                        color: #fff;
                                        height: 30px;
                                        border-radius: 2px;
                                    }
                                </style>--%>
                                <a onclick="UpdateDoc()" id="icon-plus" href="jsvascript:;">更新个人档案                            
                                </a>
                            </div>
                        </div>
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
                                <th>状态</th>
                                <th>操作</th>
                            </thead>
                            <tbody id="tb_MyDoc">
                            </tbody>
                        </table>
                        <div class="page" id="page1">
                            <span id="pageBar"></span>
                        </div>
                        <div id="divPieChart1" align="center" style="width: 1000px; height: 600px; margin: 0 auto;"></div>
                    </div>
                    <div class="wrap none">
                        <div class="newcourse_select clearfix">
                            <div class="fl" style="margin-top: 5px;">
                                <label style="float: left; line-height: 38px; display: block;">图表类型：</label>
                                <select class="select" id="select_type2">
                                    <option value="1" selected>3D</option>
                                    <option value="2">2D</option>
                                </select>
                            </div>
                            <div class="stytem_select_right fr" style="height: auto;">
                                <%-- <div onclick="$('#uploadify').click();" style="border-radius: 2px; background: #1472b9; top: 138px; width: 90px; height: 30px; text-align: center; right: 130px; color: rgb(255, 255, 255); font-size: 12px; display: block; z-index: 2; cursor: pointer;" class="un_reposity">

                            <input name="uploadify" id="uploadify" style="display: none;" type="file" multiple="multiple">
                        </div>
                        <style>
                            .un_reposity .uploadify-button {
                                border: none;
                                background: #1472b9;
                                font-size: 14px;
                                color: #fff;
                                height: 30px;
                                border-radius: 2px;
                            }
                        </style>--%>
                                <%--<a onclick="UpdateDoc()" id="icon-plus" href="jsvascript:;">
                            更新培训档案                            
                        </a>--%>
                            </div>
                        </div>
                        <table class="mt10">
                            <thead>
                                <th>机构名称</th>
                                <th>培训名称</th>
                                <th>开始时间</th>
                                <th>结束时间</th>
                                <th>培训学时</th>
                                <th>授课人</th>
                                <th>培训费用</th>
                                <th>培训结果</th>
                            </thead>
                            <tbody id="tbTran">
                            </tbody>
                        </table>
                        <div class="page" id="page2">
                            <span id="pageBar1"></span>
                        </div>
                        <div id="divPieChart2" align="center" style="width: 1000px; height: 600px; margin: 0 auto;"></div>
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
<script type="text/javascript" src="../js/common.js"></script>
<script>
    function initChart1() {
        var xml1 = "<graph  caption='参加工作时间汇总' formatNumberScale='0' numberSuffix='元'>"
                + "<categories >"
                + "<category name='2014/07/14' />"
                    + "<category name='2012/01/01' />"
                + "</categories>"
                + "<dataset seriesName='王小明' color='1D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='4000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='方晓' color='2D6741' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='5000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='林彤' color='3Dh3D1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='4500' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='郝旭' color='4D6781' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='4300' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='唐叶' color='5D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='4200' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='袁熙' color='6D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='4100' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='左义' color='9D6tD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='4000' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='王丽' color='8D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='5400' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='石琳' color='9D33D1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='5600' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='张琳' color='178sD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='3300' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='胡歌' color='1D8sD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='3800' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='张红' color='1D8Bl1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='3900' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='谢章峰' color='1g8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='4600' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='赵灵可' color='2D8mD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='4800' />"
                        + "<set value='' />"
                + "</dataset>"
                + "<dataset seriesName='罗秋香' color='8D8Bh1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                        + "<set value='' />"
                        + "<set value='3400' />"
                + "</dataset>"
                 + "</graph>";
        var myChart = new FusionCharts("../FusionCharts/Swf/MSColumnLine3D.swf", "myChartId_03", '1000', "600");
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
                    text: '参加工作时间汇总',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis'
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: ['2014/07/14', '2012/01/01']
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
                       name: '王小明',
                       type: 'bar',
                       data: ['4000', ''],
                   },
					{
					    name: '方晓',
					    type: 'bar',
					    data: ['5000', ''],
					},
                    {
                        name: '林彤',
                        type: 'bar',
                        data: ['4500', ''],
                    },
                    {
                        name: '郝旭',
                        type: 'bar',
                        data: ['4300', ''],
                    },
                    {
                        name: '唐叶',
                        type: 'bar',
                        data: ['4200', ''],
                    },
                    {
                        name: '袁熙',
                        type: 'bar',
                        data: ['4100', ''],
                    },
                    {
                        name: '左义',
                        type: 'bar',
                        data: ['4000', ''],
                    },
                    {
                        name: '王丽',
                        type: 'bar',
                        data: ['5400', ''],
                    },
                    {
                        name: '石琳',
                        type: 'bar',
                        data: ['5600', ''],
                    },
                    {
                        name: '张琳',
                        type: 'bar',
                        data: ['3300', ''],
                    },
                    {
                        name: '胡歌',
                        type: 'bar',
                        data: ['3800', ''],
                    },
                    {
                        name: '张红',
                        type: 'bar',
                        data: ['3900', ''],
                    },
                    {
                        name: '谢章峰',
                        type: 'bar',
                        data: ['4600', ''],
                    },
                    {
                        name: '赵灵可',
                        type: 'bar',
                        data: ['4800', ''],
                    },
                    {
                        name: '罗秋香',
                        type: 'bar',
                        data: ['', '3400'],
                    }

                ]
            };
            myChart.setOption(option1);
        }
    })
    function initChart2() {
        var xml2 = "<graph  formatNumberScale='0' numberSuffix='元' caption='培训档案汇总'>"
                + "<categories >"
                + "<category name='2014/01/01-2014/03/01' />"
                + "</categories>"
                + "<dataset seriesName='前端中级开发工程师' color='1D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='5000' />"
                 + "</dataset>"
                 + "<dataset seriesName='Java中级开发工程师' color='1DhBD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
                 + "<set value='5000' />"
                 + "</dataset>"
                + "<dataset seriesName='.net中级开发工程师' color='F1683C' anchorBorderColor='F1683C' anchorBgColor='F1683C'>"
                + "<set value='5000' />"
                + "</dataset></graph>";
        var myChart = new FusionCharts("../FusionCharts/Swf/MSColumnLine3D.swf", "myChartId_02", '1000', "600");
        myChart.setDataXML(xml2);
        myChart.render("divPieChart2");
    }
    initChart2();
    $('#select_type2').change(function () {
        var val = $(this).val();
        if (val == 1) {
            initChart2();
        } else if (val == 2) {
            var myChart = echarts.init(document.getElementById('divPieChart2'));
            option2 = {
                title: {
                    text: '参加工作时间汇总',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis'
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: ['2014/01/01-2014/03/01']
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
                       name: '前端中级开发工程师',
                       type: 'bar',
                       data: ['5000'],
                   },
					{
					    name: 'Java中级开发工程师',
					    type: 'bar',
					    data: ['5000'],
					},
                    {
                        name: '.net中级开发工程师',
                        type: 'bar',
                        data: ['5000'],
                    },


                ]
            };
            myChart.setOption(option2);
        }
    })
</script>
<script type="text/javascript">
    $(function () {
        $('.stytem_select_left a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            $('.spacecenter .wrap').eq(n).show().siblings().hide();
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
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
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
                    var html = '<tr><td colspan="1000"><div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
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
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
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
    //个人档案归档
    function ChangeStatus(id, Status) {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: {
                PageName: "/Certificate/Certificate.ashx",
                Func: "EditDoc",
                EditID: id,
                Status: Status
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    layer.msg("状态修改成功");
                    getMyDoc(1, 10);
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
