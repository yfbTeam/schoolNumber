<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportSubject.aspx.cs" Inherits="SMSWeb.Exam.ImportSubject" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>导入试题</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();

        $(function () {
            $("#uploadify1").uploadify({
                'auto': true,                      //是否自动上传
                'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': '/CourseManage/Uploade.ashx',
                'formData': { Func: "UploadSubJect" }, //参数
                'fileTypeExts': '*.doc;*.docx',
                'buttonText': '选择Word',//按钮文字
                // 'cancelimg': 'uploadify/uploadify-cancel.png',
                //'width': 90,
                //'height': 24,
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
                        $("#Prompt").html("上传失败");
                    }


                },

            });
        });
        var i = 0;
        function ImportStudent() {
            i = 0;
            $("#Msg").html("数据导入中请勿关闭窗口");
            var src = $("#weike").attr("src");
            $.ajax({
                url: "/CourseManage/Uploade.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "Func": "ImportSubJect",
                    "Path": encodeURI(src)//"C:\\数字校园\\应用平台\\Schoocube_Manage_System\\SMSWeb\\Exam\\2012年北京市夏季会考化学试卷.doc")// 
                },
                success: function (json) {
                    if (json.result.errNum == 0) {
                        $("#Msg").html("数据读取成功，待处理");
                        if (json.result.danxuan != null) {
                            var Major = UrlDate.HPeriod + '|' + UrlDate.HSubject;
                            var Book = UrlDate.bookVersion + '|' + UrlDate.HTextboox;
                            var Chapter = "";
                            var part = UrlDate.HChapterID;

                            //单选、多选、简答、判断
                            $.each(json.result.danxuan, function () {
                                AddQ(this.Content, Major, Major, Book, Chapter, part, 1, this.Difficulty, 1, this.Content, this.Answer, this.Analysis, 1, this.Score, this.Options);
                            });
                        }
                        if (json.result.duoxuan != null) {
                            $.each(json.result.duoxuan, function () {
                                AddQ(this.Content, Major, Major, Book, Chapter, part, 2, this.Difficulty, 1, this.Content, this.Answer, this.Analysis, 1, this.Score, this.Options);
                            });
                        }
                        if (json.result.jianda != null) {

                            //单选、多选、简答、判断
                            $.each(json.result.jianda, function () {
                                (this.Content, Major, Major, Book, Chapter, part, 3, this.Difficulty, 1, this.Content, this.Answer, this.Analysis, 1, this.Score, this.Options);
                            });
                        }
                        if (json.result.panduan != null) {
                            $.each(json.result.panduan, function () {
                                AddQ(this.Content, Major, Major, Book, Chapter, part, 4, this.Difficulty, 1, this.Content, this.Answer, this.Analysis, 1, this.Score, this.Options);
                            });
                        }
                        parent.layer.msg('导入成功!');
                        parent.CloseIFrameWindow();
                    }
                },
                error: function (json) {
                    //$("#qTypediv").html(json.result.errMsg.toString());
                }
            });
        }
        function AddQ(Title, Subject, Major, Book, Chapter, part, Type, Difficulty, Status, Question, Answer, Analysis, isshowanalysis, Score, Options) {
            var OptionA = "";
            var OptionB = "";
            var OptionC = "";
            var OptionD = "";
            var OptionE = "";
            var OptionF = "";
            if (Type != 3) {

                OptionA = StrSub("A．", "B．", Options);
                OptionB = StrSub("B．", "C．", Options);
                OptionC = StrSub("C．", "D．", Options);
                OptionD = StrSub("D．", "E．", Options);
                OptionE = StrSub("E．", "F．", Options);
                OptionF = StrSub("F．", "", Options);
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                //async: false,
                data: {
                    PageName: "/Exam/ExamHandler.ashx", "action": "AddExamQuestion", "Title": Title, "Subject": Subject, "Major": Major, "Book": Book,
                    "Chapter": Chapter, "Part": part, "Type": Type, "Difficulty": Difficulty, "Status": Status, "Question": Question,
                    "OptionA": OptionA, "OptionB": OptionB, "OptionC": OptionC, "OptionD": OptionD, "OptionE": OptionE, "OptionF": OptionF,
                    "Answer": Answer, "CAnswer": Answer, "Analysis": Analysis, "isshowanalysis": isshowanalysis, "Author": $("#HUserIdCard").val(), "Score": Score
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        i++;
                        $("#Msg").html("成功处理" + i + "条数据");

                        parent.getData(1, 10);
                    }
                    else {
                        parent.layer.msg(json.result.errMsg);
                    }
                }

            });
        }
        //获取选项内容
        function StrSub(Section1, Section2, Content) {
            if (Content != null && Content != undefined && Content != "") {

                var StartLen = Content.indexOf(Section1) + 2;
                var Len = Content.indexOf(Section2);
                if (Section2 == "" || Len <= 0) {
                    Len = Content.length;
                }
                if (Len > 0 && StartLen > 1) {
                    return Content.substring(StartLen, Len).trim();
                }
                else
                    return "";
            } else
                return "";
        }
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
        <div style="background: #fff;">
            <div style="width: 258px; overflow: hidden; margin: 0px auto; position: relative; top: 20px;" class="select_face">
                <span>请严格按照<a href="/Exam/2012年北京市夏季会考化学试卷.doc" style="color: red;">Word模板</a>更新您的word格式，<br />
                    大标题直接以（单选题、多选题、判断题、简答题）命名其他格式不支持<br />
                    ，小标题（1.开头）选项（A、开头）<br />

                </span>
            </div>

            <div class="select_reposity" style="width: 95px; margin: 25px auto 0px auto; padding-top: 5px; padding-left: 0px; border: 0px">
                <input type="file" id="uploadify1" multiple="multiple" />
            </div>

            <a id="weike" />
            <div style="margin-top: 10px; text-align: center">
                <span id="Prompt"></span>
                <br />
                <br />
                <input id="Button1" type="button" value="导入" onclick="ImportStudent()" style="border-radius: 3px; text-decoration: none; font-size: 14px; background-color: #0DA6EC; color: white; border: 0px; padding: 6px 15px; cursor: pointer;" />
            </div>
            <div id="Msg" style="color: red; text-align: center;"></div>
        </div>
    </form>
    <script src="/js/common.js"></script>

</body>
</html>
