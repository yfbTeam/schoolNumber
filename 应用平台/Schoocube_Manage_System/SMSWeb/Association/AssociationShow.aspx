<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="AssociationShow.aspx.cs" Inherits="SMSWeb.Association.AssociationShow" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <link rel="stylesheet" href="../Stu_css/allst.css"/>
<link rel="stylesheet" href="../Stu_css/ico/iconfont.css"/>	
<link href="../Stu_css/layout.css" rel="stylesheet" />
<script src="../Stu_js/jquery-1.8.0.js"></script>
<script src="../Stu_js/popwin.js"></script>
<script src="../Stu_js/tz_slider.js"></script>
<script type="text/javascript">
    $(function () {
        $(".albumpic").click(function () {
            var assoid = $(this).attr("assoid");
            var albumid = $(this).attr("albumid");
            openPage('查看相册', 'ShowAssociaePhoto.aspx?flag=show&itemid=' + assoid + '&albumid=' + albumid, '620', '550'); 
        });

        $(".lia").click(function () {
            //alert("进来了");
            var index = $(this).index();
            $(this).addClass("active").siblings().removeClass("active");
            $(".td").eq(index).show().siblings().hide();
        });
        
        //TabChange(".st_nav", "active", ".rflf", ".td");
        TabChange(".div_activies .activetab", "active", ".div_activies", ".twotd");
    })
    function TabChange(navcss, selectedcss, parcls, childcls) { //选项卡切换方法，navcss选项卡父级，selectedcss选中样式，parcls内容的父级样式，childcls内容样式
        $(navcss).find("a").click(function () {
            var index = $(this).parent().index();
            $(this).parent().addClass(selectedcss).siblings().removeClass(selectedcss);//为单击的选项卡添加选中样式，同时与当前选项卡同级的其他选项卡移除选中样式
            $(this).parents(parcls).find(childcls).eq(index).show().siblings().hide();//找到与选中选项卡相同索引的内容，使其展示，同时设置其他同级内容隐藏。
        });
    }
    function openPage(pageTitle, pageName, pageWidth, pageHeight) {
        if (pageTitle == "上传照片") {
            var ablum = $("#ablum").find("li");
            if (ablum.length == 0) {
                return alert("您还没有相册，请先创建相册");
            }
        }
        var webUrl ="";
        popWin.showWin(pageWidth, pageHeight, pageTitle, webUrl + pageName);
    }
    function closePages() {
        $("#mask,#maskTop").fadeOut(function () {
            $(this).remove();
        });
    }
    function reloadAlbum() {
        delAlbum(0, 0);
    }
    function delAlbum(id, count) {
        $("input[id$='hfAlbum']").val(id);
        if (count > 0) {
            if (confirm("该相册中有一张或多张图片,你确定要删除吗？")) {
                $("input[id$='btnDelAlbum']").click();
            }
        }
        else {
            $("input[id$='btnDelAlbum']").click();
        }
    }
    function JudgeOpenWin() {
        var btntext = document.getElementById("<%=btn_apply.ClientID%>").innerHTML;
        var flag = btntext == "申请退团" ? "1" : "0";
        openPage(btntext, 'ApplyAssociae.aspx?itemid=<%=Associae_ID %>&flag=' + flag, '650', '460');
    }
</script>
    <div>

<asp:ScriptManager ID="ScriptManager1" runat="server" > 
</asp:ScriptManager>
<div class="tz_sz" id="tz_nav" style='display:<%=Limit %>'>
    Hi,<a href="#"><asp:Literal ID="Lit_User" runat="server"></asp:Literal>社团长</a>,这是属于你们自己的社团主页。您可以
			<a href="javascript:void(0)" onclick="openPage('设置社团首页图片','AssociaeHomePic.aspx?itemid=<%=Associae_ID %>','700','400');return false;">设置社团首页图片</a>、
			<a href="javascript:void(0)" onclick="openPage('修改社团资料','AddAssociae.aspx?itemid=<%=Associae_ID %>','650','460');return false;">修改社团资料</a>、
		<a href="javascript:void(0)" onclick="openPage('团成员管理','AddMember.aspx?itemid=<%=Associae_ID %>','700','600');return false;">添加团成员</a>、		
    <a href="javascript:void(0)" onclick="openPage('发布活动','AddAssociaeActivity.aspx?itemid=<%=Associae_ID %>','600','460');return false;">发布活动</a>和
			<a href="javascript:void(0)" onclick="openPage('发布资讯','AddAssociaeNews.aspx?itemid=<%=Associae_ID %>','600','460');return false;">发布咨询</a>,把它充实起来吧！
			<a href="#" onclick="document.getElementById('tz_nav').style.display= 'none';"><i class="iconfont">&#xe601;</i></a>
