<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CertificateShow.aspx.cs" Inherits="SMSWeb.PersonalSpace.CertificateShow" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>证书预览</title>
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <!--证书-->
    <link rel="stylesheet" href="/css/certificate.css">
    <link rel="stylesheet" href="/css/certificateT.css">
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>

    <%--<script src="/Scripts/jquery-1.11.2.min.js"></script>--%>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../js/jquery.jqprint.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.1.0.js"></script>
    <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>

    <style>
        .un_reposity .uploadify-button {
            border: 1px solid #cfd8df;
            background: #fff;
            font-size: 12px;
            color: #666666;
            height: 30px;
            border-radius: 2px;
        }

        .un_reposity .swfupload {
            left: 0;
            top: 0;
        }
    </style>
    <script>
        var GetUrlDate = new GetUrlDate();
        $(function () {
            if (GetUrlDate.Type == "1") {
                ShowPlat();
            }
            else {
                ShowStu();
            }
            $("#print").click(function () {
                $(".divCertificate").jqprint({
                    debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
                    importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
                    printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
                    operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
                });
            })
            $("#GenerateImg").on("click", function (event) {
                event.preventDefault();
                html2canvas($(".viewimg"), {
                    allowTaint: true,
                    taintTest: false,
                    onrendered: function (canvas) {
                        canvas.id = "mycanvas";
                        //document.body.appendChild(canvas);
                        //生成base64图片数据
                        var dataUrl = canvas.toDataURL();
                        var newImg = document.createElement("img");
                        newImg.src = dataUrl;
                        var w = window.open('about:blank', 'image from canvas');
                        w.document.write("<img src='" + dataUrl + "' alt='from canvas'/><br/><span style='color:red;'>注：右击图片区域保存图片到本地，选择保存的图片可以下载预览状态的证书<br />下载的图片可以在管理页面上传到对应证书以便于在门户系统展示。" +
                            "</span>");
                        //<br /> <div onclick=\"$('#uploadify').click();\" style=\"border-radius: 2px; float: left; overflow: hidden; width: 83px; height: 28px; text-align: center; font-size: 12px; " +
                        //    "z-index: 2; cursor: pointer;\" class=\"un_reposity\"><input name=\"uploadify\" id=\"uploadify\" style=\"display: none;\" type=\"file\" multiple=\"multiple\"></div>" +
                        //    "<input type=\"button\" class=\"btn fl\" id=\"GenerateImg\" style=\"left: 200px; top: 380px; width: 86px; float: left; position: absolute;\" value=\"上传至平台\" />
                        //document.body.appendChild(newImg);
                        //Canvas2Image.saveAsPNG(canvas);
                        //$.ajax({
                        //    url: "GernrateImg.ashx",//random" + Math.random(),//方法所在页面和方法名
                        //    type: "post",
                        //    dataType: "text",
                        //    data: { dataUrl: dataUrl },
                        //    success: function (json) {
                        //        window.open(json);
                        //    }, 
                        //    error: function (errMsg) {
                        //        layer.msg(errMsg);
                        //    }
                        //});



                        // saveAs(dataUrl, "new.svg")


                    }
                });
            });
        })
        function saveAs(Url, filename) {

            var blob = new Blob([''], { type: 'application/octet-stream' });

            var url = webkitURL.createObjectURL(blob);

            var a = document.createElementNS(xhtml, 'a');

            a.href = Url;

            a.download = filename;

            var e = document.createEvent('MouseEvents');

            e.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);

            a.dispatchEvent(e);

            webkitURL.revokeObjectURL(url);
        }
        function ShowPlat() {
            $("#CertificateID").html("201711747074");
            $("#CreateTime").html("2016-6-1");
            $("#CerName").html(GetUrlDate.Name);
            $("#StuName").html("张三");
            $("#CourseName").html(GetUrlDate.CourseName);
            $("#Score").html(GetUrlDate.ExamName);
            var src = GetUrlDate.ImageUrl;
            src = src.replace('_s.jpg', '.jpg');
            $("#Modole_show").attr("src", src)

        }
        function ShowStu() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetCertificates",
                    ID: GetUrlDate.ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var Time = DateTimeConvert(json.result.retData[0].CreateTime, "yyyy-MM-dd");
                        $("#CertificateID").html(json.result.retData[0].Identifier);
                        $("#CreateTime").html(Time);
                        $("#CerName").html(json.result.retData[0].cName);
                        $("#StuName").html(json.result.retData[0].CreateName);
                        var src = json.result.retData[0].ImageUrl;
                        src = src.replace('_s.jpg', '.jpg');
                        $("#Modole_show").attr("src", src)
                    }
                    else {
                        $("#divCertificate").html("数据读取失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#tbCertificate").html(errMsg);
                }
            });
        }
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />


    <form id="form1" runat="server">
        <div class="cert_view" id="divCertificate">
            <div id="PreviewCer" class="viewimg" style="margin: 0 auto; margin-top: 20px; width: 470px;">
                <div id="ccpic">
                    <img src="" style="height: 340px;" id="Modole_show">
                </div>
                <div style="position: absolute; z-index: 1; width: 460px; height: 30px; margin-top: -260px; text-align: center;">
                    <span style="font-size: 22px; color: #902226; letter-spacing: 3px;" id="CerName"></span>
                </div>
                <div id="StuName" style="position: absolute; z-index: 1; width: 460px; height: 30px; margin-top: -215px; text-align: center;">
                    <span style="font-size: 22px; letter-spacing: 3px;"><%=Name %></span>
                </div>
                <div id="CerInfo" style="position: absolute; z-index: 1; width: 360px; margin-left: 60px; height: 60px; margin-top: -180px; text-align: left;">
                    <span id="cInfo" style="font-size: 20px; letter-spacing: 2px; color: #707070; font-family: ''">顺利完成
                                <span id="CourseName">注册会计师</span>课程
                                            课程的学习,成绩[<span id="Score">86</span>分],颁发此证书.</span>
                </div>
                <div id="oSign" style="display: none; position: absolute; z-index: 1; margin-left: 85px; margin-top: -110px;">
                    <span id="oSign1" style="font-size: 12px; color: #707070; float: left;"></span>
                    <div id="SIign1Pic" style="float: left; margin-top: -10px;"></div>
                </div>
                <div id="tSign" style="position: absolute; z-index: 1; margin-left: 330px; margin-top: -110px; display: block;">
                    <span id="tSign1" style="font-size: 12px; color: #707070; float: left;"></span>
                    <div id="SIign2Pic" style="float: left; margin-top: -10px;"></div>
                </div>
                <div id="oSign22" style="display: none; position: absolute; z-index: 1; margin-left: 330px; margin-top: -110px;">
                    <span id="oSign2" style="font-size: 12px; color: #707070; float: left;"></span>
                    <div id="SIign3Pic" style="float: left; margin-top: -10px;"></div>
                </div>
                <div id="CercNo" style="position: absolute; z-index: 1; margin-top: -73px; margin-left: 110px;">
                    <span style="font-size: 12px; color: #707070;" id="CertificateID"></span>
                </div>
                <div id="qrcode" style="position: absolute; z-index: 1; height: 30px; margin-top: -110px; margin-left: 208px;" title="http://www.baidu.com">
                    <canvas width="50" height="50" style="display: none;"></canvas>
                    <img alt="Scan me!" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAChklEQVRoQ+1Z7XKDMAyD939oenANZ4Iky5Rubbb+2kpIIn/IsjtP07RMhc+yLNM8z9sb69/rp/0ft0HP1HfxXbRfdsX1Rks7QC3uLx8BqPfX99hz9gydxe7W1o4JxAmRaN24Xlm9t2YWYldC9+CRPwdEWcxJ8rgGefLHPYKYpr9Yluwo7P6BXKXfZs2M95GXWh3q30V1yikLL9HvxwHJqmZfsVEM90mOEtp9L/Mwuu/mkSGAWPqkgvS5NlpfWZh5snrkHIE4h7NkZJSJlICqIxldM+IYEwhMIiHZme6KEl+pZKTVlH5T6w8e+WogqB+JcaoKlmqkHG+hfEBnqwZur2WMfp264FTcSA5qvQNcaTtaR74SCKM01pc7rnYsfEerewitYYG4gwWnH3HXONUf7SU9MgyQjH57+Z6Ng9TwodJRRgP3e9LhQ4W1XOCof0HnsDCTBosFUUkAV+ihAnqy3lP2IFZUdccG4loMrWPhg/It01htLyfs2l6w1XU8o+I1E41vAcL6ESYnVL+g6BHpsooxVHhu+wwDJEt2lQ/OlFDlCEvsKp3vHunbVFUQswlHJUEz1lL9/Km1XkNrCCCssWLJjqzIvuvZy6Ftda46J6VftDGS8UzaqzzKLu2efWItd2NHqVbCVeUke9bf4dKkUQHOyIAVy1jN1YyM7T8WEMXbfYJG7lctr5MbqB2u1qb9fld+nmauZzKEsdXbgKD4U/2Ckvbx8hWPZ4TD5guXftVFHmGXvUNkKk9DGe96JFOiWYghqyO6RvnJPPaSR9CF1YjVbWvVeCrSdKwxYwJxCl3GNE7+qBCOVkbWp0ORK/SrYvdXgWSUx5LX6b3dqUiVaG7VWp8E5AGcK2oZBWLIXQAAAABJRU5ErkJggg==" style="display: block;">
                </div>
                <div id="CerTime" style="position: absolute; z-index: 1; margin-top: -73px; margin-left: 315px;">
                    <span style="font-size: 12px; letter-spacing: 2px; color: #707070;" id="CreateTime"></span>
                </div>
            </div>
            <div class="clearfix" style="width: 130px; margin: 0 auto;">
                <input type="button" class="btn fl" id="print" value="打印" style="width: 50px; float: left; margin-right: 10px;" />
                <input type="button" class="btn fl" id="GenerateImg" style="width: 70px; float: left;" value="生成图片" />
            </div>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    $(function () {
        $("#uploadify").uploadify({
            'auto': true,                      //是否自动上传
            'swf': '../Scripts/Uploadyfy/uploadify/uploadify.swf',
            //'uploader': 'http://192.168.10.92:9005/ImageUpLoadHandler.ashx',
            //'uploader': '/SystemSettings/UserInfo.ashx',
            //'formData': { Func: "UplodWeik", Type: 2}, //参数

            'formData': { Func: "StudentImage", ImageName: $("#PhotoName").val() }, //参数
            //'fileTypeDesc': '',
            'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
            'buttonText': '更换头像',//按钮文字
            // 'cancelimg': 'uploadify/uploadify-cancel.png',
            'width': 83,
            'height': 28,
            //最大文件数量'uploadLimit':
            'multi': false,//单选            
            'fileSizeLimit': '20MB',//最大文档限制
            'queueSizeLimit': 1,  //队列限制
            'removeCompleted': true, //上传完成自动清空
            'removeTimeout': 0, //清空时间间隔
            //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
            'onUploadSuccess': function (file, data, response) {
                //location.reload();
                var json = $.parseJSON(data);
                var errNum = json.result.errMsg;
                if (errNum == "0") {
                    layer.msg("更新成功！");
                    location.reload();
                }
                if (errNum == "1") {
                    layer.msg("更新失败！");
                }
            },

        });
       
    })

</script>
