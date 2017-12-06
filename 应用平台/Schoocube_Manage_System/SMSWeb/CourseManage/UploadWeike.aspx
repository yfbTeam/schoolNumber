<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadWeike.aspx.cs" Inherits="SMSWeb.CourseManage.UploadWeike" %>

<!DOCTYPE html>
<%--<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Daniel.uy - Online Code Demos</title>
    <link href="/css/simple-demo.css" rel="stylesheet" />
</head>
<body>

    <div class="wrapper">
        <h1>Simple Demo</h1>
        <div class="left-column">
            <!-- D&D Markup -->
            <div id="drag-and-drop-zone" class="uploader">
                <div>Drag &amp; Drop Images Here</div>
                <div class="or">-or-</div>
                <div class="browser">
                    <label>
                        <input type="file" name="files[]" multiple="multiple" title='Click to add Files'>
                    </label>
                </div>
            </div>
            <!-- /D&D Markup -->
        </div>
        <div id="fileList">
            <!-- Files will be places here -->
        </div>         
    </div>
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="/src/dmuploader.js"></script>
    <script type="text/javascript">

        //-- Some functions to work with our UI
        function add_log(message) {
            var template = '<li>[' + new Date().getTime() + '] - ' + message + '</li>';
            $('#debug').find('ul').prepend(template);
        }

        function add_file(id, file) {
            var template = '' +
              '<div class="file" id="uploadFile' + id + '">' +
                '<div class="info">' +
                  '#1 - <span class="filename" title="Size: ' + file.size + 'bytes - Mimetype: ' + file.type + '">' + file.name + '</span><br /><small>Status: <span class="status">Waiting</span></small>' +
                '</div>' +
                '<div class="bar">' +
                  '<div class="progress" style="width:0%"></div>' +
                '</div>' +
              '</div>';

            $('#fileList').prepend(template);
        }

        function update_file_status(id, status, message) {
            $('#uploadFile' + id).find('span.status').html(message).addClass(status);
        }

        function update_file_progress(id, percent) {
            $('#uploadFile' + id).find('div.progress').width(percent);
        }

        // Upload Plugin itself
        $('#drag-and-drop-zone').dmUploader({
            url: 'Uploade.ashx',
            dataType: 'json',
            allowedTypes: '*',
            /*extFilter: 'jpg;png;gif',*/
            onInit: function () {
                add_log('Penguin initialized :)');
            },
            onBeforeUpload: function (id) {
                add_log('Starting the upload of #' + id);

                update_file_status(id, 'uploading', 'Uploading...');
            },
            onNewFile: function (id, file) {
                add_log('New file added to queue #' + id);

                add_file(id, file);
            },
            onComplete: function () {
                add_log('All pending tranfers finished');
            },
            onUploadProgress: function (id, percent) {
                var percentStr = percent + '%';

                update_file_progress(id, percentStr);
            },
            onUploadSuccess: function (id, data) {
                add_log('Upload of file #' + id + ' completed');

                add_log('Server Response for file #' + id + ': ' + JSON.stringify(data));

                update_file_status(id, 'success', 'Upload Complete');

                update_file_progress(id, '100%');
            },
            onUploadError: function (id, message) {
                add_log('Failed to Upload file #' + id + ': ' + message);

                update_file_status(id, 'error', message);
            },
            onFileTypeError: function (file) {
                add_log('File \'' + file.name + '\' cannot be added: must be an image');

            },
            onFileSizeError: function (file) {
                add_log('File \'' + file.name + '\' cannot be added: size excess limit');
            },
            /*onFileExtError: function(file){
              $.danidemo.addLog('#demo-debug', 'error', 'File \'' + file.name + '\' has a Not Allowed Extension');
            },*/
            onFallbackMode: function (message) {
                alert('Browser not supported(do something else here!): ' + message);
            }
        });
    </script>
