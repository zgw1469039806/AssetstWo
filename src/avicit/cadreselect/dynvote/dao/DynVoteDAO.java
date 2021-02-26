package avicit.cadreselect.dynvote.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.cadreselect.dynvote.dto.DynVoteDTO;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 12:58
 * @类说明：DYN_VOTEDao
 * @修改记录： 
 */
@MyBatisRepository
public interface DynVoteDAO {

	/**
	* 分页查询
	* @param dynVoteDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynVoteDTO>
	*/
	public Page<DynVoteDTO> searchDynVoteByPage(@Param("bean") DynVoteDTO dynVoteDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynVoteDTO 查询对象
	* @return List<DynVoteDTO>
	*/
	public List<DynVoteDTO> searchDynVote(@Param("bean") DynVoteDTO dynVoteDTO);

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynVoteDTO
	 */
	public DynVoteDTO findDynVoteById(String id);

	/**
	* 新增
	* @param dynVoteDTO 保存对象
	* @return int
	*/
	public int insertDynVote(DynVoteDTO dynVoteDTO);

	/**
	 * 批量新增
	 * @param dynVoteDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynVoteList(List<DynVoteDTO> dynVoteDTOList);

	/**
	 * 部分更新
	 * @param dynVoteDTO 更新对象
	 * @return int
	 */
	public int updateDynVoteSensitive(DynVoteDTO dynVoteDTO);

	/**
	 * 全部更新
	 * @param dynVoteDTO 更新对象
	 * @return int
	 */
	public int updateDynVoteAll(DynVoteDTO dynVoteDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynVoteList(@Param("dtoList") List<DynVoteDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynVoteById(String id);

	/**
	 * 批量删除
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDynVoteList(List<String> idList);
}
