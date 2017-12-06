<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notice_CourseEdit.aspx.cs" Inherits="SMSWeb.OnlineLearning.Notice_CourseEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>添加课程通知</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Power.js"></script>
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
                            <label for="">标题：</label>
                            <input type="text" placeholder="" class="text" id="txt_Title"/>
                            <i class="stars"></i>
                        </div>
                        <div style="clear: both"></div>
                        <div class="course_form_select">
                            <label for="">内容：</label>
                            <textarea name="" rows="" cols="" id="area_Contents"></textarea>
                        </div>
                        <div class="course_form_select fl" id="IsTop">
                            <label for="">是否置顶：</label>
                            <input type="radio" name="radio_istop" id="" value="0" checked="checked"/>
                            <label for="">否</label>
                            <input type="radio" name="radio_istop" id="" value="1"/>
                            <label for="">是</label>
                        </div>
                        <div class="course_form_select clearfix">
                            <span class="course_btn confirm_btn" onclick="SaveNotice_Course();" style="cursor:pointer;">确定</span>
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
            var itemid = GetUrlDate.itemid;
            if (itemid != 0) {
                GetNotice_CourseById(itemid);
            }
        })
        //操作课程通知数据
        function SaveNotice_Course() {
            var title = $("#txt_Title").val().trim();
            var contents = $("#area_Contents").val().trim();
            var istop = $("input[name='radio_istop']:checked").val();
            if (!title.length) {
                layer.msg("请填写通知信息！");
                return;
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/NoticeHandler.ashx",
                    Func: GetUrlDate.itemid == 0 ? "AddNotice_Course" : "EditNotice_Course",
                    ItemId: GetUrlDate.itemid,
                    Title: title,
                    Contents: contents,
                    IsTop: istop,
                    UserIdCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg(GetUrlDate.itemid == 0 ? '添加课程通知成功!' : '编辑课程通知成功!');
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
        function GetNotice_CourseById(itemid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/NoticeHandler.ashx",
                    Func: "GetNotice_CourseById",
                    ItemId: itemid
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var model = json.result.retData;
                        $("#txt_Title").val(model.Title);
                        $("#area_Contents").val(model.Contents);
                        $("input[name='radio_istop'][value=" + model.IsTop + "]").attr("checked", true);
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
