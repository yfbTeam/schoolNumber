var __domain = window.location.host;
//去掉所有的html标记
function RemoveHtmlTag(str) {
    return str.replace(/<[^>]+>/g, "");
}
function isPhone(str) {
    str = RemoveHtmlTag(str);
    if (str.length != 11) {
        return false;
    }
    var reg = /^1\d{10}$/;
    //var reg = /^(13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9])\d{8}$/;
    return reg.test(str);
}
function isEmail(str) {
    var reg = /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$/;   
    return reg.test(str);
}
function isChinese(str) {
    var reg = /^[0-9a-zA-Z\u4e00-\u9fa5]+$/;
    return reg.test(str);
}

function isChineseAndS(str) {
    var reg = /^[0-9a-zA-Z（）()、，。,.!《》？ 　?\u4e00-\u9fa5]+$/;
    return reg.test(str);
}

function isNum(str) {
    var reg = /^[0-9]*$/;
    return reg.test(str);
}

function isAddress(str) {
    var reg = /^[^\|"'<>]*$/;
    return reg.test(str);
}
function isMoney(str) {
    var reg = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
    return reg.test(str);
}
function isValidate(field) {
    for (p in field) {
        for (var m = 0; m < field[p].length; m++) {
            if (field[p][m].value == null || field[p][m].value == "") {
                return false;
            }
            else {
                return true;
            }
        }
    }
}
var N = [
  "零", "一", "二", "三", "四", "五", "六", "七", "八", "九"
];
function convertToChinese(num) {
    var str = num.toString();
    var len = num.toString().length;
    var C_Num = [];
    for (var i = 0; i < len; i++) {
        C_Num.push(N[str.charAt(i)]);
    }
    return C_Num.join('');
}

var flag = false;
function AXImg(ximg, w, h) {
    var image = new Image();
    var iwidth = w;
    var iheight = h;
    image.src = ximg.src;
    if (image.width > 0 && image.height > 0) {
        flag = true;
        if (image.width / image.height >= iwidth / iheight) {
            if (image.width > iwidth) {
                ximg.width = iwidth;
                ximg.height = (image.height * iwidth) / image.width;
            } else {
                ximg.width = image.width;
                ximg.height = image.height;
            }
            ximg.alt = image.width + "×" + image.height;
        }
        else {
            if (image.height > iheight) {
                ximg.height = iheight;
                ximg.width = (image.width * iheight) / image.height;
            } else {
                ximg.width = image.width;
                ximg.height = image.height;
            }
            ximg.alt = image.width + "×" + image.height;
        }
    }
}

function AXImgs(ximg, w, h) {
    var image = new Image();
    var iwidth = w;
    var iheight = h;
    image.src = ximg.src;
    image.url = ximg.url;

    if (image.width > 0 && image.height > 0) {
        flag = true;
        ximg.height = iheight;
        ximg.width = (iheight * image.width) / image.height;
        ximg.alt = image.width + "×" + image.height;
    }
}

function SaveServiceState(orderid, itemid, serviceName, state, newUrl) {
    $.jBox.tip("保存中,请稍候...", 'loading')
    $.ajax({
        url: '/ashx/ServiceHandler.ashx?AjaxMethod=SaveState',
        type: 'post',
        data: { orderid: orderid, itemid: itemid, serviceName: serviceName, state: state },
        dataType: 'json',
        success: function (data) {
            $.jBox.closeTip();
            if (data.IsSuccess == true) {
                if (state > 1) {
                    location.href = newUrl + "?orderid=" + orderid + "&itemid=" + itemid;
                } else {
                    $.jBox.success("保存成功", "提示", { closed: function () { if (newUrl.length > 0) { location.href = newUrl + "?orderid=" + orderid + "&itemid=" + itemid; } } });

                }
            } else {

            }
        },
        error: function () {
            alert('服务器忙，请稍后再试！');
        }
    });
}
function chooseSchool(inputId, schooltype, idInputId) {
    var pros;
    $.jBox('<div  node-type="layoutContent">  <div class="title" node-type="title" style="cursor: move;"></div>  <a href="javascript:void(0);" class="W_close" title="关闭" node-type="close"></a>  <div node-type="inner" class="layer_search_school clearfix   ">    <div class="filter" node-type="schoolproperty">      <div class="info_list left">        <div class="tit"><i>*</i>学校类型：</div>        <div class="inp">          <select node-type="schooltype" tabindex="100">  <option value="1">大学</option><option value="2">高中</option><option value="3">中专技校</option><option value="4">初中</option>       </select>        </div>      </div>      <div class="info_list left">        <div class="tit">学校所在地：</div>        <div class="inp local" node-type="citySelect">          <select node-type="province" tabindex="101">                      </select>          <select node-type="city" tabindex="102" style="display: none;">                      </select>          <select node-type="area" style="max-width: 150px; display: none;">          </select>        </div>      </div>      <div class="info_list"><div class="tit"><i>*</i>学校名称：</div>        <div class="inp">          <input type="text" tabindex="104" class="W_input" value="" node-type="schoolName">  <input type="hidden" value="" node-type="schoolId"/>      </div>        <div class="tip">                 </div>      </div>      <div class="info_list" style="display:none;" node-type="depart">        <div class="tit"><i></i>院系名称：</div>        <div class="inp"><span style="outline:none;" hidefocus="true" class="dept active" node-type="department" tabindex="106" defaultmsg="请从右侧选择你的院系" nodatamsg="没有该校的院系信息"></span></div>      </div>      <div class="info_list">        <div class="inp"><a href="javascript:void(0);" style="outline:none;" hidefocus="true" node-type="enter" class="W_btn_g" tabindex="107"><span>提交</span></a></div>      </div>    </div>    <div class="school_list"><span class="scl_arrow" node-type="arrow" style="top: 144px;">◆<em>◆</em></span>      <div class="alphabet" node-type="filter"><a title="A" href="javascript:void(0)" action-type="filter" action-data="keyword=A">A</a><a title="B" href="javascript:void(0)" action-type="filter" action-data="keyword=B">B</a><a title="C" href="javascript:void(0)" action-type="filter" action-data="keyword=C">C</a><a title="D" href="javascript:void(0)" action-type="filter" action-data="keyword=D">D</a><a title="E" href="javascript:void(0)" action-type="filter" action-data="keyword=E">E</a><a title="F" href="javascript:void(0)" action-type="filter" action-data="keyword=F">F</a><a title="G" href="javascript:void(0)" action-type="filter" action-data="keyword=G">G</a><a title="H" href="javascript:void(0)" action-type="filter" action-data="keyword=H">H</a><a title="I" href="javascript:void(0)" action-type="filter" action-data="keyword=I">I</a><a title="J" href="javascript:void(0)" action-type="filter" action-data="keyword=J">J</a><a title="K" href="javascript:void(0)" action-type="filter" action-data="keyword=K">K</a><a title="L" href="javascript:void(0)" action-type="filter" action-data="keyword=L">L</a><a title="M" href="javascript:void(0)" action-type="filter" action-data="keyword=M">M</a><a title="N" href="javascript:void(0)" action-type="filter" action-data="keyword=N">N</a><a title="O" href="javascript:void(0)" action-type="filter" action-data="keyword=O">O</a><a title="P" href="javascript:void(0)" action-type="filter" action-data="keyword=P">P</a><a title="Q" href="javascript:void(0)" action-type="filter" action-data="keyword=Q">Q</a><a title="R" href="javascript:void(0)" action-type="filter" action-data="keyword=R">R</a><a title="S" href="javascript:void(0)" action-type="filter" action-data="keyword=S">S</a><a title="T" href="javascript:void(0)" action-type="filter" action-data="keyword=T">T</a><a title="U" href="javascript:void(0)" action-type="filter" action-data="keyword=U">U</a><a title="V" href="javascript:void(0)" action-type="filter" action-data="keyword=V">V</a><a title="W" href="javascript:void(0)" action-type="filter" action-data="keyword=W">W</a><a title="X" href="javascript:void(0)" action-type="filter" action-data="keyword=X">X</a><a title="Y" href="javascript:void(0)" action-type="filter" action-data="keyword=Y">Y</a><a title="Z" href="javascript:void(0)" action-type="filter" action-data="keyword=Z">Z</a></div>      <div node-type="schoolContain">        <ul>        </ul>      </div>    </div>  </div></div>', {
        title: '选择学校',
        width: 900,
        height: 500,
        top: '10%',
        buttons: {}
    });
    $.jBox.tip('数据加载中', 'loading');
    if (schooltype != 'undefind') {
        $('select[node-type="schooltype"]').val(schooltype);
    }
    $.ajax({
        url: '/Ashx/ChooseSchoolHandel.ashx?ajaxMethod=getArea',
        type: 'get',
        data: {},
        dataType: 'json',
        success: function (data) {
            pros = eval(data);
            $('select[node-type="schooltype"]').on('change', function () {
                if ($('select[node-type="schooltype"]').val() == 1) {
                    $('select[node-type="city"]').hide();
                    $.ajax({
                        url: '/Ashx/chooseSchoolHandel.ashx?ajaxMethod=getSchool',
                        type: 'get',
                        dataType: 'json',
                        data: {
                            type: 1,
                            province: $('select[node-type="province"]').val()
                        },
                        success: function (data2) {
                            $('div[node-type="schoolContain"] ul').empty();
                            for (var j = 0; j < data2.length; j++) {
                                var schoolLi = $('<li action-type="select" action-data="school_id=' + data2[j].Id + '&amp;value=' + data2[j].Name + '&amp;department=" school-id=' + data2[j].Id + '><a truevalue="' + data2[j].Id + '" title="' + data2[j].Name + '" href="javascript:void(0);">' + data2[j].Name + '</a>');
                                schoolLi.on('click', function () {
                                    $('input[node-type="schoolName"]').val($(this).text());
                                    $('input[node-type="schoolId"]').val($(this).attr('school-id'));
                                });
                                $('div[node-type="schoolContain"] ul').append(schoolLi);
                            }
                        }
                    });
                } else if ($('select[node-type="schooltype"]').val() == 2 || $('select[node-type="schooltype"]').val() == 3 || $('select[node-type="schooltype"]').val() == 4) {
                    $('select[node-type="city"]').show();
                    $('select[node-type="province"]').trigger('change');
                }
            });
            for (var i = 0; i < pros.length; i++) {
                if (pros[i].code != 400 && pros[i].code != 100)
                    $('select[node-type="province"]').append('<option value="' + pros[i].code + '">' + pros[i].name + '</option>');
            }
            $('select[node-type="province"]').on('change', function () {
                if ($('select[node-type="city"]').css('display') == 'none') {
                    $.ajax({
                        url: '/Ashx/chooseSchoolHandel.ashx?ajaxMethod=getSchool',
                        type: 'get',
                        dataType: 'json',
                        data: {
                            type: $('select[node-type="schooltype"]').val(),
                            province: $('select[node-type="province"]').val()
                        },
                        success: function (data2) {
                            $('div[node-type="schoolContain"] ul').empty();
                            for (var j = 0; j < data2.length; j++) {
                                var schoolLi = $('<li action-type="select" action-data="school_id=' + data2[j].Id + '&amp;value=' + data2[j].Name + '&amp;department=" school-id=' + data2[j].Id + '><a truevalue="' + data2[j].Id + '" title="' + data2[j].Name + '" href="javascript:void(0);">' + data2[j].Name + '</a>');
                                schoolLi.on('click', function () {
                                    $('input[node-type="schoolName"]').val($(this).text());
                                    $('input[node-type="schoolId"]').val($(this).attr('school-id'));
                                });
                                $('div[node-type="schoolContain"] ul').append(schoolLi);
                            }
                        }
                    });
                } else {
                    $('select[node-type="city"]').empty();
                    for (var i = 0; i < pros.length; i++) {
                        if (pros[i].code == $('select[node-type="province"]').val()) {
                            for (var j = 0; j < pros[i].cities.length; j++) {
                                $('select[node-type="city"]').append('<option value="' + pros[i].cities[j].code + '">' + pros[i].cities[j].name + '</option>');
                            }
                            $('select[node-type="city"]').trigger('change');
                        }
                    }
                }
            });
            $('select[node-type="city"]').on('change', function () {
                $.ajax({
                    url: '/Ashx/chooseSchoolHandel.ashx?ajaxMethod=getSchool',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        type: $('select[node-type="schooltype"]').val(),
                        province: $('select[node-type="province"]').val(),
                        city: $('select[node-type="city"]').val()
                    },
                    success: function (data2) {
                        $('div[node-type="schoolContain"] ul').empty();
                        for (var j = 0; j < data2.length; j++) {
                            var schoolLi = $('<li action-type="select" action-data="school_id=' + data2[j].Id + '&amp;value=' + data2[j].Name + '&amp;department=" school-id=' + data2[j].Id + '><a truevalue="' + data2[j].Id + '" title="' + data2[j].Name + '" href="javascript:void(0);">' + data2[j].Name + '</a>');
                            schoolLi.on('click', function () {

                                $('input[node-type="schoolName"]').val($(this).text());
                                $('input[node-type="schoolId"]').val($(this).attr('school-id'));


                            });
                            $('div[node-type="schoolContain"] ul').append(schoolLi);
                        }
                    }
                });
            });
            $('a[action-type="filter"]').on('click', function () {
                var ajaxData = {};
                ajaxData.type = $('select[node-type="schooltype"]').val();
                ajaxData.province = $('select[node-type="province"]').val();
                ajaxData.keywords = $(this).attr('title').toLowerCase();
                if ($('select[node-type="city"]').css('display') != 'none') {
                    ajaxData.city = $('select[node-type="city"]').val();
                }
                $.ajax({
                    url: '/Ashx/chooseSchoolHandel.ashx?ajaxMethod=getSchool',
                    type: 'get',
                    dataType: 'json',
                    data: ajaxData,
                    success: function (data2) {
                        $('div[node-type="schoolContain"] ul').empty();
                        for (var j = 0; j < data2.length; j++) {
                            var schoolLi = $('<li action-type="select" action-data="school_id=' + data2[j].Id + '&amp;value=' + data2[j].Name + '&amp;department=" school-id=' + data2[j].Id + '><a truevalue="' + data2[j].Id + '" title="' + data2[j].Name + '" href="javascript:void(0);">' + data2[j].Name + '</a>');
                            schoolLi.on('click', function () {
                                $('input[node-type="schoolName"]').val($(this).text());
                                $('input[node-type="schoolId"]').val($(this).attr('school-id'));
                            });
                            $('div[node-type="schoolContain"] ul').append(schoolLi);
                        }
                    }
                });
            });
            $('a[node-type="enter"]').on('click', function () {
                $('#' + inputId).val($('input[node-type="schoolName"]').val());
                //当id隐藏域存在时，给隐藏域赋值
                if (idInputId) {
                    $('#' + idInputId).val($('input[node-type="schoolId"]').val());
                }
                $('#' + inputId).focus();
                $('a.jbox-close').trigger('click');
            });
            $('select[node-type="province"]').trigger('change');
            $.jBox.closeTip();
        },
        error: function () {
            $.jBox.closeTip();
        }
    });
}
function parseISO8601(dateStringInRange) {
    var isoExp = /^\s*(\d{4})-(\d?\d)-(\d?\d).*$/,
        date = new Date(NaN), month,
        parts = isoExp.exec(dateStringInRange);

    if (parts) {
        month = +parts[2];
        date.setFullYear(parts[1], month - 1, parts[3]);
        if (month != date.getMonth() + 1) {
            date.setTime(NaN);
        }
    }
    return date;
}
var ProductKeyWords = null;
$(function () {
    $.get("/ashx/productHandle.ashx?ajaxMethod=productSearch&k=" + escape("所有"), function (data) {
        ProductKeyWords = data;
    }, "json");
});


