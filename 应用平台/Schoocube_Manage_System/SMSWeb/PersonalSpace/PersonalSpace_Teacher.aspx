<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonalSpace_Teacher.aspx.cs" Inherits="SMSWeb.PersonalSpace.PersonalSpace_Teacher" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>教师个人空间</title>
		<!--图标样式-->
		<link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css"/>
		<link rel="stylesheet" type="text/css" href="/css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="/css/common.css"/>
		<link rel="stylesheet" type="text/css" href="/css/repository.css"/>
		<link rel="stylesheet" type="text/css" href="/css/onlinetest.css"/>
		<!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
        <script src="/Scripts/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src="js/menu_top.js"></script>
        <script src="/Scripts/layer/layer.js"></script>
        <script src="/Scripts/Common.js"></script>
        <script src="/Scripts/jquery.tmpl.js"></script>
        <script src="/Scripts/PageBar.js"></script>
         <script id="tr_Favorite" type="text/x-jquery-tmpl">
             <tr>
                 <td>${pageIndex()}</td>
                 <td>${Name}</td>
                 <td>{{if Type==0}}课程展示
                     {{else Type==1}}课程详细
                     {{else}}暂无
                     {{/if}}
                 </td>
                 <td>${CreateTime}</td>
                 <td><a href="javascript:;" onclick="javascript:delFavorites('${ID}')"><i class="icon icon-edit"></i>删除</a>
                     <a href="javascript:;" onclick="javascript:window.location='${Href}'" target="_blank"><i class="icon icon-edit"></i>查看</a>
                 </td>

             </tr>
          </script>
	</head>
	<body>
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

		<!--header-->
		<header class="repository_header_wrap">
			<div class="width repository_header clearfix">
				<a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" /></a>
				 <div class="wenzi_tips fl">
                    <img src="/images/gerenzhongxin.png" />
                </div>
				<div class="search_account fr clearfix">
					<ul class="account_area fl">
                        <li>
                            <a href="javascript:;" class="dropdown-toggle">
                                <i class="icon icon-envelope"></i>
                                <span class="badge">3</span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=PhotoURL %>" />
                                </div>
                                <h2><%=Name %></h2>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr ">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            
                             <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
				</div>
			</div>
		</header>
		<!--个人空间-->
		<div class="personal_spacewrap" >
			<div class="personal_spacea width pt20 clearfix" style="min-height:790px;">
				<div class="space_left fl">
					<div class="personal_img">
						<img src="<%=PhotoURL %>"/>
					</div>
					<div class="personal_a"></div>
					<div class="personal_btn clearfix">
						<a href="javascript:;" class="fl">更换头像</a>
						<a href="javascript:;" class="fr edit_mes">编辑资料</a>
					</div>
					<div class="personal_detail">
						<p class="people"><i class="icon icon-user"></i><%=Name%></p>
						<p class="school">所在学校：<span>北京一期一起仪表高级技工学校</span></p>
						<p class="subject">任教科目：<span>语文</span></p>
					</div>
					<ul class="personal_link">
						<li class="active">
							<a href="javascript:;">
								<i class="icon icon_home"></i>
								近况
							</a>
						</li>
						<li>
							<a href="javascript:;">
								<i class="icon icon_mess"></i>
								个人资料
							</a>
						</li>
						<li>
							<a href="javascript:;">
								<i class="icon icon_board"></i>
								留言板
							</a>
						</li>
                        <li>
							<a href="javascript:;">
								<i class="icon icon_board"></i>
								收藏夹
							</a>
						</li>
					</ul>
				</div>
				<div class="space_center fl">
					<div class="space_centerwrap">
						<div class="yy-poster">
							<textarea name="" rows="" cols="">即时分享，聊一聊现在的心情吧！
							</textarea>
							<h1 class="clearfix">
								<div class="fl expressionpicture">
									<span class="expression pr">
										<i class="icon icon_expression"></i>
										表情
									</span>
									<span class="picture pr">
										<i class="icon icon_picture"></i>
										<input type="file" name="" id="" value="" class=""/>
										图片
									</span>
								</div>
								<a href="javascript:;" class="release fr">
									发布
								</a>
							</h1>
						</div>
						<div class="stytem_select clearfix">
							<div class="stytem_select_left fl">
								<a href="javascript:;" class="on">我的动态</a>
							</div>
						</div>
						<ul class="comments_list">
							<li class="clearfix">
								<div class="comments_img fl">
									<img src="<%=PhotoURL %>"/>
								</div>
								<div class="comment_mes">
									<p class="comment_people">林敏：<span>afafgsf</span></p>
									<div class="comment_mesa">
										<span class="comment_time">今天11:36:11</span>
										<span class="comment">评论（0）</span>
										<span class="delete">删除</span>
									</div>
									<div class="comment_wrap">
										<textarea name="" rows="" cols="">我也来说一句</textarea>
									</div>
								</div>
							</li>
							<li class="clearfix">
								<div class="comments_img fl">
									<img src="<%=PhotoURL %>"/>
								</div>
								<div class="comment_mes">
									<p class="comment_people">林敏：<span>afafgsf</span></p>
									<div class="comment_mesa">
										<span class="comment_time">今天11:36:11</span>
										<span class="comment">评论（0）</span>
										<span class="delete">删除</span>
									</div>
									<div class="comment_wrap">
										<textarea name="" rows="" cols="">我也来说一句</textarea>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="space_centerwrap none">
						<div class="mess_succprecess">
							<span class="left fl">信息完整度： </span>
							<div class="progressbar fl">
                            	<span style="width:20%"></span>
                            </div>
                            <span class="left mr15 ml5 fr" id="progressNum">20%</span>
						</div>
						<h4 class="set-mold">学校信息<em>(不可修改)</em></h4>
						<table class="set-mold-table">
                            <tbody>
                            	<tr>
                                	<td class="w85">学校：</td>
                                    <td>复兴第一小学</td>
                                </tr>
                                <tr>
                                	<td class="w85">任课信息：</td>
                                    <td>
                                    	<div class="class-list">
                                    	
                                    	
                                    		<p>无任课信息</p>
                                    	
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                	<td class="w85">职位：</td>
                                    <td>其他</td>
                                </tr>
                            </tbody>
						</table>
						<h4 class="set-mold">基本信息</h4>
						<form id="myform">
	                        <table class="set-mold-table">
	                            <tbody>
	                                <tr>
                                    	<td class="w85">教学通账号：</td>
                                        <td id="accounts_txt">t39417</td>
                                    </tr>	 
									<tr>
										<td class="w85 fl">性别：</td>
										<td><select name="sex" class="select">
												<option value="1">男</option>
												<option value="2" selected="selected">女 </option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="w85">生日：</td>
										<td>
											<input type="text" name="birthday" value="" title="生日" class="input">
										</td>
									</tr>
									<tr>
										<td class="w85 fl">固话：</td>
										<td>
											<input type="text" class="input fl w40" value="" >
											<span class="ml5 mr5 fl">-</span>
											<input value="" id="phone" type="text" class="input fl w130">
										</td>
									</tr>
									<tr>
										<td class="w85 fl">手机号：</td>
										<td>
											<input type="text" class="input fl " value="" >
										</td>
									</tr>
									<tr>
										<td class="w85 fl">QQ：</td>
										<td>
											<input type="text" class="input fl " value="" >
										</td>
									</tr>
									<tr>
										<td class="w85 fl">Email：</td>
										<td>
											<input type="text" class="input fl " value="" >
										</td>
									</tr>
									<tr>
										<td class="w85 fl">居住地址：</td>
										<td>
											<select name="" class="select">
												<option value=""></option>
											</select>
											<select name="" class="select">
												<option value=""></option>
											</select>
											<select name="" class="select">
												<option value=""></option>
											</select>
										</td>
									</tr>
									<tr>
	                                    <td></td>
	                                    <td>
	                                        <textarea name="contact.address" class="w285" id="address"></textarea>
	                                        <span class="ml5" id="nb60">(<span class="counter">0</span>/<span class="counter">60</span>)</span>
	                                        <span class="addressname ml5">街道地址对其他人是保密的</span></td>
	                                </tr>
	                                <tr>
	                                	<td></td>
	                                    <td><a href="javascript:void(0)" class="xiugai">确认修改</a></td>
	                                </tr>
	                            </tbody>
							</table>
						</form>
					</div>
					<div class="space_centerwrap none">
						<div class="yy-poster">
							<textarea name="" rows="" cols="">即时分享，聊一聊现在的心情吧！
							</textarea>
							<h1 class="clearfix">
								<div class="fl expressionpicture">
									<span class="expression pr">
										<i class="icon icon_expression"></i>
										表情
									</span>
									<span class="picture pr">
										<i class="icon icon_picture"></i>
										<input type="file" name="" id="" value="" class=""/>
										图片
									</span>
								</div>
								<a href="javascript:;" class="release fr">
									留言
								</a>
							</h1>
						</div>
					</div>
                    <div class="space_centerwrap none">
                        <div class="wrap">
                            <table>
                                <thead>
                                    <th>序号</th>
                                    <th>收藏名称</th>
                                    <th>收藏类型</th>
                                    <th>收藏时间</th>
                                    <th>操作</th>
                                </thead>
                                <tbody id="tbFavorite">
                                </tbody>
                            </table>
                        </div>
                        <!--分页-->
                    <div class="page">
                        <span id="pageBar5"></span>
                    </div>
                    </div>
				</div>
				<div class="space_right fr">
				
				</div>
			</div>
		</div>
		<footer>
			<div class="footer width clearfix">
				<div class="logo fl">
					 <img src="/PortalImages/logoBefore.png" style="margin-top:10px;">
				</div>
				<div class="footer_right fr">
					<p>北京市黄庄职业高中信息中心 制作维护</p>
					<p>地址：北京市石景山区鲁谷东街29号 邮编：100040   电话：010-68638293   传真：010-68638293</p>
					<p>icp 京ICP备07012769号 | 京公网安备11010702001098号</p>
				</div>
			</div>
		</footer>
