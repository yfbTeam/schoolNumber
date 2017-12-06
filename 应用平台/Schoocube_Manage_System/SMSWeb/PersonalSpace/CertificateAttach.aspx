<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CertificateAttach.aspx.cs" Inherits="SMSWeb.PersonalSpace.CertificateAttach" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>上传附件</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <!--证书-->
    <link rel="stylesheet" href="/css/certificate.css" />
    <link rel="stylesheet" href="/css/certificateT.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>


    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            if (UrlDate.Type == "1") {
                Certificate();
            }
            else {
                CertificateM();
            }
            $("#uploadify").uploadify({
                'auto': true,                      //是否自动上传
                'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': '/CourseManage/Uploade.ashx',
                'formData': { Func: "UplodCert" }, //参数
                //'fileTypeDesc': '',
                'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                'buttonText': '选择图片',//按钮文字
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
                    $("#img_Pic").attr("src", decodeURIComponent(json.url));

                    //$("#img_Pic").val(data);
                },

            });
        });
        //证书附件上传
        function EditCertificate() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "EditCert",
                    ID: $("#Cert").val().toString().split('-')[0],
                    Attachment: $("#img_Pic").attr("src"),
                    Type: UrlDate.Type
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        parent.layer.msg('附件添加成功!');
                        if (UrlDate.Type == "1") {
                            parent.Certificate(1, 10);
                        }
                        else {
                            parent.BindPlatCertificate(1, 10);
                        }
                        parent.CloseIFrameWindow();
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

        function CertificateM() {
            {
                //初始化序号 
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    dataType: "json",
                    async: false,
                    data: {
                        PageName: "/Certificate/Certificate.ashx",
                        Func: "GetPlatCertificate",
                        Ispage: false
                    },
                    success: function (json) {

                        if (json.CertificateManage.errNum.toString() == "0") {
                            var option = "";
                            $.each(json.CertificateManage.retData, function (n, value) {
                                option += "<option value='" + this.ID + "-" + this.Attachment + "'>" + this.Name + "</option>";
                            })
                            $("#Cert").append(option);
                        }
                        else {
                            layer.msg(json.CertificateManage.errMsg);
                        }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }
        }
        //证书
        function Certificate() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetCertificates",
                    Ispage: false,
                    IDCard: $("#HUserIdCard").val(),
                    Status: 1
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {

                        var option = "";
                        $(json.result.retData).each(function () {
                            option += "<option value='" + this.ID + "-" + this.Attachment + "'>" + this.cName + "</option>";
                        })
                        $("#Cert").append(option);
                    }
                    else {
                    }
                },
                error: function (errMsg) {
                }
            });
        }
        function CertChange() {
            if ($("#Cert").val() == "") {
                $("#img_Pic").attr("src", "");
            }
            else {
                $("#img_Pic").attr("src", $("#Cert").val().toString().split('-')[1]);
            }
        }
    </script>
</head>
<body style="background: #fff;">
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="course_form_select clearfix">
                    <label for="">选择证书：</label>

                    <select id="Cert" onchange="CertChange()">
                        <option value="0">==选择证书==</option>
                    </select>
                </div>

                <div class="course_form_img clearfix" style="left: 20px; top: 50px;">
                    <img id="img_Pic" alt="" src="" />
                    <div class="change_picture">
                        <input type="file" id="uploadify" name="uploadify" />
                    </div>
                </div>
                <style>
                    .course_form_img .uploadify-button {
                        font-size: 14px;
                        color: #fff;
                        border: none;
                        background: #19c857;
                    }
                </style>
                <div class="course_form_select clearfix" style="margin-top: 150px;">
                    <a href="javscript:;" class="course_btn confirm_btn" onclick="EditCertificate()" id="btnCreate">确定</a>
                </div>
            </div>
        </div>
    </form>
    <script src="/js/common.js"></script>

</body>
</html>
