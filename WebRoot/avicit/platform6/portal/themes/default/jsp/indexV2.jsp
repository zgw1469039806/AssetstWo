<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.core.properties.PlatformConstant"%>
<%@ page import="avicit.platform6.core.properties.PlatformProperties"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.api.sysuser.dto.SysUser"%>
<%@page import="avicit.platform6.api.sysuser.SysOrgAPI"%>
<%@page import="avicit.platform6.core.spring.CacheSpringFactory"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="avicit.platform6.api.sysprofile.SysProfileAPI"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
//控制全文检索是否显示
String isOpenSearch = PlatformProperties.getProperty("platform.protal.isOpenSearch");
if(StringUtils.isNotEmpty(isOpenSearch) && isOpenSearch.equals("false")){
	isOpenSearch = "none";
}else{
	isOpenSearch = "";
}
String deptName = SessionHelper.getCurrentDeptName(request);

SysUser user = (SysUser)SessionHelper.getLoginSysUser(request);

String loginName = user.getName();

String userId = user.getId();

String orgName =CacheSpringFactory.getInstance().getBean(SysOrgAPI.class).getSysOrgNameBySysOrgId(session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_ORG).toString(), SessionHelper.getSystemDefaultLanguageCode());
SysProfileAPI sysProfileAPI = CacheSpringFactory.getInstance().getBean(SysProfileAPI.class);
%>
<!DOCTYPE html>
<html id="content" style="min-width: 1080px;">
<head>
<meta charset="UTF-8">
<title>欢迎使用-${logoConfigDTO.oneTitle}</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta name="renderer" content="webkit|ie-stand">
<!--[if gt IE 9]>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" >   
	<![endif]-->
<!--[if lte IE 9]> 
     <meta http-equiv="X-UA-Compatible" content="IE=8,chrome=1" > 
     <![endif]-->
<link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico" type="image/x-icon">
<!-- 样式标准化 boostrap.css -->
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap.css">

<!-- jquery-tabs样式依赖 -->
<link rel="stylesheet" type="text/css" href="static/h5/jquery-tabs/themes/default/linkbutton.css">
<link rel="stylesheet" type="text/css" href="static/h5/jquery-tabs/themes/default/panel.css">
<link rel="stylesheet" type="text/css" href="static/h5/jquery-tabs/themes/default/tabs.css">
<link rel="stylesheet" type="text/css" href="static/h5/jquery-tabs/themes/default/menu.css">
<link rel="stylesheet" type="text/css" href="static/h5/jquery-tabs/themes/default/menubutton.css">
<link rel="stylesheet" type="text/css" href="static/h5/skin/topFixed.css">
<!--平台公共图标库文件  -->
<link rel="stylesheet" type="text/css" href="static/h5/skin/iconfont/iconfont.css" />
<!-- 页面样式 index.css -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/portal/css/loadding.css">
<link rel="stylesheet" type="text/css" href="avicit/platform6/portal/css/index.css">
<link rel="stylesheet" type="text/css" href="static/h5/perfect-scrollbar/css/perfect-scrollbar.css">
<link rel="stylesheet" type="text/css" href="avicit/platform6/portal/themes/${_theme}/css/indexV2.css">
<link id="color_link" rel="stylesheet" type="text/css" href="avicit/platform6/portal/skin/${_skins}.css">
<!-- 换肤预留 -->
<link id="theme" rel="stylesheet" href="avicit/platform6/portal/themes/${_theme}/skins/${_skins}/index/style.css">
<!-- ie8下boostrap样式修复 -->
<!--[if lt IE 9]>
	<script type="text/javascript" src="static/h5/bootstrap/html5shiv.js"></script>
	<script type="text/javascript" src="static/h5/bootstrap/respond.min.js"></script>
    <style>
        .user-card .userhead {
            behavior: url(static/h5/bootstrap-treeview/css/PIE.htc);
        }
    </style>
	<![endif]-->

<!-- IM -->
<%if("true".equals(PlatformProperties.getProperty(PlatformConstant.IM_START))){ %>
<link rel="stylesheet" href="avicit/platform6/im/layim/css/layui.css">
<%} %>
<style>
.userinfo:hover .dropdown-menu{
	display: block;
}

.ui-ext{
			width: 200px;height: auto;/*高度自动*/
			position: absolute;z-index: 9000;
			top: 100px;left: 100px;
			border: 1px solid #d5d5d5;background: #fff;
			display: none;/*none隐藏 block显示*/
		}
