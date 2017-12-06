<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecommendedStu.aspx.cs" Inherits="SMSWeb.Recommended.RecommendedStu" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <!--图标样式-->
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" href="../css/repository.css" />
    <link rel="stylesheet" href="../css/plan.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
            <script src="../js/html5.js"></script>
        <![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../Scripts/Common.js"></script>
    <style>
        .Postadd {
            display: block;
            float: right;
            background: #96cc66;
            height: 30px;
            width: 20px;
        }

            .Postadd i {
                color: #fff;
            }

        .more_info {
            display: none;
            left: -56px;
            position: absolute;
            top: 20px;
            z-index: 200;
        }

            .more_info ul.info {
                width: 300px;
                background: #fff;
                border-collapse: collapse;
            }

                .more_info ul.info li {
                    border: 1px solid #abd0f5;
                    background: #fff;
                    height: 28px;
                    line-height: 28px;
                    width: 98px;
                    float: left;
                    font-size: 14px;
                }
    </style>
    <script type="text/x-jquery-tmpl" id="Answer_tr">
        <tr>
            <td>${EnName}</td>
            <td>${JobName}</td>
            <td>${CreateTime}</td>

        </tr>
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

    <input type="hidden" id="Sort" value="0" />
    <input type="hidden" id="HClassID" value="<%=ClassID %>" />
    <input type="hidden" id="HUserID" value="<%=IDCard %>" />

    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/PersonalSpace/Learning_center_portal.aspx">
                <img src="../images/logo.png" /></a>

            <nav class="navbar menu_mid fl">
                <ul>
                      <li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                        <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                        <li currentclass="active"><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                        <li currentclass="active"><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
                        <li currentclass="active"><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                        <li  currentclass="active"><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                        <li currentclass="active"><a href="/analysisa/student_studyprocess(4).html">个人学习进度</a></li>

                </ul>
            </nav>
            <div class="search_account fr clearfix">
                <ul class="account_area fl">
                    <li>
                        <a href="" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">3</span>
                        </a>
                    </li>
                    <li>
                        <a href="" class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %>
                            </h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr">
                    <a href="javascript::">
                        <i class="icon icon-cog"></i>
                    </a>
                     <div class="setting_none">
                         <a href="/Gopay/Gopay.aspx" target="_blank"><span>账户管理</span></a>
                        <a href="/PersonalSpace/PersonalSpace_Student.aspx" target="_blank"><span >个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!--time-->
    <div class="time_wrap pt90 width clearfix">
        <!---->
        <div class=" bordshadrad" style="background: #FFF; padding: 20px;min-height:730px;margin-bottom:20px;">
            <div class="stytem_select clearfix">
                <div class="stytem_select_left fl">
                    <a href="javascript:;" class="on" onclick="SortType('0',this)" id="Type0">全部岗位</a>
                    <a href="javascript:;" onclick="SortType('1',this)" id="Type1">推荐岗位</a>
                    <a href="JobLibrary.aspx">问答动态</a>
                </div>
            </div>
            <div class="stytem_select">
                <div class="stytem_select_right fl">

                    <div class="search_exam fl pr ml10">
                        <input type="text" name="" id="JobName" value="" placeholder="请输入岗位">
                        <i class="icon  icon-search" onclick="BindData(1,10)"></i>
                    </div>

                </div>
            </div>
            <div class="time_base">
                <table class="table_wrap mt10">
                    <thead class="thead">
                        <th>企业名称</th>
                        <th>岗位名称</th>
                        <th>创建时间</th>

                    </thead>
                    <tbody class="tbody" id="Answer_td">
                    </tbody>
                </table>
            </div>
            <div class="page">
                <div id="pageBar"></div>
            </div>
        </div>
    </div>
    <footer>
        <div class="footer width clearfix">
            <div class="logo fl">
                <img src="/images/footer_logo.png" alt="" style="margin-top:10px;"/>
            </div>
            <div class="footer_right fr">
                <p>地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                <p>
                      传真：010-62463259   网址：<a
                        href="http://www.bjybjx.cn" target="_blank" style="color: #fff;">http://www.bjybjx.cn</a>
                </p>
                <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
            </div>
        </div>
    </footer>
    <script src="../js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            if (UrlDate.Type != null && UrlDate.Type == "1") {
                $("#Type1").addClass("on").siblings().removeClass("on");
                $("#Sort").val("1");
            }
            BindData(1, 10);
            $('.tbody tr td.Post').find('.Postname').hover(function () {
                $(this).find('.more_info').show();
            }, function () {
                $(this).find('.more_info').hide();
            })
        })
        function SortType(sort, em) {
            $(em).addClass("on").siblings().removeClass("on");
            $("#Sort").val(sort);
            BindData(1, 10);
        }
        function BindData(PageIndex, pageSize) {
            $.ajax({
                type: "post",
                url: "/Common.ashx",
                data: {
                    "PageName": "/Recommended/Recommended.ashx", Func: "RecommendJob", PageIndex: PageIndex,
                    pageSize: pageSize, JobName: $("#JobName").val(), Sort: $("#Sort").val(), StuNo: $("#HUserID").val(), ClassID: $("#HUserID").val()
                },
                dataType: "json",
                success: function (json) {

                    if (json.result.errNum.toString() == "0") {
                        $(".page").show();

                        $("#Answer_td").html('');
                        $("#Answer_tr").tmpl(json.result.retData.PagedData).appendTo("#Answer_td");
                        makePageBar(BindData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                    else {
                        $("#Answer_td").html('');
                        $(".page").hide();
                    }
                },
                error: function (errMsg) {
                    alert('数据加载失败！');
                }
            });
        }
    </script>
</body>
</html>
