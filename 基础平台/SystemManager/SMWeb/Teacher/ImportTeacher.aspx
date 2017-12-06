<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportTeacher.aspx.cs" Inherits="SMWeb.Teacher.ImportTeacher" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>导入教师</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script type="text/javascript">
        var GetUrlDate = new GetUrlDate();

        $(function () {
            $("#uploadify1").uploadify({
                'auto': true,                      //是否自动上传
                'swf': '../Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': WebServiceUrl + 'TeacherHandler.ashx',
                'formData': { Func: "UploadTeacherExcel" }, //参数
                'fileTypeExts': '*.xls;*.xlsx',
                'buttonText': '选择Excel',//按钮文字
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
                    if (json.result.errNum == 0) {
                        $("#weike").attr("src", json.result.retData);
                        $("#Prompt").html("已上传文件，点击导入");
                    } else {
                        $("#Prompt").html("上传失败" );
                    }
                    

                },

            });
        });

    </script>
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
        <!--创建dialog-->
        <div style="background: #fff; height: 215px;">
            <div style="width: 258px;  overflow: hidden; margin: 0px auto; position: relative; top: 20px;" class="select_face">
                <span >如果没有模板，需要先<a href="../Temp/TeacherInfo.xlsx" style="color:red;">下载模板</a>，<br />填好数据后进行导入</span>
            </div>
            
            <div class="select_reposity" style="width: 95px; margin: 25px auto 0px auto; padding-top:5px;padding-left:20px;border: 1px solid #1783c7;">
                <input type="file" id="uploadify1" multiple="multiple" />
            </div>

            <a id="weike" />
            <div style="margin-top: 10px; text-align: center">
                <span id="Prompt"></span><br /><br />
                <input id="Button1" type="button" value="导入" onclick="ImportTeacher()" style="border-radius: 3px; text-decoration: none; font-size: 14px; background-color: #0DA6EC; color: white; border: 0px; padding: 6px 15px; cursor: pointer;" />
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script type="text/javascript">

        function ImportTeacher() {
            $("#Prompt").html("正在导入...，请勿关闭");
            $("#Button1").hide();
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                //async: false,
                dataType: "json",
                data: {
                    PageName: "TeacherHandler.ashx",
                    func: "ImportTeacher",
                    SystemKey: SystemKey,
                    InfKey: InfKey,
                    FilePath: $("#weike").attr("src")
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        $("#Prompt").html(result.errMsg);
                        parent.getData(1);
                    } else {
                        $("#Prompt").html("导入失败");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#Prompt").html("导入失败");
                }
            });
        }
    </script>
</body>
</html>