.ui-ext-title{
			height: 48px;line-height: 48px;padding-left: 20px;color: #535353;font-size: 16px;
			background: #f5f5f5;
			border-bottom: 1px solid #efefef;
			cursor: move;/*鼠标样式*/
		}
</style>
</head>
<body>
	<div class="ui-ext" id="dialog">
		<div class="ui-ext-title" id="dialogTitle">
			<span style="color: ${logoConfigDTO.extFontColor};
									font-family: ${logoConfigDTO.extFont}; 
									font-size: ${logoConfigDTO.extFontSize}px!important;
									<c:if test="${logoConfigDTO.extFontBold == 'Y'}">
									font-weight:600;
									</c:if>
									<c:if test="${logoConfigDTO.extFontItalic == 'Y'}">
									font-style:italic;
									</c:if>
									">
							${logoConfigDTO.extTitle}
						</span>
		</div>
	</div>
	<div class="mainBody">
		<!-- 头部工具栏Start -->
		<div class="header">
			<div class="logoDom">
					<div class="logo">
						<img src="${logoConfigDTO.logoPath}" />
					</div>
					<div class="title">
						<span style="color: ${logoConfigDTO.oneFontColor};
									font-family: ${logoConfigDTO.oneFont}; 
									font-size: ${logoConfigDTO.oneFontSize}px!important;
									<c:if test="${logoConfigDTO.oneFontBold == 'Y'}">
									font-weight:600;
									</c:if>
									<c:if test="${logoConfigDTO.oneFontItalic == 'Y'}">
									font-style:italic;
									</c:if>
									">
							${logoConfigDTO.oneTitle}
						</span>
						<c:if test="${not empty logoConfigDTO.secondTitle}">
								<i style="color: ${logoConfigDTO.secondFontColor};
										font-family: ${logoConfigDTO.secondFont};
										font-size: ${logoConfigDTO.secondFontSize}px!important;
										<c:if test="${logoConfigDTO.secondFontBold == 'Y'}">
										font-weight:600;
										</c:if>
										<c:if test="${logoConfigDTO.secondFontItalic == 'Y'}">
										font-style:italic;
										</c:if>
									">
									${logoConfigDTO.secondTitle}
								</i>
						</c:if>
					</div>
				</div>
			<div class="navbar">${menus}</div>
			<div class="toolbar">
				<div class="top_search" >
					<div class=" d6">
						<div class="top_search_box" >
							<i id="headSubmit" class="icon iconfont icon-search"  style="display:<%=isOpenSearch%>;"></i> <input style="width: 0px; right: 20px;" id="keywords" type="text" name="keywords" placeholder="搜索从这里开始..." autocomplete="off">
						</div>
					</div>
				</div>
				<div class="iconbtn">
					<ul>
						<li><i id="fullWindowBtn" onclick="fullWindow()" style="display: ;" title="全屏" class="icon icon-fullscreen"></i> <i title="退出全屏" id="quiteFullWindowBtn" style="display: none;"
							onclick="quiteFullWindowBtnFullWindow()" class="icon icon-quitfullscreen"></i></li>
						<li class="dropdown" id="personalMenu"><i title="常用" class="icon icon-tags-fill" style="color: #d8d8d8" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"></i>
							<div class="dropdown-menu dropdown-menu-right avic-dropmenu">
								<ul class="avic-smenu xl" id="personalMenuUl">
								</ul>
								<div class="btns">
									<div class="a-btn addFrequently" id="personalMenuAdd" onclick="loadMenuNotAdded();">
										<i class="icon icon-add"></i>添加
									</div>
									<div class="a-btn" id="personalMenuTrunk" onclick="trunkPersonalMenu();">
										<i class="icon icon-close"></i>清空
									</div>
								</div>
								<!--增加打开遮罩，用于点击屏幕其他区域时关闭该页面  -->
								<div class="window-mask"></div>
							</div></li>
						<%--<li class="dropdown" id="personalCollect">
                                    <i title="收藏" class="icon icon-shoucang" style="color:#d8d8d8" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"></i>
                                    <div class="dropdown-menu dropdown-menu-right avic-dropmenu">
                                        <ul class="avic-smenu xl">
                                            
                                        </ul>
                                        <div class="btns">
                                            <div class="a-btn noborder"><i class="icon icon-icon"></i>更多</div>
                                        </div>
                                    </div>
                                </li>--%>
						<li class="dropdown" id="personalMessage"><i title="通知" class="icon icon-bell-fill" style="color: #d8d8d8" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" id="unreadMessage">
								<div class="msg-tip">
									<span class="text">0</span>
								</div>
						</i>
							<div class="dropdown-menu dropdown-menu-right avic-dropmenu">
								<ul class="avic-smenu" id="personalMessageUl" style="overflow-y: auto; height: 200px;">
								</ul>
								<div class="btns">
									<div class="a-btn" id="addMessageDialog">
										<i class="icon icon-add"></i>添加
									</div>
									<div class="a-btn" onclick="moreMessage();">
										<i class="icon icon-icon"></i>更多
									</div>
								</div>
								<!--增加打开遮罩，用于点击屏幕其他区域时关闭该页面  -->
								<div class="window-mask"></div>
							</div></li>
						<li><i title="皮肤" class="icon icon-pifu changui" style="color: #d8d8d8" onclick="changeThemesSkinsEvent();return false;"></i></li>
						<li class="dropdown"><i title="更多" class="icon icon-gengduo" data-toggle="dropdown" style="color: #d8d8d8" aria-haspopup="true" aria-expanded="true"></i>
							<div class="dropdown-menuMore dropdown-menu dropdown-menu-right">
								<ul class="	avic-dropmenu avic-smenu auto">
									<%if("0".equals(user.getConsoleType())){ %>
									<li onclick="backConsole();"><i class="icon icon-backconsole"></i>返回控制台</li>
									<% } %>
									<li onclick="showLicenseInfo();return false;"><i class="icon icon-shouquan1"></i>授权信息</li>
									<li onclick="showVersionInfo();return false;"><i class="icon icon-banben1"></i>版本信息</li>
								</ul>
								 <!--增加打开遮罩，用于点击屏幕其他区域时关闭该页面  -->
							    <div class="window-mask"></div>
							</div>
							</li>
					</ul>
				</div>
				<div class="userinfo dropdown">
					<div class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						<span class="username"><c:out value="${userName}" /></span><i class="icon iconfont icon-xiangxiajiantou-mianxing"></i>
					</div>
					<div class="dropdown-menu dropdown-menu-right avic-dropmenu">
								<div class="dropdown-name dropdown-name-border-line clearfix">
									<div class="dropdown-head"><img src="${userHeadURI}" class="userhead haedimg" style="margin-left: 0px;"></div>
									<h2 class="dropdown-name-text">
										<%--<span class="dropdown-user-name"><c:out value="${userName}" /></span>
										<span class="dropdown-department-text">部门：${currentDeptName}</span>
										<span class="dropdown-other-text">组织：${currentOrgName}</span>--%>
										<%-- <span class="dropdown-other-text">岗位：${currentPositionName}</span> --%>
											<span class="dropdown-user-name" title="${userName}"><c:out value="${userName}" /></span>
											<span class="dropdown-other-text" title="${currentOrgName}">组织：${currentOrgName}</span>
											<span class="dropdown-other-text" title="${currentDeptName}">部门：${currentDeptName}</span>
									</h2>
								</div>
								<ul class="userinfo-list dropdown-name-border-line">
									<li class="userinfo-li" ><a onclick="settings();"><i class="icon iconfont icon-yonghu"></i>个人设置</a></li>
									<li class="userinfo-li"><a id="changePassWord"><i class="icon iconfont icon-key"></i>修改密码</a></li>
									<li class="userinfo-li"><a onclick="userSwich();"><i class="icon iconfont icon-qiehuanzhanghaohei"></i>切换组织</a></li>
								</ul>
								<ul class="userinfo-list">
									<li class="userinfo-li"><a onclick="logout();"><i class="icon iconfont icon-tuichu"></i>退出登录</a></li>
								</ul>
							</div>
					<%-- <ul class="dropdown-menu dropdown-menu-right avic-dropmenu">
						<li class="user-card">
							<div class="usercont">
								<div class="userhead">
									<img src="${userHeadURI}" class="userhead haedimg" style="margin-left: 0px;"> <i class="switch" onclick="userSwich();"></i>
								</div>
								<div class="userbase">
									<p title="${userName}">
										姓名：<span>${userName}</span>
									</p>
									<p title="${currentOrgName}">
										组织：<span class="org">${currentOrgName}</span>
									</p>
									<p title="${currentDeptName}">
										部门：<span class="department">${currentDeptName}</span>
									</p>
									<p title="${currentPositionName}">
										岗位：<span class="job">${currentPositionName}</span>
									</p>
								</div>
							</div>
							<div class="btns">
								<div class="a-btn" onclick="settings();">设置</div>
								<div class="a-btn" onclick="logout();">退出</div>
							</div>
						</li>
					</ul> --%>
				</div>
			</div>
		</div>
		<!-- 头部工具栏end -->
		<div class="bodyCont">
			<!-- 页面内容区 Start -->
			<div class="main">
				<div id="tabs-panel" class="mainbody easyui-tabs" data-options="tools:'#tab-tools',fit:true,border:false,tabHeight:30">
					<div title="首页" data-options="fit:true,border:false">
						<iframe src="" id="mainFrame" name="mainFrame" frameborder="0"></iframe>
					</div>
				</div>
			</div>
			<!-- 页面内容区 End -->
		</div>
	</div>

	<div class="hiddenMenu">
		<div id="indexMenu" class="tabsSubMenu" data-for="首页" style="width: 400px;">
			<ul class="indexMenuContent">
				<li class="changeUrl checked" rel="guider.html">
					<div>
						<i></i><span class="cn">我的工作</span><span class="setting"></span>
					</div>
				</li>
			</ul>
			<div class="btns" onclick="userDefinedPortlet_add();return false;">
				<ul>
					<li><em class="icon icon-add"></em>添加首页</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- 选择皮肤的模态框 Start-->
	<div id="changeui" class="model-s"></div>
	<!-- 选择皮肤的模态框 End -->

	<!-- 加载层 -->
	<div class="square">
		<div class="box">
			<div class="square-gradient">
				<i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i>
				<i class="gradient"></i>
			</div>
			<p>系统正在加载，请稍等...</p>
		</div>
	</div>

	<!-- 框架依赖 jquery-1.9.1.js -->
	<script type="text/javascript" src="static/h5/jquery/${jqueryVersion}"></script>
	<!-- 基础框架依赖 bootstrap.js -->
	<script type="text/javascript" src="static/h5/bootstrap/3.3.4/js/bootstrap.js"></script>
	<!-- jquery-tabs 脚本依赖 -->
	<script type="text/javascript" src="static/h5/jquery-tabs/easyloader.js"></script>
	<script type="text/javascript" src="static/h5/jquery-tabs/plugins/jquery.parser.js"></script>
	<script type="text/javascript" src="static/h5/jquery-tabs/plugins/jquery.linkbutton.js"></script>
	<script type="text/javascript" src="static/h5/jquery-tabs/plugins/jquery.menu.js"></script>
	<script type="text/javascript" src="static/h5/jquery-tabs/plugins/jquery.menubutton.js"></script>
	<script type="text/javascript" src="static/h5/jquery-tabs/plugins/jquery.tabs.js"></script>
	<script type="text/javascript" src="static/h5/jquery-tabs/plugins/jquery.panel.js"></script>
	<script type="text/javascript" src="static/h5/common-ext/window-ext.js"></script>
	<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
	<script type="text/javascript" src="static/h5/perfect-scrollbar/js/divscroll.js"></script>


	<!-- 换肤插件 jquery.changeui.js -->
	<script type="text/javascript" src="avicit/platform6/portal/js/jquery.changeui.js"></script>
	<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>
	<script type="text/javascript" src="avicit/platform6/portal/js/effect.js"></script>
	<script type="text/javascript" src="avicit/platform6/portal/portlet/js/portletUserDefined.js"></script>
	<script type="text/javascript" src="avicit/platform6/portal/themes/${_theme}/js/defaultV2.js"></script>
	<script type="text/javascript" src="avicit/platform6/portal/message/js/SysMsgPub.js"></script>
	<!-- 解决IE图标重绘问题公共js -->
	<script src="avicit/platform6/portal/js/redrawpseudoel.js"></script>
	<!-- IM -->
	<%if("true".equals(PlatformProperties.getProperty(PlatformConstant.IM_START))){ %>
	<script src="avicit/platform6/im/strophejs/strophe.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/chatstates.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/disco.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/ping.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/register.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/roster.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/pubsub.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/muc.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/rsm.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/mam.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/bookmarks.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/vcard.js"></script>
	<script src="avicit/platform6/im/strophejs/strophe-plugins/mucsub_wskj.js"></script>
	<script src="avicit/platform6/im/js/jquery.lazyload.js"></script>
	<script src="avicit/platform6/im/layim/layui.js"></script>
	<script src="avicit/platform6/im/js/config.js"></script>
	<script src="avicit/platform6/im/js/api.js"></script>
	<script src="avicit/platform6/im/js/chat.js"></script>
	<script src="avicit/platform6/im/js/UIControler.js"></script>
	<%} %>

	<script type="text/javascript">
	     var currentSkin = "${_skins}";
	     var isTemp = "${isTemp}";
