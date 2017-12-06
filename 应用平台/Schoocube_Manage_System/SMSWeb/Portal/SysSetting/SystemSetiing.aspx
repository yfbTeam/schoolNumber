<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemSetiing.aspx.cs" Inherits="SMSWeb.Portal.SysSetting.SystemSetiing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="//Scripts/jquery-1.11.2.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField runat="server" ID="hidApp" />
        <asp:HiddenField runat="server" ID="hidConn" />
        <asp:HiddenField runat="server" ID="hidHand" />
        <div>
            <table runat="server" id="tabConfig">
                <tbody>
                    <tr>
                        <th colspan="2">appSettings节点</th>
                    </tr>
                    <tr>
                        <th>Key</th>
                        <th>Value</th>
                    </tr>
                </tbody>
            </table>
            <div class="course_form_select clearfix">
                <asp:Button runat="server" ID="btnApp" Text="保存" OnClientClick="saveAppData()" OnClick="btnApp_Click" />
            </div>
            <table runat="server" id="tabConnectConfig">
                <tbody>
                    <tr>
                        <th colspan="2">connectionStrings节点</th>
                    </tr>
                    <tr>
                        <th>Key</th>
                        <th>Value</th>
                    </tr>
                </tbody>
            </table>
            <div class="course_form_select clearfix">
                <asp:Button runat="server" ID="btnConn" Text="保存" OnClientClick="saveConnData()" OnClick="btnConn_Click" />
            </div>
            <table runat="server" id="tabHandConfig">
                <tbody>
                    <tr>
                        <th colspan="2">一般处理程序下的connectionStrings节点</th>
                    </tr>
                    <tr>
                        <th>Key</th>
                        <th>Value</th>
                    </tr>
                </tbody>
            </table>
            <div class="course_form_select clearfix">
                <asp:Button runat="server" ID="btnHand" Text="保存" OnClientClick="saveHandData()" OnClick="btnHand_Click"  />
            </div>
        </div>
    </form>
    <script type="text/javascript">
        function saveAppData() {
            var attr = "";
            $("#tabConfig").find("tr").each(function () {
                $(this).find("td input").each(function () {
                    var key = $(this).attr("key");
                    var val = $(this).val();
                    attr += key + ":" + val + ",";
                });
            });

            if (attr.length > 0) {
                attr = attr.substring(0, attr.length - 1);
                $("#hidApp").val(attr);
            }

        }

        function saveConnData() {
            var attr2 = "";
            $("#tabConnectConfig").find("tr").each(function () {
                $(this).find("td input").each(function () {
                    var key = $(this).attr("key");
                    var val = $(this).val();
                    attr2 += key + ":" + val + ",";
                });
            });
            if (attr2.length > 0) {
                attr2 = attr2.substring(0, attr2.length - 1);
                $("#hidConn").val(attr2);
            }
        }

        function saveHandData() {
            var attr3 = "";
            $("#tabHandConfig").find("tr").each(function () {
                $(this).find("td input").each(function () {
                    var key = $(this).attr("key");
                    var val = $(this).val();
                    attr3 += key + ":" + val + ",";
                });
            });
            if (attr3.length > 0) {
                attr3 = attr3.substring(0, attr3.length - 1);
                $("#hidHand").val(attr3);
            }
        }
    </script>
</body>
</html>
