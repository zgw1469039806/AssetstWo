<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>配置日历</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 返回
 */
function doBack(){
	parent.closeDialog();
}

/**
 * 返回tab页签高度
 * @returns
 */
function getTabHeight(){
	return parseInt($(window).height()*0.5);;
}

/**
 * 选择日历，刷新其下的排除日期
 */
function onSelectCalendar(rowIndex, rowData){
	$('#datagridCalendarDate').datagrid('options').url = 'platform/jobCalendarController/loadJobCalendarDates.json';
	$('#datagridCalendarDate').datagrid('load',{
		jobCalenderId: rowData.id
	});
}

/**
 * 添加日历
 */
function addCalendar(){
	var usd = new CommonDialog("addCalendarDialog","450","240","avicit/platform6/modules/system/quartz/jobCalendarAdd.jsp","添加日历",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		isPrimary: true,
		handler:function(){
			var frmId = $('#addCalendarDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formCalendar').form('validate');
			if(!r){
				return false;
			}
			
			var dataVo = frm.$('#formCalendar').serializeArray();
			var dataJson = convertToJson(dataVo);
			dataVo = JSON.stringify(dataJson);
			
			//组合成参数
			var param = {
				dataVo: dataVo
			};
			
			$.ajax({
                cache: true,
                type: "POST",
                url:'platform/jobCalendarController/addJobCalendar',
                dataType:"json",
                data: param,
                async: false,
                timeout:10000,
                error: function(request) {
                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                },
                success: function(result) {
                	if (result.flag == 'success') {
                		$("#datagridCalendar").datagrid('reload');
						usd.close();
						$.messager.show({title:'提示',msg :'添加日历成功！'});
					}else{
						if(result.error){
							$.messager.show({title:'提示',msg :'添加日历失败！' + result.error});
						}else{
							$.messager.show({title:'提示',msg :'添加日历失败！'});
						}
					}
                }
            });
		}
	}];
	usd.createButtonsInDialogNew(buttons);
	usd.show();
}

/**
 * 修改日历
 */
function updateCalendar(){
	var selected = $('#datagridCalendar').datagrid('getSelected');
	if(selected == null){
		$.messager.show({title:'提示',msg :'请先选择一条数据！'});
		return false;
	}
	var id = selected.id;
	var usd = new CommonDialog("updateCalendarDialog","450","240","avicit/platform6/modules/system/quartz/jobCalendarUpdate.jsp?id=" + id,"修改日历",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		isPrimary: true,
		handler:function(){
			var frmId = $('#updateCalendarDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formCalendar').form('validate');
			if(!r){
				return false;
			}
			
			var dataVo = frm.$('#formCalendar').serializeArray();
			var dataJson = convertToJson(dataVo);
			dataVo = JSON.stringify(dataJson);
			
			//组合成参数
			var param = {
				dataVo: dataVo
			};
			
			$.ajax({
                cache: true,
                type: "POST",
                url:'platform/jobCalendarController/updateJobCalendar',
                dataType:"json",
                data: param,
                async: false,
                timeout:10000,
                error: function(request) {
                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                },
                success: function(result) {
                	if (result.flag == 'success') {
                		$("#datagridCalendar").datagrid('reload');
						usd.close();
						$.messager.show({title:'提示',msg :'修改日历成功！'});
					}else{
						if(result.error){
							$.messager.show({title:'提示',msg :'修改日历失败！' + result.error});
						}else{
							$.messager.show({title:'提示',msg :'修改日历失败！'});
						}
					}
                }
            });
		}
	}];
	usd.createButtonsInDialogNew(buttons);
	usd.show();
}

/**
 * 删除日历
 */
