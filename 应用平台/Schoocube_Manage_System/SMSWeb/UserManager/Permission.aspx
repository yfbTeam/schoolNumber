<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="Permission.aspx.cs" Inherits="SMSWeb.UserManager.Permission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stu_css/common.css" rel="stylesheet" />
    <link href="../Stu_css/style.css" rel="stylesheet" />
    <link href="../Stu_css/iconfont.css" rel="stylesheet" />
    <link href="../Stu_css/animate.css" rel="stylesheet" />
    <link href="../Stu_css/layout.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.8.0.js"></script>
    <script src="../Stu_js/layer/layer.js"></script>
    <script src="../Stu_js/layer/OpenLayer.js"></script>

    <style type="text/css">
        .hid {
            display: none;
        }

        .fileup {
            border-radius: 3px;
            background-color: #0DA6EC;
            color: white;
            border: 0px;
        }

        .Operations a.shenhe {
            display: block;
            padding: 0px 4px;
            background: #0da6ec;
            border-radius: 3px;
            color: #fff;
            float: left;
            margin: 0 4px;
            height: 20px;
            line-height: 20px;
        }

        .selected {
            display: inline-block;
            background: #0da6ec;
            color: #fff;
        }

            .selected a {
                color: #fff;
            }

        .star {
            padding: 0;
            margin: 0;
            list-style: none;
            float: left;
        }

            .star li {
                float: left;
                height: 20px;
                width: 20px;
                margin-right: 4px;
            }

                .star li.on {
                    color: #f60;
                }

                .star li.off {
                    color: #ccc;
                }

        .iconfont {
            cursor: pointer;
        }
        #rolenav input{
            width:80%;
        }
        .selectinp{
            background-color:#007cdb;
        }
    </style>
    <script type="text/javascript">

        var pIndex = 1;
        var pCount = 0;
        var pSize = 10;
        var operate = "common";
        function BindData(data) {
            $("#tab").empty();
            var FirstUrl = window.location.href;
            FirstUrl = FirstUrl.substring(0, FirstUrl.indexOf("SitePages"))
            var i = 0;

            var trfir = "<tr class='trth'><th class='Account'>序号</th><th class='name'>登录名</th><th class='Head'>姓名</th><th class='Contact'>邮箱</th><th class='Operation'>操作</th></tr>";
            $("#tab").append(trfir);
            if (data == "[]") {

                $("#tab").append("<tr><td colspan='6' style='text-align:center'>暂时没有相关数据</td></tr>");
            }
            $($.parseJSON(data)).each(function () {

                if (parseInt(i) % 2 == 0) {
                    var tr = "<tr class='Single'><td class='Account'>" + (i + 1) + "</td><td class='name'>" + this.LoginName + "</td><td class='Account'>" + this.Title + "</td><td class='Account'>" + this.Email + "</td>" +
                    "<td class='Operation'><a class='btn'  onclick='DeleUser(\"" + this.LoginName + "\")'><i class='iconfont'>&#xe624;</i></a></td></tr>";
                    $("#tab").append(tr);
                }
                else {
                    var tr = "<tr class='Double'><td class='Account'>" + (i + 1) + "</td><td class='name'>" + this.LoginName + "</td><td class='Account'>" + this.Title + "</td><td class='Account'>" + this.Email + "</td>" +
                     "<td class='Operation'><a class='btn'  onclick='DeleUser(\"" + this.LoginName + "\")'><i class='iconfont'>&#xe624;</i></a></td></tr>";
                    $("#tab").append(tr);
                }
                i++;

            })
        }
        var FirstUrl = window.location.href;
        FirstUrl = FirstUrl.substring(0, FirstUrl.indexOf("SitePages"));
        function ShowData(index) {
            var firstid = $("#hidflag").val();
            var postData = {
                CMD: "FullTab",
                PageSize: pSize,
                PageIndex: index,
                groid: firstid,
                operate: operate,
                searchval: $("#txtName").val()
            };

            $.ajax({
                type: "Post",
                url: FirstUrl + "_layouts/15/hander/SecondNav.aspx",
                data: postData,
                dataType: "text",
                success: function (returnVal) {
                    returnVal = $.parseJSON(returnVal);
                    if (returnVal != null) {
                        SetPageCount(Math.ceil(returnVal.PageCount / pSize));
                        BindData(returnVal.Data);
                    }
                },
                error: function (errMsg) {
                    alert('数据加载失败！');
                }
            });
        }

        $(function () {
            //serchSubNev();

        });



        function Bind(groid) {

            $("#hidflag").val(groid);


            $.ajax({
                type: "Post",
                url: FirstUrl + "/_layouts/15/hander/SecondNav.aspx",
                data: { CMD: "FullTab", PageSize: pSize, PageIndex: pIndex, groId: groid, operate: operate, searchval: $("#txtName").val() },
                dataType: "text",
                success: function (returnVal) {
                    returnVal = $.parseJSON(returnVal);
                    if (returnVal != null) {
                        pCount = returnVal.PageCount;
                        LoadPageControl(ShowData, "pageDiv", pIndex, pSize, Math.ceil(pCount / pSize), pCount);
                    }
                },
                error: function (errMsg) {
                    alert('数据加载失败！');
                }
            });

        }
        function btnQuery() {
            operate = "search";
            var firstid = $("#hidflag").val();
            Bind(firstid);
        }


        //绑定左侧导航
        function serchSubNev() {
            $("#Tree").empty();

            var div = "";
            $.ajax({
                type: "Post",
                url: FirstUrl + "/_layouts/15/hander/SecondNav.aspx",
                data: { CMD: "Tree" },
                dataType: "text",
                success: function (returnVal) {
                    $("#Tree").append(returnVal);
                    var firstid = $("#hidflag").val();
                    $("#div" + firstid + " div").css("background", "#F6F6F6");
                    Bind(firstid);
                    initTree();
                    //Bind();
                },
                error: function (errMsg) {
                    alert("数据加载失败");
                }
            });
        }
        //左侧导航点击绑定内容

        function navTopClick() {
            $(".navgition").html("全部文件");
            $("#quanbu").css("background", "#F6F6F6");
            $("#quanbu").children(".icon").eq(0).css("background", "#0da6ea");
            $("#quanbu").children(".icon").eq(0).css("border", "1px solid #0da6ea");
            $("[id$='hContent']").val("");

            Bind();

        }
        //左侧导航点击绑定内容
        function NavClick(id, em) {

            $(".item div").css("background", "none");

            $(em).css("background", "#F6F6F6");
            //$(em).children(".icon").eq(0).css("background", "#0da6ea");
            //$(em).children(".icon").eq(0).css("border", "1px solid #0da6ea");
            operate = "common";

            Bind(id);
        }
        //左侧导航点击、鼠标经过事件
        function initTree() {

            $(".i-menu").each(function () {
                var _this = $(this);
                $(this).hover(function () {
                    _this.find(".btn-area").show();
                }, function () {
                    _this.find(".btn-area").hide();
                });
                var i_con = $(this).next(".ici-con")[0];
                if (i_con != null) {
                    i_con.style.display = "none";
                }
            });
            $(".ici-menu").each(function () {
                var _this = $(this);
                $(this).hover(function () {
                    _this.find(".btn-area").show();
                }, function () {
                    _this.find(".btn-area").hide();
                });
                var i_con = $(this).next(".ici-con")[0];
                if (i_con != null) {
                    i_con.style.display = "none";
                }
            });
            $(".icic-item").each(function () {
                var _this = $(this);
                $(this).hover(function () {
                    _this.find(".btn-area").show();
                }, function () {
                    _this.find(".btn-area").hide();
                });
            });
            $(".i-menu").click(function () {
                $(".i-menu").next().hide();
                var dis = $(this).next().css("display");
                if (dis == "none") {
                    $(this).next().show();
                }
                else {
                    $(this).next().hide();
                }
            });
            $(".ici-menu").click(function () {
                $(".ici-menu").next().hide();
                var dis = $(this).next().css("display");
                if (dis == "none") {
                    $(this).next().show();
                }
                else {
                    $(this).next().hide();
                }
            });
        }
        function AddUserToServer(returnVal) {

            var firstid = $("#hidflag").val();
            $.ajax({
                type: "Post",
                url: FirstUrl + "/_layouts/15/hander/SecondNav.aspx",
                data: {
                    CMD: "Add", Resouce: returnVal, groid: firstid
                },
                dataType: "text",
                success: function (returnVal) {
                    if (returnVal == "1") {
                        Bind(firstid);
                    }

                },
                error: function (errMsg) {
                    alert(errMsg);
                }
            });
        }
        function AddRole() {
            var url = FirstUrl + "SitePages/AddRole.aspx";
            //openDialog(url, 420, 300, closeCallback);
            OL_ShowLayer(2, "新建角色", 480, 450, url, function (returnVal) {
                serchSubNev();
            });
            return false;
        }
        function EditRole(itemid) {
            var url = FirstUrl + "SitePages/AddRole.aspx?itemid=" + itemid;
            //openDialog(url, 420, 300, closeCallback);
            OL_ShowLayer(2, "编辑角色", 480, 350, url, function (returnVal) {
            });
            return false;
        }
        function DeleRole(itemid) {
            if (confirm("你确定要删除当前权限组吗？")) {
                $.ajax({
                    type: "Post",
                    url: FirstUrl + "/_layouts/15/hander/SecondNav.aspx",
                    data: {
                        CMD: "Dele", groid: itemid
                    },
                    dataType: "text",
                    success: function (returnVal) {
                        if (returnVal == "1") {
                            alert("删除成功");
                            serchSubNev();
                        }
                        else {
                            alert("当前权限组存在用户，不允许删除！");
                        }
                    },
                    error: function (errMsg) {
                        alert(errMsg);
                    }
                });
            }
        }
        function DeleUser(LoginName) {
            if (confirm("你确定要移除该用户吗？")) {
                var firstid = $("#hidflag").val();
                $.ajax({
                    type: "Post",
                    url: FirstUrl + "/_layouts/15/hander/SecondNav.aspx",
                    data: {
                        CMD: "DeleUser", groid: firstid, LoginName: LoginName
                    },
                    dataType: "text",
                    success: function (returnVal) {
                        if (returnVal == "1") {
                            alert("操作成功");
                            Bind(firstid);
                        }
                        else {
                            alert("操作失败！");
                        }
                    },
                    error: function (errMsg) {
                        alert(errMsg);
                    }
                });
            }
        }

        function AddUser() {

            var roleId = $("input[id$=Hid_RoleFlag]").val();
            var url = "AddRoleMember.aspx?roleid=" + roleId;
            if (roleId == "0") {
                alert("请选择角色");
                return false;
            }
            OL_ShowLayer(2, "添加人员", 730, 600, url, function (returnVal) {
                if (returnVal == "1") {
                    var clintId = $("input[id$=Hid_BtnClint]").val();
                    $("#" + clintId).click();

                }

            });
            return false;

        }
        function EditRole(obj) {
            var url = "EditRole.aspx?itemid=" + $(obj).attr("roleId");
            OL_ShowLayer(2, "分配权限", 330, 400, url, function (returnVal) {
                if (returnVal == "1") {


                }

            });
        }
        function CheckRole()
        {
            var roleId = $("input[id$=Hid_RoleFlag]").val();
            if (roleId == "0") {
                alert("请选择角色");
                return false;
            }
            else
            {
                return confirm('你确定要移除该用户吗？');
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    

    <!--校本资源库-->

    <div class="School_library">



        <div class="Whole_display_area">

            <div class="clear"></div>
            <div class="Schoolcon_wrap">
                <div class="left_navcon fl">

                    <h1>角色管理</h1>
                    <asp:HiddenField ID="Hid_RoleFlag" Value="0" runat="server" />
                    <asp:HiddenField ID="Hid_BtnClint" runat="server" />
                    <asp:Repeater ID="Rpt_Perssion" runat="server">
                        <HeaderTemplate>
                            <div class="select-box" id="Tree">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class='item' id='1'>
                                <div class='i-menu cf' onclick="<%#Eval("Id") %>">
                                    <span class="fl tubiao"><i class="iconfont">&#xe60c;</i></span>
                                    <span id="rolenav" class="tit fl">
                                        <asp:Button ID="Btn_RoleName" CommandArgument='<%#Eval("Id") %>' runat="server" OnClick="Btn_RoleName_Click" Text='<%#Eval("RoleName") %>' />
                                        &nbsp;
                                        <a class="add" roleId='<%#Eval("Id") %>' href="#" onclick="EditRole(this);"><i class="iconfont">&#xe60a;</i></a>
                                        
                                    </span>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>

                  
                    
                </div>
                <div class="right_dcon">
                    <!--操作区域-->
                    <div class="Operation_area">
                        <div class="left_choice fl" id="opertion">
                            <input type="text" style="height: 30px; line-height: 30px;" placeholder=" 请输入姓名" class="search" name="search" id="txtName" /><i class="iconfont" id="btnQuery" onclick="btnQuery()">&#xe609;</i>
                        </div>
                        <div class="right_add fr" style="font-size: 18px;">
                            <a class="add" href="#" onclick="AddUser();"><i class="iconfont">&#xe61e;</i>添加用户</a>
                        </div>
                    </div>

                    <!--展示区域-->
                    <div class="Display_form">
                        <div class="Resources_tab">

                            <div class="content" style="float:left;width:100%;">
                                <div class="tabcontent">
                                    <asp:ListView ID="LV_PermissionManager" runat="server" OnPagePropertiesChanging="LV_PermissionManager_PagePropertiesChanging">
                                        <EmptyDataTemplate>
                                            <div style="text-align: center;">
                                                暂时没有数据
                                            </div>
                                        </EmptyDataTemplate>
                                        <LayoutTemplate>
                                            <table cellspacing="0" cellpadding="0" class="W_form">
                                                <tr class="trth">
                                                    <th>
                                                        <input style="border: 0px solid black" type="checkbox" id="ckx_head" /></th>
                                                    <th>序号</th>
                                                    <th>姓名</th>
                                                    <th>性别</th>
                                                    <th>邮箱</th>
                                                    <th>身份</th>
                                                    <th>操作</th>
                                                </tr>
                                                <tr id="itemPlaceholder" runat="server"></tr>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr class="Single">
                                                <td>
                                                    <input class="ckbid" onclick="Getid(this)" style="border: 0px solid black" type="checkbox" flag='' loginname='' /></td>
                                                <td><%# Container.DataItemIndex + 1%></td>

                                                <td><%#Eval("UserName")%></td>
                                                <td><%#Eval("Sex")%></td>
                                                <td><%#Eval("Email")%></td>
                                                <td><%#Eval("RoleName")%></td>
                                                <td>
                                                    <asp:Button ID="Btn_Del" CommandArgument='<%#Eval("Id")%>' CommandName="Del" OnClientClick="return CheckRole();" runat="server" Text="移除" OnClick="Btn_Del_Click" /></td>
                                            </tr>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <tr class="Double">
                                                <td>
                                                    <input class="ckbid" onclick="Getid(this)" style="border: 0px solid black" type="checkbox" flag='' loginname='' /></td>
                                                <td><%# Container.DataItemIndex + 1%></td>
                                                <td><%#Eval("UserName")%></td>
                                                <td><%#Eval("Sex")%></td>
                                                <td><%#Eval("Email")%></td>
                                                <td><%#Eval("RoleName")%></td>
                                                <td>
                                                    <asp:Button ID="Btn_Del" CommandArgument='<%#Eval("Id")%>' CommandName="Del" OnClientClick="return CheckRole();" runat="server" Text="移除" OnClick="Btn_Del_Click" /></td>
                                            </tr>
                                        </AlternatingItemTemplate>

                                    </asp:ListView>

                                </div>
                                <div class="paging">
                                    <asp:DataPager ID="DP_PermissionManager" runat="server" PageSize="10" PagedControlID="LV_PermissionManager">
                                        <Fields>
                                            <asp:NextPreviousPagerField
                                                ButtonType="Link" ShowNextPageButton="False" ShowPreviousPageButton="true"
                                                ShowFirstPageButton="true" FirstPageText="首页" PreviousPageText="上一页" />

                                            <asp:NumericPagerField CurrentPageLabelCssClass="number now" NumericButtonCssClass="number" />

                                            <asp:NextPreviousPagerField
                                                ButtonType="Link" ShowPreviousPageButton="False" ShowNextPageButton="true"
                                                ShowLastPageButton="true" LastPageText="末页" NextPageText="下一页" />

                                            <asp:TemplatePagerField>
                                                <PagerTemplate>
                                                    <span class="page">| <%# Container.StartRowIndex / Container.PageSize + 1%> / 
                            <%# (Container.TotalRowCount % Container.MaximumRows) > 0 ? Convert.ToInt16(Container.TotalRowCount / Container.MaximumRows) + 1 : Container.TotalRowCount / Container.MaximumRows%>  页
                            (共<%# Container.TotalRowCount %>项)
                                                    </span>
                                                </PagerTemplate>
                                            </asp:TemplatePagerField>
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                                <%--<div class="tc">
                                        <div class="Order_form">
                                            <div class="Food_order">
                                                <table class="W_form" id="tab">
                                                </table>
                                                <div id="pageDiv" class="pageDiv">
                                                </div>
                                            </div>
                                        </div>
                                    </div>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
