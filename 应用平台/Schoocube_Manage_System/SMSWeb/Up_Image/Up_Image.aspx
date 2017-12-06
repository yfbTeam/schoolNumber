<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Up_Image.aspx.cs" Inherits="SMSWeb.Up_Image.Up_Image" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/index.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="Term.js"></script>
    <style>
        .change_picture .uploadify-button {font-size:14px;border:none;}
    </style>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
     <%--<header class="repository_header_wrap">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="HZ_Index.aspx">
                <img src="/images/logo.png" />

            </a>
            <div class="search_account fr clearfix">
              
                <ul class="account_area fl">
                    <li>
                        <a href="#" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">0</span>
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
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>--%>
    <div class="main width clearfix pt20">
        <div class="myapp_wrap fl bordshadrad">
            <div class="apps_title ">
                <h1 class="bordshadrad">应用图片维护</h1>
            </div>

            <ul class="app_list p10 clearfix" id="Menu">
            </ul>
        </div>
    </div>
    <script src="/js/common.js"></script>
    <script type="text/javascript">
        $(function () {
            GetLeftNavigationMenu();
          
        })

        function GetLeftNavigationMenu() {
            $.ajax({
                type: "Post",
                url: "/SystemSettings/CommonInfo.ashx",
                data: { Func: "GetLeftNavigationMenu", useridcard: $("#HUserIdCard").val(), Pid: "0" },
                dataType: "json",
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#Menu").html('');
                        $(json.result.retData).each(function () {
                            if (this.IsOwner > 0) {

                                var li = " <li style='height:140px;'><a href=\"" + this.Url + "?ParentID=" + this.Id + "&PageName=" + this.Url
                                    + "\" class=\"bgblue\"  target=\"_blank\"><i><img src=\"/" + this.MenuCode + "\" /></i><p class=\"app_name\">" +
                                    this.Name + "</p></a> <div class=\"change_picture\">  <input type=\"file\" id=\"uploadify" + this.Id + "\" name=\"uploadify \" />  </div></li>"; //<input type=\"button\" title=\"保存\" onclick=\"SetImage(" + this.Id + ")\" name=\"OK\" />
                                $("#Menu").append(li);
                                Img(this.Id);
                            }
                        });
                    }
                },
                error: function (errMsg) {
                    //  layer.msg('操作失败！');
                    alert("操作失败")
                }
            });
        }

        function Img(id) {
           
            $("#uploadify" + id).uploadify({
                'auto': true,                      //是否自动上传
                'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': '/CourseManage/Uploade.ashx',
                'formData': { Func: "SetImage" }, //参数
                //'fileTypeDesc': '',
                'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                'buttonText': '选择图片',//按钮文字
                // 'cancelimg': 'uploadify/uploadify-cancel.png',
                'width': 110,
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
                    // $("#img_Pic").attr("src", json.result.retData);
                    EditMenuCode(id, json.result.retData)
                },


            });
        }

        function EditMenuCode(id, MenuCode)
        {
            $.ajax({
                type: "Post",
                url: "/SystemSettings/CommonInfo.ashx",
                data: { Func: "EditMenuCode", MenuID: id, MenuCode: MenuCode },
                dataType: "json",
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        GetLeftNavigationMenu();
                    } else
                    {
                        alert("操作失败");
                    }
                },
                error: function (errMsg) {
                    alert("操作失败");
                }
            });
        }

    </script>
</body>
</html>
