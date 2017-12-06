<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditQuestion.aspx.cs" Inherits="SMSWeb.Exam.EditQuestion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>编辑试题</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link type="text/css" href="/css/common.css" rel="stylesheet" />
    <link type="text/css" href="/css/repository.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/KindUeditor/kindeditor-min.js"></script>
    <script src="/Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="/Scripts/KindUeditor/lang/zh_CN.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/js/common.js"></script>
    <style>
        .upload_imga {
            margin-left: 70px;
            width: 100px;
        }

            .upload_imga img {
                max-width: 100px;
                height: auto;
            }

            .upload_imga .uploadify-button {
                font-size: 16px;
                border: none;
                background: #5493D7;
                color: #fff;
            }
    </style>
</head>
<body style="background: #fff;">
    <form id="form1" runat="server">
        <div>
            <!--添加试卷dialog-->
            <div class="dialog_detail">
                <h1 class="clearfix">
                    <div class="select_left fl">
                        当前选择：
                    </div>
                    <div class="select_right fl clearfix">

                        <div class="clearfix fl">
                            <label for="">学科：</label>
                            <select name="xueke" class="select" id="a_subject" onchange="SubjectChange(this.value)">
                                <%--<option value="">请选择</option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">教材：</label>
                            <select name="jiaocai" class="select" id="se_book" onchange="TextbookChange(this.value)">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">章：</label>
                            <select name="" class="select" id="a_chapter" onchange="ChapatorChange(this.value)">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">节：</label>
                            <select name="" class="select" id="a_part">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>

                    </div>
                </h1>
                <div class="row clearfix mt10">
                    <div class="clearfix">
                        <div class="clearfix fl">
                            <label for="">题型：</label>
                            <select name="" class="select" id="a_type" onchange="ChangeQType(this.value)">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">难易程度：</label>
                            <select name="" class="select" id="a_difficult">
                                <option value="1">简单</option>
                                <option value="2">中等</option>
                                <option value="3">困难</option>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">状态：</label>
                            <select name="" class="select" id="a_status">
                                <option value="1" class="active">启用</option>
                                <option value="2">禁用</option>
                            </select>
                            <i class="star"></i>
                        </div>
                    </div>
                </div>
                <%-- <div class="row clearfix mt10">
                    <label for="">题目：</label>
                    <input type="text" class="txt" id="a_title" placeholder="请输入题目" />
                    <i class="star"></i>
                </div>--%>
                <div class="row clearfix mt10">
                    <label for="">题干：</label>
                    <div class="froala">
                        <textarea id="Question" name="Question" class="questionarea" placeholder="请输入备注"></textarea>
                    </div>
                </div>
                <div class="row clearfix mt10">
                    <label for="">分数：</label>
                    <input type="text" class="txt" id="a_score" placeholder="请输入分数" />
                    <i class="star"></i>
                </div>

                <div class="row clearfix mt10 radio none">
                    <p class="clearfix">
                        <input id="rdoOptionA" name="answer" type="radio" value="A" /><input id="OptionA" type="text" name="OptionA" placeholder="请输入A选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionA" alt="" />
                            <input type="file" id="uploadifyOptionA" name="uploadify" />
                        </div>
                    </p>

                    <p class="clearfix">
                        <input id="rdoOptionB" name="answer" type="radio" value="B" /><input id="OptionB" type="text" name="OptionB" placeholder="请输入B选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionB" alt="" />
                            <input type="file" id="uploadifyOptionB" name="uploadify" />
                        </div>
                    </p>

                    <p class="clearfix">
                        <input id="rdoOptionC" name="answer" type="radio" value="C" /><input id="OptionC" type="text" name="OptionC" placeholder="请输入C选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionC" />
                            <input type="file" id="uploadifyOptionC" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionD" name="answer" type="radio" value="D" /><input id="OptionD" type="text" name="OptionD" placeholder="请输入D选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionD" />
                            <input type="file" id="uploadifyOptionD" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionE" name="answer" type="radio" value="E" /><input id="OptionE" type="text" name="OptionE" placeholder="请输入E选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionE" />
                            <input type="file" id="uploadifyOptionE" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionF" name="answer" type="radio" value="F" /><input id="OptionF" type="text" name="OptionF" placeholder="请输入F选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionF" />
                            <input type="file" id="uploadifyOptionF" name="uploadify" />
                        </div>
                    </p>
                </div>
                <div class="row clearfix mt10 judge none">
                    <p class="clearfix">
                        <input id="rdoOpA" name="panswer" type="radio" value="A" /><label for="">正确</label>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOpB" name="panswer" type="radio" value="B" /><label for="">错误</label>
                    </p>
                </div>
                <div class="row clearfix mt10 checkbox none">
                    <%--<p class="clearfix">
                                    <input type="checkbox" name="" id="" value="" /><input type="text" class="txt" placeholder="简述当前所处状态" />
                                </p>
                                <p class="clearfix">
                                    <input type="checkbox" name="" id="" value="" /><input type="text" class="txt" placeholder="简述当前所处状态" />
                                </p>--%>
                    <p class="clearfix">
                        <input id="cbOptionA" name="danswer" type="checkbox" onclick="duoicochange(this);" value="A" /><input id="ckOptionA" type="text" name="OptionA" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionA" />
                            <input type="file" id="uploadifyckOptionA" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionB" name="danswer" type="checkbox" onclick="duoicochange(this);" value="B" /><input id="ckOptionB" type="text" name="OptionB" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionB" />
                            <input type="file" id="uploadifyckOptionB" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionC" name="danswer" type="checkbox" onclick="duoicochange(this);" value="C" /><input id="ckOptionC" type="text" name="OptionC" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionC" />
                            <input type="file" id="uploadifyckOptionC" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionD" name="danswer" type="checkbox" onclick="duoicochange(this);" value="D" /><input id="ckOptionD" type="text" name="OptionD" placeholder="请输入选项" class="txt" />

                        <div class="upload_imga">
                            <img id="img_PicckOptionD" />
                            <input type="file" id="uploadifyckOptionD" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionE" name="danswer" type="checkbox" onclick="duoicochange(this);" value="E" /><input id="ckOptionE" type="text" name="OptionE" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionE" />
                            <input type="file" id="uploadifyckOptionE" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionF" name="danswer" type="checkbox" onclick="duoicochange(this);" value="F" /><input id="ckOptionF" type="text" name="OptionF" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionF" />
                            <input type="file" id="uploadifyckOptionF" name="uploadify" />
                        </div>
                    </p>
                </div>
                <div id="answerdiv" class="row clearfix canswer mt10">
                    <label for="">答案：</label>
                    <div class="froala">
                        <textarea id="canswer" name="canswer" class="Analysisarea" placeholder="请输入参考答案"></textarea>

                    </div>
                    <%--<asp:TextBox ID="canswer" CssClass="Analysisarea" TextMode="MultiLine" placeholder="参考答案" runat="server"></asp:TextBox>--%>
                </div>
                <%--<div class="row clearfix" style="width: 255px; margin: 10px auto;">
                    <img id="img_Piccanswer" />
                    <input type="file" id="uploadifycanswer" name="uploadify" />
                </div>--%>
                <div class="row clearfix">
                    <label for="">解析：</label>
                    <input type="radio" id="rdoisshowY" name="isshowanalysis" value="1" /><label for="">显示</label><input type="radio" id="rdoisshowN" name="isshowanalysis" value="2" /><label for="">不显示</label>
                    <div class="clear"></div>
                    <div class="froala">
                        <textarea id="Analysis" name="Analysis" class="Analysisarea" placeholder="请输入解析"></textarea>

                    </div>
                    <%--<div style="width: 255px; margin: 10px auto;">
                        <img id="img_PicAnalysis" />
                        <input type="file" id="uploadifyAnalysis" name="uploadify" />
                    </div>--%>
                </div>
                <div class="row clearfix">
                    <input type="button" value="确认修改" class="btn  " onclick="EditQuestion()" />
                </div>
            </div>
        </div>
        <asp:HiddenField ID="QID" runat="server" Value="1" />
        <asp:HiddenField ID="qtype" runat="server" Value="1" />
        <asp:HiddenField ID="qldtype" runat="server" Value="1" />
    </form>
