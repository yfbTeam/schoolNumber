<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAssociaeActivity.aspx.cs" Inherits="SMSWeb.Association.AddAssociaeActivity" EnableEventValidation="false"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
      <link href="../Stu_css/common.css" rel="stylesheet" />
<link href="../Stu_css/StuAssociate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../Stu_js/jquery-1.8.0.js"></script>
<script src="../Stu_js/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
    td {
        vertical-align: middle;
    }
</style>
<script type="text/javascript">
    function Preview(file) { //展示图片
        var prevImg = document.getElementById('Imgshow');
        if (file.files && file.files[0]) {
            var reader = new FileReader();
            reader.onload = function (evt) {
                prevImg.src = evt.target.result;
            }
            reader.readAsDataURL(file.files[0]);
        }
        else {
            prevImg.style.display = "none";
            var divImg = document.getElementById('divImg');
            divImg.style.display = "block";
            divImg.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = file.value;
        }
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
  
<div>
    <form id="form_add" enctype="multipart/form-data">
        <div class="windowDiv">
            <table class="winTable">
                <tr>
                    <td class="mi">活动名称：
                    </td>
                    <td class="ku">
                        <input runat="server" id="txtTitle" name="txtTitle" type="text" />
                        <span class="wstar">*
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
                    </td>
                    <td rowspan="3" style="width: 145px; padding-right: 20px; text-align: center;">
                        <img id="Imgshow" class="imgAssoci" src="../Stu_images/nopic.png" />
                        <div id="divImg" class="imgAssoci" style="display: none;filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=../Stu_images/nopic.png); "></div>
                        <input type="file" id="fimg_Asso" name="fimg_Asso" runat="server" onchange="Preview(this);" style="width: 120px; display: none;" />
                        <a href="#" onclick="document.getElementById('<%=fimg_Asso.ClientID%>').click();" style="color: #1193f3; display: block;">活动封面</a>
                    </td>
                </tr>
                <tr>
                    <td class="mi">活动时间：
                    </td>
                    <td class="ku">
                        <input type="text" class="Wdate" readonly="readonly" runat="server" id="dtStartTime" name="dtStartTime" onclick="WdatePicker()" style="width: 97px;" />至<input type="text" class="Wdate" readonly="readonly" runat="server" id="dtEndTime" name="dtEndTime" onclick="    WdatePicker()" style="width: 97px;" />
                    </td>
                </tr>
                <tr>
                    <td class="mi">活动地址：
                    </td>
                    <td class="ku">
                        <input id="txtAddress" name="txtAddress" runat="server" type="text" />
                        <span class="wstar">*
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAddress"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">活动内容：</td>
                    <td class="ku" colspan="2">
                        <table class="innerTable">
                            <tr>
                                <td style="padding: 0px;">
                                    <textarea id="txtContent" name="txtContent" class="colwidth content" runat="server"></textarea></td>
                                <td style="width: 35px; padding: 0px;"><span class="wstar">*<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtContent"
                                    ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="mi">附件：</td>
                    <td class="ku">
                        <input type="file" id="file_activity" name="file_activity" runat="server" />
                    </td>
                </tr>
            </table>
            <div class="t_btn">
                <%--<input type="button" class="btn btn_sure" value="发布" onclick="insertvalue();" />--%>
                <asp:Button ID="btnAdd" CssClass="btn btn_sure" ClientIDMode="Static" runat="server" OnClientClick="return insertvalue();" OnClick="btnAdd_Click" ValidationGroup="ProjectSubmit" Text="发布" />
                <input type="button" class="btn btn_cancel" value="取消" onclick="parent.closePages();" />
            </div>
            <div style="display:none">
                
            </div>
        </div>
    </form>
</div>

    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    function insertvalue() {
        var title = $("input[id$='txtTitle']").val();
        if (title == "") {
            alert("请输入活动名称!"); return false;
        }
        var start = $("input[id$='dtStartTime']").val();
        if (start == "") {
            alert("请输入活动开始时间!"); return false;
        }
        var end = $("input[id$='dtEndTime']").val();
        if (end == "") {
            alert("请输入活动结束时间!"); return false;
        }
        var startTime = new Date(start.replace("-", "/"));
        var endTime = new Date(end.replace("-", "/"));
        if (endTime < startTime) {
            alert("活动开始时间应小于活动结束时间!");
        } else {
            var address = $("input[id$='txtAddress']").val();
            if (address == "") {
                alert("请输入活动地址!"); return false;
            }
            var content = $("textarea[id$='txtContent']").val();
            if (content == "") {
                alert("请输入活动内容!"); return false;
            }
            
        }
    }
</script>