// 	    $('#oacollection').oaCollectionPortal();//个人收藏初始化
        var REFRESHINTERVAL = '${refreshInterval}';//消息刷新间隔
        if(REFRESHINTERVAL==null||REFRESHINTERVAL==''){
            REFRESHINTERVAL = "30000";//默认30秒
        }
        setInterval(queryUnReadMessageAmount,parseInt(REFRESHINTERVAL));
		$(function(){
			//showDialog();
			$('#console').css("height",document.documentElement.clientHeight-50);
			$('#portal').css("height",document.documentElement.clientHeight-50);
			$('#portlet').css("height",document.documentElement.clientHeight-50);
			
			$('#keywords').bind('keypress',function(event){ 
		         if(event.keyCode == 13){  
		        	 execSearch();  
		         }  
		     });
			/* $("#headSubmit").click(function(){
				execSearch();
			}) */
			$('#keywords').blur(function() {
			 	 setTimeout(function() { //进行延时处理，时间单位为千分之一秒
			 		 $("#keywords").css({
						'width':'0',
						'right':'32px',
						'padding':'0'
					  });
				 }, 100);
			 	initHeadMenuWidth(180);
			}).focus(function(){
				var imagePath = 'url('+'<%=ViewUtil.getRequestPath(request)%>'+'avicit/platform6/portal/themes/oa/images/top_search_bg.png)';
			    $("#keywords").css({
					'width':'220px',
					'right':'0',
					'padding-right':'32px'
				 });
			    initHeadMenuWidth(0);
			});
			 $('#changePassWord').on('click',function(){
			 		
			 		modifyIndex = layer.open({
		    			type: 2,
		   				area: ['70%', '50%'],
		    			title: '修改密码',
		    			skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	        			maxmin: false, //开启最大化最小化按钮
		    			content: '<%=ViewUtil.getRequestPath(request)%>'+'avicit/platform6/console/user/modifyUserPassword.jsp?userId=<%=userId%>' 
					});  
				});
			$("#headSubmit").click(function(){
				/* execSearch(); */
				var imagePath = 'url('+'<%=ViewUtil.getRequestPath(request)%>'+'avicit/platform6/portal/themes/oa/images/top_search_bg.png)';
				if($('#keywords').width() == 0){
					$('#keywords').show();
					$('#keywords').focus();
				}else{
					execSearch();
				}
				
			})
			
			if(isTemp== "true"){
				$(".top_search").css("visibility","hidden");
				$(".iconbtn").css("visibility","hidden");
			}
		});
		$(window).resize(function(){
			$('#console').css("height",document.documentElement.clientHeight-50);
			$('#portal').css("height",document.documentElement.clientHeight-50);
			$('#portlet').css("height",document.documentElement.clientHeight-50);
		});
		
		function execSearch(){
			var id = "#tabs-panel";
			var curTabTitle = "搜索";
			var nowurl = $(id).tabs("getTab", curTabTitle);
			if(null!=nowurl&&nowurl!=""){
				var keywords = document.getElementById("keywords").value;
				$(id).tabs("getTab", curTabTitle).find('iframe').attr('src', 'platform/search/search.html?keywords='+encodeURI(encodeURI(keywords))+'&histKey=1');
			}else{
				var keywords = document.getElementById("keywords").value;
				addTab('搜索','platform/search/search.html?keywords='+encodeURI(encodeURI(keywords))+'&histKey=1');
			}
		 }
		 function closeModiyPassworDilog(){
				layer.close(modifyIndex);
			}
		/**IM**/
		<%if("true".equals(PlatformProperties.getProperty(PlatformConstant.IM_START))){ %>
		$(function(){
			try{
				Chat.connect("<%=SessionHelper.getLoginSysUser(request).getLoginName()%>", "<%=SessionHelper.getLoginSysUser(request).getLoginPassword()%>");
			}catch(e){
			}
		});
		<%} %>
		
		
		//获取元素对象函数
		function g( id ){
			return document.getElementById(id);
		}

		//自动剧中函数 - 登录浮层水平垂直居中
		//(el = Element)传入登录浮层元素对象
		function autoCenter( el ){

			//获取网页可视区域	高度，宽度
			var bodyW = document.documentElement.clientWidth;
			var bodyH = document.documentElement.clientHeight;

			//获取登录浮层的宽和高
			var elW = el.offsetWidth;
			var elH = el.offsetHeight;

			//设置浮层元素的 左边距和上边距 用以达到居中效果
			el.style.left = (bodyW - elW) + 'px';
			el.style.top = elH + 'px';
		}

		//自动全屏 - 将遮罩层放满整个屏幕
		//传入遮罩层元素对象
		/* function fillToBody( el ){
			//将传入对象的可视宽和高设置为当前页面可视区域的宽和高
			el.style.width = document.documentElement.clientWidth;
			el.style.height = document.documentElement.clientHeight;
		} */

		var mouseOffsetX = 0;	//鼠标X轴 Y轴 偏移值
		var mouseOffsetY = 0;

		var isDraging = false;	//是否为可拖拽的标记

		//鼠标事件一：计算鼠标相对拖拽元素左上角的坐标，并且标记元素为可拖动
		//mousedown鼠标按下事件
		g('dialogTitle').addEventListener('mousedown',function( e ){
			var e = e || window.event;

			//计算鼠标偏移值		g('dialog').offsetLeft;登录浮层相对于左边的位置
			//mouseOffsetX 当前鼠标距离登录浮层边框X轴距离 (mouseOffsetY)Y轴距离
			mouseOffsetX = e.pageX - g('dialog').offsetLeft;
			mouseOffsetY = e.pageY - g('dialog').offsetTop;

			//标记登录浮层可拖拽
			isDraging = true;
		})
		
		//鼠标事件二：鼠标开始移动，检测登录浮层是否为可拖动，如果是，则更新元素的位置到当前鼠标的位置（要减去第一步中获得的偏移）onmousemove鼠标移动事件
		document.onmousemove = function( e ){
			var e = e || window.event;

			var mouseX = e.pageX;	//鼠标当前位置
			var mouseY = e.pageY;

			var moveX = 0;	//登录浮层移动后的新位置
			var moveY = 0;

			if( isDraging === true){

				//计算登录浮层移动后	浮层左边距和上边距
				//mouseOffsetX 当前鼠标距离登录浮层边框X轴距离 (mouseOffsetY)Y轴距离
				//mouseX mouseY 鼠标当前坐标
				moveX = mouseX - mouseOffsetX;
				moveY = mouseY - mouseOffsetY;

				//宽度限定 moveX > 0 并且 moveX < (页面最大宽度 - 浮层宽度)
				//			moveY > 0 并且 moveY < (页面最大高度 - 浮层高度)
				
				var pageWidth = document.documentElement.clientWidth;	//页面最大宽度
				var pageHeight = document.documentElement.clientHeight;	//页面最大高度
				
				//登录浮层的最大宽和最大高
				var dialogWidth = g('dialog').offsetWidth;
				var dialogHeigth = g('dialog').offsetHeight;

				//计算moveX 和 moveY 最大值
				var maxX = pageWidth - dialogWidth;
				var maxY = pageHeight - dialogHeigth;

				//登录浮层可移动范围限定
				//Math.max(0,moveX)限定最小值为0
				//Math.min( maxX , Math.max(0,moveX) );限定最大值为 maxX
				moveX = Math.min( maxX , Math.max(0,moveX) );
				moveY = Math.min( maxY , Math.max(0,moveY) );

				//设置登录浮层的左边距和上边距
				g('dialog').style.left = moveX + 'px';
				g('dialog').style.top = moveY + 'px';

			}
		}

		//鼠标事件三：鼠标松开时，标记元素为不可拖动状态即可
		document.onmouseup = function(){
			isDraging = false;
		}

		//显示浮层函数
		function showDialog(){
			//设置浮层样式显示
			g('dialog').style.display = 'block';
			//设置遮罩层样式显示
			//g('mask').style.display = 'block';
			//设置浮层居中
			autoCenter( g('dialog') );
			//遮罩层全屏化
			//fillToBody( g('mask') );
		}

		//隐藏浮层函数
		function hideDialog(){
			//设置浮层样式隐藏
			g('dialog').style.display = 'none';
			//设置遮罩层样式隐藏
			g('mask').style.display = 'none';
		}

		//窗口大小改变时的函数
		window.onresize = function(){
			//设置浮层居中
			autoCenter( g('dialog') );
			//遮罩层全屏化
			//fillToBody( g('mask') );
		}
</script>
	<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="static/h5/common-ext/checkbrower/checkbrowser.css">
<script type="text/javascript" src="static/h5/common-ext/checkbrower/checkbrowser.js"></script>
<![endif]-->
</body>
</html>