</body>
</html>
<script type="text/javascript">
    var Questioneditor;
    var Analysiseditor;
    var Answereditor;
    var HanderServiceUrl = "/Exam/";

    $(function () {
        var srcc = "OptionA,OptionB,OptionC,OptionD,OptionE,OptionF,ckOptionA,ckOptionB,ckOptionC,ckOptionD,ckOptionE,ckOptionF"//,canswer,Analysis";
        srcc = srcc.split(",");
        for (var i = 0; i < srcc.length; i++) {
            src(srcc[i]);
        }
        BindCatagory();
        Chapator();
        KindEditor.ready(function (K) {
            Questioneditor = K.create('#Question', {
                uploadJson: 'ExamHandler.ashx?action=Upload_json',
                //fileManagerJson: HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
                //allowFileManager: true,

                Width: '785px',
                items: [
                            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                            'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                            'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
                afterBlur: function () { this.sync(); }
            });
            Analysiseditor = K.create('#Analysis', {
                uploadJson: 'ExamHandler.ashx?action=Upload_json',
                //fileManagerJson:HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
                //allowFileManager: true,
                width: '694px',
                items: [
                          'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                          'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                          'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
                afterBlur: function () { this.sync(); }
            });
            Answereditor = K.create('#canswer', {
                uploadJson: 'ExamHandler.ashx?action=Upload_json',
                //fileManagerJson:HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
                //allowFileManager: true,
                width: '650px',
                items: [
                          'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                          'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                          'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
                afterBlur: function () { this.sync(); }
            });
            BindQuestion();

        });
    });
    var CatagoryJson = "";
    function src(srcc) {
        $("#uploadify" + srcc + "").uploadify({
            'auto': true,                      //是否自动上传
            'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
            'uploader': '/CourseManage/Uploade.ashx',
            'formData': { Func: "SetImage" }, //参数
            'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
            'buttonText': '选择图片',//按钮文字
            'width': 100,
            'height': 30,
            'multi': false,//单选            
            'fileSizeLimit': '20MB',//最大文档限制
            'queueSizeLimit': 1,  //队列限制
            'removeCompleted': true, //上传完成自动清空
            'removeTimeout': 0, //清空时间间隔
            'onUploadSuccess': function (file, data, response) {
                var json = $.parseJSON(data);
                var imgpic = json.result.retData;
                $("#img_Pic" + srcc + "").attr("src", json.result.retData);
                $("#" + srcc + "").attr("value", json.result.retData);

                //onerror = "javascript:this.src='/images/course_default.jpg'"
                //$("#img_Pic").val(data);
            },
            'onUploadError': function (file, errorCode, errorMsg, errorString) {
                alert('文件 ' + file.name + '上传失败: ' + errorString);
            },
            //检测FLASH失败调用              
            'onFallback': function () {
                alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");
            },

        });
    }

    function BindCatagory() {

        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Period" },
            success: function (json) {
                CatagoryJson = json;
                BindSubject();
            },
            error: function (errMsg) {
                alert(errMsg);
            }
        });
    }
    var chapterjson = "";
    function Chapator(tcurrentSubjectID) {
        var oooption = "";
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Chapator" },
            success: function (json) {
                chapterjson = json.result.retData;
                //BindleftMenu(json);
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        if (this.TextbooxID == tcurrentSubjectID && this.PID == "0") {
                            oooption += "<option value='" + this.Id + "'>" + this.Name + "</option>";

                        }
                    }
                  );
                }
                else {
                    alert(json.result.errMsg);
                }
                $("#a_chapter").html(oooption);
            },
            error: function (errMsg) {
                alert(errMsg);
            }
        });
    }

    function selectoption(obj, id) {
        $('#a_type').children('span').each(function () {
            if ($(this).attr('value') == typeid) {
                var $select = $(this).parent().parent().children('span');
                $select.text($(this).text());
                $select.attr('value', $(this).attr('value'));
                if ($(this).attr('template')) {
                    $select.attr('template', $(this).attr('template'));
                }
            }
        });
    }
    var id = $('#<%=QID.ClientID%>').val();
    var qtype = $('#<%=qtype.ClientID%>').val();
    var html = "";
    function BindQuestion() {
        var books = "";
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "GetQuestion", "ID": id, "Qtype": qtype
            },
            success: function (json) {
                //chapterjson = json;
                var result = json.result;
                var Data = result.retData;
                var sebook = "";
                var part = "";
                var chapter = "";
                var bookid = Data[0].Book.split("|");
                var pid = 0;
                if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {

                    $(CatagoryJson.GradeOfSubject.retData).each(function () {
                        if ((this.GradeID + "|" + this.SubjectID) == (bookid[0] + "|" + bookid[1])) {
                            html += "<option selected = selected value=\"" + this.GradeID + "|" + this.SubjectID + "\">(" + this.GradeName + ")" + this.SubjectName + "</option>";
                            books += this.GradeID + "|" + this.SubjectID + "|";
                        }
                    });
                    $('#a_subject').html(html);
                }
                if (CatagoryJson.Textbook.errNum.toString() == "0") {
                    $(CatagoryJson.Textbook.retData).each(function () {
                        if (bookid.length > 2) {
                            if ((this.VersionID + "|" + this.Id + "") == (bookid[bookid.length - 2] + "|" + bookid[bookid.length - 1])) {
                                sebook += "<option value=\"" + this.VersionID + "|" + this.Id + "\">(" + this.Name + ")" + this.VersionName + "</option>";
                                books += this.VersionID + "|" + this.Id;
                                kbook = books;
                            }
                        }
                    });
                    $('#se_book').html(sebook);
                }
                var Klpoint = Data[0].Klpoint;
                if (chapterjson != "") {
                    $(chapterjson).each(function () {
                        if (this.Id == Klpoint) {
                            part += "<option value=\"" + this.Id + "\">" + this.Name + "</option>";
                            pid = this.PID;
                            $(chapterjson).each(function () {
                                if (this.Id == pid) {
                                    chapter += "<option value=\"" + this.Id + "\">" + this.Name + "</option>";
                                }
                            });

                        }
                    });
                    $('#a_chapter').html(chapter);
                    $('#a_part').html(part);
                }
                BindType(Data[0].QType);
                selectoption($('#a_type'), Data[0].Type);
                $("#a_difficult").val(Data[0].Difficulty);
                $("#a_type").val(Data[0].Type);
                $("#a_status").val(Data[0].Status);
                selectoption($('#a_difficult'), Data[0].Difficulty);
                if (Data[0].IsShowAnalysis == "1") { $('#rdoisshowY').attr("checked", "checked"); } else {
                    $('#rdoisshowN').attr("checked", "checked");
                }
                //$("#Analysis").val(Data[0].Analysis);
                //$("#a_title").val(Data[0].Title);
                $("#a_score").val(Data[0].Score);
                Questioneditor.html(Data[0].Question);
                Analysiseditor.html(Data[0].Analysis);
                Answereditor.html(Data[0].Answer);
                //$("#Question").text(Data[0].Question);
                bindaoptionanswer(Data);
            },
            error: function (errMsg) {
                layer.msg('试题信息获取失败！');
            }
        });
    }
    var kbook = "";
    function bindaoptionanswer(Data) {

        if (Data[0].Template == "1") {//单选

            $(".radio").show();
            $(".checkbox").hide();
            $(".canswer").hide();
            $(".judge").hide();

            //绑定选项
            var OptionA = Data[0].OptionA;
            var OptionB = Data[0].OptionB
            var OptionC = Data[0].OptionC
            var OptionD = Data[0].OptionD
            var OptionE = Data[0].OptionE
            var OptionF = Data[0].OptionF
            if (OptionA.indexOf('/') == 0) {
                $("#img_PicOptionA").attr("src", OptionA);
            } if (OptionB.indexOf('/') == 0) {
                $("#img_PicOptionB").attr("src", OptionB);
            }
            if (OptionC.indexOf('/') == 0) {
                $("#img_PicOptionC").attr("src", OptionC);
            }
            if (OptionD.indexOf('/') == 0) {
                $("#img_PicOptionD").attr("src", OptionD);
            }
            if (OptionE.indexOf('/') == 0) {
                $("#img_PicOptionE").attr("src", OptionE);
            }
            if (OptionF.indexOf('/') == 0) {
                $("#img_PicOptionF").attr("src", OptionF);
            }
            $("input[id='OptionA']").val(OptionA);
            $("input[id='OptionB']").val(OptionB);
            $("input[id='OptionC']").val(OptionC);
            $("input[id='OptionD']").val(OptionD);
            $("input[id='OptionE']").val(OptionE);
            $("input[id='OptionF']").val(OptionF);
            //绑定答案
            $(".radio input[name$='answer']").each(function () {
                if ($(this).val() == Data[0].Answer) {
                    this.checked = true;
                }
            });

        } else if (Data[0].Template == "2") {//多选

            $(".checkbox").show();
            $(".radio").hide();
            $(".canswer").hide();
            $(".judge").hide();
            //绑定选项
            $("#img_PicckOptionA").attr("src", Data[0].OptionA);
            $("#img_PicckOptionB").attr("src", Data[0].OptionB);
            $("#img_PicckOptionC").attr("src", Data[0].OptionC);
            $("#img_PicckOptionD").attr("src", Data[0].OptionD);
            $("#img_PicckOptionE").attr("src", Data[0].OptionE);
            $("#img_PicckOptionF").attr("src", Data[0].OptionF);
            $("input[id='ckOptionA']").val(Data[0].OptionA);
            $("input[id='ckOptionB']").val(Data[0].OptionB);
            $("input[id='ckOptionC']").val(Data[0].OptionC);
            $("input[id='ckOptionD']").val(Data[0].OptionD);
            $("input[id='ckOptionE']").val(Data[0].OptionE);
            $("input[id='ckOptionF']").val(Data[0].OptionF);
            //绑定答案
            var answers = Data[0].Answer.split("&");
            for (var i = 0; i < answers.length; i++) {
                $("input[name$='danswer']").each(function () {
                    if ($(this).val() == answers[i]) {
                        this.checked = true;
                    }
                });
            }
            //icochange();
        } else if (Data[0].Template == "3")//判断
        {
            $(".judge").show();
            $(".canswer").hide();
            $(".checkbox").hide();
            $(".radio").hide();
            //绑定答案
            if (Data[0].Answer.trim() == "A") {
                $("input[id='rdoOpA']").attr("checked", true);
            }
            else if (Data[0].Answer.trim() == "B") {
                $("input[id='rdoOpB']").attr("checked", true);
            }
        }
        else if (Data[0].Template == "4") {//文本
            $(".canswer").show();
            $(".checkbox").hide();
            $(".radio").hide();
            $(".judge").hide();
            //绑定答案
            $("#img_Piccanswer").attr("src", Data[0].Answer);
            $("#canswer").val(Data[0].Answer);
            //$("input[name$='danswer']").attr("checked", false);
            //$("input[name$='answer']").attr("checked", false);
            //$("input[name$='janswer']").attr("checked", false);
        }
    }

    function EditQuestion() {
        var Qid = $('#<%=QID.ClientID%>').val();
        var qldtype = $('#<%=qldtype.ClientID%>').val();
        var Analysis = Analysiseditor.text();
        var Question = Questioneditor.text();
        var Book = $('#a_subject').attr('value');
        var Subject = $('#a_subject').attr('value'); //$('select[id=]').val();
        var Chapter = $('#a_chapter').attr('value');// $("select[id$='Chapter']").val();
        var Part = $('#a_part').attr('value'); //$("select[id$='Part']").val();
        var Type = $('#a_type').attr('value');// $("select[id$='Type']").val();
        var Difficulty = $('#a_difficult').attr('value');// $("select[id$='Difficulty']").val();
        var OptionA = "";
        var OptionB = "";
        var OptionC = "";
        var OptionD = "";
        var OptionE = "";
        var OptionF = "";
        var Answer = "";
        var isshowanalysis = $('input[name="isshowanalysis"]:checked').val();
        var CAnswer = Answereditor.text();// // $("input[name$='canswer']").val();
        var Status = $('#a_status').attr('value'); //$("select[id$='Status']").val();
        //var Title = $('#a_title').val(); //$("input[id$='Title']").val();
        var score = $('#a_score').val(); //$("input[id$='Title']").val();
        var Major = Subject + "|" + Chapter + "|" + Part;
        //获取选项
        if ($(".radio").css("display") == "block") {
            OptionA = $("input[id='OptionA']").val();
            OptionB = $("input[id='OptionB']").val();
            OptionC = $("input[id='OptionC']").val();
            OptionD = $("input[id='OptionD']").val();
            OptionE = $("input[id='OptionE']").val();
            OptionF = $("input[id='OptionF']").val();
            Answer = $(".radio input[name='answer']:checked").val();
        } else if ($(".checkbox").css("display") == "block") {
            OptionA = $("input[id='ckOptionA']").val();
            OptionB = $("input[id='ckOptionB']").val();
            OptionC = $("input[id='ckOptionC']").val();
            OptionD = $("input[id='ckOptionD']").val();
            OptionE = $("input[id='ckOptionE']").val();
            OptionF = $("input[id='ckOptionF']").val();
            //拼接答案
            $("input[name$='danswer']:checked").each(function () {
                if (Answer == "") {
                    Answer = $(this).val();
                }
                else {
                    Answer = Answer + "&" + $(this).val();
                }
            });
        } else if ($(".judge").css("display") == "block")//判断
        {
            OptionA = "正确";
            OptionB = "错误";
            Answer = $("input[name='panswer']:checked").val();
        }

        if (CheckNull()) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Exam/ExamHandler.ashx",
                    "action": "EditExamQuestion",
                    "QID": Qid,
                    "Type": Type,
                    "oldtype": qldtype,
                    "Question": Question,
                    "Answer": Answer,
                    "OptionA": OptionA,
                    "OptionB": OptionB,
                    "OptionC": OptionC,
                    "OptionD": OptionD,
                    "OptionE": OptionE,
                    "OptionF": OptionF,
                    "Difficulty": Difficulty,
                    "Major": Major,
                    "Book": Book,
                    "Subject": Subject,
                    "Chapter": Chapter,
                    "Part": Part,
                    //"Point": Point,
                    "Status": Status,
                    "Analysis": Analysis,
                    "isshowanalysis": isshowanalysis,
                    "Title": Question,
                    "Score": score,
                },

                success: function (data) {
                    if (data.result.errNum.toString() == "0") {
                        parent.layer.msg('修改成功!');
                        parent.getData(1, 10);
                        parent.CloseIFrameWindow();
                    }
                    else {
                        parent.layer.msg('修改失败!');
                    }
                },
                error: function (errMsg) {

                    layer.msg('试题信息获取失败！');
                },
            });
        }
    }
    //判断非空（专业/题型/）
    function CheckNull() {
        var result = false;
        var Major = $('#a_subject').attr('value');//$("select[id$='Major']").val();
        var Question = Questioneditor.text();
        //var Title = $('#a_title').val();//$("input[id$='Title']").val();
        var score = $('#a_score').val();//$("input[id$='Title']").val();
        var Type = $('#a_type').attr('value');// $("select[id$='Type']").val();
        var Difficulty = $('#a_difficult').attr('value');// $("select[id$='Difficulty']").val();
        //客观(单选)
        if ($(".radio").css("display") == "block") {
            var Answer = $("input[name='answer']:checked").val();
            var OptionA = $("input[id='OptionA']").val();
            if (score != null && score.trim() != "0" && Major != null && Major != "0" && Type != null && Type != "请选择" && Type != "0" && Question != null && Question.trim() != "" && OptionA != null && OptionA.trim() != "" && Answer != null && Answer != "" && Difficulty != "0") {
                result = true;

            } else {
                if (Title == null || Title.trim() == "") {
                    alert('请输入唯一的标题！');
                }
                else if (Major == null || Major == "0") { alert('请选择学科！'); }
                else if (Type == null || Type == "0" || Type == "请选择") { alert('请选择试题类型！'); }
                else if (Question == null || Question.trim() == "") { alert('请输入题文！'); }
                else if (OptionA == null || OptionA.trim() == "") { alert('请输入一个以上选项,从选项A开始！'); }
                else if (Answer == null || Answer == "") { alert('请选择答案！'); }
                else if (Difficulty == null || Difficulty == "0") { alert('请选择试题难度！'); }
            }
        }//主观
        else if ($(".canswer").css("display") == "block" && $(".checkbox").css("display") == "none" && $(".radio").css("display") == "none") {
            if (Title != null && Title.trim() != "" && Major != null && Major != "0" && Type != null && Type != "0" && Question != null && Question.trim() != "" && Difficulty != "0") {
                result = true;
            } else {
                if (Title != null && Title.trim() != "") {
                    alert('请输入唯一的标题！');
                }
                else if (Major == null || Major == "0") { alert('请选择学科！'); }
                else if (Type == null || Type == "0" || Type == "请选择") { alert('请选择试题类型！'); }
                else if (Question == null || Question.trim() == "") { alert('请输入题文！'); }
                else if (Difficulty == null || Difficulty == "0") { alert('请选择试题难度！'); }
            }
        }
            //客观（多选）
        else if ($(".canswer").css("display") == "none" && $(".checkbox").css("display") == "block" && $(".radio").css("display") == "none") {
            var Answer = "";
            $("input[name$='danswer']:checked").each(function () {
                if (Answer == "") {
                    Answer = $(this).val();
                }
                else {
                    Answer = Answer + "&" + $(this).val();
                }
            });
            var OptionA = $("input[id$='ckOptionA']").val();
            if (Title != null && Title.trim() != "" && Major != null && Major != "0" && Type != null && Type != "0" && Question != null && Question.trim() != "" && OptionA != null && OptionA.trim() != "" && Answer != null && Answer != "" && Difficulty != "0") {
                result = true;
            } else {
                if (Title == null || Title.trim() == "") {
                    alert('请输入唯一的标题！');
                }
                else if (Major == null || Major == "0") { alert('请选择专业！'); }
                else if (Type == null || Type == "0" || Type == "请选择") { alert('请选择试题类型！'); }
                else if (Question == null || Question.trim() == "") { alert('请输入题文！'); }
                else if (OptionA == null || OptionA.trim() == "") { alert('请输入一个以上选项,从选项A开始！'); }
                else if (Answer == null || Answer == "") { alert('请选择答案！'); }
                else if (Difficulty == null || Difficulty == "0") { alert('请选择试题难度！'); }
            }
        }
            //判断
        else if ($(".judge").css("display") == "block") {
            var Answer = $("input[name='panswer']:checked").val();
            if (Title != null && Title.trim() != "" && Major != null && Major != "0" && Type != null && Type != "0" && Question != null && Question.trim() != "" && Answer != null && Answer != "" && Difficulty != "0") {
                result = true;
            } else {
                if (Title == null || Title.trim() == "") {
                    alert('请输入唯一的标题！');
                }
                else if (Major == null || Major == "0") { alert('请选择学科！'); }
                else if (Type == null || Type == "0" || Type == "请选择") { alert('请选择试题类型！'); }
                else if (Question == null || Question.trim() == "") { alert('请输入题文！'); }
                else if (Answer == null || Answer == "") { alert('请选择答案！'); }
                else if (Difficulty == null || Difficulty == "0") { alert('请选择试题难度！'); }
            }
        } else {
            if (Title == null || Title.trim() == "") {
                alert('请输入唯一的标题！');
            }
            else if (Major == null || Major == "0") { alert('请选择学科！'); }
            else if (Type == null || Type == "0" || Type == "请选择") { alert('请选择试题类型！'); }
            else if (Question == null || Question.trim() == "") { alert('请输入题文！'); }
            else if (Difficulty == null || Difficulty == "0") { alert('请选择试题难度！'); }
            else { result = true; }
        }
        return result;
    }
    function BindType(id) {

        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "GetQuestionTypeList"
            },
            success: function (json) {
                var httpl = "";
                $.each(json.result.retData, function () {
                    if (this.QType == id) {
                        httpl += "<option value=\"" + this.ID + "\" template=\"" + this.Template + "\">" + this.Title + "</option>";
                    }
                });
                $("#a_type").html(httpl);
            },
            //error: OnError
        });
    }
    function ChangeQType(did) {
        //题型判断
        $(".judge").hide();
        $(".radio").hide();
        $(".checkbox").hide();
        $(".canswer").hide();
        if (did != "0") {
            if (did == "2") {
                $(".checkbox").show();
            } else if (did == "6") {
                $(".judge").show();
            } else if (did == "1") {
                $(".radio").show();
            } else {
                $(".canswer").show();
            }
        }
    }
    //科目
    function BindSubject() {
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            var j = 0;
            $(CatagoryJson.GradeOfSubject.retData).each(function () {
                var num = 0;
                var SelPeriod = this.GradeID;
                var SubjectID = this.SubjectID;
                var SubjectName = this.SubjectName;
                html += "<option value=\"" + this.GradeID + "|" + SubjectID + "\">(" + this.GradeName + ")" + SubjectName + "</option>";
                //SubjectChange(SelPeriod,SubjectID);
                j++;
            });
        }
        else {
            alert(CatagoryJson.GradeOfSubject.errMsg);
        }
    }
    function SubjectChange(idvalue) {
        //BindSubject();
        var kk = "<option value=\"0\">请选择</option>";
        $("#se_book").html(kk);
        $("#se_book").empty();
        $("#a_chapter").html(kk);
        $("#a_chapter").empty();
        $("#a_part").html(kk);
        $("#a_part").empty();
        var persubArray = idvalue.split("|");
        var currentPeriod = persubArray[0];
        var currentSubjectID = persubArray[1];
        Textbook(currentPeriod, currentSubjectID);
        if ($("#se_book").val() != null) {
            var tChapatorid = $("#se_book").val();
            var tpersubArray = tChapatorid.split("|");
            var tcurrentPeriod = tpersubArray[0];
            var tcurrentSubjectID = tpersubArray[1];
            Chapator(tcurrentSubjectID);
        }
        else { Chapator(0) }
        var Partd = $("#a_chapter").val();
        Part(Partd);
    }

    //教材
    function Textbook(SelPeriod, SubjectID) {
        var ooption = "";
        $("#se_book").children().remove();
        option = "<span value='0' class='active'>选择教材</span>";
        $("#Textbook").append(option);
        if (CatagoryJson.Textbook.errNum.toString() == "0") {
            $(CatagoryJson.Textbook.retData).each(function () {
                if (SelPeriod == this.GradeID && this.SubjectID == SubjectID) {
                    //alert(this.Name);
                    ooption += "<option value='" + this.VersionID + "|" + this.Id + "'>" + this.Name + "(" + this.VersionName + ")" + "</option>";
                }

            });
        }
        else {
            alert(CatagoryJson.Textbook.errMsg);
        }
        $("#se_book").html(ooption);

    }
    function TextbookChange(idvalue) {
        //alert(idvalue);
        var tpersubArray = idvalue.split("|");
        var tcurrentPeriod = tpersubArray[0];
        var tcurrentSubjectID = tpersubArray[1];
        Chapator(tcurrentSubjectID);
        var Partd = $("#a_chapter").val();
        Part(Partd);
    }
    function ChapatorChange(idvalue) {
        Part(idvalue);
    }
    function Part(idvalue) {
        var ooooption = "";
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Chapator" },
            success: function (json) {
                $(json.result.retData).each(function () {
                    if (this.PID == idvalue) {
                        ooooption += "<option value='" + this.Id + "'>" + this.Name + "</option>";
                    }
                });
                $("#a_part").html(ooooption);
            }
        })
    }
</script>
