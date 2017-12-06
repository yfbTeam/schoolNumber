


/*
添加到购物车
pid: 产品id   num: 产品数量   isRedirect: 是否直接跳转[true/false]
*/
function AddCart(pid, num, isRedirect, productType, applySchoolNum, element) {

    //弹出对话框的内容
    var popInfo = '<p style="float:left; margin-left:80px;margin-top:10px;margin-bottom:10px;"><img src="http://img.51liucheng.com/u/mall/accept.png" /></p><p class="ft16" style="line-height:42px;padding-left:50px;margin-top:10px;margin-left:80px"><strong>商品已加入购物车。</strong></p>';
    $.jBox.tip("操作中,请稍候...", 'loading')
    jQuery.post(
                    "/Ashx/ShopCart.ashx?ajaxMethod=add",
                    {
                        productType: productType,
                        productId: pid,
                        number: num,
                        applySchoolNum: applySchoolNum,
                        element: element
                    },
                    function (data) {
                        $.jBox.closeTip();
                        if (data.RectCode == 101) {
                            alert("您已经购买过此产品，此产品限一个用户只能购买一个！");
                            return;
                        }
                        else if (data.RectCode == 102) {
                            if (isRedirect) {
                                window.location = "/Mall/Cart.aspx";
                                return;
                            }
                            getCartNum();
                            jBoxConfig.defaults = { showClose: false, buttons: {} };
                            $.jBox.setDefaults(jBoxConfig);
                            $("#ShopCartBox").show();
                        }
                        else if (data.RectCode == 1) {
                            if (isRedirect) {
                                window.location = "/Mall/Cart.aspx";
                                return;
                            }

                            getCartNum();
                            //var content = {
                            //    state1: {
                            //        content: popInfo, buttons: { '继续购物': 1, '去结算': 0 },
                            //        buttonsFocus: 0,
                            //        submit: function (v, h, f) {
                            //            if (v == 0) {
                            //                window.location = "/Mall/Cart.aspx";
                            //            }
                            //            else { 
                            //                return true;
                            //            }
                            //            return false;
                            //        }
                            //    }
                            //};
                            // $.jBox(content);
                            jBoxConfig.defaults = { showClose: false, buttons: {} };
                            $.jBox.setDefaults(jBoxConfig);
                            //  var content = "<table width=\"496\" border=\"0\" cellspacing=\"0\" cellpadding=\"5\">        <tr>          <td height=\"98\" align=\"center\" valign=\"middle\" class=\"line002\"><table width=\"465\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">            <tr>              <td width=\"56\"><img src=\"http://img.51liucheng.com/u/mall/cart/line-04.jpg\" width=\"52\" height=\"51\" /></td>              <td width=\"144\" valign=\"middle\" class=\"font001\">商品已加入购物车</td>              <td width=\"134\" align=\"right\" valign=\"middle\"><a href=\"javascript:$.jBox.close(true)\"><img src=\"http://img.51liucheng.com/u/mall/cart/line-05.jpg\" width=\"121\" height=\"30\" border=\"0\" /></a></td>              <td width=\"131\" align=\"right\" valign=\"middle\"><a href=\"javascript:window.location ='/Mall/Cart.aspx'\"><img src=\"http://img.51liucheng.com/u/mall/cart/line-06.jpg\" width=\"122\" height=\"30\" border=\"0\" /></a></td>            </tr>          </table></td>        </tr>        <tr>          <td><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"5\" style='padding:10px'>            <tr>              <td class=\"font001\">热卖商品</td>            </tr>            <tr>              <td><table width=\"496\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                <tr>                  <td width=\"129\" align=\"left\" valign=\"top\"><table width=\"108\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                    <tr>                      <td align=\"center\" valign=\"top\"><table width=\"85\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"sp_01x\">                        <tr>                          <td><a href=\"/product/product60.html\"><img src=\"http://img.51liucheng.com/u/mall/p60-small.jpg\" width=\"85\" height=\"85\" border=\"0\" /></a></td>                        </tr>                      </table></td>                    </tr>                    <tr>                      <td align=\"left\" valign=\"top\"><a href=\"/product/product60.html\" class=\"fin_link001\">[2015年留学预售]英国TOP30大学留学申请</a></td>                    </tr>                  </table></td>                  <td width=\"129\" align=\"left\" valign=\"top\"><table width=\"108\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                    <tr>                      <td align=\"center\" valign=\"top\"><table width=\"85\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"sp_01x\">                        <tr>                          <td><a href=\"/product/product66.html\"><img src=\"http://img.51liucheng.com/u/mall/p66-small.jpg\" width=\"85\" height=\"85\" border=\"0\" /></a></td>                        </tr>                      </table></td>                    </tr>                    <tr>                      <td align=\"left\" valign=\"top\"><a href=\"/product/product66.html\" class=\"fin_link001\">[2015年留学预售]澳大利亚名校留学申请</a></td>                    </tr>                  </table></td>                  <td width=\"129\" align=\"left\" valign=\"top\"><table width=\"108\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                    <tr>                      <td align=\"center\" valign=\"top\"><table width=\"85\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"sp_01x\">                        <tr>                          <td><a href=\"/product/product61.html\"><img src=\"http://img.51liucheng.com/u/mall/p61-small.jpg\" width=\"85\" height=\"85\" border=\"0\" /></a></td>                        </tr>                      </table></td>                    </tr>                    <tr>                      <td align=\"left\" valign=\"top\"><a href=\"/product/product61.html\" class=\"fin_link001\">[2015年留学预售]美国名牌正规大学留学申请</a></td>                    </tr>                  </table></td>                  <td align=\"right\" valign=\"top\"><table width=\"108\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                    <tr>                      <td align=\"center\" valign=\"top\"><table width=\"85\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"sp_01x\">                        <tr>                          <td><a href=\"/product/product62.html\"><img src=\"http://img.51liucheng.com/u/mall/p62-small.jpg\" width=\"85\" height=\"85\" border=\"0\" /></a></td>                        </tr>                      </table></td>                    </tr>                    <tr>                      <td align=\"left\" valign=\"top\"><a href=\"/product/product62.html\" class=\"fin_link001\">[2015年留学预售]荷兰U类研究型大学全程留学</a></td>                    </tr>                  </table></td>                </tr>              </table></td>            </tr>          </table></td>        </tr>      </table>";
                            // var content = "<div class=\"addcart-box\">	<div class=\"addcart\">    	<div class=\"addsucc\">            	<div class=\"su-ico\"></div>                <div class=\"su-wenz\">添加成功！</div>                 <div class=\"close\" onclick=\"$.jBox.close(true)\"></div>        	    	</div>        <div class=\"set-cart\">        	<a href=\"/Mall/Cart.aspx\"><div class=\"settle\">去购物车结算</div></a>        	<div class=\"gotobuy\"><a href=\"javascript:$.jBox.close(true)\">再逛逛</a></div>        </div>        <div class=\"dotted\"> </div>        <div class=\" addsee\"> 看了此商品的会员通常还看了</div>        <ul>        	<li>            	<div class=\"photo\"><a href=\" \"><img src=\"http://img.51liucheng.com/u/mall/shopinfo/tj1.jpg\"> </a></div>                <div class=\"title\"><a href=\" \"> [英国留学预售]	英国TOP30大学留学申请 </a></div>                <div class=\"price\"> ¥<span>899.00</span> </div>            </li>            <li>            	<div class=\"photo\"><a href=\" \"><img src=\"http://img.51liucheng.com/u/mall/shopinfo/tj2.jpg\"> </a></div>                <div class=\"title\"><a href=\" \"> [英国留学预售]	澳大利亚名校留学申请 </a></div>                <div class=\"price\"> ¥<span>899.00</span> </div>            </li>            <li>            	<div class=\"photo\"><a href=\" \"><img src=\"http://img.51liucheng.com/u/mall/shopinfo/tj3.jpg\"> </a></div>                <div class=\"title\"><a href=\" \"> [英国留学预美国名牌正规大学留学申请</a></div>                <div class=\"price\"> ¥<span>899.00</span> </div>            </li>            <li>            	<div class=\"photo\"><a href=\" \"><img src=\"http://img.51liucheng.com/u/mall/shopinfo/tj4.jpg\"> </a></div>                <div class=\"title\"><a href=\" \"> [英国留学预售]	荷兰U类研究型大学全程留学申请 </a></div>                <div class=\"price\"> ¥<span>899.00</span> </div>            </li>        </ul>    </div></div>";
                            // $.jBox(content, { width: "650px", height: "500px" })
                            $("#ShopCartBox").show();
                        } else {
                            $.jBox.info(data.Msg, '提示信息');
                        }
                    },
                    "json"
                );
}




