<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdeviceinventory/assetsDeviceInventoryController/toAssetsDeviceInventoryManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div id="panelnorth"
     data-options="region:'north',height:fixheight(1),onResize:function(a){$('#assetsDeviceInventory').setGridWidth(a);$('#assetsDeviceInventory').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_assetsDeviceInventory" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceInventory_button_add"
                                   permissionDes="添加">
                <a id="assetsDeviceInventory_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceInventory_button_edit"
                                   permissionDes="编辑">
                <a id="assetsDeviceInventory_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceInventory_button_delete"
                                   permissionDes="删除">
                <a id="assetsDeviceInventory_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
            </sec:accesscontrollist>
        </div>
        <div class="toolbar-right">
            <%--            <select id="workFlowSelect"--%>
            <%--                    class="form-control input-sm workflow-select">--%>
            <%--                <option value="all" selected="selected">全部</option>--%>
            <%--                <option value="start">拟稿中</option>--%>
            <%--                <option value="active">流转中</option>--%>
            <%--                <option value="ended">已完成</option>--%>
            <%--            </select>--%>
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="assetsDeviceInventory_keyWord" id="assetsDeviceInventory_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsDeviceInventory_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsDeviceInventory_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsDeviceInventory"></table>
    <div id="assetsDeviceInventoryPager"></div>
