<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddQuestion.aspx.cs" Inherits="SMSWeb.Exam.AddQuestion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>添加试题</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.js"></script>
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/KindUeditor/kindeditor-min.js"></script>
    <script src="../Script/KindUeditor/plugins/code/prettify.js"></script>
    <script src="../Script/KindUeditor/lang/zh_CN.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="../js/common.js"></script>
    <style>
        .upload_imga{margin:10px auto;width:255px;}
        .upload_imga .uploadify-button {font-size:16px;border:none;background:#5493D7;color:#fff;}
    </style>
</head>
<body style="background:#fff;">
    <form id="form1" runat="server">
        <div>
            <asp:HiddenField ID="hIDCard" runat="server" />
            <asp:HiddenField ID="HSchoolID" runat="server" Value="1" />
            <asp:HiddenField ID="HPeriod" runat="server" />
            <asp:HiddenField ID="HSubject" runat="server" Value="1" />
            <asp:HiddenField ID="bookVersion" runat="server" />
            <asp:HiddenField ID="HTextboox" runat="server" Value="1" />
            <asp:HiddenField ID="HChapterID" runat="server" />
            <!--添加试卷dialog-->
            <%--<div class="testdialog_title">
                    添加试题
						<span class="close fr">
                            <i class="icon icon-remove"></i>
                        </span>
                </div>--%>
            <div class="dialog_detail">
                <h1 class="clearfix">
                    <div class="select_left fl">
                        当前选择：
                    </div>
                    <div class="select_right fl clearfix">

                        <div class="clearfix fl">
                            <i class="star"></i>
                            <label for="">学科：</label>
                            <select name="" class="select" id="se_subject" onchange="SubjectChange(this.value)">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">教材：</label>
                            <select name="" class="select" id="se_book" onchange="TextbookChange(this.value)">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">章：</label>
                            <select name="" class="select" id="se_chapter" onchange="ChapatorChange(this.value)">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">节：</label>
                            <select name="" class="select" id="se_part">
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
                            <span class="select questiontypesel">
                                <span value="0" template="0" class="select_judge" id="as_type">请选择</span><i class="icon icon-angle-down"></i>
                                <div class="enable_wrap none" id="a_type">
                                    <span value="0" template="0" class="active">请选择</span>
                                </div>
                            </span>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">难易程度：</label>
                            <span class="select">
                                <span value="0" id="as_difficult">请选择</span><i class="icon icon-angle-down"></i>
                                <div class="enable_wrap none">
                                    <span value="0" class="active">请选择</span>
                                    <span value="1">简单</span>
                                    <span value="2">中等</span>
                                    <span value="2">困难</span>
                                </div>
                            </span>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">状态：</label>
                            <span class="select">
                                <span value="1" id="as_status">启用</span><i class="icon icon-angle-down"></i>
                                <div class="enable_wrap none">
                                    <span value="1" class="active">启用</span>
                                    <span value="2">禁用</span>
                                </div>
                            </span>
                            <i class="star"></i>
                        </div>
                    </div>
                </div>
                <div class="row clearfix mt10">
                    <label for="">题目：</label>
                    <input type="text" class="txt" id="a_title" placeholder="请输入题目" />
                    <i class="star"></i>
                </div>
                <div class="row clearfix mt10">
                    <label for="">分数：</label>
                    <input type="text" class="txt" id="a_score" placeholder="请输入分数" />
                    <i class="star"></i>
                </div>
                <div class="row clearfix mt10">
                    <label for="">内容：</label>
                    <div class="froala">
                        <textarea id="Question" name="Question" class="questionarea" placeholder="请输入题干" runat="server"></textarea>
                    </div>
                </div>
                <div class="row clearfix mt10 radio none">
                    <p class="clearfix">
                        <input id="rdoOptionA" name="answer" type="radio" value="A" /><input id="OptionA" type="text" name="OptionA" placeholder="请输入选项" class="txt" />
                        <img id="img_PicOptionA" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyOptionA" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionB" name="answer" type="radio" value="B" /><input id="OptionB" type="text" name="OptionB" placeholder="请输入选项" class="txt" />
                        <img id="img_PicOptionB" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyOptionB" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionC" name="answer" type="radio" value="C" /><input id="OptionC" type="text" name="OptionC" placeholder="请输入选项" class="txt" />
                        <img id="img_PicOptionC" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyOptionC" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionD" name="answer" type="radio" value="D" /><input id="OptionD" type="text" name="OptionD" placeholder="请输入选项" class="txt" />
                        <img id="img_PicOptionD" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyOptionD" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionE" name="answer" type="radio" value="E" /><input id="OptionE" type="text" name="OptionE" placeholder="请输入选项" class="txt" />
                        <img id="img_PicOptionE" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyOptionE" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionF" name="answer" type="radio" value="F" /><input id="OptionF" type="text" name="OptionF" placeholder="请输入选项" class="txt" />
                        <img id="img_PicOptionF" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyOptionF" name="uploadify" />
                    </p>
                </div>
                <div class="row clearfix mt10 judge none">
                    <%--<p class="clearfix">
                                    <input type="radio" name="judge" id="" value="" /><label for="">正确</label>
                                </p>
                                <p class="clearfix">
                                    <input type="radio" name="judge" id="" value="" /><label for="">错误</label>
                                </p>--%>
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
                        <img id="img_PicckOptionA" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyckOptionA" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionB" name="danswer" type="checkbox" onclick="duoicochange(this);" value="B" /><input id="ckOptionB" type="text" name="OptionB" placeholder="请输入选项" class="txt" />
                        <img id="img_PicckOptionB" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyckOptionB" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionC" name="danswer" type="checkbox" onclick="duoicochange(this);" value="C" /><input id="ckOptionC" type="text" name="OptionC" placeholder="请输入选项" class="txt" />
                        <img id="img_PicckOptionC" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyckOptionC" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionD" name="danswer" type="checkbox" onclick="duoicochange(this);" value="D" /><input id="ckOptionD" type="text" name="OptionD" placeholder="请输入选项" class="txt" />
                        <img id="img_PicckOptionD" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyckOptionD" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionE" name="danswer" type="checkbox" onclick="duoicochange(this);" value="E" /><input id="ckOptionE" type="text" name="OptionE" placeholder="请输入选项" class="txt" />
                        <img id="img_PicckOptionE" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyckOptionE" name="uploadify" />
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionF" name="danswer" type="checkbox" onclick="duoicochange(this);" value="F" /><input id="ckOptionF" type="text" name="OptionF" placeholder="请输入选项" class="txt" />
                        <img id="img_PicckOptionF" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                            <input type="file" id="uploadifyckOptionF" name="uploadify" />
                    </p>
                </div>
                <div id="answerdiv" class="row clearfix canswer mt10 none">
                    <label for="">答案：</label>
                    <asp:TextBox ID="canswer" CssClass="Analysisarea" TextMode="MultiLine" placeholder="参考答案" runat="server"></asp:TextBox>
                    <div class="row clearfix">
                    <div class="upload_imga">
                        <img id="img_Piccanswer" alt="" src="../images/fpsc.jpg" style="width: 255px; height: auto;" />
                        <input type="file" id="uploadifycanswer" name="uploadify" />
                    </div>
                </div>
                </div>
                <div class="row clearfix">
                    <label for="">解析（可为空）：</label>
                    <input type="radio" id="rdoisshowY" name="isshowanalysis" value="1" /><label for="">显示</label><input type="radio" id="rdoisshowN" name="isshowanalysis" value="2" checked="checked" /><label for="">不显示</label>
                    <div class="clear"></div>
                    <div class="froala">
                        <textarea id="Analysis" name="Analysis" class="Analysisarea" placeholder="请输入解析，可以为空" runat="server"></textarea>
                    </div>
                </div>
                <div class="row clearfix">
                <div class="row clearfix">
                <input type="button" value="确定添加" onclick="AddQuestion()" class="btn" />
            </div>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    choose($('.select'));
    $(function () {
        var srcc = "OptionA,OptionB,OptionC,OptionD,OptionE,OptionF,ckOptionA,ckOptionB,ckOptionC,ckOptionD,ckOptionE,ckOptionF,canswer";
        srcc = srcc.split(",");
        BindType();
        for (var i = 0; i < srcc.length; i++) {
            src(srcc[i]);
        }
        
        $('#se_subject').find('div').children('span').click(function () {
            debugger;
            var $select = $(this).parent().parent().children('span');
            $select.attr('value', $(this).attr('value'));
            Textbook();
        });
   });
    var Questioneditor;
    function src(srcc) {
        $("#uploadify"+srcc+"").uploadify({
            'auto': true,                      //是否自动上传
            'swf': '../Scripts/Uploadyfy/uploadify/uploadify.swf',
            'uploader': '../CourseManage/Uploade.ashx',
            'formData': { Func: "SetImage" }, //参数
            'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
            'buttonText': '选择图片',//按钮文字
            'width': 255,
            'height': 30,
            'multi': false,//单选            
            'fileSizeLimit': '20MB',//最大文档限制
            'queueSizeLimit': 1,  //队列限制
            'removeCompleted': true, //上传完成自动清空
            'removeTimeout': 0, //清空时间间隔
            'onUploadSuccess': function (file, data, response) {
                var json = $.parseJSON(data);

                $("#img_Pic"+srcc+"").attr("src", json.result.retData);
                $("#"+srcc+"").attr("value", json.result.retData);

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
    var Analysiseditor;
    //var HanderServiceUrl = "/Exam/";
    KindEditor.ready(function (K) {
        Questioneditor = K.create('#<%=Question.ClientID%>', {
            uploadJson: HanderServiceUrl + 'ExamHandler.aspx?action=Upload_json',
            //fileManagerJson: HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
            //allowFileManager: true,
            width: '600px',
            minWidth: '600px',
            items: [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
            afterBlur: function () { this.sync(); }
        });
        Analysiseditor = K.create('#<%=Analysis.ClientID%>', {
            uploadJson: HanderServiceUrl + 'ExamHandler.aspx?action=Upload_json',
            //fileManagerJson:HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
            //allowFileManager: true,
            width: '600px',
            minWidth: '600px',
            items: [
                      'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                      'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                      'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
            afterBlur: function () { this.sync(); }
        });
    })
    function AddQuestion() {
        if ($('#se_subject').attr('value') != "" && $("#se_book").attr('value') != "" && $("#se_chapter").attr('value')!="" && $("#se_part").attr('value')!="") {
            var Analysis = Analysiseditor.text();
            var Question = Questioneditor.text();
            var Subject = $('#se_subject').attr('value');
            var Major = $('#se_subject').attr('value');
            var Book = $("#se_book").attr('value');
            var Chapter = $('#se_part').attr('value');
            var Part = $('#se_part').attr('value');
            var Type = $('#as_type').attr('value');
            var Difficulty = $('#as_difficult').attr('value');
            var Status = $('#as_status').attr('value');
            var Title = $('#a_title').val();
            var CAnswer = $('#<%=canswer.ClientID%>').val();
            var OptionA = "";
            var OptionB = "";
            var OptionC = "";
            var OptionD = "";
            var OptionE = "";
            var OptionF = "";
            var Answer = "";
            var isshowanalysis = $('input[name="isshowanalysis"]:checked').val();
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
            var score = $("#a_score").val();
            var IDCard = $("#hIDCard").val();
            if (CheckNull()) {
                //obj.disabled = true;
                $.ajax({
                    url: "/Common.ashx",//?action=AddExamQuestion&" + Math.random(),   // 提交的页面
                    type: "post",                   // 设置请求类型为"POST"，默认为"GET"
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "/Exam/ExamHandler.ashx",
                        "action": "AddExamQuestion",
                        "Title": Title,
                        "Subject": Subject,
                        "Major": Major,
                        "Book": Book,
                        "Chapter": Chapter,
                        "Part": Part,
                        "Type": Type,
                        "Difficulty": Difficulty,
                        "Status": Status,
                        "Question": Question,
                        "OptionA": OptionA,
                        "OptionB": OptionB,
                        "OptionC": OptionC,
                        "OptionD": OptionD,
                        "OptionE": OptionE,
                        "OptionF": OptionF,
                        "Answer": Answer,
                        "CAnswer": CAnswer,
                        "Analysis": Analysis,
                        "isshowanalysis": isshowanalysis,
                        "Author": IDCard,
                        "Score": score
                    },
                    beforeSend: function ()          // 设置表单提交前方法
                    {
                        //layer.msg("准备提交数据");


                    },
                    error: function (request) {      // 设置表单提交出错
                        //layer.msg("表单提交出错，请稍候再试");
                        //rebool = false;
                    },
                    success: function (json) { 
                        if (json.result.errNum.toString() == "0") {
                            parent.layer.msg('新增成功!');
                            parent.getData(1, 10);
                            parent.CloseIFrameWindow();
                        } else {
                            layer.msg(json.result.errMsg);
                        }
                    }

                });
            }
        } else {
            layer.msg('必须选择年级教材章和小节');
        }
    }
    //判断非空（专业/题型/）
    function CheckNull() {
        var result = false;
        var Major = $('#se_subject').attr('value');//$("select[id$='Major']").val();
        var Question = Questioneditor.text();
        var Title = $('#a_title').val();//$("input[id$='Title']").val();
        var Type = $('#as_type').attr('value');// $("select[id$='Type']").val();
        var Difficulty = $('#as_difficult').attr('value');// $("select[id$='Difficulty']").val();
        //客观(单选)
        if ($(".radio").css("display") == "block") {
            var Answer = $("input[name='answer']:checked").val();
            var OptionA = $("input[id='OptionA']").val();
            if (Title != null && Title.trim() != "" && Major != null && Major != "0" && Type != null && Type != "请选择" && Type != "0" && Question != null && Question.trim() != "" && OptionA != null && OptionA.trim() != "" && Answer != null && Answer != "" && Difficulty != "0") {
                result = true;

            } else {
                if (Title == null || Title.trim() == "") {
                    layer.msg('请输入唯一的标题！');
                }
                else if (Major == null || Major == "0") { layer.msg('请选择学科！'); }
                else if (Type == null || Type == "0" || Type == "请选择") { layer.msg('请选择试题类型！'); }
                else if (Question == null || Question.trim() == "") { layer.msg('请输入题文！'); }
                else if (OptionA == null || OptionA.trim() == "") { layer.msg('请输入一个以上选项,从选项A开始！'); }
                else if (Answer == null || Answer == "") { layer.msg('请选择答案！'); }
                else if (Difficulty == null || Difficulty == "0") { layer.msg('请选择试题难度！'); }
            }
        }//主观
        else if ($(".canswer").css("display") == "block" && $(".checkbox").css("display") == "none" && $(".radio").css("display") == "none") {
            if (Title != null && Title.trim() != "" && Major != null && Major != "0" && Type != null && Type != "0" && Question != null && Question.trim() != "" && Difficulty != "0") {
                result = true;
            } else {
                if (Title == null && Title.trim() != "") {
                    layer.msg('请输入唯一的标题！');
                }
                else if (Major == null || Major == "0") { layer.msg('请选择学科！'); }
                else if (Type == null || Type == "0" || Type == "请选择") { layer.msg('请选择试题类型！'); }
                else if (Question == null || Question.trim() == "") { layer.msg('请输入题文！'); }
                else if (Difficulty == null || Difficulty == "0") { layer.msg('请选择试题难度！'); }
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
                    layer.msg('请输入唯一的标题！');
                }
                else if (Major == null || Major == "0") { layer.msg('请选择专业！'); }
                else if (Type == null || Type == "0" || Type == "请选择") { layer.msg('请选择试题类型！'); }
                else if (Question == null || Question.trim() == "") { layer.msg('请输入题文！'); }
                else if (OptionA == null || OptionA.trim() == "") { layer.msg('请输入一个以上选项,从选项A开始！'); }
                else if (Answer == null || Answer == "") { layer.msg('请选择答案！'); }
                else if (Difficulty == null || Difficulty == "0") { layer.msg('请选择试题难度！'); }
            }
        }
            //判断
        else if ($(".judge").css("display") == "block") {
            var Answer = $("input[name='panswer']:checked").val();
            if (Title != null && Title.trim() != "" && Major != null && Major != "0" && Type != null && Type != "0" && Question != null && Question.trim() != "" && Answer != null && Answer != "" && Difficulty != "0") {
                result = true;
            } else {
                if (Title == null || Title.trim() == "") {
                    layer.msg('请输入唯一的标题！');
                }
                else if (Major == null || Major == "0") { layer.msg('请选择学科！'); }
                else if (Type == null || Type == "0" || Type == "请选择") { layer.msg('请选择试题类型！'); }
                else if (Question == null || Question.trim() == "") { layer.msg('请输入题文！'); }
                else if (Answer == null || Answer == "") { layer.msg('请选择答案！'); }
                else if (Difficulty == null || Difficulty == "0") { layer.msg('请选择试题难度！'); }
            }
        } else {
            if (Title == null || Title.trim() == "") {
                layer.msg('请输入唯一的标题！');
            }
            else if (Major == null || Major == "0") { layer.msg('请选择学科！'); }
            else if (Type == null || Type == "0" || Type == "请选择") { layer.msg('请选择试题类型！'); }
            else if (Question == null || Question.trim() == "") { layer.msg('请输入题文！'); }
            else if (Difficulty == null || Difficulty == "0") { layer.msg('请选择试题难度！'); }
            else { result = true; }
        }
        return result;
    }
    function BindType() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名"
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "GetQuestionTypeList"
            },
            success: function (json) {
                var html = "";
                var count = 0;
                $.each(json.result.retData, function () {
                    count = 1 + parseInt(count);
                    html += "<span value=\"" + this.ID + "\" template=\"" + this.Template + "\">" + this.Title + "</span>";
                });
                $("#a_type").append(html);
                ChangeQType();
                BindCatagory();
            },
            //error: OnError
        });
    }

    function ChangeQType() {
        //题型判断
        $('.questiontypesel').click(function () {
            $(this).parents('.dialog_detail').find('.checkbox').hide();
            $(this).parents('.dialog_detail').find('.radio').hide();
            $(this).parents('.dialog_detail').find('.judge').hide();
            $(this).parents('.dialog_detail').find('.canswer').hide();
            if ($(this).children('.select_judge').html() != "请选择") {
                if ($(this).children('.select_judge').html() == "多选题") {
                    $(this).parents('.dialog_detail').find('.checkbox').show();
                } else if ($(this).children('.select_judge').html() == "判断题") {
                    $(this).parents('.dialog_detail').find('.judge').show();
                } else if ($(this).children('.select_judge').html() == "单选题") {
                    $(this).parents('.dialog_detail').find('.radio').show();
                } else {
                    $(this).parents('.dialog_detail').find('.canswer').show();
                }
            }
            $("#as_type").attr("value",$(this).children('.select_judge').attr("value"));
        })
    }
    function BindCatagory() {
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",

            data: { "Func": "Period" },
            success: function (json) {
                CatagoryJson = json;
                //学段
                BindSubject();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //科目
    function BindSubject() {
        var HPeriod = $("#HPeriod").val();
        var HSubject = $("#HSubject").val();
        var option = "";
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            $(CatagoryJson.GradeOfSubject.retData).each(function () {
                if ((this.GradeID + "|" + this.SubjectID) == (HPeriod + "|" + HSubject)) {
                    option += "<option selected = selected value=\"" + this.GradeID + "|" + this.SubjectID + "\">(" + this.GradeName + ")" + this.SubjectName + "</option>";
                } else {
                    var SelPeriod = this.GradeID;
                var SubjectID = this.SubjectID;
                var SubjectName = this.SubjectName;
                option += "<option value=\"" + this.GradeID + "|" + SubjectID + "\">(" + this.GradeName + ")" + SubjectName + "</option>";
            }
                
            })
        }
        else {
            layer.msg(CatagoryJson.GradeOfSubject.errMsg);
        }
        $("#se_subject").html(option);
        Textbook();
    }
    function SubjectChange(idvalue) {
        var kk = "<option value=\"0\">请选择</option>";
        $("#se_book").html(kk);
        $("#se_chapter").html(kk);
        $("#se_part").html(kk);
        $("#se_book").empty();
        $("#se_chapter").empty();
        $("#se_part").empty();
        Textbook();
    }
    function ChapatorChange(idvalue) {
        var kk = "<option value=\"0\">请选择</option>";
        $("#se_part").html(kk);
        $("#se_part").empty();
        Part();
    }
    function TextbookChange(idvalue) {
        var kk = "<option value=\"0\">请选择</option>";
        $("#se_chapter").html(kk);
        $("#se_part").html(kk);
        $("#se_chapter").empty();
        $("#se_part").empty();
        Chapator();
    }
    //教材
    function Textbook() {
        $("#se_book").html("");
        var option = "";
        var perandsub = $("#se_subject").attr('value');
        if (perandsub == "0") {
            return;
        }
        var persubArray = perandsub.split("|");
        var currentPeriod = persubArray[0];
        var currentSubjectID = persubArray[1];
        if (CatagoryJson.Textbook.errNum.toString() == "0") {

            $(CatagoryJson.Textbook.retData).each(function () {
                if (currentPeriod == this.GradeID && this.SubjectID == currentSubjectID) {
                    option += "<option value='" + this.VersionID + "|" + this.Id + "'>(" + this.VersionName + ")" + this.Name + "</option>";
                }

            })

        }
        else {
            layer.msg(CatagoryJson.Textbook.errMsg);
        }
        $("#se_book").html(option);
        Chapator();
    }
    var partjson = "";
    function Chapator() {
        var HChapterID = $("#HChapterID").val();
        var option = "";
        var curbook = $("#se_book").attr('value');
        if (curbook == "0") {
            $("#se_chapter").html(option);
            return;
        }
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Chapator" },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    div = "";
                    var chapterjson = json.result.retData;
                    partjson = chapterjson;
                    $(chapterjson).each(function () {
                        if (this.TextbooxID == curbook.split("|")[1] && this.PID == 0) {
                            option += "<option value='" + this.Id + "'>" + this.Name + "</option>";
                        }
                    });
                }
                else {
                    layer.msg(json.result.errMsg);
                }
                $("#se_chapter").html(option);
                Part();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function Part() {
        var option = "";
        var curchapator = $("#se_chapter").attr('value');
        if (curchapator == "0") {
            $("#se_part").html(option);
            return;
        }
        $(partjson).each(function () {
            if (this.PID == curchapator) {
                option += "<option value='" + this.Id + "'>" + this.Name + "</option>";
            }
        })
        $("#se_part").html(option);
    }

</script>
