package avicit.assets.device.assetsdeviceacheckproc.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import avicit.platform6.api.sysautocode.SysAutoCodeAPI;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;
import avicit.platform6.bpmreform.bpmbusiness.service.BusinessService;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetsdeviceacheckproc.dao.AssetsDeviceAcheckProcDao;
import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckProcDTO;

import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckPlanDTO;

import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 17:30
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceAcheckProcService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceAcheckProcService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceAcheckProcDao assetsDeviceAcheckProcDao;
	@Autowired
	private AssetsDeviceAcheckPlanService assetsDeviceAcheckPlanServiceSub;

	@Autowired
	private BpmOperateService bpmOperateService;

	@Autowired
	private BusinessService businessService;

	@Autowired
	private SysAutoCodeAPI sysAutoCodeAPI;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceAcheckProcDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceAcheckProcDTO> searchAssetsDeviceAcheckProcByPage(
			QueryReqBean<AssetsDeviceAcheckProcDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAcheckProcDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAcheckProcDTO> dataList = assetsDeviceAcheckProcDao
					.searchAssetsDeviceAcheckProcByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceAcheckProcDTO> queryRespBean = new QueryRespBean<AssetsDeviceAcheckProcDTO>();
			for (AssetsDeviceAcheckProcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAcheckProcByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceAcheckProcDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceAcheckProcDTO> searchAssetsDeviceAcheckProcByPageOr(
			QueryReqBean<AssetsDeviceAcheckProcDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAcheckProcDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAcheckProcDTO> dataList = assetsDeviceAcheckProcDao
					.searchAssetsDeviceAcheckProcByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceAcheckProcDTO> queryRespBean = new QueryRespBean<AssetsDeviceAcheckProcDTO>();
			for (AssetsDeviceAcheckProcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAcheckProcByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 流程的编码转换成名称
	* @param stateCode 编码
	* @return String
	*/
	private String processStateCode2StateName(String stateCode) {
		String stateName = "";
		if (stateCode != null && "active".equals(stateCode)) {
			stateName = "流转中";
		} else if (stateCode != null && "ended".equals(stateCode)) {
			stateName = "结束";
		} else if (stateCode != null && "start".equals(stateCode)) {
			stateName = "草稿";
		}
		return stateName;
	}

	/**
	 * 按条件查询
	 * @param queryReqBean 条件
	 * @return List<AssetsDeviceAcheckProcDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceAcheckProcDTO> searchAssetsDeviceAcheckProc(
			QueryReqBean<AssetsDeviceAcheckProcDTO> queryReqBean) throws Exception {
		try {
			AssetsDeviceAcheckProcDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsDeviceAcheckProcDTO> dataList = assetsDeviceAcheckProcDao
					.searchAssetsDeviceAcheckProc(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAcheckProc出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceAcheckProcDTO
	 * @throws Exception
	 */
	public AssetsDeviceAcheckProcDTO queryAssetsDeviceAcheckProcByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceAcheckProcDTO dto = assetsDeviceAcheckProcDao.findAssetsDeviceAcheckProcById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsDeviceAcheckProcByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsDeviceAcheckProc(AssetsDeviceAcheckProcDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//给预约编号赋值
			Map<String,String> map = sysAutoCodeAPI.generateAutoCodeValue("","ACC_CHECK_CODE",dto.getAutoCodeValue(),dto.getId(), false);
			if (map.get("result").equals("success")){
				dto.setAcheckCode(map.get("autoCodeValue"));
			}

			assetsDeviceAcheckProcDao.insertAssetsDeviceAcheckProc(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceAcheckProc出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceAcheckProcList(List<AssetsDeviceAcheckProcDTO> dtoList) throws Exception {
		List<AssetsDeviceAcheckProcDTO> beanList = new ArrayList<AssetsDeviceAcheckProcDTO>();
		for (AssetsDeviceAcheckProcDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsDeviceAcheckProcDao.insertAssetsDeviceAcheckProcList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceAcheckProcList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAcheckProc(AssetsDeviceAcheckProcDTO dto) throws Exception {
		//记录日志
		AssetsDeviceAcheckProcDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = assetsDeviceAcheckProcDao.updateAssetsDeviceAcheckProcAll(old);
		if (count == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return count;

	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAcheckProcSensitive(AssetsDeviceAcheckProcDTO dto) throws Exception {
		//记录日志
		AssetsDeviceAcheckProcDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = assetsDeviceAcheckProcDao.updateAssetsDeviceAcheckProcSensitive(old);
		if (count == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return count;

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAcheckProcList(List<AssetsDeviceAcheckProcDTO> dtoList) throws Exception {
		try {
			return assetsDeviceAcheckProcDao.updateAssetsDeviceAcheckProcList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceAcheckProcList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckProcById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceAcheckProcDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			//删除子表
			for (AssetsDeviceAcheckPlanDTO sub : assetsDeviceAcheckPlanServiceSub
					.queryAssetsDeviceAcheckPlanByPid(obje.getId())) {
				assetsDeviceAcheckPlanServiceSub.deleteAssetsDeviceAcheckPlan(sub);
			}
			//删除主表
			return assetsDeviceAcheckProcDao.deleteAssetsDeviceAcheckProcById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceAcheckProcById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckProcByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceAcheckProcById(id);
			result++;
		}
		return result;
	}

	/**
	 * 批量删除数据2
	 * @param idList 主键集合
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckProcList(List<String> idList) throws Exception {
		try {
			return assetsDeviceAcheckProcDao.deleteAssetsDeviceAcheckProcList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceAcheckProcList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceAcheckProcDTO
	 * @throws Exception
	 */
	private AssetsDeviceAcheckProcDTO findById(String id) throws Exception {
		try {
			AssetsDeviceAcheckProcDTO dto = assetsDeviceAcheckProcDao.findAssetsDeviceAcheckProcById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 保存表单并启动流程
	 * @param bean 表单对象
	 * @param parameter 启动流程所需要的参数
	 * @return StartResultBean
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public StartResultBean insertAssetsDeviceAcheckProcAndStartProcess(AssetsDeviceAcheckProcDTO bean,
			List<AssetsDeviceAcheckPlanDTO> beanSub, Map<String, Object> parameter) throws Exception {
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String) parameter.get("processDefId");
		String formCode = (String) parameter.get("formCode");
		String jsonString = (String) parameter.get("jsonString");
		String userId = (String) parameter.get("userId");
		String deptId = (String) parameter.get("deptId");
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		bean.setGenerateBy(userId);
		//主表业务操作
		this.insertAssetsDeviceAcheckProc(bean);
		//子表业务操作
		assetsDeviceAcheckPlanServiceSub.insertOrUpdateAssetsDeviceAcheckPlan(beanSub, bean.getId());
		Map<String, Object> variables = new HashMap<String, Object>();
		//web表单传递过来(除表单对象外)的变量，可以为空
		if (jsonString != null && !"".equals(jsonString)) {
			Map<String, Object> extVariables = JsonUtil.parseJSON2Map((String) jsonString);
			variables.putAll(extVariables);
		}
		//把表单对象转换成map,传递给流程变量
		Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
		variables.putAll(pojoMap);
		String processInstanceId = bpmOperateService.startProcessInstanceById(processDefId, formCode, userId, deptId,
				variables);
		// 返回对象
		return businessService.getStartResultBean(processInstanceId, bean.getId(), userId);
	}

}