</body>
</html>--%>
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
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>


    <style type="text/css">
        .select_face .uploadify-button {
            font-size: 14px;
        }

        .select_reposity .uploadify-button {
            font-size: 14px;
        }
    </style>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HClassID" runat="server" />

    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff; height: 100%; padding-bottom: 80px;">

            <%--<div style="width: 258px; height: 124px; border: 1px solid #1783c7; overflow: hidden; margin: 0px auto; position: relative; top: 20px;" class="select_face">
                <img id="img_Pic" alt="" src="" />
                <div style="width: 90px; height: 24px; line-height: 24px; text-align: center; display: block; background: #40bb6b; font-size: 12px; position: absolute; right: -2px; top: 0; color: #fff; z-index: 2; cursor: pointer;">
                    <input type="file" id="uploadify" multiple="multiple" />
                </div>
            </div>--%>
            <%--<div class="select_reposity" style="width: 95px; margin: 40px auto 0px auto;">
                <input type="file" id="uploadify1" multiple="multiple" />
            </div>--%>
            <div id="drag-and-drop-zone" class="uploader">
                <div>拖动封面到这里</div>
                <img id="img_Pic" alt="" src="" />
                <%--<div class="or">-or-</div>--%>
                <%--<div class="browser">
                    <label>
                        <input type="file" name="files[]" multiple="multiple" title='Click to add Files'>
                    </label>
                </div>--%>
            </div>
            <div id="drag-and-drop-zone1" class="uploader">
                <div>拖动微课视频到这里</div>
                <%--<img id="img_Pic" alt="" src="" />--%>
                <a id="vidio" class="or"></a>
                <%--<div class="browser">
                    <label>
                        <input type="file" name="files[]" multiple="multiple" title='Click to add Files'>
                    </label>
                </div>--%>
            </div>
            <a id="weike" />
            <div style="margin-top: 20px; text-align: center">
                <input id="Button1" type="button" value="确定" onclick="AddWeike()" style="border-radius: 3px; text-decoration: none; font-size: 14px; background-color: #0DA6EC; color: white; border: 0px; padding: 6px 15px; cursor: pointer;" />
            </div>
        </div>
    </form>
    <script src="/js/common.js"></script>

    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="/js/dmuploader.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#weike").attr("title", "123")
            $("#weike").html("title123")
        })

        $('#drag-and-drop-zone1').dmUploader({
            url: 'test.ashx',
            dataType: 'json',
            //allowedTypes: '*',
            extFilter: 'mp4;mav;mpeg;',

            onUploadSuccess: function (id, data) {
                $("#img_Pic").attr("src", decodeURIComponent(data.url))
                alert("上传成功");
            },
            onUploadError: function (id, message) {
                alert("上传失败");
            },
            onFallbackMode: function (message) {
                alert('Browser not supported(do something else here!): ' + message);
            }
        });
        //-- Some functions to work with our UI
        //function add_log(message) {
        //    var template = '<li>[' + new Date().getTime() + '] - ' + message + '</li>';
        //    $('#debug').find('ul').prepend(template);
        //}

        //function add_file(id, file) {
        //    var template = '' +
        //      '<div class="file" id="uploadFile' + id + '">' +
        //        '<div class="info">' +
        //          '#1 - <span class="filename" title="Size: ' + file.size + 'bytes - Mimetype: ' + file.type + '">' + file.name + '</span><br /><small>Status: <span class="status">Waiting</span></small>' +
        //        '</div>' +
        //        '<div class="bar">' +
        //          '<div class="progress" style="width:0%"></div>' +
        //        '</div>' +
        //      '</div>';

        //    $('#fileList').prepend(template);
        //}

        //function update_file_status(id, status, message) {
        //    $('#uploadFile' + id).find('span.status').html(message).addClass(status);
        //}

        //function update_file_progress(id, percent) {
        //    $('#uploadFile' + id).find('div.progress').width(percent);
        //}

        // Upload Plugin itself
        $('#drag-and-drop-zone').dmUploader({
            url: 'test.ashx',
            //url: 'Uploade.ashx?Func=UplodWeik&Type=2&UserIdCard=1',
            dataType: 'json',
            extFilter: 'mp4;',
            onInit: function () {
                //add_log('Penguin initialized :)');
            },
            onBeforeUpload: function (id) {
                //add_log('Starting the upload of #' + id);

                //update_file_status(id, 'uploading', 'Uploading...');
            },
            onNewFile: function (id, file) {
                // add_log('New file added to queue #' + id);

                //add_file(id, file);
            },
            onComplete: function () {
                //add_log('All pending tranfers finished');
            },
            onUploadProgress: function (id, percent) {
                //var percentStr = percent + '%';

                //update_file_progress(id, percentStr);
            },
            onUploadSuccess: function (id, data) {
                $("#img_Pic").attr("src", decodeURIComponent(data.url))
                alert("上传成功");
            },
            onUploadError: function (id, message) {
                alert("上传失败");

                //add_log('Failed to Upload file #' + id + ': ' + message);

                //update_file_status(id, 'error', message);
            },
            onFileTypeError: function (file) {
                alert("类型错误");
                //add_log('File \'' + file.name + '\' cannot be added: must be an image');

            },
            onFileSizeError: function (file) {
                alert(太大);
                //add_log('File \'' + file.name + '\' cannot be added: size excess limit');
            },
            onFileExtError: function (file) {
                alert('File \'' + file.name + '\' has a Not Allowed Extension');
            },
            onFallbackMode: function (message) {
                alert('Browser not supported(do something else here!): ' + message);
            }
        });
    </script>
    <%--<script type="text/javascript">

        function AddWeike() {

            var weikePic = $("#img_Pic").attr("src");
            var weike = $("#weike").attr("src");
            var CourceID = GetUrlDate.CourceID;
            var ChapterID = GetUrlDate.ChapterID;
            var IsVideo = GetUrlDate.IsVideo;
            $.ajax({
                url: "Uploade.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    func: "AddWeike", VidoeImag: weikePic, ResourcesID: weike, CourceID: CourceID, ChapterID: ChapterID, IsVideo: IsVideo
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
    </script>--%>
</body>
</html>