<script src="/js/common.js"></script>
		<script>
		    $(function () {
		        $('.personal_link>li').click(function () {
		            $(this).addClass('active').siblings().removeClass('active');
		            var n = $(this).index();
		            $('.space_center .space_centerwrap').eq(n).show().siblings().hide();
		        })
		        $('.edit_mes').click(function () {
		            $('.personal_link>li').removeClass('active');
		            $('.personal_link>li').eq(1).addClass('active');
		            $('.space_center .space_centerwrap').hide();
		            $('.space_center .space_centerwrap').eq(1).show();
		        })

		        getDataF(1, 10);
		    })

		    function getDataF(startIndex, pageSize)
		    {
		        pageNum = (startIndex - 1) * pageSize + 1;
		        $.ajax({
		            url: "/Common.ashx",
		            type: "post",
		            async: false,
		            dataType: "json",
		            data: {
		                PageName: "PortalManage/AdminManager.ashx",
		                Func: "GetPageFavoritesList",
		                PageIndex: startIndex,
		                PageSize: pageSize,
		                isPage:true,
		                IDCard: $("#HUserIdCard").val()
		            },
		            success: function (json) {
		                if (json.result.errMsg == "success") {
		                    $("#tbFavorite").html('');
		                    $("#tr_Favorite").tmpl(json.result.retData.PagedData).appendTo("#tbFavorite");
		                    makePageBar(getDataF, document.getElementById("pageBar5"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
		                }
		                else {
		                    $("#tbFavorite").html("<tr><td colspan=5>暂无收藏！</td></tr>");
		                }
		            },
		            error: function (XMLHttpRequest, textStatus, errorThrown) {

		            }
		        });
		    }

		    function delFavorites(id)
		    {
		        $.ajax({
		            url: "/Common.ashx",
		            type: "post",
		            async: false,
		            dataType: "json",
		            data: {
		                PageName: "PortalManage/AdminManager.ashx",
		                Func: "DelFavorites",
		                ID: id
		            },
		            success: function (json) {
		                if (json.result.errNum == 0) {
		                    layer.msg("删除成功！")
		                } else {
		                    layer.msg(json.result.errMsg);
		                }
		                getDataF(1,10)
		            }
		        })
		    }
		</script>
	</body>
</html>