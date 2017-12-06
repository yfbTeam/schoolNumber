<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEnterprise.aspx.cs" Inherits="SMSWeb.Recommended.AddEnterprise" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>添加企业信息</title>
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
    <script src="Term.js"></script>

    <script type="text/javascript">
        function validateNum(input) {
            var reg = new RegExp("^[0-9]*$");
            var number = $("#" + input).val();
            if (!reg.test(number)) {
                $("#" + input).focus();
                $("#" + input).val("");

                alert("请输入数字!");
                $("#Validate").val("false");
            }
            if (!/^[0-9]+$/.test(number)) {
                $("#" + input).focus();
                $("#" + input).val("");

                alert("请输入数字!");
                $("#Validate").val("false");

            }
        }

        function validatePhone(input) {
            var tel = $("#" + input).val();

            var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;

            if (reg.test(tel)) {
                $("#Validate").val("true");
            } else {
                $("#" + input).focus();
                alert("请输入合法电话号码!");
                $("#Validate").val("false");
            };
          
        }
    </script>
</head>
<body>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
        <input type="hidden" id="Validate" value="true" />
        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                        <label for="">公司名称：</label>
                        <input type="text" placeholder="公司名称" class="text" id="Name" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">联 系 人 ：</label>
                        <input type="text" placeholder="联系人" class="text" id="RelationName" />
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">联系电话：</label>
                        <input type="text" placeholder="联系电话" class="text" id="RelationPhone" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">企业邮箱：</label>
                        <input type="text" placeholder="企业邮箱" class="text" id="RelationEmail" />
                    </div>
                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">招聘人数：</label>
                            <input type="text" placeholder="招聘人数" class="text" id="RecruitNum" />
                            <i class="stars"></i>

                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">公司地址：</label>
                            <input type="text" placeholder="公司地址" class="text" id="Address" />
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">公司简介：</label>
                            <input type="text" placeholder="公司简介" class="text" id="Introduction" />
                        </div>
                        <div style="clear: both"></div>
                        <div class="course_form_select clearfix">
                            <a class="course_btn confirm_btn" onclick="EnterAdd()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script>

        //添加数据
        function EnterAdd() {
            var Name = $("#Name").val();
            var RelationName = $("#RelationName").val();
            var RelationPhone = $("#RelationPhone").val();
            var RelationEmail = $("#RelationEmail").val();
            var RecruitNum = $("#RecruitNum").val();
            var Address = $("#Address").val();
            var Introduction = $("#Introduction").val();
            if (Name.length <= 0 || RelationPhone.length <= 0 || RecruitNum.length <= 0) {
                layer.msg("请填写完整信息！");
            }
            else {
                validateNum("RecruitNum");
                validatePhone("RelationPhone");
                if ($("#Validate").val() == "true") {

                    $.ajax({
                        url: "/Common.ashx",
                        type: "post",
                        dataType: "json",
                        data: {
                            "PageName": "/Recommended/Recommended.ashx", func: "AddEnter", Name: Name, RelationName: RelationName, RelationPhone: RelationPhone, RelationEmail: RelationEmail,
                            RecruitNum: RecruitNum, Address: Address, Introduction: Introduction, CreateUID: $("#HUserIdCard").val()
                        },
                        success: function (json) {
                            var result = json.result;
                            if (result.errNum == 0) {
                                parent.layer.msg('添加成功!');
                                parent.BindEnter(1, 10);
                                parent.CloseIFrameWindow();
                            }
                            else {
                                layer.msg(result.errMsg);
                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            layer.msg("操作失败！");
                        }
                    });
                }
            }
        }

    </script>
</body>
</html>
