<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LibraryAdd.aspx.cs" Inherits="SMSWeb.LibraryAdd" %>

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
                            <label for="">问题：</label>
                            <input id="Key" type="text" class="text" />
                            <i class="stars"></i>
                        </div>

                        <div class="course_form_div clearfix">
                            <label for="">答案：</label>
                        </div>
                        <div class="mb20 clearfix pr">
                            <div style="width: 99%; height: 260px; float: left;">
                                <textarea id="editor_id" name="content" style="width: 100%; height: 260px;">
                                </textarea>
                            </div>
                        </div>
                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a class="course_btn confirm_btn" onclick="saveData()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            KindEditor.ready(function (K) {
                window.editor = K.create('#editor_id', {
                    uploadJson: '/Portal/UploadImage.ashx?action=UploadImgForAdvertContent',
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
            });
        })

        function initData() {
            if (UrlDate.MenuId != "" && UrlDate.MenuId != undefined) {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "/Library/Library.ashx", "func": "GetLibrary", "ID": UrlDate.MenuId, "Ispage": false
                    },
                    success: function (json) {
                        if (json.result.errNum == "0") {
                            var item = json.result.retData;
                            if (item != null && item.length > 0) {
                                editor.html(item[0].Answer);
                                $("#Key").val(item[0].Question);
                            }
                        }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }
        }

        function saveData() {
            var Content = editor.html() == "请添加你的描述..." ? "" : encodeURIComponent(editor.html());
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "/Library/Library.ashx", "func": "AddLibrary", "Key": $("#Key").val(), "Content": Content, "ID": UrlDate.MenuId
                },
                success: function (json) {
                    if (json.result.errNum == "0") {
                        if (UrlDate.MenuId != "" && UrlDate.MenuId != undefined) {
                            parent.layer.msg('修改成功!');
                        }
                        else {
                            parent.layer.msg('添加成功!');
                        }
                        parent.BindData(1, 10);

                        parent.CloseIFrameWindow();

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
