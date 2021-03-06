<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>

<title>自定义页面</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'west',split:false"
			style="width: 570px; padding: 0px; overflow: auto;">
			<div id="tableToolbar" class="toolbar">
				<div class="toolbar-right">
					<div class="input-group form-tool-search">
						<input type="text" name="dictionary_keyWord"
							id="dictionary_keyWord" style="width: 240px;"
							class="form-control input-sm" placeholder="请输入！"> <label
							id="dictionary_searchPart"
							class="icon icon-search form-tool-searchicon"></label>
					</div>
				</div>
			</div>
			<table id="dictionaryjqGrid"></table>
			<div id="jqGridPager"></div>
		</div>
		<div data-options="region:'center',title:''">
				<ul style='padding-left: 15px;margin-top: -30px;padding-left: 15px;position: absolute;top: 50%;margin-top: -40px;'>
					<li style='list-style-type:none;'><a href="javascript:;" id="dictinaryAdd" 
									class="btn btn-primary form-tool-btn typeb btn-sm" title="新增" style="min-width: 30px;"><i
									class="fa fa-angle-double-right"></i> </a></li>
					<br>
					<li style='list-style-type:none;'><a href="javascript:;" id="dictinaryRemove" 
									class="btn btn-primary form-tool-btn typeb btn-sm" title="移除" style="min-width: 30px;"><i
									class="fa fa-angle-double-left"></i> </a></li>
				</ul>

		</div>
		<div data-options="region:'east',title:'',collapsible:false" style="width: 570px; padding: 0px; overflow: auto;">
			<table id="dictionarySelectedjqGrid"></table>
			<div id="jqGridSelectedPager"></div>
		</div>
	<div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script
	src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script type="text/javascript">
var mapping;
var querySql;

function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}

$(document).ready(function () {
	var dataGridColModel =  "";
    
    $("#dictionary_keyWord").on('keydown', function(e) {
		if (e.keyCode == '13') {
			searchByKeyWord();
		}
	});

    $("#dictionary_searchPart").on('click', function(e) {
        searchByKeyWord();
    });
});


