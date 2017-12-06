<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyDocEdit.aspx.cs" Inherits="SMSWeb.PersonalSpace.MyDocEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <!--证书-->
    <link rel="stylesheet" href="/css/certificate.css">
    <link rel="stylesheet" href="/css/certificateT.css">
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <title></title>
    <script type="text/javascript">
        var GetUrlDate = new GetUrlDate();
        $(function () {
            GetPersonDocument();
        })
        //个人档案
        function GetPersonDocument() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "PersonDocument",
                    IDCart: GetUrlDate.IDCard,
                    Ispage: false
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#MyDocID").val(this.ID);
                            $("#DocumentID").val(this.DocumentID);
                            $("#Name").html(this.Name);
                            $("#Sex").val(this.Sex);
                            $("#Nation").val(this.Nation);
                            $("#Photo").attr("src", this.Photo);
                            $("#Nation").val(this.Nation);
                            $("#Origion").val(this.Origion);
                            $("#BirsDay").val(DateTimeConvert(this.BirsDay, "yyyy-MM-dd"));
                            //if (this.MaritalStatus == 0) {
                            $("#MaritalStatus").val(this.MaritalStatus);
                            //}
                            //else {
                            //    $("#MaritalStatus").val("已婚");
                            //}
                            $("#joinTime").val(DateTimeConvert(this.joinTime, "yyyy-MM-dd"));
                            $("#HalfEdudate").val(this.HalfEdudate);
                            $("#Major").val(this.Major);
                            $("#CompnyType").val(this.CompnyType);
                            $("#PoliticalStatus").val(this.PoliticalStatus);
                            $("#PersonIdentity").val(this.PersonIdentity);
                            $("#CurrentJob").val(this.CurrentJob);
                            $("#JobDegree").val(this.JobDegree);
                            $("#JobTime").val(DateTimeConvert(this.JobTime, "yyyy-MM-dd"));
                            $("#JobYear").val(this.JobYear);
                            $("#IDCart").html(this.IDCart);
                            $("#Age").val(this.Age);
                            $("#SymbolicAnimals").val(this.SymbolicAnimals);
                            $("#SchoolName").val(this.SchoolName);
                            $("#WorkExperience").val(this.WorkExperience);
                            $("#FamilyPeople").val(this.FamilyPeople);
                            $("#TrainExperience").val(this.TrainExperience);
                            $("#ComponyName").val(this.ComponyName);
                            $("#RewardExperience").val(this.RewardExperience);
                            $("#SchoolExperience").val(this.SchoolExperience);
                        })

                    }
                    else {
                        layer.msg("获取档案信息失败");
                    }
                },
                error: function (errMsg) {
                    layer.msg("获取档案信息失败");
                }
            });
        }

        //修改个人档案
        function EditMyDoc() {
            var ID = $("#MyDocID").val();
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "EditPersonDocument",
                    IDCard: $("#HUserIdCard").val(),
                    ID: ID,
                    Sex: $("#Sex").val(),
                    Nation: $("#Nation").val(),
                    Nation: $("#Nation").val(),
                    Origion: $("#Origion").val(),
                    BirsDay: $("#BirsDay").val(),
                    joinTime: $("#joinTime").val(),
                    HalfEdudate: $("#HalfEdudate").val(),
                    Major: $("#Major").val(),
                    CompnyType: $("#CompnyType").val(),
                    PoliticalStatus: $("#PoliticalStatus").val(),
                    PersonIdentity: $("#PersonIdentity").val(),
                    CurrentJob: $("#CurrentJob").val(),
                    JobDegree: $("#JobDegree").val(),
                    JobTime: $("#JobTime").val(),
                    JobYear: $("#JobYear").val(),
                    Age: $("#Age").val(),
                    SymbolicAnimals: $("#SymbolicAnimals").val(),
                    SchoolName: $("#SchoolName").val(),
                    WorkExperience: $("#WorkExperience").val(),
                    FamilyPeople: $("#FamilyPeople").val(),
                    TrainExperience: $("#TrainExperience").val(),
                    ComponyName: $("#ComponyName").val(),
                    RewardExperience: $("#RewardExperience").val(),
                    SchoolExperience: $("#SchoolExperience").val(),
                    MaritalStatus: $("#MaritalStatus").val(),

                }, success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        parent.layer.msg('修改成功!');
                        parent.getMyDoc(1, 10);
                        parent.CloseIFrameWindow();
                    }
                    else {
                        layer.msg("修改失败");
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
    <input type="hidden" id="MyDocID" />
    <form id="form1" runat="server">
        <table class="hr_mess" style="margin: 5px; width: 99%">
            <tbody>
                <tr>
                    <td>
                        <span>姓　名</span>
                    </td>
                    <td>
                        <span id="Name"></span>
                    </td>
                    <td>
                        <span>性　别</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="Sex"></span>
                    </td>
                    <td>
                        <span>民　族</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="Nation"></span>
                    </td>
                    <td rowspan="5" colspan="2" style="vertical-align: middle; width: 158px;" class="imgbsa">
                        <span>
                            <img id="Photo"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>身份证号</span>
                    </td>
                    <td colspan="3">
                        <span id="IDCart"></span>
                    </td>
                    <td>
                        <span>籍　贯</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="Origion"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>出生日期</span>
                    </td>
                    <td colspan="2">
                        <span>
                            <input type="text" id="BirsDay" style="width: 135px;"></span>
                    </td>
                    <td>
                        <span>婚姻状况</span>
                    </td>
                    <td colspan="2">
                        <span>
                            <input type="text" id="MaritalStatus" style="width: 165px;"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>政治面貌</span>
                    </td>
                    <td colspan="2">
                        <span>
                            <input type="text" id="PoliticalStatus" style="width: 135px;"></span>
                    </td>
                    <td>
                        <span>入党团日期</span>
                    </td>
                    <td colspan="2">
                        <span>
                            <input type="text" id="joinTime" style="width: 165px;"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>文化程度</span>
                    </td>
                    <td colspan="2">
                        <span>
                            <input type="text" id="HalfEdudate" style="width: 135px;"></span>
                    </td>
                    <td>
                        <span>所学专业</span>
                    </td>
                    <td colspan="2">
                        <span>
                            <input type="text" id="Major" style="width: 165px;"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>单位性质</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="CompnyType"></span>
                    </td>
                    <td>
                        <span>人员身份</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="PersonIdentity"></span>
                    </td>
                    <td>
                        <span>现任职务</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="CurrentJob"></span>
                    </td>
                    <td>
                        <span>职务级别</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="JobDegree"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>参加工作时间</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="JobTime"></span>
                    </td>
                    <td>
                        <span>工龄</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="JobYear"></span>
                    </td>

                    <td>
                        <span>年龄</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="Age"></span>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>

                    <td>
                        <span>生肖</span>
                    </td>
                    <td>
                        <span>
                            <input type="text" id="SymbolicAnimals"></span>
                    </td>
                    <td colspan="2">
                        <span>现工作单位</span>
                    </td>
                    <td colspan="4">
                        <span>
                            <input type="text" id="ComponyName" style="width: 230px;"></span>
                    </td>
                    <%--<td></td><td></td>--%>
                </tr>
                <tr>
                    <td>
                        <span>毕业院校（时间）</span>
                    </td>
                    <td colspan="7"><span>
                        <textarea name="" id="SchoolExperience"></textarea></span></td>
                </tr>
                <tr>
                    <td>
                        <span>工作经历</span>
                    </td>
                    <td colspan="7"><span>
                        <textarea name="" id="WorkExperience">
                                            </textarea></span></td>
                </tr>
                <tr>
                    <td><span>家庭成员</span></td>
                    <td colspan="7"><span>
                        <textarea name="" id="FamilyPeople"></textarea></span></td>
                </tr>
                <tr>
                    <td><span>学习培训情况</span></td>
                    <td colspan="7"><span>
                        <textarea name="" id="TrainExperience"></textarea></span></td>
                </tr>

                <tr>
                    <td><span>奖励情况</span></td>
                    <td colspan="7"><span>
                        <textarea name="" id="RewardExperience"></textarea></td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: center;">
                        <input type="button" class="btn fl" onclick="EditMyDoc()" value="确定" />
                    </td>
                </tr>

            </tbody>
        </table>
    </form>
</body>
</html>
