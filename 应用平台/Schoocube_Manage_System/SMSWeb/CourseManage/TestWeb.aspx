<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestWeb.aspx.cs" Inherits="SMSWeb.CourseManage.TestWeb" %>

<!DOCTYPE html>

<html>
<head>
    <title>另存网页</title>
    <script type="text/javascript">
        function runCode(obj) {
            var winname = window.open('', "_blank", '');
            winname.document.open('text/html', 'replace');
            winname.opener = null // 防止代码对父页面修改 
            winname.document.write(obj.value);
            winname.document.close();
        }
        function saveCode(obj) {
            var winname = window.open('', '_blank', 'top=10000');
            winname.document.open('text/html', 'replace');
            winname.document.write(obj.value);
            winname.document.execCommand('saveas', '', 'code.htm');
            winname.close();
        }

        function oCopy(obj) {
            obj.select();
            js = obj.createTextRange();
            js.execCommand("Copy");
            alert("脚本之家提示：代码已经被成功复制！");
        }</script>
</head>
<body>
    <object classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"
        height="0" width="0" id="WebBrowser">
    </object>
    <input type="button" value="另存网页" onclick="WebBrowser.ExecWB(4, 1)">
</body>
</html>

