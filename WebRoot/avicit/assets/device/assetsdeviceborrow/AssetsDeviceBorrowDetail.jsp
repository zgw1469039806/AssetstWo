<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,table,fileupload,tree";
    String formId = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdeviceborrow/assetsDeviceBorrowController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <!-- 当前页 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/editForm.css">
    <!-- 定制tab标签样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/avictabs.css">
    <!-- 流程标签 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/workflow.css">
    <!-- 时间轴 样式 -->
    <link rel="stylesheet" type="text/css" href="static/h5/timeliner/css/timeliner.css">
</head>
<body>
<div class="main">
    <!-- 右侧工具栏 Start -->
    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttons.jsp" %>
    <!-- 右侧工具栏 End -->
    <!-- 正文内容 Start -->
    <div class="content">
        <!-- 简单tab Start -->
        <div class="avic-tab">
            <div class="tab-bar">
                <ul>
                    <li class="on">表单信息</li>
                    <li>流程跟踪</li>
                    <li>引用文档</li>
                    <li>关联流程</li>
                </ul>
            </div>
            <div class="btn-bar on">
                <!-- 暂存 关注 正文 等流程代理的按钮 -->
                <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttonBar.jsp" %>
            </div>
            <div class="tab-panel">
                <div class="panel-body on">
                    <div class="panel-main">
                        <!-- 业务表单 Start -->
                        <form id='form'>
                            <input type="hidden" name="id" id="id"/>
                            <input type="hidden" name="version" id="version"/>
                            <table class="form_commonTable">
                                <tr>
                                    <th width="10%">
                                        <label for="createdByPersonAlias">申请人:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="createdByPerson" name="createdByPerson">
                                            <input class="form-control" placeholder="请选择用户" type="text"
                                                   id="createdByPersonAlias" name="createdByPersonAlias">
                                            <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="createdByDeptAlias">申请人部门:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="createdByDept" name="createdByDept">
                                            <input class="form-control" placeholder="请选择部门" type="text"
                                                   id="createdByDeptAlias" name="createdByDeptAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="createdByTel">申请人电话:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="createdByTel"
                                               id="createdByTel"/>
                                    </td>
                                    <th width="10%">
                                        <label for="formState">单据状态:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="formState"
                                               id="formState"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="procName">流程名称:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="procName" id="procName"/>
                                    </td>
                                    <th width="10%">
                                        <label for="procId">流程ID:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="procId" id="procId"/>
                                    </td>
                                    <th width="10%">
                                        <label for="assetId">资产编号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="assetId" id="assetId"/>
                                    </td>
                                    <th width="10%">
                                        <label for="unifiedId">统一编号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="unifiedId"
                                               id="unifiedId"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="deviceCategory">设备类别:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="deviceCategory"
                                               id="deviceCategory"/>
                                    </td>
                                    <th width="10%">
                                        <label for="deviceName">设备名称:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="deviceName"
                                               id="deviceName"/>
                                    </td>
                                    <th width="10%">
                                        <label for="deviceModel">设备型号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="deviceModel"
                                               id="deviceModel"/>
                                    </td>
                                    <th width="10%">
                                        <label for="deviceSpec">设备规格:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="deviceSpec"
                                               id="deviceSpec"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="ownerIdAlias">责任人:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="ownerId" name="ownerId">
                                            <input class="form-control" placeholder="请选择用户" type="text"
                                                   id="ownerIdAlias" name="ownerIdAlias">
                                            <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="ownerDeptAlias">责任人部门:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="ownerDept" name="ownerDept">
                                            <input class="form-control" placeholder="请选择部门" type="text"
                                                   id="ownerDeptAlias" name="ownerDeptAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="userIdAlias">使用人:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="userId" name="userId">
                                            <input class="form-control" placeholder="请选择用户" type="text" id="userIdAlias"
                                                   name="userIdAlias">
                                            <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="userDeptAlias">使用人部门:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="userDept" name="userDept">
                                            <input class="form-control" placeholder="请选择部门" type="text"
                                                   id="userDeptAlias" name="userDeptAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="borrowDate">实际借用时间:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control date-picker" type="text" name="borrowDate"
                                                   id="borrowDate"/><span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="expectReturnDate">预计归还时间:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control date-picker" type="text" name="expectReturnDate"
                                                   id="expectReturnDate"/><span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="returnDate">实际归还时间:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control date-picker" type="text" name="returnDate"
                                                   id="returnDate"/><span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="borrowLength">借用时长:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                            <input class="form-control" type="text" name="borrowLength"
                                                   id="borrowLength" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                                                   data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1"
                                                   data-precision="0">
                                            <span class="input-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                                class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                                class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="manageState">统管设备状态:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="manageState"
                                               id="manageState"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="attachment">附件</label></th>
                                    <td colspan="<%=4 * 2 - 1%>">
                                        <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
                                    </td>
                                </tr>
                            </table>
                        </form>
                        <!-- 业务表单 End -->
                    </div>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/tracks.jsp" %>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/files.jsp" %>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/processlevel.jsp" %>
                </div>
            </div>
        </div>
        <!-- 简单tab End -->
    </div>
    <!-- 正文内容 End -->
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 页面脚本 avictabs.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/avictabs.js"></script>
<!-- 时间轴组件 timeliner.js-->
<script type="text/javascript" src="static/h5/timeliner/js/timeliner.js"></script>
<!-- 页面脚本 editForm.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/editForm.js"></script>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowEditor.js"></script>
<!-- 业务的js -->
<script src="avicit/assets/device/assetsdeviceborrow/js/AssetsDeviceBorrowDetail.js"></script>
<script type="text/javascript">
    //注册附件上传完毕后执行的方法
    var afterUploadEvent = null;
    $(document).ready(function () {
        //创建业务操作JS
        var assetsDeviceBorrowDetail = new AssetsDeviceBorrowDetail('form');
        //创建流程操作JS
        new FlowEditor(assetsDeviceBorrowDetail);

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
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=formId%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //绑定表单验证规则
        assetsDeviceBorrowDetail.formValidate($('#form'));

        $('#createdByPersonAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPerson', textFiled: 'createdByPersonAlias'});
            this.blur();
            nullInput(e);
        });
        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#ownerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerId', textFiled: 'ownerIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#ownerDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDept', textFiled: 'ownerDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'userId', textFiled: 'userIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'userDept', textFiled: 'userDeptAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>