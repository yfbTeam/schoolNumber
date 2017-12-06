<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyDocDetail.aspx.cs" Inherits="SMSWeb.PersonalSpace.MyDocDetail" %>

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
            PersonDocument();
        })
        //个人档案
        function PersonDocument() {
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
                            $("#DocumentID").html(this.DocumentID);
                            $("#Name").html(this.Name);
                            $("#Sex").html(this.Sex);
                            $("#Nation").html(this.Nation);
                            $("#Photo").attr("src", this.Photo);
                            $("#Nation").html(this.Nation);
                            $("#Origion").html(this.Origion);
                            $("#BirsDay").html(DateTimeConvert(this.BirsDay, "yyyy-MM-dd"));
                            //if (this.MaritalStatus == 0) {
                            $("#MaritalStatus").html(this.MaritalStatus);
                            //}
                            //else {
                            //    $("#MaritalStatus").html("已婚");
                            //}
                            $("#joinTime").html(DateTimeConvert(this.joinTime, "yyyy-MM-dd"));
                            $("#HalfEdudate").html(this.HalfEdudate);
                            $("#Major").html(this.Major);
                            $("#CompnyType").html(this.CompnyType);
                            $("#PoliticalStatus").html(this.PoliticalStatus);
                            $("#PersonIdentity").html(this.PersonIdentity);
                            $("#CurrentJob").html(this.CurrentJob);
                            $("#JobDegree").html(this.JobDegree);
                            $("#JobTime").html(DateTimeConvert(this.JobTime, "yyyy-MM-dd"));
                            $("#JobYear").html(this.JobYear);
                            $("#IDCart").html(this.IDCart);
                            $("#Age").html(this.Age);
                            $("#SymbolicAnimals").html(this.SymbolicAnimals);
                            $("#SchoolName").html(this.SchoolName);
                            $("#WorkExperience").html(this.WorkExperience);
                            $("#FamilyPeople").html(this.FamilyPeople);
                            $("#TrainExperience").html(this.TrainExperience);
                            $("#ComponyName").html(this.ComponyName);
                            $("#RewardExperience").html(this.RewardExperience);
                            $("#SchoolExperience").html(this.SchoolExperience);
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
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

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
                        <span id="Sex"></td>
                    <td>
                        <span>民　族</span>
                    </td>
                    <td>
                        <span id="Nation"></td>
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
                        <span id="Origion"></td>
                </tr>
                <tr>
                    <td>
                        <span>出生日期</span>
                    </td>
                    <td colspan="2">
                        <span id="BirsDay"></td>
                    <td>
                        <span>婚姻状况</span>
                    </td>
                    <td colspan="2">
                        <span id="MaritalStatus"></td>
                </tr>
                <tr>
                    <td>
                        <span>政治面貌</span>
                    </td>
                    <td colspan="2">
                        <span id="PoliticalStatus"></td>
                    <td>
                        <span>入党团日期</span>
                    </td>
                    <td colspan="2">
                        <span id="joinTime"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>文化程度</span>
                    </td>
                    <td colspan="2">
                        <span id="HalfEdudate"></span>
                    </td>
                    <td>
                        <span>所学专业</span>
                    </td>
                    <td colspan="2">
                        <span id="Major"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>单位性质</span>
                    </td>
                    <td>
                        <span id="CompnyType"></span>
                    </td>
                    <td>
                        <span>人员身份</span>
                    </td>
                    <td>
                        <span id="PersonIdentity"></span>
                    </td>
                    <td>
                        <span>现任职务</span>
                    </td>
                    <td>
                        <span id="CurrentJob"></span>
                    </td>
                    <td>
                        <span>职务级别</span>
                    </td>
                    <td>
                        <span id="JobDegree"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>参加工作时间</span>
                    </td>
                    <td>
                        <span id="JobTime"></span>
                    </td>
                    <td>
                        <span>工龄</span>
                    </td>
                    <td>
                        <span id="JobYear"></span>
                    </td>

                    <td>
                        <span>年龄</span>
                    </td>
                    <td>
                        <span id="Age"></span>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>

                    <td>
                        <span>生肖</span>
                    </td>
                    <td>
                        <span id="SymbolicAnimals"></span>
                    </td>
                    <td colspan="2">
                        <span>现工作单位</span>
                    </td>
                    <td colspan="4">
                        <span id="ComponyName"></span>
                    </td>
                    <%--<td></td><td></td>--%>
                </tr>
                <tr>
                    <td>
                        <span>毕业院校（时间）</span>
                    </td>
                    <td colspan="7"><span id="SchoolExperience"></span></td>
                </tr>
                <tr>
                    <td>
                        <span>工作经历</span>
                    </td>
                    <td colspan="7"><span id="WorkExperience"></span></td>
                </tr>
                <tr>
                    <td><span>家庭成员</span></td>
                    <td colspan="7"><span id="FamilyPeople"></span></td>
                </tr>
                <tr>
                    <td><span>学习培训情况</span></td>
                    <td colspan="7"><span id="TrainExperience"></span></td>
                </tr>

                <tr>
                    <td><span>奖励情况</span></td>
                    <td colspan="7"><span id="RewardExperience"></td>
                </tr>

            </tbody>
        </table>
    </form>
</body>
</html>
