<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_TaskAdd.aspx.cs" Inherits="SMSWeb.CourseManage.Course_TaskAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增任务</title>
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
    <script src="/Scripts/PageBar.js"></script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                        <div class="course_form_div clearfix ">
                            <label for="">任务名称：</label>
                            <input type="text" placeholder="" class="text" id="txt_Name" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div fl">
                            <label for="">开始时间：</label>
                            <input type="text" class="Wdate text" readonly="true" id="da_StartTime" onclick="javascript: WdatePicker({ maxDate: '#F{$dp.$D(\'da_EndTime\')}' });"/>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div fr">
                            <label for="">结束时间：</label>
                            <input type="text" class="Wdate text" readonly="true" id="da_EndTime" onclick="javascript: WdatePicker({ minDate: '#F{$dp.$D(\'da_StartTime\')}' });"/>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_select fl">
                            <label for="">任务类型：</label>
                            <select class="select" id="sel_Type" onchange="BindRelationDataByTask(this.value,0);">
                                <option value="0" selected="selected">学资源</option>
                                <option value="1">试卷</option>
                                <option value="2">讨论</option>
                                <option value="3">作业</option>
                                <option value="4">调查问卷</option>
                            </select>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_select fr">
                            <label for="" id="la_RelWord">选择任务：</label>
                            <select class="select" id="sel_Relation"></select>
                            <i class="stars"></i>
                        </div>
                        <div style="clear: both;"></div>
                        <div class="course_form_select clearfix">
                            <label for="">学生范围：</label>
                            <div id="div_Class"></div>
                        </div>
                         <div class="course_form_div fl">
                            <label for="">权重：</label>
                            <input type="text" placeholder="" class="text" id="txt_Weight" onkeyup="(this.v=function(){if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'');}else{this.value=10;}}).call(this)" onblur="this.v();"/>
                            <i class="stars"></i><label style="color:red;">(请输入1~10的数字,数字越大,任务越重要)</label>
                        </div>
                        <div style="clear: both;"></div>
                        <div class="course_form_select clearfix">
                            <span class="course_btn confirm_btn" onclick="SaveTask();" style="cursor:pointer;">确定</span>
                        </div>
                    </div>
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();
        var classArray = [];
        $(function () {
            var itemid = UrlDate.itemid;
            if (itemid != 0) {
                GetTaskById(itemid);
            } else {
                StudyTheCourseClass('');
                BindRelationDataByTask(0,0);
            }            
        });
        function StudyTheCourseClass(classStr) {
            $("#div_Class").html("");
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "/OnlineLearning/MyLessonsHandler.ashx", "Func": "StudyTheCourseStu", CourseID: UrlDate.courseid, CourceType: UrlDate.coursetype },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (json.result.retData.length <= 0) {
                            $("#div_Class").html("<label>暂无正在学习的同学！</label>");
                            return;
                        }
                        $("#div_Class").append("<label style=\"margin-right:10px;\"><input type=\"checkbox\" name=\"ck_all\" id=\"ck_all\" value=\"\" onclick=\"CheckAll(this);\"/>全选</label>");
                        var selArray = [];
                        if (classStr.length) {
                            selArray = classStr.split(',');
                        }
                        $(json.result.retData).each(function () {                            
                            if (classArray.indexOf(this.ClassID) == -1) {
                                classArray.push(this.ClassID);
                                var checked =!classStr.length?"":(selArray.indexOf(this.ClassID) == -1?"":"checked=\"checked\"");
                                $("#div_Class").append("<label style=\"margin-right:10px;\"><input type=\"checkbox\" name=\"ck_stuclass\" id=\"\" onclick=\"CheckSub(this);\" value=\"" + this.ClassID + "\" " + checked + " />" + this.GradeName + this.ClassName + "</label>");
                            }
                        });
                    }
                    else { $("#div_Class").html("<label>暂无正在学习的同学！</label>"); }
                },
                error: function (errMsg) {
                    layer.msg('加载失败！');
                }
            });
        }
        
        function BindRelationDataByTask(type, relationid) {
            var reldata;
            if (type == 0) {
                reldata = { PageName: "/CourseManage/CouseResource.ashx",Func: "GetResourceList", CourceID: UrlDate.courseid, IsVideo: 1, ChapterID: UrlDate.ChapterID };
            } else if (type == 1) {
                reldata = {
                    PageName: "/Exam/ExamHandler.ashx", action: "GetExamQPageList",
                    PageIndex: 1, pageSize: 10, IsPage: false, Type:1, IsRelease: 1
                };
            } else if (type == 2) {
                reldata = {
                    PageName: "/OnlineLearning/TopicHandler.ashx", Func: "GetTopicDataPage", ispage: false, Type: 0,
                    CouseID: UrlDate.courseid, ChapterID: UrlDate.ChapterID, StuIDCard: $("#HUserIdCard").val() };
            } else if (type == 3) {
                reldata = {
                    PageName: "/OnlineLearning/WorkHandler.ashx",Func: "GetWorkDataPage",
                    CourseID: UrlDate.courseid, ispage: false, StuIDCard: $("#HUserIdCard").val()
                };
            }
            else if (type == 4) {
                reldata = {PageName: "/Exam/ExamHandler.ashx",action: "GetExamQPageList",
                    PageIndex: 1,pageSize: 10,IsPage:false,Type: 4,IsRelease: 1
                };
            }
            $("#sel_Relation").html("<option value=\"0\">==请选择任务==</option>");
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: reldata,
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var option = "<option value='" + ((type == 2 || type == 3) ? this.Id : this.ID) + "'>" + this.Name + "</option>";
                            $("#sel_Relation").append(option);
                        });
                        if (relationid != 0) {
                            $("#sel_Relation").val(relationid);
                        }
                    }                                       
                },
                error: function (errMsg) {
                    layer.msg('加载失败！');
                }
            });
        }
        //操作任务数据
        function SaveTask() {           
            var name = $("#txt_Name").val().trim();
            var relationid = $("#sel_Relation").val(), weight = $("#txt_Weight").val().trim();
            var startTime = $("#da_StartTime").val().trim(), endTime=$("#da_EndTime").val().trim();
            var selArray = [];            
            $("input[type=checkbox][name=ck_stuclass]:checked").each(function () {    
                selArray.push(this.value);
            });
            if (!selArray.length) {
                layer.msg("请选择学生范围！");
                return;
            }
            var classStr = selArray.join(",");
            if (!name.length ||relationid=="0" || !classStr.length || !startTime.length || !endTime.length | !weight.length) {
                layer.msg("请填写完整信息！");
                return;
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/TaskHandler.ashx",
                    Func: UrlDate.itemid == 0 ? "AddTask" : "EditTask",
                    ItemId: UrlDate.itemid,
                    Name: name,
                    CourseID: UrlDate.courseid,
                    ChapterID: UrlDate.ChapterID,
                    RelationID: relationid,
                    Type: $("#sel_Type").val(),
                    StuRange: classStr,
                    StartTime: startTime,
                    EndTime: endTime,
                    Weight: weight,
                    UserIdCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        parent.layer.msg(UrlDate.itemid == 0 ? '新增任务成功!' : '编辑任务成功!');
                        parent.BindExamPaper();
                        parent.CloseIFrameWindow();
                    } else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        //绑定数据
        function GetTaskById(itemid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/TaskHandler.ashx",
                    Func: "GetTaskByID",
                    ItemId: itemid
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var model = json.result.retData;
                        $("#txt_Name").val(model.Name);
                        $("#sel_Type").val(model.Type);
                        $("#da_StartTime").val(model.StartTime);
                        $("#da_EndTime").val(model.EndTime);
                        $("#txt_Weight").val(model.Weight);
                        BindRelationDataByTask(model.Type,model.RelationID);
                        StudyTheCourseClass(model.StuRange);
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
        //全选或全不选
        function CheckAll(obj) {
            var flag = obj.checked;//获取全选按钮的状态 
            $("input[type=checkbox][name=ck_stuclass]").each(function () {//查找每一个name为cb_sub的checkbox 
                this.checked = flag;//选中或者取消选中 
            });
        }
        //反选
        function CheckSub(obj) {
            var flag = obj.checked;//获取当前按钮的状态 
            if (!flag) {
                $("input[type=checkbox][name=ck_all]")[0].checked = false;
                return;
             }  
            var chsub = $("input[type='checkbox'][name='ck_stuclass']").length; //获取subcheck的个数  
            var checkedsub = $("input[type='checkbox'][name='ck_stuclass']:checked").length; //获取选中的subcheck的个数  
            if (checkedsub == chsub) {
                $("input[type=checkbox][name=ck_all]")[0].checked = true;
            }
        }
    </script>
</body>
</html>