function Progress(MaxPercent, divid, Percent) {
    this.curwidth = 0;
    this.divid = divid;
    this.Percent = Percent;
    var self = this;
    var divob = $("#" + divid);
    var Schollwidth = Math.floor(this.Percent / MaxPercent * 125);

    this.run = function () {

        setTimeout(function () { self.start(); }, 50)
    };
    this.start = function () {
        var s = Math.floor((Schollwidth - this.curwidth) / 10)
        if (s < 1)
            s = 1;
        this.curwidth = this.curwidth + s;
        divob.attr("style", "width:" + this.curwidth + "px");
        divob.html(Math.round((this.curwidth / 125) * (MaxPercent / 100) * 100) + '%');
        if (this.curwidth < Schollwidth) {
            this.run();
        } else {
            divob.html(this.Percent + '%');
        }
    }
}

function flashChecker() {

    var hasFlash = 0; //是否安装了flash
    if (navigator.plugins && navigator.plugins.length > 0) {
        var swf = navigator.plugins["Shockwave Flash"];
        if (swf) {
            hasFlash = 1;
        }
    }

    var TipsMsg = "";
    if (hasFlash) {
        TipsMsg = "（您已经安装Flash Player）";
    }
    else {
        TipsMsg = "（<font color='red'>*</font>您没有安装Flash Player，会导致文件无法上传，请到官网<a style='margin-left:0px;color: blue;text-decoration: underline;' href='https://get.adobe.com/cn/flashplayer/' target='_blank'>下载</a>安装）";
    }

    //客户环境未知 不一定兼容新版Flash Player
    //下载连接中有A、SPAN标签 使用页面会有样式问题 综上不提供下载链接

    // 判断ie 与 ie11
    //if (navigator.userAgent.indexOf("MSIE") > 0 ||
    //    (Object.hasOwnProperty.call(window, "ActiveXObject") && !window.ActiveXObject)) {
    //    TipsMsg = "（您没有安装Flash Player，请<a href=\"http://dlsw.baidu.com/sw-search-sp/soft/34/17153/flashplayer_21_ax_debug_21.0.0.213.1460355126.exe\"><span style=\"color: red\">下载</span></a>安装）";
    //}
    //else {
    //    TipsMsg = "（您没有安装Flash Player，请<a href=\"http://dlsw.baidu.com/sw-search-sp/soft/f4/15432/flashplayer_21_plugin_debug_21.0.0.213.1460355213.exe\"><span style=\"color: red\">下载</span></a>安装）";
    //}

    return { f: hasFlash, t: TipsMsg };
}