function deleteCalendar(){
	var selected = $('#datagridCalendar').datagrid('getSelected');
	if(selected == null){
		$.messager.show({title:'提示',msg :'请先选择一条数据！'});
		return false;
	}
	var id = selected.id;
	$.messager.confirm('确认', '您确认删除吗?', function(r){
        if (r){
        	var param = {
        		id: id
        	};
        	
			$.ajax({
				url:'platform/jobCalendarController/deleteJobCalendar',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						$("#datagridCalendar").datagrid('uncheckAll'); 
						$("#datagridCalendar").datagrid('unselectAll');
						$("#datagridCalendar").datagrid('clearSelections');
						$("#datagridCalendar").datagrid('reload');
						$("#datagridCalendarDate").datagrid('loadData',[]); 
						$.messager.show({title:'提示',msg :'删除成功！'});
					} else {
						$.messager.show({title:'提示',msg :'删除失败！'});
					}
				}
			});
        }
    });	
}

/**
 * 添加排除日期
 */
function addCalendarDate(){
	var selected = $('#datagridCalendar').datagrid('getSelected');
	if(selected == null){
		$.messager.show({title:'提示',msg :'请先选择一条任务日历！'});
		return false;
	}
	$('#addCalendarDateWindow').window('open',true);
	$('#jobCalendarId').val(selected.id);
	
	/**
	 *添加排除日期
	 */
	doAddCalendarDate = function(){
		var r = $('#formCalendarDate').form('validate');
		if(!r){
			return false;
		}
		
		var dataVo = $('#formCalendarDate').serializeArray();
		var dataJson = convertToJson(dataVo);
		dataVo = JSON.stringify(dataJson);
		
		//组合成参数
		var param = {
			dataVo: dataVo
		};
		
		$.ajax({
            cache: true,
            type: "POST",
            url:'platform/jobCalendarController/addJobCalendarDate',
            dataType:"json",
            data: param,
            async: false,
            timeout:10000,
            error: function(request) {
            	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
            },
            success: function(result) {
            	if (result.flag == 'success') {
            		$("#datagridCalendarDate").datagrid('reload');
            		closeAddCalendarDate();
            		$('#formCalendarDate').form('clear');
					$.messager.show({title:'提示',msg :'保存成功！'});
				}else{
					$.messager.show({title:'提示',msg :'保存失败！'});
				}
            }
        });
	};
	
	/**
	 * 关闭添加窗口
	 */
	closeAddCalendarDate = function(){
		$('#addCalendarDateWindow').window('close',true);
	};
}

/**
 * 删除排除日期
 */
function deleteCalendarDate(){
	var selected = $('#datagridCalendarDate').datagrid('getSelected');
	if(selected == null){
		$.messager.show({title:'提示',msg :'请先选择一条数据！'});
		return false;
	}
	var id = selected.id;
	$.messager.confirm('确认', '您确认删除吗?', function(r){
        if (r){
        	var param = {
        		id: id
        	};
        	
			$.ajax({
				url:'platform/jobCalendarController/deleteJobCalendarDate',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						$("#datagridCalendarDate").datagrid('uncheckAll'); 
						$("#datagridCalendarDate").datagrid('unselectAll');
						$("#datagridCalendarDate").datagrid('clearSelections');
						$("#datagridCalendarDate").datagrid('reload'); 
						$.messager.show({title:'提示',msg :'删除成功！'});
					} else {
						$.messager.show({title:'提示',msg :'删除失败！'});
					}
				}
			});
        }
    });	
}
</script>
</head>
<body class="easyui-layout" fit="true">
<div region="north" border="false" data-options="height: getTabHeight()">
	<table id="datagridCalendar" class="easyui-datagrid" 
			data-options="
				fit: true,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: true,
				method: 'post',
				url: 'platform/jobCalendarController/loadJobCalendars.json',
				idField: 'id',
				singleSelect: true,
				toolbar:'#toolbarCalendar',
				onSelect: onSelectCalendar
			">
		<thead>
			<tr>
				<sec:accesscontrollist hasPermission="3" domainObject="jobCalendarMaintainManager_gridform_name">
					<th data-options="field:'name', halign:'center', align:'center'" width="200">名称</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="jobCalendarMaintainManager_gridform_description">
					<th data-options="field:'description', halign:'center', align:'center'" width="200">描述</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="jobCalendarMaintainManager_gridform_createDate">
					<th data-options="field:'createDate', halign:'center', align:'center',formatter:formatColumnDate" width="100">创建时间</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="jobCalendarMaintainManager_gridform_createUser">
					<th data-options="field:'createUser', halign:'center', align:'center'" width="100">创建人</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="jobCalendarMaintainManager_gridform_updateDate">
					<th data-options="field:'updateDate', halign:'center', align:'center',formatter:formatColumnDate" width="100">更新时间</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="jobCalendarMaintainManager_gridform_updateUser">
					<th data-options="field:'updateUser', halign:'center', align:'center'" width="100">更新人</th>
				</sec:accesscontrollist>
			</tr>
		</thead>
	</table>
	<div id="toolbarCalendar" class="datagrid-toolbar" style="height:auto;display: block;padding:0 0 0 10px;">
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addCalendar();" href="javascript:void(0);">添加</a>
		<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateCalendar();" href="javascript:void(0);">修改</a>
		<a id="backButton" href="javascript:void(0)" onclick="doBack()" class="easyui-linkbutton" data-options="iconCls:'icon-back'" plain="true">返回</a>
		<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteCalendar();" href="javascript:void(0);">删除</a>
	</div>
