/**
 *
 */
function AssetsUstdtempapplyCollect(datagrid, url, searchD, form, keyWordId, searchNames, dataGridColModel) {
    if (!datagrid || typeof(datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = url;
    this.getUrl = function () {
        return _url;
    }
    this._datagridId = "#" + datagrid;
    this._jqgridToolbar = "#t_" + datagrid;
    this._doc = document;
    this._formId = "#" + form;
    this._searchDialogId = "#" + searchD;
    this._keyWordId = "#" + keyWordId;
    this._searchNames = searchNames;
    this.dataGridColModel = dataGridColModel;
    this.init.call(this);
};
//初始化操作
AssetsUstdtempapplyCollect.prototype.init = function () {
    var _self = this;
    $(_self._datagridId).jqGrid({
        url: this.getUrl() + 'getAssetsUstdtempapplyCollectsByPage.json',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true, 'top'],
        colModel: this.dataGridColModel,
        height: $(window).height() - 120,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20,
        rowList: [200, 100, 50, 30, 20, 10],
        altRows: true,
        userDataOnFooter: true,
        pagerpos: 'left',
        loadComplete: function () {
            $(this).jqGrid('getColumnByUserIdAndTableName');
        },
        styleUI: 'Bootstrap',
        viewrecords: true,
        multiselect: true,
        autowidth: true,
        shrinkToFit: true,
        responsive: true,//开启自适应
        pager: "#jqGridPager"
    });
    $(this._jqgridToolbar).append($("#tableToolbar"));

    $('.date-picker').datepicker({
        beforeShow: function () {
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
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
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
    //禁止时间和日期格式手输
    $('.date-picker').on('keydown', nullInput);
    $('.time-picker').on('keydown', nullInput);
    //回车查询
    $(_self._keyWordId).on('keydown', function (e) {
        if (e.keyCode == '13') {
            _self.searchByKeyWord();
        }
    });
};
//添加页面
AssetsUstdtempapplyCollect.prototype.insert = function () {
    this.insertIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '添加',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Add/null'
    });
};
//编辑页面
AssetsUstdtempapplyCollect.prototype.modify = function () {
    var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    if (ids.length == 0) {
        layer.alert('请选择要编辑的数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    } else if (ids.length > 1) {
        layer.alert('只允许选择一条数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    }
    var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
    this.eidtIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '编辑',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Edit/' + rowData.id
    });
};
//详细页
AssetsUstdtempapplyCollect.prototype.detail = function (id) {
    this.detailIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '详细页',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Detail/' + id
    });
};
//打开高级查询框
AssetsUstdtempapplyCollect.prototype.openSearchForm = function (searchDiv) {
    var _self = this;
    var contentWidth = 800;
    var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
    var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
    var text = $(searchDiv).text();
    var width = $(searchDiv).innerWidth();


    layer.config({
        extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
    });

    layer.open({
        type: 1,
        shift: 5,
        title: false,
        scrollbar: false,
        move: false,
        area: [contentWidth + 'px', '400px'],
        offset: [top + 'px', left + 'px'],
        closeBtn: 0,
        shadeClose: true,
        btn: ['查询', '清空', '取消'],
        content: $(this._searchDialogId),
        success: function (layero, index) {
            var serachLabel = $('<div class="serachLabel"><span>' + text + '</span><span class="caret"></span></div>').appendTo(layero);
            serachLabel.bind('click', function () {
                layer.close(index);
            });
            serachLabel.css('width', width + 'px');
        },
        yes: function (index, layero) {
            _self.searchData();
            layer.close(index);//查询框关闭
        },
        btn2: function (index, layero) {
            _self.clearData();
            return false;
        },
        btn3: function (index, layero) {

        }
    });
};
//控件校验   规则：表单字段name与rules对象保持一致
AssetsUstdtempapplyCollect.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            stdId: {
                maxlength: 50
            },
            createdByDept: {
                maxlength: 50
            },
            createdByTel: {
                maxlength: 20
            },
            formState: {
                maxlength: 10
            },
            deviceName: {
                maxlength: 30
            },
            deviceCategory: {
                maxlength: 50
            },
            manufactureUnit: {
                maxlength: 30
            },
            subjectCode: {
                maxlength: 30
            },
            competentAuthority: {
                maxlength: 50
            },
            modelDirector: {
                maxlength: 50
            },
            competentLeader: {
                maxlength: 50
            },
            applyReasonPurpose: {
                maxlength: 1024
            },
            orignEquipSituation: {
                maxlength: 1024
            },
            efficiencySituation: {
                maxlength: 1024
            },
            developmentContent: {
                maxlength: 1024
            },
            technicalIndex: {
                maxlength: 1024
            },
            developmentCycle: {
                maxlength: 1024
            },
            isNeedInstall: {
                maxlength: 10
            },
            positionId: {
                maxlength: 50
            },
            serviceVoltage: {
                maxlength: 10
            },
            isHumidityNeed: {
                maxlength: 10
            },
            humidityNeed: {
                maxlength: 500
            },
            isWaterNeed: {
                maxlength: 10
            },
            waterNeed: {
                maxlength: 500
            },
            isGasNeed: {
                maxlength: 10
            },
            gasNeed: {
                maxlength: 500
            },
            isLet: {
                maxlength: 10
            },
            letNeed: {
                maxlength: 500
            },
            isOtherNeed: {
                maxlength: 10
            },
            otherNeed: {
                maxlength: 500
            },
            isAboveConditions: {
                maxlength: 10
            },
            isMetering: {
                maxlength: 10
            },
            meteringRequirement: {
                maxlength: 500
            },
            financialEstimate: {
                number: true
            },
            financialResources: {
                maxlength: 10
            },
            belongProject: {
                maxlength: 50
            },
            projectNo: {
                maxlength: 50
            },
            replyName: {
                maxlength: 50
            },
            approvalFormNumber: {
                maxlength: 50
            },
            isTestDevice: {
                maxlength: 10
            },
            competentDeviceLeader: {
                maxlength: 50
            },
            headerId: {
                maxlength: 50
            },
        }
    });
}
//保存功能
AssetsUstdtempapplyCollect.prototype.save = function (form, id) {
    var _self = this;
    avicAjax.ajax({
        url: _self.getUrl() + "save",
        data: {data: JSON.stringify(serializeObject(form))},
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                _self.reLoad();
                if (id == "insert") {
                    layer.close(_self.insertIndex);
                } else {
                    layer.close(_self.eidtIndex);
                }
                layer.msg('保存成功！');
            } else {
                layer.alert('保存失败！' + r.error, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title: "提示"
                    }
                );
            }
        }
    });
};

