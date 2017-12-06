<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SMSWeb.Portal.WebEntered.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>在线报名</title>
    <link href="/PortalCss/layout.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
   <%-- <link rel="stylesheet" type="text/css" href="/css/common.css" />--%>
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    
      <style>
        .width {
            width: 1024px;
            margin: 0 auto;
        }

        #header .top {
            width: 100%;
            height: 34px;
            background: #333333;
        }

            #header .top .top_con {
                height: 34px;
                font-size: 12px;
                line-height: 34px;
                color: #fff;
            }

                #header .top .top_con h1 .tel {
                    width: 22px;
                    height: 22px;
                    display: block;
                    float: left;
                    background: url(/PortalImages/sprite.png) no-repeat 0 0;
                    margin: 6px 5px 6px 0px;
                }

        .weixin span {
            width: 22px;
            height: 22px;
            display: block;
            background: url(/PortalImages/sprite.png) no-repeat 0px -26px;
            margin: 6px 5px 6px 0px;
            float: left;
        }

        .login_resig {
            margin-left: 20px;
        }

            .login_resig a {
                padding: 0px 5px;
                color: #fff;
            }
        /*logo*/
        .logo_search {
            padding: 25px 0px;
        }

        .search {
            height: 32px;
            width: 300px;
            border-radius: 2px;
            border: 2px solid #2562ba;
            margin: 10px 0px;
        }

            .search input[type=text] {
                text-indent: 2em;
                width: 240px;
                height: 30px;
                border: none;
                outline: none;
            }

            .search input[type=submit] {
                width: 57px;
                height: 32px;
                border: none;
                background: #2562ba;
                color: #fff;
                font-size: 12px;
            }
        /*nav*/
        /*nav*/
        .nav {
            width: 100%;
            background: #2562ba;
            height: 40px;
            text-align: center;
            margin: auto;
            position: relative;
        }

        .nav_a ul.nav_b li {
            background: url("/PortalImages/nav_rightbg.png") no-repeat right center;
            float: left;
            font-family: "微软雅黑";
            font-size: 16px;
            line-height: 40px;
            position: relative;
            text-align: center;
            width: 100px;
        }
            /*.nav_a ul.nav_b li:hover { background:#0296f4;}*/
            .nav_a ul.nav_b li .xiala dt.hover {
                background: url(/PortalImages/hover_nav.png) no-repeat;
                background-size: 100%;
            }

            .nav_a ul.nav_b li .xiala dt {
                height: 40px;
            }

            .nav_a ul.nav_b li a {
                color: #fff;
                display: block;
            }

        .lie {
            display: none;
            left: 0;
            position: absolute;
            top: 40px;
            z-index: 200;
        }

            .lie ul.liea li {
                background: #0077DB;
                height: 28px;
                line-height: 28px;
                width: 100px;
            }

                .lie ul.liea li:hover {
                    background: #0296f4;
                }

                .lie ul.liea li a {
                    color: #fff;
                    display: block;
                    font-size: 14px;
                    font-weight: normal;
                }

                    .lie ul.liea li a:hover {
                        text-decoration: underline;
                    }
        /*banner*/
        .banner_bg {
            width: 100%;
            height: 300px;
            box-shadow: 0px 3px 30px 0px rgba(0,0,0,.2);
        }

        .slider {
            width: 100%;
            height: 300px;
            position: relative;
            overflow: hidden;
        }

            .slider ul li a {
                display: block;
                width: 100%;
                height: 300px;
            }
            /*数字按钮样式*/
            .slider .num {
                width: 100%;
                height: 14px;
                bottom: 15px;
                position: absolute;
                text-align: center;
                z-index: 1;
            }

                .slider .num ul {
                    display: inline-block;
                    height: 14px;
                    vertical-align: top;
                }

                .slider .num li {
                    display: inline-block;
                    width: 12px;
                    text-indent: -9999px;
                    height: 12px;
                    border: 1px solid #ef8222;
                    float: left;
                    border-radius: 100%;
                    background: #fff;
                    margin-left: 5px;
                    cursor: pointer;
                }

                    .slider .num li.on {
                        background: #ef8222;
                    }
    </style>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/Validform_v5.3.1.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/PortalJs/syslogin.js"></script>
       <script src="../../PortalJs/header.js"></script>
