<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsuserlog/assetsUserLogController/operation/Add/null" -->
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="userid">操作用户ID :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="userid" id="userid"/>
                </td>
                <th width="10%">
                    <label for="userName">操作用户姓名 :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="userName" id="userName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deptid">操作用户部门ID :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deptid" id="deptid"/>
                </td>
                <th width="10%">
                    <label for="deptName">操作用户部门名称:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deptName" id="deptName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="time">操作时间 :</label></th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="time" id="time"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="ip">操作IP :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="ip" id="ip"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="opType">操作类型:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="opType" id="opType"/>
                </td>
                <th width="10%">
                    <label for="moduleName">模块名称 :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="moduleName" id="moduleName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="moduleId">模块ID :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="moduleId" id="moduleId"/>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称 :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceid">设备ID :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceid" id="deviceid"/>
                </td>
                <th width="10%">
                    <label for="logContent">日志内容:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="logContent" id="logContent"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="opResult">操作结果 :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="opResult" id="opResult"/>
                </td>
                <th width="10%">
                    <label for="secretLevel">密级:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="secretLevel" id="secretLevel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="source">业务来源（流程名称）:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="source" id="source"/>
                </td>
                <th width="10%">
                    <label for="sourceid">业务来源的ID （流程名称的ID） :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="sourceid" id="sourceid"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="formid">履历卡:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="formid" id="formid"/>
                </td>
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="保存" id="assetsUserLog_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsUserLog_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
    function closeForm() {
        parent.assetsUserLog.closeDialog("insert");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        //限制保存按钮多次点击
        $('#assetsUserLog_saveForm').addClass('disabled').unbind("click");
        parent.assetsUserLog.save($('#form'), "insert");
    }

    $(document).ready(function () {
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
            beforeShow: function (selectedDate) {
                if ($('#' + selectedDate.id).val() == "") {
                    $(this).datetimepicker("setDate", new Date());
                    $('#' + selectedDate.id).val('');
                }
            }
        });

        parent.assetsUserLog.formValidate($('#form'));
        //保存按钮绑定事件
        $('#assetsUserLog_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsUserLog_closeForm').bind('click', function () {
            closeForm();
        });


        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>