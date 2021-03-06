﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DictionaryEdit.aspx.cs" Inherits="SMSWeb.Portal.Admin.DictionaryEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="/PortalCss/bootstrap.min.css" rel="stylesheet" />
    <link href="/PortalCss/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="/PortalCss/syntax.css" rel="stylesheet" />
    <link href="/PortalCss/demo.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/webuploader.css" />
    <link rel="stylesheet" type="text/css" href="/css/webuploader-style.css" />
    <link rel="stylesheet" type="text/css" href="/css/webuploader-demo.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="../../Scripts/layer/layer.js"></script>
    <script src="../../Scripts/jquery.cookie.js"></script>
    <script src="../../Scripts/Common.js"></script>
    <script src="../../Scripts/Webuploader/webuploader.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HId" runat="server" />
        <input type="hidden" id="HShowImgUrl" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                        <label for="">标题：</label>
                        <input type="text" placeholder="标题" class="text" id="Title" value="" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">类型：</label>
                        <select id="Type">
                            <option value="0">国标</option>
                            <option value="1">校标</option>
                            <option value="2">行标</option>
                        </select>
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">图片信息：</label>
                        <div id="showUploader" class="none">
                            <img src="" id="ShowImgUrl" alt="" width="200px" height="200px" /><input type="button" value="删除" id="btnDelShowImg" class="course_btn confirm_btn" />
                        </div>
                        <div id="uploader" class="wu-example" style="display: none;">
                            <div class="queueList">
                                <div id="dndArea" class="placeholder">
                                    <div id="filePicker" class="webuploader-container">
                                        <div class="webuploader-pick">点击选择图片</div>
                                        <div id="rt_rt_1alshdmov10qicndmab1ftopc51" style="position: absolute; top: 0px; left: 227.5px; width: 168px; height: 44px; overflow: hidden; bottom: auto; right: auto;">
                                            <input type="file" name="file" class="webuploader-element-invisible" multiple="multiple" accept="image/*" /><label style="opacity: 0; width: 100%; height: 100%; display: block; cursor: pointer; background: rgb(255, 255, 255);"></label>
                                        </div>
                                    </div>
                                    <p>或将照片拖到这里，单次最多选1张</p>
                                </div>
                                <ul class="filelist"></ul>
                            </div>
                            <div class="statusBar" style="display: none;">
                                <div class="progress" style="display: none;">
                                    <span class="text">0%</span>
                                    <span class="percentage" style="width: 0%;"></span>
                                </div>
                                <div class="info">共0张（0B），已上传0张</div>
                                <div class="btns">
                                    <div id="filePicker2" class="webuploader-container">
                                        <div class="webuploader-pick none" style="border: none;"></div>
                                        <div id="rt_rt_1alshdmp81p491fmtnlh29msgf6" style="position: absolute; top: 0px; left: 0px; width: 168px; height: 44px; overflow: hidden;" class="none">
                                            <input type="file" name="file" class="webuploader-element-invisible" multiple="multiple" accept="image/*" /><label style="opacity: 0; width: 100%; height: 100%; display: block; cursor: pointer; background: rgb(255, 255, 255);"></label>
                                        </div>
                                    </div>
                                    <div class="uploadBtn state-pedding">开始上传</div>
                                </div>
                            </div>
                        </div>
                        <i class="stars"></i>
                    </div>


                </div>
                <div style="clear: both"></div>

                <div class="course_form_select clearfix">
                    <a href="javscript:;" class="course_btn confirm_btn" onclick="saveData()" id="btnCreate">确定</a>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        jQuery(function () {
            var $ = jQuery,    // just in case. Make sure it's not an other libaray.

                $wrap = $('#uploader'),

                // 图片容器
                $queue = $('<ul class="filelist"></ul>')
                    .appendTo($wrap.find('.queueList')),

                // 状态栏，包括进度和控制按钮
                $statusBar = $wrap.find('.statusBar'),

                // 文件总体选择信息。
                $info = $statusBar.find('.info'),

                // 上传按钮
                $upload = $wrap.find('.uploadBtn'),

                // 没选择文件之前的内容。
                $placeHolder = $wrap.find('.placeholder'),

                // 总体进度条
                $progress = $statusBar.find('.progress').hide(),

                // 添加的文件数量
                fileCount = 0,

                // 添加的文件总大小
                fileSize = 0,

                // 优化retina, 在retina下这个值是2
                ratio = window.devicePixelRatio || 1,

                // 缩略图大小
                thumbnailWidth = 110 * ratio,
                thumbnailHeight = 110 * ratio,

                // 可能有pedding, ready, uploading, confirm, done.
                state = 'pedding',

                // 所有文件的进度信息，key为file id
                percentages = {},

                supportTransition = (function () {
                    var s = document.createElement('p').style,
                        r = 'transition' in s ||
                              'WebkitTransition' in s ||
                              'MozTransition' in s ||
                              'msTransition' in s ||
                              'OTransition' in s;
                    s = null;
                    return r;
                })(),

                // WebUploader实例
                uploader;

            if (!WebUploader.Uploader.support()) {
                layer.msg('Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
                throw new Error('WebUploader does not support the browser you are using.');
            }

            // 实例化
            uploader = WebUploader.create({
                pick: {
                    id: '#filePicker',
                    label: '点击选择图片'
                },
                dnd: '#uploader .queueList',
                paste: document.body,

                accept: {
                    title: 'Images',
                    extensions: 'gif,jpg,jpeg,bmp,png',
                    mimeTypes: 'image/*'
                },

                // swf文件路径
                swf: '../../Scripts/Webuploader/Uploader.swf',

                disableGlobalDnd: true,

                chunked: true,
                server: '/Portal/UploadImage.ashx',
                formData: { action: "UploadImgForShoolStyle" },
                fileNumLimit: 1,//上传个数
                fileSizeLimit: 5 * 1024 * 1024,    // 200 M
                fileSingleSizeLimit: 1 * 1024 * 1024    // 50 M
            });

            // 添加“添加文件”的按钮，
            //uploader.addButton({
            //    id: '#filePicker2',
            //    label: '继续添加'
            //});

            // 当有文件添加进来时执行，负责view的创建
            function addFile(file) {
                var $li = $('<li id="' + file.id + '">' +
                        '<p class="title">' + file.name + '</p>' +
                        '<p class="imgWrap"></p>' +
                        '<p class="progress"><span></span></p>' +
                        '</li>'),

                    $btns = $('<div class="file-panel">' +
                        '<span class="cancel">删除</span>' +
                        '<span class="rotateRight">向右旋转</span>' +
                        '<span class="rotateLeft">向左旋转</span></div>').appendTo($li),
                    $prgress = $li.find('p.progress span'),
                    $wrap = $li.find('p.imgWrap'),
                    $info = $('<p class="error"></p>'),

                    showError = function (code) {
                        switch (code) {
                            case 'exceed_size':
                                text = '文件大小超出';
                                break;

                            case 'interrupt':
                                text = '上传暂停';
                                break;

                            default:
                                text = '上传失败，请重试';
                                break;
                        }

                        $info.text(text).appendTo($li);
                    };

                if (file.getStatus() === 'invalid') {
                    showError(file.statusText);
                } else {
                    // @todo lazyload
                    $wrap.text('预览中');
                    uploader.makeThumb(file, function (error, src) {
                        if (error) {
                            $wrap.text('不能预览');
                            return;
                        }

                        var img = $('<img src="' + src + '">');
                        $wrap.empty().append(img);
                    }, thumbnailWidth, thumbnailHeight);

                    percentages[file.id] = [file.size, 0];
                    file.rotation = 0;
                }

                file.on('statuschange', function (cur, prev) {
                    if (prev === 'progress') {
                        $prgress.hide().width(0);
                    } else if (prev === 'queued') {
                        $li.off('mouseenter mouseleave');
                        $btns.remove();
                    }

                    // 成功
                    if (cur === 'error' || cur === 'invalid') {
                        console.log(file.statusText);
                        showError(file.statusText);
                        percentages[file.id][1] = 1;
                    } else if (cur === 'interrupt') {
                        showError('interrupt');
                    } else if (cur === 'queued') {
                        percentages[file.id][1] = 0;
                    } else if (cur === 'progress') {
                        $info.remove();
                        $prgress.css('display', 'block');
                    } else if (cur === 'complete') {
                        $li.append('<span class="success"></span>');
                    }

                    $li.removeClass('state-' + prev).addClass('state-' + cur);
                });

                $li.on('mouseenter', function () {
                    $btns.stop().animate({ height: 30 });
                });

                $li.on('mouseleave', function () {
                    $btns.stop().animate({ height: 0 });
                });

                $btns.on('click', 'span', function () {
                    var index = $(this).index(),
                        deg;

                    switch (index) {
                        case 0:
                            uploader.removeFile(file);
                            return;

                        case 1:
                            file.rotation += 90;
                            break;

                        case 2:
                            file.rotation -= 90;
                            break;
                    }

                    if (supportTransition) {
                        deg = 'rotate(' + file.rotation + 'deg)';
                        $wrap.css({
                            '-webkit-transform': deg,
                            '-mos-transform': deg,
                            '-o-transform': deg,
                            'transform': deg
                        });
                    } else {
                        $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + (~~((file.rotation / 90) % 4 + 4) % 4) + ')');

                    }


                });

                $li.appendTo($queue);
            }

            // 负责view的销毁
            function removeFile(file) {
                var $li = $('#' + file.id);

                delete percentages[file.id];
                updateTotalProgress();
                $li.off().find('.file-panel').off().end().remove();
            }

            function updateTotalProgress() {
                var loaded = 0,
                    total = 0,
                    spans = $progress.children(),
                    percent;

                $.each(percentages, function (k, v) {
                    total += v[0];
                    loaded += v[0] * v[1];
                });

                percent = total ? loaded / total : 0;

                spans.eq(0).text(Math.round(percent * 100) + '%');
                spans.eq(1).css('width', Math.round(percent * 100) + '%');
                updateStatus();
            }

            function updateStatus() {
                var text = '', stats;

                if (state === 'ready') {
                    text = '选中' + fileCount + '张图片，共' +
                            WebUploader.formatSize(fileSize) + '。';
                } else if (state === 'confirm') {
                    stats = uploader.getStats();
                    if (stats.uploadFailNum) {
                        text = '已成功上传' + stats.successNum + '张照片至XX相册，' +
                            stats.uploadFailNum + '张照片上传失败，<a class="retry" href="#">重新上传</a>失败图片或<a class="ignore" href="#">忽略</a>'
                    }

                } else {
                    stats = uploader.getStats();
                    text = '共' + fileCount + '张（' +
                            WebUploader.formatSize(fileSize) +
                            '），已上传' + stats.successNum + '张';

                    if (stats.uploadFailNum) {
                        text += '，失败' + stats.uploadFailNum + '张';
                    }
                }

                $info.html(text);
            }

            function setState(val) {
                var file, stats;

                if (val === state) {
                    return;
                }

                $upload.removeClass('state-' + state);
                $upload.addClass('state-' + val);
                state = val;

                switch (state) {
                    case 'pedding':
                        $placeHolder.removeClass('element-invisible');
                        $queue.parent().removeClass('filled');
                        $queue.hide();
                        $statusBar.addClass('element-invisible');
                        uploader.refresh();
                        break;

                    case 'ready':
                        $placeHolder.addClass('element-invisible');
                        $('#filePicker2').removeClass('element-invisible');
                        $queue.parent().addClass('filled');
                        $queue.show();
                        $statusBar.removeClass('element-invisible');
                        uploader.refresh();
                        break;

                    case 'uploading':
                        $('#filePicker2').addClass('element-invisible');
                        $progress.show();
                        $upload.text('暂停上传');
                        break;

                    case 'paused':
                        $progress.show();
                        //$upload.text('继续上传');
                        break;

                    case 'confirm':
                        $progress.hide();
                        $upload.text('开始上传').addClass('disabled');

                        stats = uploader.getStats();
                        if (stats.successNum && !stats.uploadFailNum) {
                            setState('finish');
                            return;
                        }
                        break;
                    case 'finish':
                        stats = uploader.getStats();
                        if (stats.successNum) {
                            layer.msg('上传成功');
                        } else {
                            // 没有成功的图片，重设
                            state = 'done';
                            location.reload();
                        }
                        break;
                }

                updateStatus();
            }

            uploader.onUploadProgress = function (file, percentage) {
                var $li = $('#' + file.id),
                    $percent = $li.find('.progress span');

                $percent.css('width', percentage * 100 + '%');
                percentages[file.id][1] = percentage;
                updateTotalProgress();
            };

            uploader.onFileQueued = function (file) {
                fileCount++;
                fileSize += file.size;

                if (fileCount === 1) {
                    $placeHolder.addClass('element-invisible');
                    $statusBar.show();
                }

                addFile(file);
                setState('ready');
                updateTotalProgress();
            };

            uploader.onFileDequeued = function (file) {
                fileCount--;
                fileSize -= file.size;

                if (!fileCount) {
                    setState('pedding');
                }

                removeFile(file);
                updateTotalProgress();

            };

            // 文件上传成功，给item添加成功class, 用样式标记上传成功。
            uploader.on('uploadSuccess', function (file) {
                $('#' + file.id).addClass('upload-state-done');
            });

            uploader.on('uploadAccept', function (file, response) {
                if (response) {
                    var jsonVal = eval('(' + decodeURIComponent(response._raw) + ')');
                    $("#HShowImgUrl").val(jsonVal.path);
                    // 通过return false来告诉组件，此文件上传有错。
                    return true;
                }
                $("#HShowImgUrl").val("");
                return false;
            });


            uploader.on('all', function (type) {
                var stats;
                switch (type) {
                    case 'uploadFinished':
                        setState('confirm');
                        break;

                    case 'startUpload':
                        setState('uploading');
                        break;

                    case 'stopUpload':
                        setState('paused');
                        break;

                }
            });

            uploader.onError = function (code) {
                layer.msg('Eroor: ' + code);
            };

            $upload.on('click', function () {
                if ($(this).hasClass('disabled')) {
                    return false;
                }

                if (state === 'ready') {
                    uploader.upload();
                } else if (state === 'paused') {
                    uploader.upload();
                } else if (state === 'uploading') {
                    uploader.stop();
                }
            });

            $info.on('click', '.retry', function () {
                uploader.retry();
            });

            $info.on('click', '.ignore', function () {
                layer.msg('todo');
            });

            $upload.addClass('state-' + state);
            updateTotalProgress();
        });

        $(function () {
            initDictionary();
            $("#btnDelShowImg").click(function () {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { PageName: "PortalManage/AdminManager.ashx", Func: "UpdateDictionary", Id: $("#HId").val(), ShowImgUrl: "" },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#HShowImgUrl").val("");
                            $("#ShowImgUrl").attr("src", "");
                            $("#showUploader").hide();
                            $("#uploader").show();
                            $('#filePicker div:eq(1)').css({ 'position': 'absolute', 'width': '126px', 'height': '36px', 'left': '50%', 'top': '50%', 'margin-left': '-61px', 'margin-top': '-18px' });
                        }
                        else { parent.layer.msg('删除失败！'); }
                    },
                    error: function (errMsg) {
                        parent.layer.msg('删除失败！');
                    }
                });

            });
        })

        function initDictionary() {
            if ($("#HId").val() != "") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/AdminManager.ashx",
                        "func": "GetDictionary",
                        "Id": $("#HId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null) {
                                $("#Title").val(item.Title);
                                $("#Type").val(item.Type);
                                if (item.ImageUrl != null && item.ImageUrl != "" && item.ImageUrl.length > 0) {
                                    $("#ShowImgUrl").attr("src", item.ImageUrl);
                                    $("#showUploader").show();
                                    $("#HShowImgUrl").val(item.ImageUrl);
                                } else {
                                    $("#uploader").show();
                                    $('#filePicker div:eq(1)').css({ 'position': 'absolute', 'width': '126px', 'height': '36px', 'left': '50%', 'top': '50%', 'margin-left': '-61px', 'margin-top': '-18px' });
                                }

                            }
                        }
                    },
                    error: OnError
                });
            } else {
                $("#uploader").show();
                $('#filePicker div:eq(1)').css({ 'position': 'absolute', 'width': '126px', 'height': '36px', 'left': '50%', 'top': '50%', 'margin-left': '-61px', 'margin-top': '-18px' });
            }
        }

        function saveData() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdminManager.ashx",
                    "func": "EditDictionary",
                    "Title": $("#Title").val(),
                    "ImageUrl": $("#HShowImgUrl").val(),
                    "Id": $("#HId").val(),
                    "Type": $("#Type").val()
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
