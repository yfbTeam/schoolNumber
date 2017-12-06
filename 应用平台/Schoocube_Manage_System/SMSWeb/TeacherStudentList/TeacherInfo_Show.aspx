<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeacherInfo_Show.aspx.cs" Inherits="SMSWeb.TeacherStudentList.TeacherInfo_Show" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>教师信息</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <style type="text/css">
        .list_bars{border-bottom:2px solid #66ABDA;height:30px;margin-top:20px;}
        .list_bars a{width:75px;height:30px;line-height:30px;border-radius:4px 4px 0px 0px;line-height:32px;color:#fff;text-align:center;font-size:14px;background:#66ABDA;display:block;}
        .teacher_lists .deyta{font-size:14px;color:#666;line-height:25px;margin-top:10px;}
    </style>
</head>
<body style="background:#fff;">
    <input type="hidden" id="HUserIdCard" runat="server"/>
    <input type="hidden" id="HUserName" runat="server"/>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="clearfix">
                        <div class="teacher_lists" id="div_Qual">
                            <div class="list_bars" style="margin-top:0px;">
                                <a href="javascript:;">教师资质</a>
                            </div>
                            <div class="deyta" id="lbl_Qualifications"></div>
                        </div>
                        <div class="teacher_lists">
                            <div class="list_bars">
                                <a href="javascript:;">上课信息</a>
                            </div>
                            <div class="deyta" id="lbl_AttendClass"></div>
                        </div>
                        <div class="teacher_lists">
                            <div class="list_bars">
                                <a href="javascript:;">教学信息</a>
                            </div>
                            <div  class="deyta" id="lbl_Teaching"></div>
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
            var curdate = new Date()
            var vYear = curdate.getFullYear();
            if (vYear.toString() == GetUrlDate.StudySection) {
                $("#div_Qual").show();
            } else {
                $("#div_Qual").hide();
            }
            var itemid = GetUrlDate.itemid;
            InitData(itemid);
            GetTeachingData(itemid);
            GetAttendClassData(itemid);
        });
        function InitData(itemid) {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    IDCard: itemid,
                    Func: "GetTeacherData"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#lbl_Qualifications").html('');
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            $("#lbl_Qualifications").html(items[0].BriefIntroduction);
                        }
                    }
                    else {
                        $("#lbl_Qualifications").html("暂无教师资质信息！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#lbl_Qualifications").html("暂无教师资质信息！");
                }
            });
        }
        //获取上课信息
        function GetAttendClassData(itemid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "/OnlineLearning/MyLessonsHandler.ashx", "Func": "GetClassCourses", ClassID: GetUrlDate.ClassID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            if ((this.CreateUID == GetUrlDate.itemid) && (this.TermName.substring(0, 4) == GetUrlDate.StudySection)) {
                                var cur = "《" + this.Name + "》 ";
                                $("#lbl_AttendClass").append(cur);
                            }
                        });
                    }
                    if (!$("#lbl_AttendClass").html().length) {
                        $("#lbl_AttendClass").html("暂无上课信息！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#lbl_AttendClass").html("暂无上课信息！");
                }
            });
        }
        //获取教学信息
        function GetTeachingData(itemid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", Ispage: false, OperSymbol: '', IdCard: itemid },
                success: function(json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            if (this.TermName.substring(0, 4)== GetUrlDate.StudySection) {
                                var cur ="《"+this.Name+ "》 ";
                              $("#lbl_Teaching").append(cur);
                            }                            
                        });
                    }
                    if (!$("#lbl_Teaching").html().length) {
                        $("#lbl_Teaching").html("暂无教学信息！");
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    $("#lbl_Teaching").html("暂无教学信息！");
                }
            });
        }
    </script>
</body>
</html>