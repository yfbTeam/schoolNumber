<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JobLibrary.aspx.cs" Inherits="SMSWeb.Recommended.JobLibrary" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" href="../css/repository.css" />
    <link rel="stylesheet" href="../css/plan.css" />
    <link href="/Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <style type="text/css">
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle;
        }
    </style>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.exedit-3.5.js"></script>

    <script type="text/x-jquery-tmpl" id="Answer_tr">
        <tr>
            <td>${Name}</td>
            <td>${ask}</td>
            <td>${anwer}</td>
            <%--  <td>${StartTime}</td>
            <td>${EndTime}</td>
            <td>${CreateUID}</td>--%>
        </tr>
    </script>
    <style>
        .ztreea {
            padding-top: 15px;
        }

        .ztree {
            border: 1px solid #ccc;
            border-top: none;
        }

        .ztreea_left {
            width: 20%;
            float: left;
        }

            .ztreea_left h1 {
                background: #37A8E0;
                color: #fff;
                font-size: 16px;
                line-height: 34px;
                padding-left: 10px;
                font-weight: normal;
            }

        .ztreea_right {
            border: 1px solid #ccc;
            width: 75%;
            padding: 20px;
        }

        #addParent {
            width: 80px;
            height: 35px;
            background: #37A8E0;
            display: block;
            border-radius: 2px;
            text-align: center;
            color: #fff;
            font-size: 14px;
            line-height: 35px;
        }

        .course_form_div {
            margin: 10px 0px;
            height: 30px;
        }

            .course_form_div label {
                width: 75px;
                text-align: right;
                line-height: 30px;
                display: inline-block;
            }

            .course_form_div input[type=text] {
                width: 240px;
                height: 26px;
                border: none;
                border: 1px solid #ccc;
                border-radius: 2px;
                text-indent: 10px;
            }

            .course_form_div input[type=radio] {
                width: 15px;
                height: 15px;
                margin: 0px 10px;
            }

            .course_form_div .stars {
                color: red;
                margin-left: 10px;
            }

        .course_form_select {
            margin-left: 100px;
        }

            .course_form_select a {
                display: inline-block;
                width: 80px;
                height: 30px;
                background: #0488C9;
                border-radius: 2px;
                font-size: 14px;
                color: #fff;
                margin-top: 30px;
                cursor: pointer;
                text-align: center;
                line-height: 30px;
            }

        .add_res:hover {
            color: #fff;
        }
    </style>
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
    <input type="hidden" id="ID" />
    <input type="hidden" id="Pid" />
    <input type="hidden" id="Type" />
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/PersonalSpace/Learning_center_portal.aspx">
                <img src="../images/logo.png" /></a>


            <nav class="navbar menu_mid fl">
                <ul>
                    <li><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                    <li><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                    <li><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                    <li><a href="/Exam/MyExam.aspx">在线考试</a></li>
                    <li class="active"><a href="#">推荐就业</a></li>
                    <li><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                    <li><a href="/analysisa/student_studyprocess(4).html">个人学习进度</a></li>
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
                <div class="settings fl">
                    <a href="">
                        <i class="icon icon-cog"></i>
                    </a>
                </div>
            </div>
        </div>
    </header>
    <!--time-->
    <div class="time_wrap pt90 width clearfix">
        <!---->
        <div class=" bordshadrad" style="background: #FFF; padding: 20px;">
            <div class="stytem_select clearfix">
                <div class="stytem_select_left fl">
                    <a href="/Recommended/RecommendedStu.aspx?Type=0">全部岗位</a>
                    <a href="/Recommended/RecommendedStu.aspx?Type=1">推荐岗位</a>
                    <a href="javascript:;" class="on">问答动态</a>
                </div>
            </div>

            <div class="time_base">
                <div class="ztreea clearfix">
                    <div class="ztreea_left">
                        <h1>企业岗位信息</h1>
                        <ul id="treeEnter" class="ztree"></ul>
                    </div>
                    <div class="fr ztreea_right">
                        <div class="stytem_select">
                            <div class="stytem_select_right fl">
                                <div class="search_exam fl pr">
                                    <input type="text" placeholder="请输入问题" class="text" id="Question" />

                                    <a href="javascript:;" class="add_res" onclick="AddQuestion();">提交问题
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div style="background: #fff; margin-top: 10px;">
                            <div class="newcourse_dialog_detail">
                                <table class="table_wrap mt10">
                                    <thead class="thead">
                                        <th>岗位名称</th>
                                        <th>问题</th>
                                        <th>答案</th>
                                        <%--<th>提问时间</th>
                                        <th>回复时间</th>
                                        <th>回复人</th>--%>
                                    </thead>
                                    <tbody class="tbody" id="Answer_td">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="page">
                            <div id="pageBar"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/common.js"></script>
    <script>
        $(function () {
            $('.tbody tr td.Post').find('.Postname').hover(function () {
                $(this).find('.more_info').show();
            }, function () {
                $(this).find('.more_info').hide();
            })
        })
    </script>
    <script type="text/javascript">
        function AddQuestion() {
            var Question = $("#Question").val();

            if (Question.length > 0) {
                var ID = $("#ID").val();
                var Pid = $("#Pid").val();
                var Type = $("#Type").val();//1企业2岗位

                if (Type != "2") {
                    layer.msg("只能对岗位提问题！");
                }
                else {
                    $.ajax({
                        url: "/Common.ashx",
                        type: "post",
                        dataType: "json",
                        data: {
                            "PageName": "/Recommended/Recommended.ashx", func: "AddQuestion", Question: Question, EnID: Pid,
                            JobID: ID, CreateUID: $("#HUserIdCard").val()
                        },
                        success: function (json) {
                            var result = json.result;
                            if (result.errNum == 0) {
                                parent.layer.msg('添加成功!');
                                BindData(1, 10, Type, ID);

                            } else {
                                layer.msg(result.errMsg);
                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            layer.msg("操作失败！");
                        }
                    });
                }
            }
            else {
                $("#Question").focus();
                layer.msg("请输入问题！");
            }

        }

        var zNodes = [];

        var setting = {
            data: {
                //key: {
                //    title: "t"
                //},
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeClick: beforeClick,
                onClick: onClick
            }
        };

        var log, className = "dark";
        function beforeClick(treeId, treeNode, clickFlag) {
            className = (className === "dark" ? "" : "dark");
            showLog("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.name);
            return (treeNode.click != false);
        }
        function onClick(event, treeId, treeNode, clickFlag) {
            var Type = treeNode.type;//1企业2岗位
            var ID = treeNode.root;
            var Pid = treeNode.pId;
            $("#Type").val(Type);
            $("#ID").val(ID);
            $("#Pid").val(Pid);

            BindData(1, 10, Type, ID);
        }
        function BindData(PageIndex, pageSize, Type, ID) {
            $.ajax({
                type: "post",
                url: "/Common.ashx",
                data: { "PageName": "/Recommended/Recommended.ashx", Func: "GetJobLibrary", Type: Type, ID: ID, PageIndex: PageIndex, pageSize: pageSize },
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
        function showLog(str) {
            if (!log) log = $("#log");
            log.append("<li class='" + className + "'>" + str + "</li>");
            if (log.children("li").length > 8) {
                log.get(0).removeChild(log.children("li")[0]);
            }
        }
        function getTime() {
            var now = new Date(),
            h = now.getHours(),
            m = now.getMinutes(),
            s = now.getSeconds();
            return (h + ":" + m + ":" + s);
        }
        function treeNode() {

        }
        $(function () {
            GetNave();
            BindData(1, 10, "", "");
        })

        function GetNave() {
            $.ajax({
                type: "post",
                url: "/Common.ashx",
                data: { "PageName": "/Recommended/Recommended.ashx", Func: "BindNav" },
                dataType: "text",
                success: function (returnVal) {

                    var dtJson = $.parseJSON(returnVal);
                    $.fn.zTree.init($("#treeEnter"), setting, dtJson);
                },
                error: function (errMsg) {
                    alert('数据加载失败！');
                }
            });
        }
        function treeClick() {
            this.close();

            //parent.MoveMore($("#Hidden1").val(), GetRequest().ID, GetRequest().Type)
        }
    </script>
</body>
</html>
