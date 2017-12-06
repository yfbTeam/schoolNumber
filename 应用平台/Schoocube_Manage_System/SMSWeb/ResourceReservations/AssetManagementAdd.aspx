<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetManagementAdd.aspx.cs" Inherits="SMSWeb.ResourceReservations.AssetManagementAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增资产</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <link href="/css/plan.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">

        var UrlDate = new GetUrlDate();
        $(function () {
            var ID = UrlDate.ID;
            var Type = UrlDate.type;
            if (ID != undefined) {
                $("#btnCreate").val("修改资产");
                GetAssetByID(ID);//AssetManagement
                if (Type == 1) {
                    setDisable(true);
                }
            }
            else {
                $("#btnCreate").val("新增资产");
            }
        })
    </script>
</head>
<body style="background: #fff;">
    <input type="hidden" id="HUserName" value="<%=Name%>" />
    <input type="hidden" id="HValidateSubmit" value="" />
    <%--<form id="form1">--%>
    <div class="MenuDiv">
        <table class="tbEdit">
            <tbody>
                <tr>
                    <td class="mi">
                        <span class="m">资产名称：</span>
                    </td>
                    <td class="ku">
                        <input name="Name" type="text" id="Name" value="">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">型号：
                    </td>
                    <td class="ku">
                        <input name="AssetModel" type="text" id="AssetModel" value="">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">数量：
                    </td>
                    <td class="ku">
                        <input name="Number" type="text" id="Number" value="">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">存放地名称：</td>
                    <td class="ku">
                        <input name="AdressName" type="text" id="AdressName" value="">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">使用单位：</td>
                    <td class="ku">
                        <input name="UseUnits" type="text" id="UseUnits" value="">
                        <span style="color: red;">* </span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">保修日期：
                    </td>
                    <td class="ku">
                        <input id="WarrantyDate" class="Wdate fl" type="text" placeholder="选择日期" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">负责人：</td>
                    <td class="ku">
                        <input name="Principal" type="text" id="Principal" value="">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">购置日期
                    </td>
                    <td class="ku">
                        <input id="AcquisitionDate" class="Wdate fl" type="text" placeholder="选择日期" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">设备来源
                    </td>
                    <td class="ku">
                        <input name="SourceEquipment" type="text" id="SourceEquipment" value="">
                        <span style="color: red;">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">使用状态
                    </td>
                    <td class="ku">
                        <select name="UseStatus" class="select fl" id="UseStatus">
                            <option value="0" selected="selected">未使用</option>
                            <option value="1">使用</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="ku t_btn" colspan="2">
                        <input type="submit" id="submit" name="" value="提交" class="btn" onclick="AddAsset()">
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <%-- </form>--%>
    <script src="/js/common.js"></script>
    <script>
        //添加数据
        function AddAsset() {
            var validate = "";
            var Name = $("#Name").val();
            var AssetModel = $("#AssetModel").val();
            var Number = $("#Number").val();
            var AdressName = $("#AdressName").val();
            var UseUnits = $("#UseUnits").val();
            var WarrantyDate = $("#WarrantyDate").val();
            var Principal = $("#Principal").val();
            var AcquisitionDate = $("#AcquisitionDate").val();
            var SourceEquipment = $("#SourceEquipment").val();
            var UseStatus = $("#UseStatus").val();
            var UserName = $("#HUserName").val();
            
            if (isNaN(Number)) {
                layer.msg("数量请输入数字！");
                return;
            }

            var ID = "";
            if (UrlDate.ID != undefined) {
                ID = UrlDate.ID;
            }
            if (Name == "" || AssetModel == "" || Number == "" || AdressName == "" || UseUnits == "" || WarrantyDate == "" || Principal == "" || AcquisitionDate == "" || SourceEquipment == "") {
                layer.msg("请填写完整信息！");
                return;
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/AssetManagementHandler.ashx",
                    Func: "GetPageList", "Name": Name, "AssetModel": AssetModel, "UseStatus": UseStatus,"IsDelete":0, "ispage": false
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        $("#HValidateSubmit").attr("value", 1);
                    } else {
                        $("#HValidateSubmit").attr("value", 2);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("新增资产页面操作失败！");
                }
            });
            validate = $("#HValidateSubmit").val();
            if (validate == "1") {
                layer.msg("已存在该资产!");
            } else {
                SaveAsset(Name, AssetModel, Number, AdressName, UseUnits, WarrantyDate, Principal, AcquisitionDate, SourceEquipment, UseStatus, ID, UserName);
            }
            

        }

        //绑定数据
        function GetAssetByID(ID) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/AssetManagementHandler.ashx", "Func": "GetPageList", "ispage": "false", "ID": ID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function (i, n) {
                            $("#Name").val(n.Name);
                            $("#AssetModel").val(n.AssetModel);
                            $("#Number").val(n.Number);
                            $("#AdressName").val(n.AdressName);
                            $("#UseUnits").val(n.UseUnits);
                            $("#WarrantyDate").val(DateTimeConvert(n.WarrantyDate));
                            $("#Principal").val(n.Principal);
                            $("#AcquisitionDate").val(DateTimeConvert(n.AcquisitionDate));
                            $("#SourceEquipment").val(n.SourceEquipment);
                            $("#UseStatus option").each(function () {
                                if ($(this).val() == n.UseStatus) {
                                    $(this).attr("selected", "selected");
                                }
                            })
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

        function setDisable(value) {
            $("#Name").attr("disabled", value);
            $("#AssetModel").attr("disabled", value);
            $("#Number").attr("disabled", value);
            $("#AdressName").attr("disabled", value);
            $("#UseUnits").attr("disabled", value);
            $("#WarrantyDate").attr("disabled", value);
            $("#Principal").attr("disabled", value);
            $("#AcquisitionDate").attr("disabled", value);
            $("#SourceEquipment").attr("disabled", value);
            $("#UseStatus").attr("disabled", value);
            $("#submit").attr("disabled", value);
        }

        function SaveAsset(Name, AssetModel, Number, AdressName, UseUnits, WarrantyDate, Principal, AcquisitionDate, SourceEquipment, UseStatus, ID, UserName) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/AssetManagementHandler.ashx",
                    Func: "AddAssetManagement", "Name": Name, "AssetModel": AssetModel, "Number": Number, "AdressName": AdressName, "UseUnits": UseUnits,
                    "WarrantyDate": WarrantyDate, "Principal": Principal, "AcquisitionDate": AcquisitionDate, "SourceEquipment": SourceEquipment, "UseStatus": UseStatus, "ID": ID, "UserName": UserName
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('新增资产成功!');
                        parent.getData(1, 10);
                        parent.CloseIFrameWindow();
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("新增资产失败！");
                }
            });
        }

        //function addAssest() {
        //    $.ajax({
        //        url: "/Common.ashx",
        //        type: "post",
        //        async: false,
        //        dataType: "json",
        //        data: {
        //            "PageName": "ResourceReservations/AssetManagementHandler.ashx",
        //            Func: "AddAssetManagement", Name: Name, AssetModel: AssetModel, Number: Number, AdressName: AdressName, UseUnits: UseUnits,
        //            WarrantyDate: WarrantyDate, Principal: Principal, AcquisitionDate: AcquisitionDate, SourceEquipment: SourceEquipment, UseStatus: UseStatus, ID: ID, UserName: UserName
        //        },
        //        success: function (json) {
        //            var result = json.result;
        //            if (result.errNum == 0) {
        //                parent.layer.msg('操作成功!');
        //                parent.getData(1, 10);
        //                parent.CloseIFrameWindow();
        //            } else {
        //                layer.msg(result.errMsg);
        //            }
        //        },
        //        error: function (XMLHttpRequest, textStatus, errorThrown) {
        //            layer.msg("操作失败！");
        //        }
        //    });
        //}
    </script>
</body>
</html>
