<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeDetail.aspx.cs" Inherits="SMSWeb.PersonalSpace.NoticeDetail" ValidateRequest="false"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/KindUeditor/kindeditor.js"></script>
    <script src="/Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="/Scripts/KindUeditor/lang/zh_CN.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">标题：</label>
                            <span id="Key"></span>
                            <%--<input id="Key" type="text" class="text" />--%>
                            
                        </div>

                        <div class="course_form_div clearfix">
                            <label for="">内容：</label>
                        </div>
                        <div class="mb20 clearfix pr">
                            <div style="width: 99%; height: 100px; float: left;" id="content">
                                <%--<textarea id="editor_id" name="content" style="width: 100%; height: 100px;">
                                </textarea>--%>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            var noticeid = UrlDate.noticeid;
            var relid = UrlDate.relid;
            var Type = UrlDate.Type;
            if (Type == "1") {
                CourseNoticeDetail();
                //$("#Key").val(UrlDate.Title);
                //$("#content").html("<img alt=\"\" src=\"http://192.168.10.92:9066/Stu_js/KindUeditor/plugins/emoticons/images/0.gif\" border=\"0\" />");
            }
            else {
                Notice_CourseClick(noticeid, relid);
            }
        })
        function CourseNoticeDetail() {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",
                type: "post",
                dataType: "json",
                data: {
                    Func: "StuMessage",
                    Id: UrlDate.ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var model = json.result.retData[0];
                        var content = model.NewsContent;
                        $("#Key").html(model.Title);
                        $("#content").html(model.NewsContent.toString().replace("/attached", ClassServiceUrl));
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
        function Notice_CourseClick(noticeid, relid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/NoticeHandler.ashx",
                    Func: "GetNotice_CourseById",
                    ItemId: noticeid
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var model = json.result.retData;
                        $("#Key").html(model.Title);
                        $("#content").html(model.Contents);
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
            OperNotice_CourseSeeRel(noticeid, relid);
        }
        function OperNotice_CourseSeeRel(noticeid, relid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/NoticeHandler.ashx",
                    Func: "OperNotice_CourseSeeRel",
                    ItemId: relid,
                    NoticeId: noticeid,
                    UserIdCard: $("#HUserIdCard").val(),
                    UserName: $("#HUserName").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (relid == 0) {
                            $("#span_read0_" + noticeid).removeClass("test_normal").addClass("test_type");
                            $("#span_read0_" + noticeid).html("已读");
                        }
                    }
                },
                error: function (errMsg) {

                }
            });
        }
    </script>
</body>
</html>