</div>
<div region="center" border="false">
	<table id="datagridCalendarDate" class="easyui-datagrid" 
			data-options="
				fit: true,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: true,
				method: 'post',
				idField: 'id',
				singleSelect: true,
				toolbar:'#toolbarCalendarDate'
			">
		<thead>
			<tr>
				<sec:accesscontrollist hasPermission="3" domainObject="jobCalendarMaintainManager_gridform_excludedDate">
					<th data-options="field:'excludedDate', halign:'center', align:'center',formatter:formatColumnDate" width="100">排除的日期</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="jobCalendarMaintainManager_gridform_description">
					<th data-options="field:'description', halign:'center', align:'center'" width="100">描述</th>
				</sec:accesscontrollist>
			</tr>
		</thead>
	</table>
	<div id="toolbarCalendarDate" class="datagrid-toolbar" style="height:auto;display: block;padding:0 0 0 10px;">
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addCalendarDate();" href="javascript:void(0);">添加</a>
		<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteCalendarDate();" href="javascript:void(0);">删除</a>
	</div>
</div>
<div id="addCalendarDateWindow" class="easyui-window" title="添加排除日期" style="width:450px;height:220px"   
        data-options="modal:true,closed:true,minimizable:false">   
    <div class="easyui-layout" data-options="fit:true">   
        <form id="formCalendarDate" fit="true">
        	<input id="jobCalendarId" name="jobCalendarId" type="hidden" value=""/>
	        <div region="center" border="false" style="padding: 5px 15px 0px 0px;">
				<table class="form_commonTable">
					<tr>
						<th width="100px"><span class="remind">*</span>排除的日期</th>
						<td><input id="excludedDate" name="excludedDate" class="easyui-datebox" editable="false" required="true"/></td>
					</tr>
					<tr>
						<th>描述</th>
						<td><textarea id="description" name="description" class="textareabox easyui-validatebox" data-options="validType:'maxByteLength[200]'" style="height: 50px!important;"></textarea></td>
					</tr>
				</table>
			</div>
			<div region="south" border="false" style="height:40px;">
				<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">					
					 <table class="tableForm" border="0" cellspacing="1" width='100%'>
                		<tr>
                    		<td align="right">
                        		<a class="easyui-linkbutton primary-btn" onclick="doAddCalendarDate();" href="javascript:void(0);">提交</a>
                        		<a class="easyui-linkbutton" onclick="closeAddCalendarDate();" href="javascript:void(0);">关闭</a>
                    		</td>
                		</tr>
            		</table>
				</div>
			</div>
		</form>
    </div>   
</div> 
</body>
</html>
