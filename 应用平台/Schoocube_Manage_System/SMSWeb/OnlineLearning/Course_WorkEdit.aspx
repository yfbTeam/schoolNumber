<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_WorkEdit.aspx.cs" Inherits="SMSWeb.OnlineLearning.Course_WorkEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>发布作业</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>   
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server"/>
    <input type="hidden" id="HUserName" runat="server"/>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">                    
                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">作业标题：</label>
                            <input type="text" placeholder="" class="text" id="txt_Name"/>
                            <i class="stars"></i>
                        </div>
                        <div style="clear: both"></div>
                        <div class="course_form_select">
                            <label for="">作业要求：</label>
                            <textarea name="" rows="" cols="" id="area_Requirement" style="width:350px;"></textarea>
                        </div>
                        <div class="course_form_div">
                            <label for="">起止时间：</label>
                            <input type="text" class="Wdate text" style="width:166px;" readonly="true" id="da_StartTime" onclick="javascript: WdatePicker({ maxDate: '#F{$dp.$D(\'da_EndTime\')}' });"/>
                            <label for="">至</label>
                            <input type="text" class="Wdate text" style="width:166px;" readonly="true" id="da_EndTime" onclick="javascript: WdatePicker({ minDate: '#F{$dp.$D(\'da_StartTime\')}' });"/>
                            <i class="stars"></i>
                        </div>                       
                        <div class="course_form_div">
                            <label for="">作业附件：</label>
                            <input type="text" placeholder="" class="text" id="txt_File" readonly="true"/>
                            <div class="select_homework">
                                <input type="file" id="uploadify" name="uploadify"/>
                            </div>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_select clearfix">
                            <span class="course_btn confirm_btn" onclick="SaveWork();" style="cursor:pointer;">确定</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <style>
        .select_homework{position:relative;float:left;margin-left:10px;}
        .select_homework .uploadify-button{font-size:14px;color:#fff;background:#19c857;border:none;}
    </style>
    <script src="/js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            UploadFile();
            var itemid = UrlDate.itemid;
            if (itemid != 0) {
                GetWorkById(itemid);
            }
        })
        //操作作业数据
        function SaveWork() {
            var name = $("#txt_Name").val().trim();
            var requirement = $("#area_Requirement").val().trim();
            var startTime = $("#da_StartTime").val().trim(), endTime = $("#da_EndTime").val().trim();
            var attachment = $("#txt_File").val().trim();
            if (!name.length || !startTime.length || !endTime.length || !attachment.length) {
                layer.msg("请填写完整信息！");
                return;
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func: UrlDate.itemid == 0 ? "AddWork" : "EditWork",
                    ItemId: UrlDate.itemid,
                    CourseID: UrlDate.courseid,
                    ChapterID: UrlDate.ChapterID,
                    PointID:UrlDate.pointid,
                    Name: name,
                    Requirement: requirement,                    
                    StartTime: startTime,
                    EndTime: endTime,
                    Attachment:attachment,
                    UserIdCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg(UrlDate.itemid == 0 ?'发布作业成功!':'编辑作业成功!');
                        parent.GetWorkData();
                        if (UrlDate.itemid == 0) {
                            Notice_StudyTheCourseStu(result.retData);
                        }
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
        function GetWorkById(itemid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func: "GetWorkById",
                    ItemId: itemid
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var model = json.result.retData;
                        $("#txt_Name").val(model.Name);
                        $("#area_Requirement").val(model.Requirement);
                        $("#da_StartTime").val(DateTimeConvert(model.StartTime));
                        $("#da_EndTime").val(DateTimeConvert(model.EndTime));
                        $("#txt_File").val(model.Attachment);
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
        //上传文件
        function UploadFile() {
            $("#uploadify").uploadify({
                'auto': true,                      //是否自动上传
                'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': '/CourseManage/Uploade.ashx',
                'formData': { Func: "UplodeCourse_Work" }, //参数
                //'fileTypeDesc': '',
                //'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                'buttonText': '选择作业',//按钮文字
                // 'cancelimg': 'uploadify/uploadify-cancel.png',
                'width': 90,
                'height': 30,
                //最大文件数量'uploadLimit':
                'multi': false,//单选            
                'fileSizeLimit': '20MB',//最大文档限制
                'queueSizeLimit': 1,  //队列限制
                'removeCompleted': true, //上传完成自动清空
                'removeTimeout': 0, //清空时间间隔
                //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
                'onUploadSuccess': function (file, data, response) {
                    var json = $.parseJSON(data);
                    $("#txt_File").val(json.result.retData);
                }
            });
        }
        //给学习该课程的学生发布作业通知
        function Notice_StudyTheCourseStu(newworkid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "/OnlineLearning/MyLessonsHandler.ashx", "Func": "StudyTheCourseStu", CourseID: UrlDate.courseid, CourceType: UrlDate.coursetype },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (json.result.retData.length <= 0) {
                            return;
                        }
                        var selArry = [];
                        $(json.result.retData).each(function () {                           
                            selArry.push({ Receiver: this.IDCard, ReceiverEmail: "", ReceiverName: this.Name, Href: "/OnlineLearning/StuLessonDetail.aspx?itemid=" + UrlDate.courseid + "&nav_index=4&relname=&flag=1&tabconid=" + newworkid });
                        });
                        Notice_MoreSendMessage("发布作业", $("#HUserName").val()+"老师发布了新作业，赶快去看看吧！", 9, $("#HUserIdCard").val(), $("#HUserName").val(), selArry);
                    }
                },
                error: function (errMsg) {
                    //layer.msg('加载失败！');
                }
            });
        }
    </script>
</body>
</html>