</div>
<%--<div id="centerpanel"--%>
<%--     data-options="region:'center',split:true,onResize:function(a){$('#assetsDeviceInventorySub').setGridWidth(a); $('#assetsDeviceInventorySub').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">--%>
<%--    <div id="toolbar_assetsDeviceInventorySub" class="toolbar">--%>
<%--        <div class="toolbar-right">--%>
<%--            <div class="input-group form-tool-search" style="width:125px">--%>
<%--                <input type="text" name="assetsDeviceInventorySub_keyWord" id="assetsDeviceInventorySub_keyWord"--%>
<%--                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">--%>
<%--                <label id="assetsDeviceInventorySub_searchPart" class="icon icon-search form-tool-searchicon"></label>--%>
<%--            </div>--%>
<%--            <div class="input-group-btn form-tool-searchbtn">--%>
<%--                <a id="assetsDeviceInventorySub_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"--%>
<%--                   role="button">高级查询 <span class="caret"></span></a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <table id="assetsDeviceInventorySub"></table>--%>
<%--    <div id="assetsDeviceInventorySubPager"></div>--%>
<%--</div>--%>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">盘点名称:</th>
                <td width="15%">
                    <input title="盘点名称" class="form-control input-sm" type="text" name="inventoryName"
                           id="inventoryName"/>
                </td>
                <th width="10%">盘点单号:</th>
                <td width="15%">
                    <input title="盘点单号" class="form-control input-sm" type="text" name="inventoryId" id="inventoryId"/>
                </td>
                <th width="10%">申请人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias"
                               name="createdByPersonAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">申请人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">创建日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createDateBegin"
                               id="createDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">创建日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createDateEnd" id="createDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">基准日(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDateBegin" id="beginDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">基准日(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDateEnd" id="beginDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
    <form id="formSub">
        <table class="form_commonTable">
            <tr>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">设备ID:</th>
                <td width="15%">
                    <input title="设备ID" class="form-control input-sm" type="text" name="deviceId" id="deviceId"/>
                </td>
                <th width="10%">资产编号:</th>
                <td width="15%">
                    <input title="资产编号" class="form-control input-sm" type="text" name="assetId" id="assetId"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">责任人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerIdSub" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAliasSub"
                               name="ownerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">责任人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDeptSub" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAliasSub"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
                </td>
                <th width="10%">供应商:</th>
                <td width="15%">
                    <input title="供应商" class="form-control input-sm" type="text" name="supplier" id="supplier"/>
                </td>
                <th width="10%">立卡日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateBegin"
                               id="createdDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">立卡日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateEnd" id="createdDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">安装地点ID:</th>
                <td width="15%">
                    <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">原值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">净值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netValue" id="netValue"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">设备状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceState" id="deviceState" title="设备状态"
                                  isNull="true" lookupCode="DEVICE_STATE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">盘点人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="inventoryPersonSub" name="inventoryPerson">
                        <input class="form-control" placeholder="请选择用户" type="text" id="inventoryPersonAliasSub"
                               name="inventoryPersonAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">盘点人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="inventoryDeptSub" name="inventoryDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="inventoryDeptAliasSub"
                               name="inventoryDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">盘点时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="inventoryDateBegin"
                               id="inventoryDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">盘点时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="inventoryDateEnd"
                               id="inventoryDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">备注:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="备注" name="remarks" id="remarks"></textarea>
                </td>
                <th width="10%">标志位:</th>
                <td width="15%">
                    <input title="标志位" class="form-control input-sm" type="text" name="flag" id="flag"/>
                </td>
                <th width="10%">盘点状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="inventoryState" id="inventoryState"
                                  title="盘点状态" isNull="true" lookupCode="INVENTORY_STATE"/>
                </td>
                <th width="10%">盘点结果:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="inventoryResult" id="inventoryResult"
                                  title="盘点结果" isNull="true" lookupCode="INVENTORY_RESULT"/>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="avicit/assets/device/assetsdeviceinventory/js/AssetsDeviceInventory.js" type="text/javascript"></script>
<script src="avicit/assets/device/assetsdeviceinventory/js/AssetsDeviceInventorySub.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsDeviceInventory;
    var assetsDeviceInventorySub;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsDeviceInventory.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsDeviceInventory.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsDeviceInventory.reLoad();
    };

    $(document).ready(function () {
        <%--alert('${jump}');--%>
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("inventoryName");
        searchMainTips.push("盘点名称");
        searchMainNames.push("inventoryId");
        searchMainTips.push("盘点单号");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsDeviceInventory_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsDeviceInventory_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("unifiedId");
        searchSubTips.push("统一编号");
        searchSubNames.push("deviceId");
        searchSubTips.push("设备ID");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsDeviceInventorySub_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsDeviceInventorySub_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        var assetsDeviceInventoryGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '盘点名称', name: 'inventoryName', width: 150}
            , {label: '盘点单号', name: 'inventoryId', width: 150}
            , {label: '申请人', name: 'createdByPersonAlias', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '创建日期', name: 'createDate', width: 150, formatter: format}
            , {label: '基准日', name: 'beginDate', width: 150, formatter: format}
            // , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            // , {label: '流程状态', name: 'businessstate_', width: 150}
        ];
        var assetsDeviceInventorySubGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备ID', name: 'deviceId', width: 150}
            , {label: '资产编号', name: 'assetId', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '供应商', name: 'supplier', width: 150}
            , {label: '立卡日期', name: 'createdDate', width: 150, formatter: format}
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {label: '原值', name: 'originalValue', width: 150}
            , {label: '净值', name: 'netValue', width: 150}
            , {label: '设备状态', name: 'deviceStateName', width: 150}
            , {label: '盘点人', name: 'inventoryPersonAlias', width: 150}
            , {label: '盘点人部门', name: 'inventoryDeptAlias', width: 150}
            , {label: '盘点时间', name: 'inventoryDate', width: 150, formatter: format}
            , {label: '备注', name: 'remarks', width: 150}
            , {label: '标志位', name: 'flag', width: 150}
            , {label: '盘点状态', name: 'inventoryStateName', width: 150}
            , {label: '盘点结果', name: 'inventoryResultName', width: 150}
        ];

        assetsDeviceInventory = new AssetsDeviceInventory('assetsDeviceInventory', '${url}', 'form', assetsDeviceInventoryGridColModel, 'searchDialog',
            function (pid) {
                assetsDeviceInventorySub = new AssetsDeviceInventorySub('assetsDeviceInventorySub', '${surl}', "formSub", assetsDeviceInventorySubGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsDeviceInventorySub_keyWord");
            },
            function (pid) {
                assetsDeviceInventorySub.reLoad(pid);
            },
            searchMainNames,
            "assetsDeviceInventory_keyWord");
        //主表操作
        //添加按钮绑定事件
        // assetsDeviceInventory.reLoad();

        $('#assetsDeviceInventory_insert').bind('click', function () {
            assetsDeviceInventory.insert();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceInventory_modify').bind('click', function () {
            assetsDeviceInventory.modify();
        });
        //删除按钮绑定事件
        $('#assetsDeviceInventory_del').bind('click', function () {
            assetsDeviceInventory.del();
        });
        //打开高级查询框
        $('#assetsDeviceInventory_searchAll').bind('click', function () {
            assetsDeviceInventory.openSearchForm(this, $('#assetsDeviceInventory'));   //this= $('#assetsDeviceInventory_searchAll')
        });
        //关键字段查询按钮绑定事件
        $('#assetsDeviceInventory_searchPart').bind('click', function () {
            assetsDeviceInventory.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsDeviceInventory.initWorkFlow($(this).val());
        });
        //子表操作
        //打开高级查询
        $('#assetsDeviceInventorySub_searchAll').bind('click', function () {
            assetsDeviceInventorySub.openSearchForm(this, $('#assetsDeviceInventorySub'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsDeviceInventorySub_searchPart').bind('click', function () {
            assetsDeviceInventorySub.searchByKeyWord();
        });

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

        $('#ownerIdAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerIdSub', textFiled: 'ownerIdAliasSub'});
            this.blur();
            nullInput(e);
        });

        $('#ownerDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDeptSub', textFiled: 'ownerDeptAliasSub'});
            this.blur();
            nullInput(e);
        });
        $('#inventoryPersonAliasSub').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'inventoryPersonSub',
                textFiled: 'inventoryPersonAliasSub'
            });
            this.blur();
            nullInput(e);
        });

        $('#inventoryDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'inventoryDeptSub', textFiled: 'inventoryDeptAliasSub'});
            this.blur();
            nullInput(e);
        });

    });

</script>
</html>