</head>
<body>
    <form id="registerform" name="registerform" class="registerform" runat="server">
        <asp:HiddenField ID="displayMenu" runat="server" />
         <div class="top">
            <div class="top_con width clearfix">
                <h1 class="fl"><span class="tel"></span>全国咨询热线： 010- 62460887   &nbsp;  62461764    &nbsp; 62463259</h1>
                <div class="top_right fr clearfix">
                    <div class="weixin fl">
                        <span></span>
                        官方微信

                    </div>
                    <a href="/Portal/Certificate/Query.aspx?id=11" class="fl" style="color: #fff; margin-left: 20px;">证书搜索</a>
                    <a href="#" class="fl" style="color: #fff; margin-left: 20px;" id="divSude" target="_blank">进入教育平台</a>
                     <a href="#" target="_blank" id="GoBBS" class="fl" style="color: #fff; margin-left: 20px;">进入论坛</a>
                    <div class="fr login_resig" id="loginItem">
                    </div>
                </div>
            </div>
        </div>
        <%--<iframe name="htmlHeader" src="../headerTop.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="460px"></iframe>--%>
       <%--  <div id="htmlHeader" style="min-height:155px;"></div>--%>
         <div id="header">

            <!--logo-->
            <div class="logo_search width clearfix">
                <div class="logo fl">
                    <a href="/Portal/index.aspx"><img src="/PortalImages/logo.png" /></a>
                </div>
                <!--<div class="search fr">
                <input type="text" placeholder="请输入关键词" />
                <input type="submit" value="搜索" />
            </div>-->
            </div>
            <!--nav-->
            <div class="nav">
                <div class="nav_a width">
                    <ul class="nav_b" id="menuList"></ul>
                </div>
            </div>
        </div>
        <div class="width" style="border: 1px solid #C2C2C2;
    box-shadow: 0px 0px 1px #C2C2C2;
    border-radius: 2px;margin:20px auto;padding-bottom:10px;background:#fff;">
            <div class="content" style="width: auto;">
            <div class="clearfix" style="width: 467px; margin: 0 auto;">
                <div class="course_form_div clearfix">
                    <label for="">姓名：</label>
                    <input type="text" placeholder="姓名" class="text" id="Name" value="" datatype="*" nullmsg="请输入真实姓名！" />
                </div>
                <div class="course_form_div clearfix">
                    <label for="">性别：</label>
                    <input type="radio" id="Sex1" name="Sex" value="1" checked="checked" />男
                                                <input type="radio" id="Sex2" name="Sex" value="0" />女
                </div>
                <div class="course_form_div clearfix">
                    <label for="">年龄：</label>
                    <input type="text" placeholder="年龄" class="text" id="Age" value="" datatype="*|n" nullmsg="请输入年龄！" />
                </div>
                <div class="course_form_div clearfix">
                    <label for="">籍贯：</label>
                    <input type="text" placeholder="籍贯" class="text" id="Roots" value="" datatype="*" nullmsg="请输入籍贯！" />
                </div>

                <div class="course_form_div clearfix">
                    <label for="">身份证号：</label>
                    <input type="text" placeholder="身份证号" class="text" id="IDCard" value="" datatype="*" nullmsg="请输入身份证号！" />
                </div>


                <div class="course_form_div clearfix">
                    <label for="">现住址：</label>
                    <input type="text" placeholder="现住址" class="text" id="Address" value="" />
                </div>
                <div class="course_form_div clearfix">
                    <label for="">联系电话：</label>
                    <input type="text" placeholder="联系电话" class="text" id="Phone" value="" datatype="*|n"/>
                </div>
                  <div class="course_form_div clearfix">
                    <label for="">个人简历：</label>
                    <textarea  placeholder="个人简历" class="text" id="Job" style="height:123px; width:264px;"></textarea>
                </div>
                <div class="course_form_select clearfix">
                    <input type="button" class="course_btn confirm_btn ml10" id="btnCreate" value="申请" />
                    <input type="reset" class="course_btn quxiao_btn ml10" id="btnClear" value="重填" />
                </div>
            </div>
        </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" src="../bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px"  style="margin-top:20px;"></iframe>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#htmlHeader").load("/Portal/headerTop.html");
            if ($("#displayMenu").val()=="none") {
                $("#htmlHeader").css("display","none");
            }
            var valiForm = $(".registerform").Validform({
                btnSubmit: "#btnCreate",
                btnReset: "#btnClear",
                tiptype: 3,
                showAllError: true,
                beforeSubmit: function (curform) {
                    saveData();
                }
            })
        });

        function saveData() {
            var Name = $("#Name").val().trim();
            var Sex = $("input:radio[name='Sex']:checked").val();
            var Age = $("#Age").val().trim();
            var Roots = $("#Roots").val().trim();
            var IDCard = $("#IDCard").val().trim();
            var Address = $("#Address").val().trim();
            var Phone = $("#Phone").val().trim();
            var Job = $("#Job").val().trim();
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdminManager.ashx",
                    func: "AddWebEntered",
                    Name: Name,
                    Sex: Sex,
                    Age: Age,
                    Roots: Roots,
                    IDCard: IDCard,
                    Address: Address,
                    Phone: Phone,
                    Job:Job
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == -1) {
                        layer.msg(result.errMsg);
                    }
                    else if (result.errNum == 0) {
                        layer.msg('操作成功!');
                        $("#reset").trigger("click");
                    } else {
                        layer.msg("操作失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
    </script>

</body>
</html>
