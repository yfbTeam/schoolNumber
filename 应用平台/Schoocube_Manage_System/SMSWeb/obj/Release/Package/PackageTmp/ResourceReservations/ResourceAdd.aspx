<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceAdd.aspx.cs" Inherits="SMSWeb.ResourceReservations.ResourceAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增资源</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link href="../css/plan.css" rel="stylesheet" />
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../ResourceReservationMenu.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>


    <script type="text/javascript">

        var GetUrlDate = new GetUrlDate();
        $(function () {
            getCarDriverInfo();
            var ID = GetUrlDate.ID;
            var PName = unescape(GetUrlDate.PName);
            $("#HTypeName").val(PName);
            $(".typeName").text(PName);
            if (ID != undefined) {
                if (PName == "车辆") {
                    $("#officeResource").hide();
                    $("#carResource").show();
                    $("#trFloor").hide();
                    $("#trRoom").hide();
                } else if (PName == "专业教室") {
                    $("#officeResource").show();
                    $("#carResource").hide();
                    $("#trArea").show();
                    $("#trFloor").show();
                    $("#trRoom").show();
                } else {
                    $("#officeResource").show();
                    $("#carResource").hide();
                    $("#trFloor").hide();
                    $("#trRoom").hide();
                }
                $("#btnCreate").val("修改资源");
                GetResourceByID(ID, PName);
            }
            else {
                if (PName == "车辆") {
                    $("#officeResource").hide();
                    $("#carResource").show();
                    $("#trFloor").hide();
                    $("#trRoom").hide();
                } else if (PName == "专业教室") {
                    $("#officeResource").show();
                    $("#carResource").hide();
                    $("#trFloor").show();
                    $("#trRoom").show();
                } else {
                    $("#officeResource").show();
                    $("#carResource").hide();
                    $("#trArea").hide();
                    $("#trFloor").hide();
                    $("#trRoom").hide();
                }
                $("#btnCreate").val("新增资源");
            }
            if (PName == "车辆") {
                $("#uploadify1").uploadify({
                    'auto': true,                      //是否自动上传
                    'swf': '../Scripts/Uploadyfy/uploadify/uploadify.swf',
                    'uploader': 'Uploade.ashx',
                    'formData': { Func: "Uplod_Image" }, //参数
                    'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                    'buttonText': '选择图片',//按钮文字
                    'width': 250,
                    'height': 30,
                    'queueID': 'fileQueue1',
                    'fileTypeDesc': '文件',       //图片选择描述  
                    'progressData': 'all',
                    //最大文件数量
                    'uploadLimit': 999,
                    'multi': false,//单选            
                    'fileSizeLimit': '20MB',//最大文档限制
                    'queueSizeLimit': 1,  //队列限制
                    'removeCompleted': true, //上传完成自动清空
                    'removeTimeout': 0, //清空时间间隔
                    'onUploadSuccess': function (file, data, response) {
                        var json = $.parseJSON(data);

                        $("#img_Pic1").attr("src", json.result.retData);

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
            } else {
                $("#uploadify").uploadify({
                    'auto': true,                      //是否自动上传
                    'swf': '../Scripts/Uploadyfy/uploadify/uploadify.swf',
                    'uploader': 'Uploade.ashx',
                    'formData': { Func: "Uplod_Image" }, //参数
                    'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                    'buttonText': '选择图片',//按钮文字
                    'width': 250,
                    'height': 30,
                    'queueID': 'fileQueue',
                    'fileTypeDesc': '文件',       //图片选择描述  
                    'progressData': 'all',
                    //最大文件数量
                    'uploadLimit': 999,
                    'multi': false,//单选            
                    'fileSizeLimit': '20MB',//最大文档限制
                    'queueSizeLimit': 1,  //队列限制
                    'removeCompleted': true, //上传完成自动清空
                    'removeTimeout': 0, //清空时间间隔
                    'onUploadSuccess': function (file, data, response) {
                        var json = $.parseJSON(data);

                        $("#img_Pic").attr("src", json.result.retData);

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
            

        })
    </script>
    <style>
        .change_picture .uploadify-button{font-size:14px;border:none;background:#00a1ec;color:#fff;}
    </style>
</head>
<body>
    <%--<form id="officeResource" runat="server" enctype='multipart/form-data'>--%>
    <input type="hidden" id="HTypeName" value="" runat="server" />
     <input type="hidden" id="HUserName" value="<%=Name%>" />
    <div id="officeResource">
        <div class="MenuDiv">
            <table class="tbEdit">
                <tbody>
                    <tr>
                        <td class="mi">
                            <span class="m">资源类型：</span>
                        </td>
                        <td class="ku">
                            <span class="typeName" id="officeTypeName"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">名称：
                        </td>
                        <td class="ku">
                            <input name="OfficeName" type="text" id="OfficeName" value="">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">地点：
                        </td>
                        <td class="ku">
                            <input name="Address" type="text" id="Address" value="">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">面积：</td>
                        <td class="ku">
                            <input name="Area" type="text" id="Area" value="">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">容纳人数：</td>
                        <td class="ku">
                            <input name="Galleryful" type="text" id="Galleryful" value="">
                            <span style="color: red;">* </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">开放时间：
                        </td>
                        <td class="ku">
                            <input name="OpenTime" type="text" id="OpenTime" class="Wdate" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss',maxDate:'#F{$dp.$D(\'ClosedTime\') || $dp.$DV(\'2020-4-3\')}'})">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">关闭时间：</td>
                        <td class="ku">
                            <input name="ClosedTime" type="text" id="ClosedTime" class="Wdate" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss',minDate:'#F{$dp.$D(\'OpenTime\') || $dp.$DV(\'2020-4-3\')}'})">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr style="display:none" id="trFloor">
                        <td class="mi">楼层：</td>
                        <td class="ku">
                            <input name="Floor" type="text" id="Floor" value="">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr style="display:none" id="trRoom">
                        <td class="mi">房间号：</td>
                        <td class="ku">
                            <input name="Room" type="text" id="Room" value="">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">状态：</td>
                        <td class="ku">
                            <select name="Status" class="select fl" id="officeStatus">
                                <option value="0" selected="selected">正常</option>
                                <option value="1">故障</option>
                                <option value="2">维修中</option>
                            </select>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="mi">相关图片：
                        </td>
                        <td class="ku">
                            <img id="img_Pic" alt="" src="../images/fpsc.jpg"  style="width:255px;height:auto;"/>
                            <div class="change_picture">
                                <input type="file" id="uploadify" name="uploadify" />
                                <div id="fileQueue" style="float: left; height: 35px;"></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="ku t_btn" colspan="2">
                            <input type="submit" name="" value="提交" class="btn" onclick="AddOfficeResource()">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <%--</form>--%>
    <%--<form id="carResource">--%>
    <div id="carResource">
        <div class="MenuDiv">
            <table class="tbEdit">
                <tbody>
                    <tr>
                        <td class="mi">
                            <span class="m">资源类型：</span>
                        </td>
                        <td class="ku">
                            <span class="typeName"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">车辆名称：
                        </td>
                        <td class="ku">
                            <input name="CarName" type="text" id="CarName">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">车辆型号：
                        </td>
                        <td class="ku">
                            <input name="Model" type="text" id="Model">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">车牌号：</td>
                        <td class="ku">
                            <input name="LicensePlate" type="text" id="LicensePlate">
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">座位数：</td>
                        <td class="ku">
                            <input name="SeatNum" type="text" id="SeatNum">
                            <span style="color: red;">* </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">车辆司机：
                        </td>
                        <td class="ku">
                            <select name="CarDriver" class="select fl" id="CarDriver">
                                <option value=""></option>
                            </select>
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">状态：</td>
                        <td class="ku">
                            <select name="CarStatus" class="select fl" id="CarStatus">
                                <option value="0" selected="selected">正常</option>
                                <option value="1">故障</option>
                                <option value="2">维修中</option>
                            </select>
                            <span style="color: red;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">相关图片：
                        </td>
                        <td class="ku">
                            <img id="img_Pic1" alt="" src="../images/fpsc.jpg"  style="width:255px;height:auto;" />
                            <div class="change_picture">
                                <input type="file" id="uploadify1" name="uploadify" />
                                <div id="fileQueue1" style="float: left; height: 35px;"></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="ku t_btn" colspan="2">
                            <input type="submit" name="" value="提交" class="btn" onclick="AddCarResource()">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <%-- </form>--%>
    <script src="../js/common.js"></script>
    <script>

        //添加数据
        function AddOfficeResource() {
            var PName = $("#HTypeName").val();
            $(".typeName").text(PName);
            var Name = $("#OfficeName").val();
            var UserName = $("#HUserName").val();
            var Address = $("#Address").val();
            var Area = $("#Area").val();
            var Galleryful = $("#Galleryful").val();
            var OpenTime = $("#OpenTime").val();
            var ClosedTime = $("#ClosedTime").val();
            var filePic = $("#img_Pic").attr("src");
            var Floor = $("#Floor").val();
            var Room = $("#Room").val();
            var Status = $("#officeStatus").val();
            var ID = "";
            var PName = "";
            if (GetUrlDate.ID != undefined) {
                ID = GetUrlDate.ID;
            }
            if (GetUrlDate.PName != undefined || GetUrlDate.PName != null) {
                PName = unescape(GetUrlDate.PName);
            }
            if (PName == "专业教室") {
                if (Name == "" || Address == "" || Area == "" || Galleryful == "" || OpenTime == "" || ClosedTime == "" || Floor == "" || Room == "") {
                    layer.alert("请填写完整信息！");
                    return;
                }
            } else {
                if (Name == "" || Address == "" || Area == "" || Galleryful == "" || OpenTime == "" || ClosedTime == "") {
                    layer.alert("请填写完整信息！");
                    return;
                }
            }
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "ResourceReservations/ResourceReservationInfoHandler.ashx",
                        Func: "AddNewResourceInfo", Name: Name, ResourceId: GetUrlDate.PID, ResourceTypeName: PName, Address: Address, Area: Area,
                        Galleryful: Galleryful, OpenTime: OpenTime, ClosedTime: ClosedTime, Type: 0, ID: ID, FoldUrl: filePic, UserName: UserName, Room: Room, Floor: Floor, Status: Status
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            parent.layer.msg('操作成功!');
                            parent.getData(1, 10);
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

        function AddCarResource() {
            var PName = unescape(GetUrlDate.PName);;
            $("#carResource .typeName").text(PName);
            var Name = $("#CarName").val();
            var Model = $("#Model").val();
            var LicensePlate = $("#LicensePlate").val();
            var SeatNum = $("#SeatNum").val();
            var CarDriver = $("#CarDriver").val();
            var UserName = $("#HUserName").val();
            var Status = $("#CarStatus").val();
            var filePic = $("#img_Pic1").attr("src");
            var ID = "";
            if (GetUrlDate.ID != undefined) {
                ID = GetUrlDate.ID;
            }
            if (Name == "" || Model == "" || LicensePlate == "" || SeatNum == "") {
                layer.msg("请填写完整信息！");
            }
            else {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "ResourceReservations/ResourceReservationInfoHandler.ashx",
                        Func: "AddNewResourceInfo", Name: Name, ResourceId: GetUrlDate.PID, ResourceTypeName: PName, Model: Model, LicensePlate: LicensePlate,
                        SeatNum: SeatNum, CarDriver: CarDriver, Type: 1, ID: ID, UserName: UserName, FoldUrl: filePic, Status: Status
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            parent.layer.msg('操作成功!');
                            parent.getData(1, 10);
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
        }
        //绑定数据
        function GetResourceByID(ID, PName) {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/ResourceReservationInfoHandler.ashx", "Func": "GetPageList", "ispage": "false", "ID": ID },
                success: function (json) {
                    if (PName == "车辆") {
                        if (json.result.errNum.toString() == "0") {
                            $(json.result.retData).each(function () {
                                $("#CarName").val(this.Name);
                                $("#ResourceTypeName").val(this.ResourceTypeName);
                                $("#Model").val(this.Model);
                                $("#LicensePlate").val(this.LicensePlate);
                                $("#SeatNum").val(this.SeatNum);
                                $("#CarDriver").val(this.CarDriver);
                                if (this.Image !=""){
                                    $("#img_Pic1").attr("src", this.Image);
                                }
                                $("#CarStatus").val(this.Status);
                            });
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    } else {
                        if (json.result.errNum.toString() == "0") {
                            $(json.result.retData).each(function () {
                                $("#OfficeName").val(this.Name);
                                $("#ResourceTypeName").val(this.ResourceTypeName);
                                $("#Address").val(this.Address);
                                $("#Area").val(this.Area);
                                $("#Galleryful").val(this.Galleryful);
                                $("#OpenTime").val(this.OpenTime);
                                $("#ClosedTime").val(this.ClosedTime);
                                if (this.Image != "") {
                                    $("#img_Pic").attr("src", this.Image);
                                }
                                $("#Floor").val(this.Floor);
                                $("#Room").val(this.Room);
                                $("#officeStatus").val(this.Status);
                            });
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    }

                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

        function getCarDriverInfo() {
            $.ajax({
                url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "GetAllTeacherInfo" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function (i,n) {
                            $("#CarDriver").append("<option value='" + n.Id + "'>" + n.Name + "</option>");
                        });
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