function deleteProduct(id) {

    var submit = function (v, h, f) {
        if (v == 'ok') {
            $.jBox.tip("操作中,请稍候...", 'loading')
            $.get("/ashx/ShopCart.ashx?ajaxMethod=deleteproduct&id=" + id, function (data) {

                if (data) {
                    $.jBox.closeTip();
                    showCartList();
                }
            });
        }
    };
    $.jBox.confirm("确定要删除该商品吗？", "提示", submit, { top: '15%' });

}

function addCount(type, id, OnlyOne) {

    var input = $("#input_pcount" + id);
    var pcount = input.val();

    if (type == 0) {
        if (pcount > 1) {
            --pcount;
            input.val(pcount);
            $.get("/ashx/ShopCart.ashx?ajaxMethod=edit&id=" + id + "&pcount=" + pcount, function (data) {
                showCartList();
            });
        }
    } else {
        if (OnlyOne) {
            input.parent().parent().find(".xian").fadeOut(200).fadeIn(200).fadeOut(200).fadeIn(200);
        } else {
            ++pcount;
            input.val(pcount);
            $.get("/ashx/ShopCart.ashx?ajaxMethod=edit&id=" + id + "&pcount=" + pcount, function (data) {
                showCartList();
            });
        }
    }

}

function checkInput(a, OnlyOne) {

    if (!isNum(a.value)) {
        a.value = "1";
    }
    if (a.value <= 0) {
        a.value = "1";
    }
    if (OnlyOne) {
        a.value = "1";
    }
    if (!OnlyOne && isNum(a.value) && a.value > 0) {
        var id = a.id.replace("input_pcount", "");
        var pcount = a.value;
        $.get("/ashx/ShopCart.ashx?ajaxMethod=edit&id=" + id + "&pcount=" + pcount, function (data) {
            showCartList();
        });
    }
}

