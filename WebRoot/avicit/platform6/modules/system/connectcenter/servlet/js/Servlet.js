/**
 * 
 */
function Servlet(formSub,searchSubNames,keyWord,searchDialogSub,datagrid, url, form,parentId) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this._datagridId = "#" + datagrid;
	this._jqgridToolbar = "#t_" + datagrid;
	this._searchDialogId = "#" + searchDialogSub;
	this._keyWordId = "#" + keyWord;
	this._searchNames = searchSubNames;
	this.searchForm = "#" + formSub;
	this._doc = document;
	this._formId = "#" + form;
	this._parentId = parentId;
	this.Pagerlbar = "#" + datagrid + "Pager";
	
	var dataGridColModel = [ {
		label : '标识',
		name : 'id',
		key : true,
		width : 75
	},{
		label : '名称',
		name : 'name',
		width : 75
	},{
		label : 'url',
		name : 'url',
		width : 75
	}];
	
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
Servlet.prototype.init = function() {
	var _self = this;
	var param = {id:_self._parentId};
	$(_self._datagridId).jqGrid({
		url : _self.getUrl() + 'getServletsByPage.json',
		mtype : 'POST',
		postData : param,
		datatype : "json",
		toolbar : [ false, 'top' ],
		colModel : _self.dataGridColModel,
		height : $(window).height() - 120-40,
		scrollOffset : 20, //设置垂直滚动条宽度
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		pagerpos : 'left',
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
			setTimeout(function(){
        		$(document).trigger('resize');
        	},100)
		},
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true,//开启自适应
		pager : _self.Pagerlbar
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));
	$(_self._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_self.searchByKeyWord();
		}
	});
};
//添加页面
Servlet.prototype.insert = function() {
	this.insertIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '添加【Servlet】',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Add/null'
	});
};
//编辑页面
Servlet.prototype.modify = function() {
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('请选择一条数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '编辑【Servlet】',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Edit/' + rowData.id
	});
};
//详细页
Servlet.prototype.detail = function(id) {
	this.detailIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '详细页',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Detail/' + id
	});
};
//控件校验   规则：表单字段name与rules对象保持一致
Servlet.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			name : {
				required: true,
				maxlength : 100
			},
			url : {
				required: true,
				maxlength : 500
			},
			requestMethod : {
				required: true,
				maxlength : 100
			},
		}
	});
}
//保存功能
Servlet.prototype.save = function(form, id,classId) {
	var _self = this;
	var formSerializeValue = form.serialize();
	//formSerializeValue = decodeURIComponent(formSerializeValue,true);//解决序列化时乱码
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
	avicAjax.ajax({
		url : _self.getUrl() + "save",
		data : {formDataJson:formDataJson,classId:classId},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad(classId);
				
				layer.msg('保存成功！');
			} else {
				layer.alert('保存失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
			}
		}
	});
};
//保存编辑
Servlet.prototype.saveEdit = function(form, id,classId) {
	var _self = this;
	var formSerializeValue = form.serialize();
	//formSerializeValue = decodeURIComponent(formSerializeValue,true);//解决序列化时乱码
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
	avicAjax.ajax({
		url : _self.getUrl() + "saveEdit",
		data : {formDataJson:formDataJson,classId:classId},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad(classId);
				
				layer.msg('保存成功！');
			} else {
				layer.alert('保存失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
			}
		}
	});
};
//删除
Servlet.prototype.del = function(classId) {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确定要删除该数据吗?', {
			icon : 2,
			title : "请确认：",
			area : [ '400px', '' ]
		}, function(index) {
			for (; l--;) {
				ids.push(rows[l]);
			}
			avicAjax.ajax({
				url : _self.getUrl() + 'delete',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						_self.reLoad(classId);
					} else {
						layer.alert('删除失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0
						});
					}
				}
			});
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的记录！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
	}
};
//重载数据
Servlet.prototype.reLoad = function(id) {
	if (id != undefined) {
		this._parentId = id;
	}
	var searchdata = {
		//param : JSON.stringify({classId:id})
		id : id
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
Servlet.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
Servlet.prototype.openSearchForm = function(searchDiv, par) {
	var _self = this;
	par = null;
	//if(!par) par = $(window);
	var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
	var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
	var text = $(searchDiv).text();  // 这里是this.test，就是按钮的文字
	var width = $(searchDiv).innerWidth();

	layer.config({
		extend : 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	layer.open({
		type : 1,
		shift : 5,
		title : false,
		scrollbar : false,
		move : false,
		area : [ contentWidth + 'px', '350px' ],
		offset : [ top + 'px', left + 'px' ],
		closeBtn : 0,
		shadeClose : true,
		btn : [ '查询', '清空', '取消' ],
		content : $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>' + text + '</span><span class="caret"></span></div>').appendTo(layero);
			serachLabel.bind('click', function() {
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
		},
		yes : function(index, layero) {
			_self.searchData();
			layer.close(index);
		},
		btn2 : function(index, layero) {
			_self.clearData();
			return false;
		},
		btn3 : function(index, layero) {}
	});
};
//高级查询
Servlet.prototype.searchData = function() {
	var searchdata = {
		id : this._parentId,
		keyWord : "",
		searchParam : JSON.stringify(serializeObject($(this.searchForm)))
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关键字段查询
Servlet.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for (var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}

	var searchdata = {
		keyWord : JSON.stringify(param),
		id : this._parentId
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
/*清空查询条件*/
Servlet.prototype.clearData = function() {
	clearFormData(this.searchForm);
	//this.searchData();
};


//测试
Servlet.prototype.testServlet = function(form) {
	var _self = this;
	var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
	avicAjax.ajax({
		url : _self.getUrl() + "testServlet",
		data : {formDataJson:formDataJson},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				layer.alert('调用成功！', {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
			} else {
				layer.alert('调用失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
			}
		}
	});
};