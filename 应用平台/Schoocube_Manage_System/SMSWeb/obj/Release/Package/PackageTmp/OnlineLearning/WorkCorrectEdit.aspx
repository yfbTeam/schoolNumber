<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkCorrectEdit.aspx.cs" Inherits="SMSWeb.OnlineLearning.WorkCorrectEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>作业批改</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
</head>
<body style="background:#fff;">
    <input type="hidden" id="HUserIdCard" runat="server"/>
    <input type="hidden" id="HUserName" runat="server"/>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">                    
                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">分数：</label>
                            <input type="text" placeholder="" class="text" id="txt_Score" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"                                      onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'0')}else{this.value=this.value.replace(/\D/g,'')}"/>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_select clearfix">
                            <label for="">等级：</label>
                            <select class="select" id="sel_ScoreStatus">
                                <option value="1" selected="selected">优</option>
                                <option value="2">良</option>
                                <option value="3">中</option>
                                <option value="4">差</option>
                            </select>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_select">
                            <label for="">评语：</label>
                            <textarea name="" rows="" cols="" id="area_CorrectContent" style="width:350px;"></textarea>
                        </div>                  
                        <div class="course_form_select clearfix">
                            <span id="span_workCorrSave" class="course_btn confirm_btn" onclick="SaveWorkCorrect();" style="cursor:pointer;">确定</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <style>
        .select_homework{position:relative;float:left;margin-left:10px;}
        .select_homework .uploadify-button{font-size:14px;color:#fff;background:#19c857;border:none;}
    </style>
    <script src="../js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            var itemid = UrlDate.itemid;
            if (UrlDate.flag == 1) {
                $("#span_workCorrSave").hide();
                $("#txt_Score").attr("disabled", "disabled");
                $("#sel_ScoreStatus").attr("disabled","disabled");
                $("#area_CorrectContent").attr("disabled","disabled");
            }
            if (itemid != 0) {
                GetWorkCorrectRelById(itemid);
            }
        })
        //保存作业批改
        function SaveWorkCorrect() {
            var score = $("#txt_Score").val().trim(),scoreStatus=$("#sel_ScoreStatus").val();
            var correctContent = $("#area_CorrectContent").val().trim();
            if (!score.length) {
                layer.msg("请填写分数！");
                return;
            }
            if (!correctContent.length) {
                layer.msg("请填写评语！");
                return;
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func:"TeaCorr_WorkCorrectRel",
                    ItemId: UrlDate.itemid,
                    Score: score,
                    ScoreStatus:scoreStatus,
                    CorrectContent: correctContent,
                    UserIdCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('作业批改成功!');
                        parent.GetSubmitWorkData();
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
        //绑定数据
        function GetWorkCorrectRelById(itemid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func: "GetWorkCorrectRelById",
                    ItemId: itemid
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var model = json.result.retData;
                        $("#txt_Score").val(model.Score);
                        $("#sel_ScoreStatus").val(model.ScoreStatus||"1");
                        $("#area_CorrectContent").val(model.CorrectContent);
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
    </script>
</body>
</html>