function showCartList() {
    $.ajax({
        url: "/ashx/ShopCart.ashx?ajaxMethod=load",
        dataType: "json",
        beforeSend: function () {
            //$("#cartLoading").show();
            $.jBox.tip("正在加载购物车列表,请稍候...", 'loading')
        },
        success: function (data) {
            $.jBox.closeTip();
            $(".co-plist").empty();
            $(".jies-box").show();
            $("#div_taocan").hide();
            $("#div_productlist").hide();
            var totalprice = 0;
            if (data.length == 0) {  // 空购物车 
                $(".jies-box").hide();
                $("#div_taocan").hide();
                $("#div_productlist").show().html("<div style='min-height:150px;font-size:14px;text-align:center;padding-top:20px;'><a href='/'>您的购物车为空，立即去选购商品。</a><div>");
            }

            for (var i = 0; i < data.length; i++) {
                var html = "";
                var pcount = data[i].ProductCount;
                var id = data[i].Id;
                if (data[i].PackageInfo) {
                    var packageProductsHtml = "<div class=\"yhtc\"><span class=\"yhtctit\">" + data[i].PackageInfo.PackageName + "</span></div>";
                    $("#div_taocan").show();
                    var price = data[i].PackageInfo.PackagePrice;
                    var orprice = data[i].PackageInfo.OriginPrice;
                    // orprice = "";
                    var sumPrice = price * pcount;
                    var onlyone = data[i].PackageInfo.OnlyOne;
                    totalprice += sumPrice;
                    for (var j = 0; j < data[i].PackageInfo.ProductPackageItem.length; j++) {
                        var pid = data[i].PackageInfo.ProductPackageItem[j].ProductId;
                        var purl = "/Product/product" + pid + ".html";
                        var pimg = "http://img.51liucheng.com/u/mall/p" + pid + "-small.jpg";
                        var pname = data[i].PackageInfo.ProductPackageItem[j].ProductName;
                        var num = data[i].PackageInfo.ProductPackageItem[j].ApplySchoolNum;
                        if (num > 0) {
                            pname += "[" + num + "所院校]";
                        }
                        var ProductAgency = data[i].PackageInfo.ProductPackageItem[j].ProductAgency;
                        if (j == 0)
                            packageProductsHtml += "<div class=\"cartpro\">       <div class=\"sel\"></div>                 <div class=\"spinfo\">                	<div class=\"pics\"><a href=\"" + purl + "\" target=\"_blank\"><img src=\"" + pimg + "\"></a></div>                    <div class=\"pisi\">                        <p><a href=\"" + purl + "\" target=\"_blank\">" + pname + "</a></p>                        <p>服务商：" + ProductAgency + "</p>                        <p>                                                  <div class=\"bao\" title=\"消费者保障\"></div>                            <div class=\"yil\" title=\"银联支付\"></div>                            <div class=\"xyk\" title=\"信用卡支付\"></div>                        </p>                    </div>                    </div>                <div class=\"price\">¥" + price.toFixed(2) + "</div>                <div class=\"shul\">                	<span class=\"decrease_num \" onclick=\"addCount(0," + id + "," + onlyone + ")\">-</span>                	<input type=\"text\" id=\"input_pcount" + id + "\" onblur='checkInput(this," + onlyone + ")'   value=\"" + pcount + "\" class=\"quantity-input\" />                	<span class=\"increase_num\" onclick=\"addCount(1," + id + "," + onlyone + ")\">+</span>    <span class=\"xian\" style=\"display:none\">每单限购一件</span>            </div>                <div class=\"count\">¥" + sumPrice.toFixed(2) + "</div>                <div class=\"del\"><a href=\"javascript:deleteProduct(" + id + ")\">删除</a></div>	            </div>";
                        else
                            packageProductsHtml += "<div class=\"cartpro\">       <div class=\"sel\"></div>                 <div class=\"spinfo\">                	<div class=\"pics\"><a href=\"" + purl + "\" target=\"_blank\"><img src=\"" + pimg + "\"></a></div>                    <div class=\"pisi\">                        <p><a href=\"" + purl + "\" target=\"_blank\">" + pname + "</a></p>                        <p>服务商：" + ProductAgency + "</p>                        <p>                                                       <div class=\"bao\" title=\"消费者保障\"></div>                            <div class=\"yil\" title=\"银联支付\"></div>                            <div class=\"xyk\" title=\"信用卡支付\"></div>                        </p>                    </div>                    </div>                        </div>";

                    }
                    $("#div_taocan").append(packageProductsHtml);
                } else {
                    var pid = data[i].ProductInfo.Id;
                    var purl = "/Product/product" + pid + ".html";
                    var pimg = "http://img.51liucheng.com/u/mall/p" + pid + "-small.jpg";
                    var pname = data[i].ProductInfo.ProductName;
                    var price = data[i].ProductInfo.ProductPrice.SalePrice;
                    if (data[i].ApplySchoolNum > 0) {
                        pname = data[i].ProductInfo.ProductName + "[" + data[i].ApplySchoolNum + "所院校]";
                        for (var j = 0; j < data[i].ProductInfo.ProductSubPrice.length; j++) {
                            if (data[i].ProductInfo.ProductSubPrice[j].ApplySchoolNum == data[i].ApplySchoolNum) {
                                price = data[i].ProductInfo.ProductSubPrice[j].ProductPrice;
                                break;
                            }
                        }
                    }
                    var ProductAgency = "";
                    if (data[i].ProductInfo.ProductAgency != null) {

                        ProductAgency = data[i].ProductInfo.ProductAgency.Name;
                    }


                    var orprice = data[i].ProductInfo.ProductPrice.OriginPrice;
                    orprice = "";

                    var sumPrice = price * pcount - data[i].DeductionMoney;
                    var onlyone = false;
                    var IsRefund = false;
                    if (data[i].ProductInfo.ProductIntroduction.IsRefund.length > 0) { IsRefund = true }
                    if (data[i].ProductInfo.ProductIntroduction.IsModifyNum == 0) { onlyone = true }
                    totalprice += sumPrice;
                    // html = "<ul class=\"item-content clearfix\"><li class=\"td td-item\"><div class=\"td-inner\"><div class=\"item-pic\"><a href=\"" + purl + "\" title=\"\" target=\"_blank\"><img src=\"" + pimg + "\" width=\"50\" height=\"50\" /></a></div><div class=\"item-info\"><a href=\"" + purl + "\" title=\"\" target=\"_blank\" class=\"item_title\">" + pname + "</a><div class=\"ser-info\">服 务 商：" + ProductAgency + "</div></div></div></li><li class=\"td td-price\"><div class=\"td-inner\"><div class=\"item-price\"><div class=\"price-line\"><em class=\"price-now\" tabindex=\"0\">" + price + "</em></div><div class=\"price-line\"><em class=\"price-original\">" + orprice + "</em></div></div></div></li><li class=\"td td-amount\"><div class=\"td-inner\"><div class=\"item-amount\"><a href=\"javascript:addCount(0," + id + "," + onlyone + ")\" class=\"minus\">-</a><input type=\"text\" id='input_pcount" + id + "' maxlength=\"2\" value=\"" + pcount + "\" onblur='checkInput(this," + onlyone + ")' class=\"text text-amount\" data-max=\"5\" data-now=\"1\" autocomplete=\"off\"><a href=\"javascript:addCount(1," + id + "," + onlyone + ")\" class=\"plus\">+</a></div><div class=\"xian\" style=\"display:none\">每单限购一件</div></div></li><li class=\"td td-sum\"><div class=\"td-inner\"><em tabindex=\"0\" class=\"number\">" + sumPrice.toFixed(2) + "</em></div></li><li class=\"td td-op\"><div class=\"td-inner\"><a href=\"javascript:void()\" onclick='deleteProduct(" + id + ")' class=\"J_Del J_MakePoint\">删除</a></div></li></ul><div class=\"c_line clearfix\" id=\"div_" + pid + "\"></div>";
                    var str_tui = "";
                    if (IsRefund)
                        str_tui = "<div class=\"tui\" title=\"不成功全额退款\"></div>";
                    html = "<div class=\"cartpro\">       <div class=\"sel\"></div>                 <div class=\"spinfo\">                	<div class=\"pics\"><a href=\"" + purl + "\" target=\"_blank\"><img src=\"" + pimg + "\"></a></div>                    <div class=\"pisi\">                        <p><a href=\"" + purl + "\" target=\"_blank\">" + pname + "</a></p>                        <p>服务商：" + ProductAgency + "</p>                        <p>                            " + str_tui + "                            <div class=\"bao\" title=\"消费者保障\"></div>                            <div class=\"yil\" title=\"银联支付\"></div>                            <div class=\"xyk\" title=\"信用卡支付\"></div>                        </p>                    </div>                    </div>                <div class=\"price\">¥" + price.toFixed(2) + "</div>                <div class=\"shul\">                	<span class=\"decrease_num \" onclick=\"addCount(0," + id + "," + onlyone + ")\">-</span>                	<input type=\"text\" id=\"input_pcount" + id + "\" onblur='checkInput(this," + onlyone + ")'   value=\"" + pcount + "\" class=\"quantity-input\" />                	<span class=\"increase_num\" onclick=\"addCount(1," + id + "," + onlyone + ")\">+</span>  <span class=\"xian\" style=\"display:none\">每单限购一件</span>              </div>                <div class=\"count\" style='position: relative;'>¥" + sumPrice.toFixed(2) + (data[i].DeductionMoney > 0 ? "<br/><span class=\"xian\" style='display:block;text-align: center;width: 120px;left: 0px;padding: 0; font-size:12px; font-style:normal; color:#DD0000;'>折扣" + data[i].DeductionMoney + "元</span>" : "") + "</div>                <div class=\"del\"><a href=\"javascript:deleteProduct(" + id + ")\">删除</a></div>	            </div>";
                    $("#div_productlist").append(html);
                    $("#div_productlist").show();
                }

            }

            $(".jqed").html("￥" + totalprice.toFixed(2));
            //$("#cartLoading").hide();
            //if (data.length == 0) {
            //    $(".pay_bar.clearfix").remove();
            //}
            getCartNum();
        }
    });
}
function goUrl() {
    try {
        if (document.referrer && document.referrer.toLowerCase().indexOf("product") >= 0)
            location.href = document.referrer;
        else
            location.href = "/";
    } catch (err) {
        location.href = "/";
    }
}
function ClearCart() {
    var submit = function (v, h, f) {
        if (v == 'ok') {
            $.jBox.tip("操作中,请稍候...", 'loading')
            $.get("/ashx/ShopCart.ashx?ajaxMethod=clear", function (data) {
                $.jBox.closeTip();
                showCartList();
            });
        }
    };
    $.jBox.confirm("确定要删除所有商品吗？", "提示", submit, { top: '15%' });

}

/* 获取购物车数量 右上角展示 */
function getCartNum() {
    $.get("/ashx/ShopCart.ashx?ajaxMethod=getnum", function (e) {
        var data = eval("(" + e + ")");
        $("#div_cartnum").html(data.TypeNum);  //种类总数
        //$("#div_cartnum").html(data.TotalNum); // 明细总数
    });
}