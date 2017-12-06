<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdvertisingEdit.aspx.cs" Inherits="SMSWeb.Portal.Advertising.AdvertisingEdit" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HAdvertId" runat="server" />
        <input type="hidden" id="HType" />
           <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">类型：</label>
                            <label for="" id="lblType" class="none"></label>
                            <select id="Type" name="Type" class="none"   onchange="changeValue()">
                                <option value="">请选择</option>
                             <%--   <option value="0">联系我们</option>
                                <option value="1">网站简介</option>
                                <option value="2">友情链接</option>--%>
                            </select>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">说明：</label>
                            <input type="text" placeholder="说明" class="text" id="Description" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">内容：</label>
                            <textarea id="editor_id" name="content" style="width:664px;height:300px;">
                            </textarea>
                            <i class="stars"></i>
                        </div>
                        
                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a href="javscript:;" class="course_btn confirm_btn" onclick="saveData()" id="btnCreate">确定</a>
                        </div>

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
                        self.edit = edit = this; var strIndex = self.edit.html().indexOf("请添加你的评论..."); if (strIndex != -1) { self.edit.html(self.edit.html().replace("请添加你的评论...", "")); }
                    },
                    //失去焦点事件
                    afterBlur: function () { this.sync(); self.edit = edit = this; if (self.edit.isEmpty()) { self.edit.html("请添加你的评论..."); } },
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
                initOption();
            });
        })

        function initData() {
            if ($("#HAdvertId").val() != "") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/AdvertisingHandler.ashx",
                        "func": "GetAdvertising",
                        "Id": $("#HAdvertId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null) {
                                $("#HType").val(item.Type);
                                $("#lblType").show();
                                $("#lblType").html(showAdvertType(item.Type));
                                $("#Description").val(item.Description);
                                editor.html(item.CreativeHTML);
                            }
                        }
                    },
                    error: OnError
                });
            } else {
                $("#Type").show();

            }
        }
        var optionList = [
            { key: 0, vals: "联系我们" },
            { key: 1, vals: "网站简介" },
            { key: 2, vals: "友情链接" },
            { key: 3, vals: "学校简介" },
            { key: 4, vals: "校长寄语" },
            { key: 6, vals: "学校历史" },
            { key: 7, vals: "招生信息" },
            { key: 8, vals: "就业分配" },
            { key: 9, vals: "教学环境" },
            { key: 10, vals: "校园文化" },
            { key: 11, vals: "鉴定培训" },
            { key: 12, vals: "职业培训" },
            { key: 13, vals: "网上报名" },
            { key: 14, vals: "学校特色" },
            { key: 15, vals: "荣誉资质" },
            { key: 16, vals: "明星学员" },
            { key: 17, vals: "联系学校" }
        ];
        Array.prototype.contains = function (item) {
            return RegExp("\\b" + item + "\\b").test(this);
        };
        function Uniquelize(a, b) {
            var readArry = [];
            var backArry = [];
            for (var i = 0; i < a.length; i++) {
                for (var j = 0; j < b.length; j++) {
                    if (a[i].key == b[j].Type) {
                        readArry.push(b[j].Type);
                        break;
                    }
                }
            }
            for (var z = 0; z < a.length; z++) {
                if (!readArry.contains(a[z].key)) {
                    var obj = new Object();
                    obj.key = a[z].key;
                    obj.vals = a[z].vals;
                    backArry.push(obj);
                }
            }
            return backArry;
        };
        function initOption() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "IsDelete": 0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items.length > 0) {
                            var arry = Uniquelize(optionList, items);
                            for (var z = 0; z < arry.length; z++) {
                                $("select[name='Type']")[0].add(new Option(arry[z].vals, arry[z].key))
                            }
                        } else {
                            for (var i = 0; i < optionList.length; i++) {
                                $("select[name='Type']")[0].add(new Option(optionList[i].vals, optionList[i].key))
                            }
                        }
                    }
                },
                error: OnError
            });
        }



        function changeValue() {
            $("#HType").val($("#Type").val());
            if ($("#Type").val() == "") {
                return;
            }
        }

        function saveData() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdvertisingHandler.ashx",
                    "func": "EditAdvertising",
                    "Id": $("#HAdvertId").val(),
                    "Type": $("#HType").val(),
                    "Description": $("#Description").val(),
                    "CreativeHTML": encodeURIComponent(editor.html()),
                    "Creator": $("#HUserName").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        parent.layer.msg('操作成功!');
                        parent.getData(1, 10);
                        parent.CloseIFrameWindow();
                    }
                },
                error: OnError
            });
        }
    </script>
    
</body>
</html>
