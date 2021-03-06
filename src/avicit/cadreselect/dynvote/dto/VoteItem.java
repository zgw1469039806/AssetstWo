package avicit.cadreselect.dynvote.dto;

import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;

import javax.persistence.Id;

public class VoteItem {

    /**
     * 模板ITEM ID
     */
    private java.lang.String dynItId;//模板ITEM ID

    /**
     * 意见 0：未投票  -1：同意 -2：反对 -3：弃权 正数表示分数
     */
    private java.lang.String dynVoteOpinion;//意见 0：未投票  -1：同意 -2：反对 -3：弃权 正数表示分数

    /**
     * 标识
     */
    private java.lang.String dynVoteId;//标识

    /**
     * 主键
     */
    private java.lang.String id;//主键

    /**
     * 候选人姓名
     */
    private java.lang.String tiUserName;//候选人姓名

    /**
     * 候选人部门
     */
    private java.lang.String tiUserDept;//候选人部门

    /**
     * 0-女 1-男
     */
    private java.lang.Integer tiUserSex;// 0-女 1-男

    /**
     * 职务
     */
    private java.lang.String tiUserPost;//职务

    /**
     * 生日
     */
    private java.lang.String tiUserBirth;//生日

    private String temId;//投票轮次id

    private String dynVoteType;//0-候选人 1-推荐人


    //region get set

    public String getDynItId() {
        return dynItId;
    }

    public void setDynItId(String dynItId) {
        this.dynItId = dynItId;
    }

    public String getDynVoteOpinion() {
        return dynVoteOpinion;
    }

    public void setDynVoteOpinion(String dynVoteOpinion) {
        this.dynVoteOpinion = dynVoteOpinion;
    }

    public String getDynVoteId() {
        return dynVoteId;
    }

    public void setDynVoteId(String dynVoteId) {
        this.dynVoteId = dynVoteId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTiUserName() {
        return tiUserName;
    }

    public void setTiUserName(String tiUserName) {
        this.tiUserName = tiUserName;
    }

    public String getTiUserDept() {
        return tiUserDept;
    }

    public void setTiUserDept(String tiUserDept) {
        this.tiUserDept = tiUserDept;
    }

    public Integer getTiUserSex() {
        return tiUserSex;
    }

    public void setTiUserSex(Integer tiUserSex) {
        this.tiUserSex = tiUserSex;
    }

    public String getTiUserPost() {
        return tiUserPost;
    }

    public void setTiUserPost(String tiUserPost) {
        this.tiUserPost = tiUserPost;
    }

    public String getTiUserBirth() {
        return tiUserBirth;
    }

    public void setTiUserBirth(String tiUserBirth) {
        this.tiUserBirth = tiUserBirth;
    }

    public String getTemId() {
        return temId;
    }

    public void setTemId(String temId) {
        this.temId = temId;
    }

    public String getDynVoteType() {
        return dynVoteType;
    }

    public void setDynVoteType(String dynVoteType) {
        this.dynVoteType = dynVoteType;
    }
//endregion
}
