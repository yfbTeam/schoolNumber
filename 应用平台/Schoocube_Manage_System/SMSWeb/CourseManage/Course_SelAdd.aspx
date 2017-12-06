<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_SelAdd.aspx.cs" Inherits="SMSWeb.CourseManage.Course_SelAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>选修课设置</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="Term.js"></script>
    <script src="/Scripts/Power.js"></script>
    <script type="text/javascript">
        $(function () {
            GetTerm();
        })
        //学年学期
    </script>

</head>
<body>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />

        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_select clearfix">
                        <label for="">学年学期：</label>
                        <select id="StudyTerm">
                            <option value="0">选择学期</option>
                        </select>
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_select clearfix">
                        <label for="">筛选方式：</label>
                        <select id="SelType">
                            <option value="1">先到先得</option>
                            <option value="2">优先级</option>
                        </select>
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_select clearfix">
                        <label for="">课程状态：</label>
                        <select id="Status">
                            <option value="0">待激活</option>
                            <option value="1">激活</option>
                            <option value="2">停用</option>

                        </select>
                    </div>
                    <div class="course_form_select clearfix">
                        <label for="">周设置：</label>
                        <input type="radio" name="WeekSet" id="" value="1" />
                        <label for="">启用</label>
                        <input type="radio" name="WeekSet" id="" value="0" checked="checked" />
                        <label for="">禁用</label>
                    </div>
                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">学生最多选课数：</label>
                            <input type="text" placeholder="学生最多选课数" class="text" id="SelMaxNum" value="0" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">学生最少选课数：</label>
                            <input type="text" placeholder="学生最少选课数" class="text" id="SelMinNum" value="0" />
                            <i class="stars"></i>
                        </div>


                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a href="javscript:;" class="course_btn confirm_btn" onclick="SelAdd()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="/js/common.js"></script>
    <script>
        var GetUrlDate = new GetUrlDate();
        $(function () {
            var ID = GetUrlDate.ID;
            if (ID != undefined) {
                GetSelByID(ID);
            }
        })
        //添加数据
        function SelAdd() {
            var WeekSet = $("input[name='WeekSet']:checked").val();
            var TermName = $("#StudyTerm").find("option:selected").text();

            var TermID = $("#StudyTerm").val();
            var SelType = $("#SelType").val();
            var SelMaxNum = $("#SelMaxNum").val();
            var SelMinNum = $("#SelMinNum").val();
            var Status = $("#Status").val();
            var ID = "";
            if (GetUrlDate.ID != undefined) {
                ID = GetUrlDate.ID;
            }

            if (TermName == "选择学期" || !SelMaxNum.length || !SelMinNum.length || SelMaxNum=="0") {
                layer.msg("请填写完整信息！");
                return;
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "CourseManage/CourseSet.ashx", func: "Add", TermName: TermName, TermID: TermID, SelType: SelType, SelMaxNum: SelMaxNum,
                    SelMinNum: SelMinNum, ID: ID, Status: Status, WeekSet: WeekSet, UserIdCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        parent.getData(1, 10);
                        parent.CloseIFrameWindow();
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        //绑定数据
        function GetSelByID(ID) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourseSet.ashx", "Func": "GetPageList", PageIndex: 1, pageSize: 10, ID: ID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData.PagedData).each(function () {
                            $("input[name='WeekSet'][value=" + this.WeekSet + "]").attr("checked", true);
                            $("#StudyTerm").val(this.TermID);
                            $("#SelType").val(this.SelType);
                            $("#Status").val(this.Status);
                            $("#SelMaxNum").val(this.SelMaxNum);
                            $("#SelMinNum").val(this.SelMinNum);
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