</div>
<div class="Term_wrap">
<div class="st_tp">
    <img runat="server" id="headerPic" src="../Stu_images/homepic.jpeg" alt="">
</div>
<div class="st_content">
    <!--content_left-->
      <div class="rflf fl">
        <div class="st_nav">
            <ul class="tab_li">
                <li class="active lia"><a href="#" class="first">首页</a></li>
                <li class="lia"><a href="#" class="second">社团资料</a></li>
                <li class="lia"><a href="#" class="three">社团活动</a></li>
                <li class="lia"><a href="#" class="four">相册</a></li>
            </ul>
        </div>
        <div class="st_dt">
            <div class="td" id="first">
                <div class="st_dt_title">
                    <h2>社团动态</h2>
                    <span><a href="#">全部动态</a></span>
                </div>
                <asp:ListView ID="News_TermList" runat="server">
                    <EmptyDataTemplate>
                        <table class="W_form">
                            <tr>
                                <td>暂无社团动态</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <ul>
                            <li>
                                <img src='<%# Eval("New_Pic") %>'>
                                <h3><%# Eval("Title") %></h3>
                                <div><%# Eval("Content") %></div>
                            </li>
                            <li id='<%# Eval("ID") %>'>
                                <p><i class="iconfont">&#xe604;</i><%# Eval("Date") %></p>
                                <span>
                                    <i class="iconfont">&#xe605;</i><a href="javascript:void(0)">(0)赞</a>
                                    
                                </span>
                            </li>
                        </ul>
                    </ItemTemplate>
                </asp:ListView>
                <asp:ListView ID="Photo_TermList" runat="server">
                    <EmptyDataTemplate>
                        <table class="W_form">
                            <tr>
                                <td>暂无社团照片</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <ol>
                            <li><a href="javascript:void(0)"><%# Eval("Editor") %></a><span>上传<%# Eval("Count") %>张照片到</span><a href="javascript:void(0)"><%# Eval("Title") %></a></li>
                            <li class="albumpic" assoid='<%# Eval("AssoId") %>' albumid='<%# Eval("Album_ID") %>'>
                                <%# Eval("Photo") %>
                            </li>
                            <li id='<%# Eval("Album_ID") %>'>
                                <p><i class="iconfont">&#xe604;</i><%# Eval("Date") %></p>
                                <span>
                                    <i class="iconfont">&#xe605;</i><a href="javascript:void(0)">(0)赞</a>
                                    
                                </span>
                            </li>


                            
                        </ol>
                    </ItemTemplate>
                </asp:ListView>
            </div>
            <div class="td" id="second" style="display: none;">
                <div class="st_zl">
                    <dl>
                        <dt>
                            <p></p>
                            <span>社团口号</span></dt>
                        <dd>
                            <asp:Literal ID="Literal1" runat="server"></asp:Literal></dd>
                    </dl>
                    <dl id="selectContent">
                        <dt>
                            <p></p>
                            <span>社团介绍</span></dt>
                        <dd class="st_zl_js ddHeight">
                            <asp:Literal ID="Literal2" runat="server"></asp:Literal><span class="more" id="more">展开</span></dd>
                    </dl>
                    <dl>
                        <dt>
                            <p></p>
                            <span>社团成员</span>(<asp:Literal ID="Literal3" runat="server"></asp:Literal>)</dt>
                        <dd>
                            <ol>
                                <asp:ListView ID="LV_MemberList" runat="server">
                                    <EmptyDataTemplate>
                                        <table class="W_form">
                                            <tr>
                                                <td>暂无成员,赶紧去招安吧</td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                    <ItemTemplate>
                                        <li id='<%# Eval("ID") %>'>
                                            <img src='<%# Eval("Photo") %>'>
                                            <h3><%# Eval("Name") %></h3>
                                            <div>
                                                <%--<span><a class="iconfont" href="">&#xe601;</a></span>
                                                <p><a href="">任命副团</a></p>--%>
                                            </div>
                                        </li>
                                    </ItemTemplate>
                                </asp:ListView>
                            </ol>
                        </dd>
                    </dl>
                </div>
            </div>
            <div class="td" id="three" style="display: none;">
                <div class="div_activies sthd_list">
                    <div class="activetab">
					<dl>
						<dt>
                            <span class="active"><a href="#">正在进行的</a></span>
                            <span><a href="#">已经结束的</a></span>               
                        <%--<a href="javascript:void(0)" class="btn" onclick="openPage('发布活动','/SitePages/AddAssociaeActivity.aspx?itemid=<%=Associae_ID %>','600','460');return false;">发布活动</a>--%>
						</dt>
                    </dl>
                    </div>
                    <div>
                        <div class="twotd">
                            <dl>
                                <dd>
                                    <asp:ListView ID="lv_Activeing" runat="server">
                                        <EmptyDataTemplate>
                                            <table class="W_form">
                                                <tr>
                                                    <td>暂无正在进行的活动</td>
                                                </tr>
                                            </table>
                                        </EmptyDataTemplate>
                                        <ItemTemplate>
                                            <div>
                                                <ul>
                                                    <li>
                                                        <img src='<%# Eval("Activity_Pic") %>' alt=""></li>
                                                    <li>
                                                        <h2 style="text-indent:1em;"><a href='ActivityShow.aspx?itemid=<%# Eval("ID") %>&fromurl=AssociationShow.aspx?itemid=<%=Associae_ID %>'><%# Eval("Title") %></a></h2>
                                                    </li>
                                                    <li><i class="iconfont">&#xe60c;</i><%# Eval("Associae") %></li>
                                                    <li><i class="iconfont">&#xe604;</i><%# Eval("Date") %></li>
                                                    <li><i class="iconfont">&#xe607;</i><%# Eval("Address") %></li>
                                                    <li><i class="iconfont">&#xe60b;</i><%# Eval("Count") %>人参加</li>
                                                </ul>
                                            </div>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </dd>
                            </dl>
                        </div>
                        <div class="twotd" style="display: none;">
                            <dl>
						<dd>
                                    <asp:ListView ID="lv_ActiveOver" runat="server">
                                <EmptyDataTemplate>
                                    <table class="W_form">
                                        <tr>
                                            <td>暂无已经结束的活动</td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <div>
                                        <ul>
                                            <li>
                                                <img src='<%# Eval("Activity_Pic") %>' alt=""></li>
                                            <li>
                                                <h2><a href='ActivityShow.aspx?itemid=<%# Eval("ID") %>&fromurl=AssociationShow.aspx?itemid=<%=Associae_ID %>'><%# Eval("Title") %></a></h2>
                                            </li>
                                            <li><i class="iconfont">&#xe60c;</i><%# Eval("Associae") %></li>
                                            <li><i class="iconfont">&#xe604;</i><%# Eval("Date") %></li>
                                            <li><i class="iconfont">&#xe607;</i><%# Eval("Address") %></li>
                                            <li><i class="iconfont">&#xe60b;</i><%# Eval("Count") %>人参加</li>
                                        </ul>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>							
						</dd>
					</dl>				
				</div>
            </div>
                </div>                
            </div>
            <div class="td" id="four" style="display: none;">
                <div class="st_xc">
                    <div class="st_xc_sc" style='display:<%=Limit %>'>
                        <a href="javascript:void(0)" onclick="openPage('创建相册','AddAlbum.aspx?itemid=<%=Associae_ID %>','560','350');return false;">创建相册</a>
                        <a href="javascript:void(0)" onclick="openPage('上传照片','UploadPhoto2.aspx?itemid=<%=Associae_ID %>&loginid=<%=Userid %>&flag=1','700','570');return false;"><i class="iconfont">&#xe60a;</i>上传照片</a>
                    </div>
                    <ul id="ablum">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True" RenderMode="Block">
                            <ContentTemplate>
                                <asp:ListView ID="Album_TermList" runat="server">
                                    <EmptyDataTemplate>
                                        <table class="W_form" id="emptyAlbum">
                                            <tr>
                                                <td>暂无社团相册</td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                    <ItemTemplate>
                                        <li>
                                            <img src='<%# Eval("Photo") %>' alt="<%# Eval("Title") %>"onclick="openPage('<%# Eval("Title") %>-相册详情','ShowAssociaePhoto.aspx?itemid=<%=Associae_ID %>&albumid=<%# Eval("Album_ID") %>','620','550');return false;">
                                            <span><%# Eval("Count") %></span>
                                            <h3 style="left: 5px;"><%# Eval("Title") %></h3>
                                            <h3 style="display:<%=Limit %>;text-align: right;cursor:pointer" onclick="delAlbum('<%# Eval("Album_ID") %>',<%# Eval("Count") %>)">删除</h3>
                                        </li>
                                    </ItemTemplate>
                                </asp:ListView>
                                <div style="display:none">
                                    <asp:HiddenField runat="server" ID="hfAlbum" />
                                    <asp:Button runat="server" ID="btnDelAlbum" OnClick="btnDelAlbum_Click" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!--content_right-->
    <div class="rfrf stright_con fr">        
            <div class="st_tit">
                <img id="Associae_Pic" runat="server" src="../Stu_images/nopic.png">
                <span><asp:Literal ID="Lit_Title" runat="server"></asp:Literal></span>
         </div>
        <div class="st_js">
            <div class="st_jj">
                <h2>社团简介</h2>
                <asp:Literal ID="Lit_Slogans" runat="server"></asp:Literal>
                <div>
                    <asp:Literal ID="Lit_Introduce" runat="server"></asp:Literal>
                </div>
                <a href="javascript:void(0)" id="btn_apply" name="btn_apply"  visible="false" runat="server" class="applybtn" style="" onclick="JudgeOpenWin();">申请加入</a>
            </div>
            <ul>
                <li>
                    <i class="iconfont">&#xe603;</i>
                    <span>社团成员</span>
                </li>
                <li><span>社团长</span></li>
                <li>
                    <div>
                        
                        <img src="/images/student.jpg" id="Leader_pic" runat="server" />
                        <h2>
                            <asp:Literal ID="Lit_Leader" runat="server" /></h2>
                    </div>
                </li>
                <li><span>副团长</span></li>
                <li>
                    <asp:ListView ID="LV_TermList" runat="server">
                        <EmptyDataTemplate>
                            <table class="W_form">
                                <tr>
                                    <td>暂无副团长,赶紧申请吧</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <div>
                                <img src='<%# Eval("U_Pic") %>'>
                                <h2><%# Eval("Name") %></h2>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </li>
            </ul>
        </div>
        <div class="st_hd">
            <ol>
                <li>
                    <i class="iconfont">&#xe602;</i>
                    <span>社团活动</span>
                    <h2>更多 +</h2>
                </li>
                <asp:ListView ID="SB_TermList" runat="server">
                    <EmptyDataTemplate>
                        <table class="W_form">
                            <tr>
                                <td>您所在社团暂无活动</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <li id='<%# Eval("ID") %>'>
                            <img src='<%# Eval("Activity_Pic") %>' />
                            <h3><a href='ActivityShow.aspx?itemid=<%# Eval("ID") %> &fromurl=AssociationShow.aspx?itemid=<%=Associae_ID %>'><%# Eval("Title") %></a></h3>
                            <p>
                                <i class="iconfont">&#xe604;</i><%# Eval("Date") %></p>
                        </li>
                    </ItemTemplate>
                </asp:ListView>
            </ol>
        </div>
    </div>  
</div>
</div>
    </div>
</asp:Content>
