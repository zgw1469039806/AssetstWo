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
    <title>JS文件扩展</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <style>
		.select2-container {
		     z-index: 99999999999999 !important;
		}
		.select2-drop-mask {
		     z-index: 99999999999999 !important;
		}
    
	    .select2-drop-active {
	        z-index: 99999999999999 !important;
	    }
        .ui-jqgrid-bdiv div{
            overflow-x: hidden;
        }

        .ui-jqgrid tr.jqgrow td { text-overflow : ellipsis;    overflow: hidden !important; }
    </style>
    <script>
		var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	</script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false" style="padding: 8px 0;overflow: hidden">
    <input id="tableId" value="DYN_HY_01" type="hidden"/>
    <input id="contentvalue" type="hidden"/>
    <form id='form'>
        <div class="mce-content-body">
 <table border="0" class="form_commonTable1">
  <tbody>
   <tr>
    <td style="width:20%; text-align: right;"><i class='required'>*</i>联动目标字段：</td>
    <td style="width:30%;">

        <div class="input-group-sm">
            <select class="form-control input-sm" id="linkageColumnid" name="linkageColumnid" title="联动目标字段"> </select>
        </div> </td>
    <td style="width:20%; text-align: right;"></td>
    <td style="width:40%;"></td>
   </tr>
   <tr id="tabletr">
    <td style="width:85%;" colspan="4"> <style>
.datatable{
	margin:0 !important;
}
.ui-jqgrid-bdiv{
	overflow-x:auto !important;
}
.ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td {
    padding-right: 2px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    word-break: break-all;
    vertical-align: middle;
    padding-top: 4px;
    padding-bottom: 4px;
}
</style>
        <div class="easyui-layout" fit="true">
     <table style="table-layout: fixed;margin: 0;width: 100%;">
      <tbody>
       <tr>
        <td>
            <div id="tableToolbar" class="tollbar">
                <div>
                    <a id="jslist_insert" href="javascript:void(0)"
                       class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
                       title="添加"><i class="fa fa-plus"></i> 添加</a>
                    <a id="jslist_del" href="javascript:void(0)"
                       class="btn btn-primary form-tool-btn btn-sm" role="button"
                       title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                </div>
            </div>
          <table id="propertytable"></table>
           </td>
       </tr>
      </tbody>
     </table></div> </td>
   </tr>
  </tbody>
 </table>
</div>
    </form>
</div>


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="static/js/platform/eform/common.js"></script>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript" src="static/js/platform/eform/jqgridValidate.js"></script>
<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>
<script type="text/javascript" src="avicit/platform6/eform/formdesign/js/plugins/linkform-box/linkform-property.js"></script>

</body>

</html>