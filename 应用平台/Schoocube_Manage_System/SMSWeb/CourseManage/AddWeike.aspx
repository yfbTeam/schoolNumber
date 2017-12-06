﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddWeike.aspx.cs" Inherits="SMSWeb.CourseManage.AddWeike" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>上传微课</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/simple-demo.css" rel="stylesheet" />

    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/js/jquery-migrate-1.1.0.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>

    <script src="/Scripts/Power.js?v=0.101"></script>

    <%--<script type="text/javascript">

        $(function () {

            $("#uploadify").uploadify({
                'auto': true,                      //是否自动上传
                'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': 'Uploade.ashx',
                'formData': { Func: "UplodWeik", Type: 1, UserIdCard: GetUrlDate.UserIdCard }, //参数
                //'fileTypeDesc': '',
                'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                'buttonText': '选择封面',//按钮文字
                // 'cancelimg': 'uploadify/uploadify-cancel.png',
                'width': 90,
                'height': 24,
                //最大文件数量'uploadLimit':
                'multi': false,//单选            
                'fileSizeLimit': '20MB',//最大文档限制
                'queueSizeLimit': 1,  //队列限制
                'removeCompleted': true, //上传完成自动清空
                'removeTimeout': 0, //清空时间间隔
                //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
                'onUploadSuccess': function (file, data, response) {
                    var json = $.parseJSON(data);
                    $("#img_Pic").attr("src", json.result.retData);
                    //$("#img_Pic").val(data);
                },

            });
            $("#uploadify1").uploadify({
                'auto': true,                      //是否自动上传
                'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': 'Uploade.ashx',
                'formData': { Func: "UplodWeik", Type: 2, UserIdCard: GetUrlDate.UserIdCard }, //参数
                'fileTypeExts': '*.mp4;*.mav;*.avi;*.rmvb;*.vmv;*.mpeg',
                'buttonText': '选择微课',//按钮文字
                // 'cancelimg': 'uploadify/uploadify-cancel.png',
                'width': 90,
                'height': 24,
                //最大文件数量'uploadLimit':
                'multi': false,//单选            
                'fileSizeLimit': '1024MB',//最大文档限制
                'queueSizeLimit': 1,  //队列限制
                'removeCompleted': true, //上传完成自动清空
                'removeTimeout': 0, //清空时间间隔
                //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
                'onUploadSuccess': function (file, data, response) {
                    var json = $.parseJSON(data);
                    $("#weike").attr("src", json.result.retData);

                    //$("#img_Pic").val(data);
                },

            });
        });

    </script>--%>
    <%--<style type="text/css">
        .select_face .uploadify-button {
            font-size: 14px;
        }

        .select_reposity .uploadify-button {
            font-size: 14px;
        }
    </style>--%>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HClassID" runat="server" />

    <%--<form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff; height: 100%; padding-bottom: 80px;">

            <div style="width: 258px; height: 124px; border: 1px solid #1783c7; overflow: hidden; margin: 0px auto; position: relative; top: 20px;" class="select_face">
                <img id="img_Pic" alt="" src="" />
                <div style="width: 90px; height: 24px; line-height: 24px; text-align: center; display: block; background: #40bb6b; font-size: 12px; position: absolute; right: -2px; top: 0; color: #fff; z-index: 2; cursor: pointer;">
                    <input type="file" id="uploadify" multiple="multiple" />
                </div>
            </div>
            <div class="select_reposity" style="width: 95px; margin: 40px auto 0px auto;">
                <input type="file" id="uploadify1" multiple="multiple" />
            </div>

            <a id="weike" />
            <div style="margin-top: 20px; text-align: center">
                <input id="Button1" type="button" value="确定" onclick="AddWeike()" style="border-radius: 3px; text-decoration: none; font-size: 14px; background-color: #0DA6EC; color: white; border: 0px; padding: 6px 15px; cursor: pointer;" />
            </div>
        </div>
    </form>--%>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff; height: 100%; padding-bottom: 80px;">
            <div id="drag-and-drop-zone" class="uploader">
                <div>拖动封面到这里</div>
                <img id="img_Pic" alt="" src="" />
            </div>
            <div id="drag-and-drop-zone1" class="uploader">
                <div><a id="weike" class="or" style="color:#92aab0;">拖动微课视频到这里</a></div>
                
            </div>
            <div style="margin-top: 20px; text-align: center">
                <input id="Button1" type="button" value="确定" onclick="AddWeike()" style="border-radius: 3px; text-decoration: none; font-size: 14px; background-color: #0DA6EC; color: white; border: 0px; padding: 6px 15px; cursor: pointer;" />
            </div>
        </div>
    </form>
    <script src="/js/common.js"></script>
    <%--<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>--%>
    <script src="/js/dmuploader.js"></script>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();

        $('#drag-and-drop-zone1').dmUploader({
            url: 'Uploade.ashx?Func=UplodWeik&Type=2&UserIdCard=' + $("#HUserIdCard").val(),
            //data: { Func: "UplodWeik", Type: 2, UserIdCard: GetUrlDate.UserIdCard },
            dataType: 'json',
            //allowedTypes: '*',
            extFilter: 'mp4;mav;mpeg;',

            onUploadSuccess: function (id, data) {
                var retD= data.result.retData;
                $("#weike").attr("href", retD.toString().split('-')[1]);
                $("#weike").attr("alt", retD.toString().split('-')[0]);

                $("#weike").html("点击查看");
                // $("#weike").attr("src", decodeURIComponent(data.url))
            },
            onUploadError: function (id, message) {
                alert("上传失败" + message);
            },
            onFileTypeError: function (file) {
                alert("所选文件格式不被支持" + file.name);
            },
            
            onFileSizeError: function (file) {
                alert("文件超过大小限制");
            },
            onFileExtError: function (file) {
                alert('文件 \'' + file.name + '\' 格式错误');
            },
            onFallbackMode: function (message) {
                alert('Browser not supported(do something else here!): ' + message);
            }
        });

        $('#drag-and-drop-zone').dmUploader({
            url: 'Uploade.ashx?Func=UplodWeik&Type=1&UserIdCard=' + $("#HUserIdCard").val(),
            dataType: 'json',
            //data: { id: 'signImage', uploadFileName: image_path },
            //options: { Func: "UplodWeik", Type: 1, UserIdCard: GetUrlDate.UserIdCard },
            //allowedTypes: '*',
            extFilter: 'jpg;png;gif',
            onUploadSuccess: function (id, data) {
                $("#img_Pic").attr("src", data.result.retData);

                //$("#img_Pic").attr("src", decodeURIComponent(data.url))
            },
            onUploadError: function (id, message) {
                alert("上传失败" + message);
            },
            onFileTypeError: function (file) {
                alert("所选文件格式不被支持" + file.name);
            },
            onFallbackMode: function (message) {
                alert('浏览器不支持' + message);
            }
        });
    </script>
    <script type="text/javascript">

        function AddWeike() {

            var weikePic = $("#img_Pic").attr("src");
            var weike = $("#weike").attr("alt");
            var CourceID = UrlDate.CourceID;
            var ChapterID = UrlDate.ChapterID;
            var IsVideo = UrlDate.IsVideo;
            $.ajax({
                url: "Uploade.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    func: "AddWeike", VidoeImag: weikePic, ResourcesID: weike, "CourceID": CourceID, "ChapterID": ChapterID, "IsVideo": IsVideo, "UserIdCard": $("#HUserIdCard").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        if (IsVideo == "1") {
                            parent.BindWeikeResource();
                        }
                        else {
                            parent.BindPutongResource();
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
    </script>
</body>
</html>