//保存功能
function save(form,id) {
    var _self = this;
    var datas = [serializeObject(form)];
    avicAjax.ajax({
        url: "platform/assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/operation/sub/save",
        data: {data: JSON.stringify(datas)},
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                // $("#bpm_save",window.parent.document).click();
                layer.msg('保存成功！');
                // var closewindow = window.parent.document.getElementsByClassName("layui-layer-ico layui-layer-close layui-layer-close1");
                // closewindow[0].click();
                // layer.close(_self.insertIndex);
                // closeForm();
                parent["callBackFnList"]();
            } else {
                layer.alert('保存失败！' + r.error, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title: "提示"
                    }
                );
            }
        }
    });
};


//删除
AssetsUstdtempapplyCollect.prototype.del = function () {
    var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    var _self = this;
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        layer.confirm('确认要删除选中的数据吗?', {icon: 3, title: "提示", area: ['400px', '']}, function (index) {
            for (; l--;) {
                ids.push(rows[l]);
            }
            avicAjax.ajax({
                url: _self.getUrl() + 'delete',
                data: JSON.stringify(ids),
                contentType: 'application/json',
                type: 'post',
                dataType: 'json',
                success: function (r) {
                    if (r.flag == "success") {
                        _self.reLoad();
                    } else {
                        layer.alert('删除失败！' + r.error, {
                                icon: 7,
                                area: ['400px', ''],
                                closeBtn: 0,
                                btn: ['关闭'],
                                title: "提示"
                            }
                        );
                    }
                }
            });
            layer.close(index);
        });
    } else {
        layer.alert('请选择要删除的数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
    }
};
//重载数据
AssetsUstdtempapplyCollect.prototype.reLoad = function () {
    var searchdata = {param: JSON.stringify(serializeObject($(this._formId)))}
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
AssetsUstdtempapplyCollect.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.eidtIndex);
    }
};
//高级查询
AssetsUstdtempapplyCollect.prototype.searchData = function () {
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(serializeObject($(this._formId)))
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
AssetsUstdtempapplyCollect.prototype.searchByKeyWord = function () {
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
    var names = this._searchNames;

    var param = {};
    for (var i in names) {
        var name = names[i];
        param[name] = keyWord;
    }
    var searchdata = {
        keyWord: JSON.stringify(param),
        param: null
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
}
//隐藏查询框
AssetsUstdtempapplyCollect.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};
/*清空查询条件*/
AssetsUstdtempapplyCollect.prototype.clearData = function () {
    clearFormData(this._formId);
    this.searchData();
};
