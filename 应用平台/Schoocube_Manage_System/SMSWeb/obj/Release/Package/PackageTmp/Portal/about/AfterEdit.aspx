<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AfterEdit.aspx.cs" Inherits="SMSWeb.Portal.about.AfterEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../../Scripts/Common.js"></script>
    <script src="../../Scripts/KindUeditor/kindeditor.js"></script>
    <script src="../../Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="../../Scripts/KindUeditor/lang/zh_CN.js"></script>
    <script src="../../Scripts/layer/layer.js"></script>
    <script src="../../Scripts/jquery.cookie.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HMenuId" runat="server" />
        <input type="hidden" id="HAdvertId" />
           <div style="background: #fff">
                <div class="newcourse_dialog_detail">
                    <script type="text/javascript">
                        var ptitle = getQueryString("ptitle");
                        var title = getQueryString("title");
                        document.write("<div class=\"crumbs\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                    </script>
                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">标题：</label>
                            <input id="Description"  type="text" class="text" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">内容：</label>
                        </div>
                            <div class="mb20 clearfix pr" >
                            <div  style="width:99%;height:700px;float:left;">
                                <textarea id="editor_id" name="content" style="width:100%;height:700px;">
                                </textarea>
                            </div>
                            <i class="stars" style="position:absolute;top:50%;margin-top:-15px;right:0px;"></i>
                        </div>
                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a href="javscript:;" class="course_btn confirm_btn" onclick="saveData()" id="btnCreate">确定</a>
                        </div>
                    </div>
                </div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            KindEditor.ready(function (K) {
                window.editor = K.create('#editor_id', {
                    uploadJson: '../UploadImage.ashx?action=UploadImgForAdvertContent',
                    allowFileManager: false,//true时显示浏览服务器图片功能。
                    allowImageRemote: false,//网络图片
                    resizeType: 0,
                    items: [
                    'source', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', "strikethrough",
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'undo', 'redo', '|', 'emoticons', 'image', 'link'],
                    afterFocus: function () {
                        self.edit = edit = this; var strIndex = self.edit.html().indexOf("请添加你的描述..."); if (strIndex != -1) { self.edit.html(self.edit.html().replace("请添加你的描述...", "")); }
                    },
                    //失去焦点事件
                    afterBlur: function () { this.sync(); self.edit = edit = this; if (self.edit.isEmpty()) { self.edit.html("请添加你的描述..."); } },
                    afterUpload: function (data) {
                        if (data.result) {
                            //data.url 处理
                        } else {

                        }
                    },
                    afterError: function (str) {
                        //alert('error: ' + str);
                    }
                });

                initData();
                getUserInfoCookie();
            });
        })

        function initData() {
            if ($("#HMenuId").val() != "") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/AdvertisingHandler.ashx",
                        "func": "GetAdvertising",
                        "MenuId": $("#HMenuId").val(),
                        "AdvId": $("#HAdvertId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null && item.length>0) {
                                editor.html(item[0].CreativeHTML);
                                $("#Description").val(item[0].Description);
                                $("#HAdvertId").val(item[0].Id);
                            }
                        }
                    },
                    error: OnError
                });
            }
        }

        function saveData() {
            var desc = editor.html() == "请添加你的描述..." ? "" : encodeURIComponent(editor.html());
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdvertisingHandler.ashx",
                    "func": "EditAdvertising",
                    "MenuId": $("#HMenuId").val(),
                    "Id":$("#HAdvertId").val(),
                    "CreativeHTML": desc,
                    "Description": $("#Description").val(),
                    "Creator": $("#HUserName").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg('操作成功!');
                        window.location.reload();
                    }
                },
                error: OnError
            });
        }
        function getUserInfoCookie() {
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                if (UserInfo != null) {
                    $("#HUserName").val(UserInfo.LoginName);
                }
            }
        }
    </script>
</body>
</html>
