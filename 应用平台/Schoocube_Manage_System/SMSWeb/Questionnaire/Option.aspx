<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Option.aspx.cs" Inherits="SMSWeb.Questionnaire.Option" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>问卷选项管理</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/CourseMenu.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
        <%--试题类型--%>
        <input id="hid_Type" type="hidden" value="1" />
        <%-- 学段--%>
        <input id="hidQuestionsID" type="hidden" value="0" />
        <%--试题类型--%>
        <input id="hf_Type" type="hidden" value="2" />
        <div>
            <!--header-->
            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="/HZ_Index.aspx">
                        <img src="/images/logo.png" /></a>
                    <div class="wenzi_tips fl">
                        <img src="/images/wenjuandiaocha.png" />
                    </div>
                    <nav class="navbar menu_mid fl">
                        <ul>
                            <li class="active"><a href="/Questionnaire/Option.aspx">问卷项管理</a></li>
                            <li currentclass="active"><a href="/Questionnaire/FormOption.aspx">问卷管理</a></li>
                            <li currentclass="active"><a href="/analysisa/question.aspx">问卷调查统计</a></li>
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
                <div class="stytem_items">
                    <div class="stytem_item clearfix a">
                        <div class="stytem_items_title fl">
                            问卷项类型
                        </div>
                        <div class="stytem_items_list fl" id="QuestionsID">
                            <a href="javascript:;" id='qb' class="on" onclick=' PeriodChangeall(0,this)' value="全部">全部</a>
                            <a href="javascript:;" id='sh'onclick=' PeriodChangeall(1,this)' value="生活类">生活类</a>
                            <a href="javascript:;" id='xy'  onclick=' PeriodChangeall(2,this)' value="校园类">校园类</a>
                        </div>
                    </div>

                </div>

            </div>
            <div class="width clearfix testsystem_wrap  pt20">
                <div style="background:#fff;padding:0px 20px;" class="bordshadrad">
                    <!---->
                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl" id="qTypediv">
                        </div>
                        <div class="stytem_select_right fr">
                            <span class="enable">
                                <span value="1" id="Status">启用 </span><i class="icon icon-angle-down"></i>
                                <div class="enable_wrap none">
                                    <span value="1" class="active" onclick="selectstatus(1)">启用</span>
                                    <span value="2" onclick="selectstatus(2)">禁用</span>
                                </div>
                            </span>
                            <div class="search_exam fl pr">
                                <input type="text" name="Title" id="Title" value="" onblur="getData(1, 10);" placeholder="问卷选择项" />
                                <i class="icon  icon-search"></i>
                            </div>
                            <a href="javascript:;" class="addtest" onclick="AddQuestion();"><i class="icon icon-plus"></i>添加问卷选择项
                            </a>
                        </div>
                    </div>
                    <div class="test_norelase">
                        <ul class="test_lists" id="ExamQdiv">
                        </ul>
                    </div>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
            <input id="hf_Book" type="hidden" /><input id="hf_Klpoint" type="hidden" />
            <script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
            <script src="/js/system.js" type="text/javascript" charset="utf-8"></script>

        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    function accountManagement() {
        window.location.href = "/Gopay/Gopay.aspx";
    }
    function Mycenter() {
        window.open("/PersonalSpace/PersonalSpace_Student.aspx", "_blank")
    }

    $(function () {

        GetType();
        getData(1, 10);
    });



    function selectstatus(status) {
        $("#Status").attr("value", status);
        getData(1, 10);
    }


    function PeriodChangeall(QuestionsID, em) {
        $("#hidQuestionsID").val(QuestionsID);
        getData(1, 10);
    }



    //绑定题目
    function getData(startIndex, pageSize) {
        var QuestionsID = $("#hidQuestionsID").val() == "0" ? "0" : $("#hidQuestionsID").val();
        var type = $("#hid_Type").val();
        var Status = $("#Status").attr("value");
        var Title = $("#Title").val();
        var qtype = $("#hf_Type").val()
        var action = "GetExamSubQList";
        if (qtype != 1) {
            action = "GetExamObjQList";
        }

        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        //name = name || '';
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": action, PageIndex: startIndex, pageSize: pageSize,
                "Questions": QuestionsID, "Status": Status, "Type": type, "Title": Title, "Status": Status, "Style": 1
            },
            success: OnSuccess,
            //error: OnError
        });
    }
    function OnSuccess(json) {
        if (json.result.errNum.toString() == "0") {
            var html = "";
            $.each(json.result.retData.PagedData, function () {
                html += "<li class=\"clearfix\">"

                + "<div class=\"test_description fl\"><h2><a href='#' onclick=\"LookQuestion(" + this.ID + "," + this.Template + "," + this.QType + ")\">" + this.Title + "</a>";

                html += "<p>" + this.Content + "</p></div>"
                            + "<div class=\"test_lists_right fr clearfix\">"
                                + "<div class=\"dates_a fr\">"
                                    + "<div class=\"seedeletion none\">"
                                        + "<i class=\"icon icon-eye-open\" onclick=\"LookQuestion(" + this.ID + "," + this.Template + "," + this.QType + ")\"></i>"
                                        + "<i class=\"icon  icon-trash\" onclick=\"DelQuestion(" + this.ID + "," + this.Template + "," + this.QType + ")\"></i>"
                                        + "<i class=\"icon  icon-edit\" onclick=\"EditQuestion(" + this.ID + "," + this.Template + "," + this.TypeID + "," + this.QType + ")\"></i>"
                                        + "<i class=\"icon " + (this.Status != 1 ? " icon-ok-circle\"" : "icon-ban-circle\"");
                html += " onclick=\"ChangQstatus(this," + this.ID + "," + this.Template + "," + this.QType + ")\"></i>"
            + "</div>"
            + "<div class=\"data\">"
                + this.CreateTime
            + "</div>"
        + "</div>"
    + "</div>"
+ "</li>";
            });
            $("#ExamQdiv").html(html);
            makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
            HoverQuestion();
        } else {
            $("#pageBar").hide();
            var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
            $("#ExamQdiv").html(html);
        }
    }


    function HoverQuestion() {
        //题库管理
        $('.test_lists li').hover(function () {
            $(this).find('.seedeletion').show();
            //发步图标划过文字显示
            $(this).find('.release').hover(function () {
                $(this).find('em').slideDown();
            }, function () {
                $(this).find('em').slideUp();
            })
        }, function () {
            $(this).find('.seedeletion').hide();
        })
    }


    ///绑定题目类型
    function GetType() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                OptionType: 1,
                "action": "GetQuestionTypeList"
            },
            success: function (json) {
                var html = "";
                var count = 0;
                $.each(json.result.retData, function () {
                    count = 1 + parseInt(count);
                    if (count == 1) {
                        html += "<a href=\"javascript:void(0);\" class=\"on\"  onclick='typesearch(" + this.ID + "," + this.Template + "," + this.QType + ")'>" + this.Title + "</a>";
                    } else {
                        html += "<a href=\"javascript:void(0);\" onclick='typesearch(" + this.ID + "," + this.Template + "," + this.QType + ")'>" + this.Title + "</a>";
                    }
                });
                $("#qTypediv").html(html);
                $('.stytem_select_left a').click(function () {
                    $(this).addClass('on').siblings().removeClass('on');
                });

            },
            error: function (json) {
                $("#qTypediv").html(json.result.errMsg.toString());
            }
        });
    }


    function typesearch(id, template, qtype) {
        $("#hid_Type").val(id);
        $("#hf_Type").val(qtype);
        getData(1, 10);
    }


    function DelQuestion(Id, Template, Qtype) {
        layer.msg("确定要删除该试题?", {
            time: 0 //不自动关闭
           , btn: ['确定', '取消']
           , yes: function (index) {
               layer.close(index);
               $.ajax({
                   url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                   type: "post",
                   async: false,
                   dataType: "json",
                   data: {
                       PageName: "/Exam/ExamHandler.ashx",
                       "action": "DelQuestion", DelID: Id, "Qtype": Qtype
                   },
                   success: function (json) {
                       if (json.result.errNum.toString() == "0") {
                           layer.msg("删除成功");
                           getData(1, 10);
                       }
                       else { layer.msg('删除失败！'); }
                   },
                   error: function (errMsg) {
                       layer.msg('删除失败！');
                   }
               });
           }
        });
    }


    function ChangQstatus(obj, Id, Template, Qtype) {
        var str = "";
        var status = 2;
        if ($(obj).hasClass("icon-ok-circle")) { status = 1; }
        if (status == 1) {
            str = "启";
        } else {
            str = "禁";
        }

        layer.msg("确定要" + str + "用该试题?", {
            time: 0 //不自动关闭
           , btn: ['确定', '取消']
           , yes: function (index) {
               layer.close(index);
               $.ajax({
                   url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                   type: "post",
                   async: false,
                   dataType: "json",
                   data: {
                       PageName: "/Exam/ExamHandler.ashx",
                       "action": "ChangeQuestionStatus", QuesID: Id, "Qtype": Qtype, "Status": status
                   },
                   success: function (json) {
                       if (json.result.errNum.toString() == "0") {
                           getData(1, 10);
                       }
                   },
                   error: function (errMsg) {

                   }
               });
           }
        });
    }

    //预览
    function LookQuestion(Id, Template, Qtype) {
        OpenIFrameWindow('查看问卷项', '/Exam/LookQuestion.aspx?Id=' + Id + "&type=" + Qtype, '780px', '70%');
    }

    function AddQuestion()
    {
        OpenIFrameWindow('编辑问卷项', '/Questionnaire/OptionEdit.aspx?Id=' + 0 + "&type=" + 0 + "&TypeID=" + 0, '830px', '70%');
    }

    function EditQuestion(Id, Template, type, QType) {
        OpenIFrameWindow('编辑问卷项', '/Questionnaire/OptionEdit.aspx?Id=' + Id + "&type=" + QType + "&TypeID=" + type, '830px', '70%');
    }
</script>
