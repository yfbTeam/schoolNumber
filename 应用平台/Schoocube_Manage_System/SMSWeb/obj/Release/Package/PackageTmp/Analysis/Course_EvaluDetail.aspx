<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_EvaluDetail.aspx.cs" Inherits="SMSWeb.Analysis.Course_EvaluDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>课程评价详情</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/echarts.js"></script>
    <script src="/Scripts/PageBar.js"></script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                       <div id="div_CourseEvalue" style="float:left; width: 100%; height: 330px;"></div>                       
                </div>
                <div id="div_stuContent" class="course_learned fr bordshadrad pr" style="display:none;">                
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
            CourseEvalueDetail(1,10);
        });
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('div_CourseEvalue'));

        // 指定图表的配置项和数据
        option = {
            title: {
                text: UrlDate.CourseName + '-评价详情',
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
                data: ['5分', '4分', '3分', '2分','1分']
            },
            series: [
                {
                    name: UrlDate.CourseName + '-评价详情',
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
        function CourseEvalueDetail(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;

            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/CourseManage/CourceManage.ashx",
                    Func: "OneCourse_EvalueStatist",
                    ID: UrlDate.ID,
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        myChart.setOption({ //加载数据图表
                            legend: {
                                data: ['5分', '4分', '3分', '2分', '1分']
                            },
                            series: [{
                                data: json.result.retData
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
        
    </script>
</body>
</html>