function initGrid(selectType, rowCnt,queryStatement,dataGridColModel,imapping,dataCombox,dataComboxType,callback,getParamsValue,rowData,dicUniqueCode,jsSuccess){
	
	mapping = JSON.parse(imapping);
    

    var targetNameNames = "";
    $.each(mapping,function(index,value){
        if(mapping[index].filter == true){
            targetNameNames += mapping[index].targetNameName + "、";
        }
    });

    $('#dictionary_keyWord').attr('placeholder','请按' + targetNameNames.substring(0,targetNameNames.length-1)  + '查询!');

	//正则替换表单变量
    if(rowData != undefined && rowData != null){
		var reg = /subfield{(.*?)(?=[\}])/g;
		var fieldNames = queryStatement.match(reg); 
		if(fieldNames != null && fieldNames.length > 0){
			for(var i = 0; i < fieldNames.length; i++){
				var fieldName = fieldNames[i];
				var fieldNameNew = fieldName.replaceAll("subfield{","");
				var fieldNameNewValue = "";
				
				fieldNameNewValue = eval("rowData."+fieldNameNew);
				queryStatement = queryStatement.replaceAll(fieldName + "}", fieldNameNewValue);
			}
		}
	}
	
	var reg = /field{(.*?)(?=[\}])/g;
	var fieldNames = queryStatement.match(reg); 
	if(fieldNames != null && fieldNames.length > 0){
		for(var i = 0; i < fieldNames.length; i++){
			var fieldName = fieldNames[i];
			var fieldNameNew = fieldName.replaceAll("field{","");
			var fieldNameNewValue = "";
			if (typeof(getParamsValue)=='function') {
				fieldNameNewValue = getParamsValue(fieldNameNew);
            }else{
            	fieldNameNewValue = parent.$("#"+fieldNameNew).val();
            }

			queryStatement = queryStatement.replaceAll(fieldName + "}", fieldNameNewValue);
		}
	}
	
    //queryStatement = window.btoa(queryStatement);
	queryStatement = encodeURIComponent(queryStatement);
	querySql = queryStatement;
	var searchdata = {
		sql: queryStatement,
		dataCombox:dataCombox,
		dataComboxType:dataComboxType,
		dicUniqueCode:dicUniqueCode
	};
	
	$("#dictionaryjqGrid").jqGrid({
			url : "eform/plugin/getDictionaryTableInfo",
			mtype : 'POST',
			datatype : "json",
			toolbar : [ true, 'top' ],//启用toolbar
			colModel : JSON.parse(dataGridColModel), //表格列的属性
			height : $(window).height() - 120, //初始化表格高度
			scrollOffset : 20, //设置垂直滚动条宽度
			rowNum : rowCnt,//每页条数
			rowList : [ 200, 100, 50, 30, 20, 10 ], //每页条数可选列表
			altRows : true,//斑马线
			userDataOnFooter : true,
			pagerpos : 'left',//分页栏位置
			loadComplete : function(xhr) {
				$(this).jqGrid('getColumnByUserIdAndTableName');

				var rows = $(this).jqGrid('getRowData');
				if (typeof(jsSuccess)=='function') {
					jsSuccess(xhr,rows);
				}
			},
			styleUI : 'Bootstrap',//Bootstrap风格
			viewrecords : true, //是否要显示总记录数
			multiselect : true, //可多选
			autowidth : true, //列宽度自适应
			shrinkToFit : true,
			responsive : true,//开启自适应
			pager : "#jqGridPager",
			width:"100%",
			postData : searchdata,
			hasTabExport:false,
			hasColSet:false,
			jsonReader : {"id": "id"}
		});
	$("#t_dictionaryjqGrid").append($("#tableToolbar"));


	$("#dictionarySelectedjqGrid").jqGrid({
			mtype : 'GET',
			datatype : "json",
			toolbar : [ true, 'top' ],//启用toolbar
			colModel : JSON.parse(dataGridColModel), //表格列的属性
			height : $(window).height() - 120, //初始化表格高度
			scrollOffset : 20, //设置垂直滚动条宽度
			rowNum : rowCnt,//每页条数
			rowList : [ 200, 100, 50, 30, 20, 10 ], //每页条数可选列表
			altRows : true,//斑马线
			userDataOnFooter : true,
			pagerpos : 'left',//分页栏位置
			loadComplete : function() {
				$(this).jqGrid('getColumnByUserIdAndTableName');
			},
			styleUI : 'Bootstrap',//Bootstrap风格
			viewrecords : true, //是否要显示总记录数
			multiselect : true, //可多选
			autowidth : true, //列宽度自适应
			shrinkToFit : true,
			responsive : true,//开启自适应
			pager : "#jqGridSelectedPager",
			width:"100%",
			hasTabExport:false,
			hasColSet:false
	});
	
	$("#t_dictionarySelectedjqGrid").append($("#selectedTableToolbar"));

	$("#gbox_dictionaryjqGrid>thead").find("tr").each(function(){
		$(this).find("th").css("text-align","center");
	});


	for(var i =0; i< mapping.length; i++){
		var obj = mapping[i];
		$("#dictionaryjqGrid_" + obj.name).css("text-align","center");
	}
	//$("select .ui-pg-selbox").css("display","none");
	$("select").css("display","none");

}
/**
 * 搜索
 */
function searchByKeyWord(){
	var keyWord = $("#dictionary_keyWord").val() == $("#dictionary_keyWord").attr(
		"placeholder") ? "" : $("#dictionary_keyWord").val();
	
	var searchdata = {
		keyWord : keyWord,
		sql: querySql,
		mapParam: JSON.stringify(mapping)
	};
	
	$("#dictionaryjqGrid").jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
		}).trigger("reloadGrid");
}

/**
 * 单选后除其他选择项
 */
function beforeSelectRow(){
	$("#dictionaryjqGrid").jqGrid("resetSelection");
	return true;
}

$('#dictinaryAdd').bind('click',function(){
	var ids = $("#dictionaryjqGrid").jqGrid('getGridParam', 'selarrrow');
	for(var i =0; i<ids.length; i++){
		var rowData = $("#dictionaryjqGrid").jqGrid('getRowData', ids[i]);
		if(rowData.ID != "" && rowData.ID != undefined){
			var selectData = $("#dictionarySelectedjqGrid").jqGrid('getRowData', rowData.ID);
			if(!jQuery.isEmptyObject(selectData)){
				continue;
			}
		}
		var parameters = {
			rowID : rowData.ID,
			initdata : rowData,
			position :"first",
			useDefValues : true,
			useFormatter : true,
			addRowParams : {extraparam:{}}
		}
		$("#dictionarySelectedjqGrid").jqGrid('addRow', parameters);
	}
	
});


$('#dictinaryRemove').bind('click',function(){
	var ids = $("#dictionarySelectedjqGrid").jqGrid('getGridParam', 'selarrrow');
	for(var i =ids.length-1; i>=0; i--){
		$("#dictionarySelectedjqGrid").jqGrid('delRowData', ids[i]);
	}
});

</script>
</html>