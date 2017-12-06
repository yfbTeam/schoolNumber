<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_WorkStatistics.aspx.cs" Inherits="SMSWeb.OnlineLearning.Course_WorkStatistics" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>作业统计</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/echarts.js"></script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                       <div id="div_work" style="float:left; width: 40%; height: 400px;"></div>                       
                </div>
                <div id="div_stuContent" class="course_learned fr bordshadrad pr" style="display:none;width:500px;">                
                <p class="learned_title"></p>
                <div class="class_selectwrap">
                    <ul class="class_select" id="ul_stuContent"></ul>
                </div>
               </div>
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
            GetWorkStatisticsInfo();
        });
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('div_work'));
        // 指定图表的配置项和数据
        option = {
            title: {
                text: decodeURIComponent(UrlDate.workname) + '-作业统计',
                subtext: '',
                x: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['优', '良', '中', '差', '未批改作业', '未提交作业']
            },
            series: [
                {
                    name: decodeURIComponent(UrlDate.workname) + '-作业统计',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: [

                    ],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        //绑定数据
        function GetWorkStatisticsInfo() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func: "GetWorkStatisticsInfo",
                    WorkId: UrlDate.workid,
                    CourseID: UrlDate.courseid,
                    CourseType: UrlDate.coursetype
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        myChart.setOption({ //加载数据图表
                            legend: { data: ['优', '良', '中', '差', '未批改作业', '未提交作业'] },
                            series: [{
                                data:json.result.retData
                            }]
                        });
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        myChart.on('click', function (params) {
            $('#ul_stuContent').html('');
            var status = GetScoreStatus(params.name);
            $('.learned_title').html(params.name + "的学生");
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func: "GetStuWorkCompleteInfo",
                    WorkId: UrlDate.workid,
                    ScoreStatus: status,
                    CourseID:UrlDate.courseid,
                    CourseType: UrlDate.coursetype
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {                        
                        var gradeArray = [], classArray = [];
                        $(json.result.retData).each(function () {
                            if (gradeArray.indexOf(this.GradeID) == -1) {
                                gradeArray.push(this.GradeID);
                                if (gradeArray.length == 1) {
                                    $("#ul_stuContent").append("<li><span>" + this.GradeName + "<i class='icon  icon-angle-down'></i></span><ul style='display: block;' id=\"ul_grade_" + this.GradeID + "\"></ul></li>");
                                } else {
                                    $("#ul_stuContent").append("<li><span>" + this.GradeName + "<i class='icon  icon-angle-up'></i></span><ul id=\"ul_grade_" + this.GradeID + "\"></ul></li>");
                                }
                            }
                            if (classArray.indexOf(this.ClassID) == -1) {
                                classArray.push(this.ClassID);
                                if (classArray.length == 1) {
                                    $("#ul_grade_" + this.GradeID).append("<li><span class='active'>" + this.ClassName + "<i class='icon  icon-angle-down'></i></span><ul id=\"ul_class_" + this.ClassID + "\" class='learned_students_lists clearfix' style='display: block;'></ul></li>");
                                } else {
                                    $("#ul_grade_" + this.GradeID).append("<li><span>" + this.ClassName + "<i class='icon  icon-angle-up'></i></span><ul id=\"ul_class_" + this.ClassID + "\" class='learned_students_lists clearfix'></ul></li>");
                                }
                            }
                            $("#ul_class_" + this.ClassID).append("<li><div class='learned_students_img'><img src=\"" + this.PhotoURL + "\" alt='' onerror=\"javascript:this.src='/images/discuss_img_01.jpg'\"/></div><p class='learned_students_name'>" + this.Name + "</p></li>");
                        });
                        GradeOrClassExpand();                                          
                    }
                    else {
                        $('#ul_stuContent').html("<li><span>无"+params.name + "的学生</span></li>");
                    }
                    layer.open({
                        type: 1,
                        shade: false,
                        title: false, //不显示标题
                        content: $('#div_stuContent'), //捕获的元素
                        area: ['532px', 'auto'],
                        cancel: function (index) {
                            layer.close(index);
                        }
                    });
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        });
        function GetScoreStatus(name) {
            var status = 0;
            switch (name) {
                case "未提交作业":
                    status = 0;
                    break;
                case "优":
                    status = 1;
                    break;
                case "良":
                    status = 2;
                    break;
                case "中":
                    status = 3;
                    break;
                case "差":
                    status = 4;
                    break;
                case "未批改作业":
                    status = 5;
                    break;
            }
            return status;
        }
        function GradeOrClassExpand() {
            //年级班级筛选
            $('.class_select').find('li:has(ul)').children('span').click(function () {
                $('.class_select').find('li:has(ul)').children('span').removeClass('active');
                $(this).addClass('active');
                var $icon = $(this).children('.icon');
                var $next = $(this).next('ul');
                if ($next.is(':hidden')) {
                    $next.stop().slideDown();
                    $icon.addClass('icon-angle-down').removeClass('icon-angle-up');
                    if ($(this).parent('li').siblings('li').children('ul').is(':visible')) {
                        $(this).parent("li").siblings("li").find("ul").slideUp();
                    }
                } else {
                    $next.slideUp();
                    $icon.addClass('icon-angle-up').removeClass('icon-angle-down');
                }
            });
        }
    </script>
</body>
</html>
