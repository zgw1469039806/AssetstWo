<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobilepushcustom/MobilePushCustomController/operation/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value='${mobilePushCustomDTO.id}' />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><span style="color:red;">*</span>对应设备:</th>
					<td width="40%">
						<select name="appid" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<c:forEach items="${mobileApp}" var="mobileApp">
							<option value="${mobileApp.id}"
								<c:if test="${mobileApp.id eq mobilePushCustomDTO.appid}">SELECTED</c:if>>${mobileApp.appName}</option>
							</c:forEach>
						</select>
					</td>
					<th width="10%">推送目标:</th>
					<td width="40%"><input title="TARGET_TYPE"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[50]'" style="width: 180px;"
						type="text" name="targetType" id="targetType"
						value='<c:out value='${mobilePushCustomDTO.targetType}'/>' /></td>
				</tr>
				<tr>
					<th>证书类型:</th>
					<td>
						<pt6:syslookup name="developProductId" lookupCode="PLATFORM_MOBILE_CERT_TYPE" isNull="true" defaultValue='${mobilePushCustomDTO.developProductId}' dataOptions="onShowPanel:comboboxOnShowPanel,editable:false,panelHeight:'auto'">
						</pt6:syslookup> 
					</td>
				</tr>
				<tr>
					<th>推送内容:</th>
					<td colspan="3"><input title="CONTENT"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[3000]'"
						type="text" name="content" id="content"
						value='<c:out value='${mobilePushCustomDTO.content}'/>' /></td>
				</tr>
			</table>
		</form>
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton"
						class="easyui-linkbutton primary-btn" onclick="saveForm();"
						href="javascript:void(0);">保存</a> <a title="返回" id="returnButton"
						class="easyui-linkbutton" onclick="closeForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {    
        maxLength: {    
            validator: function(value, param){    
                return param[0] >= value.length;
                
            },    
            message: '请输入最多 {0} 字符.'   
        }    
    });  
	$(function(){
																																																																																																																																																							})
	function closeForm(){
		parent.mobilePushCustom.closeDialog("#edit");
	}
	function saveForm(){
	    if ($('#form').form('validate') == false) {
            return;
        }
		parent.mobilePushCustom.save(serializeObject($('#form')),"#edit");
	}
	</script>
</body>
</html>