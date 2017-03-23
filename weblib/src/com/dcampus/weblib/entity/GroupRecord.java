package com.dcampus.weblib.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.dcampus.common.persistence.BaseEntity;


/**
 * 描述柜子的动态属性
 * 也就是一些操作的记录
 * 什么人在什么时间,在哪一范围对什么对象做了什么操作，结果如何
 * 
 * @author patrick
 *
 */

@Entity
@Table(name = "weblib_group_record")
public class GroupRecord extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
//	public static enum Position {
//		GLOBAL("global"), CATEGORY("category"), GROUP("group"), FORUM("forum");
//
//		private String name;
//
//		private Position(String name) {
//			this.name = name;
//		}
//
//		public String getName() {
//			return name;
//		}
//
//		public static Position transform(String name) {
//			if ("global".equalsIgnoreCase(name))
//				return GLOBAL;
//			else if ("category".equalsIgnoreCase(name))
//				return CATEGORY;
//			else if ("group".equalsIgnoreCase(name))
//				return GROUP;
//			else
//				return FORUM;
//		}
//	}
	
	/**描述动态产生位置，全局****/
	private static final String POSITION_GLOBAL = "global";
	/**描述动态产生位置，目录****/
	private static final String POSITION_CTEGORY = "category";
	/**描述动态产生位置，资源柜****/
	private static final String POSITION_GROUP = "group";
	/**描述动态产生位置，论坛****/
	private static final String POSITION_FORUM = "forum";

//	public static enum Action {
//		ADD("add"), UPDATE("update"), DELETE("delete"), SHARE("share");
//
//		private String name;
//
//		private Action(String name) {
//			this.name = name;
//		}
//
//		public String getName() {
//			return name;
//		}
//
//		public static Action transform(String name) {
//			if ("add".equalsIgnoreCase(name))
//				return ADD;
//			else if ("update".equalsIgnoreCase(name))
//				return UPDATE;
//			else if ("delete".equalsIgnoreCase(name))
//				return DELETE;
//			else
//				return SHARE;
//		}
//	}
	
	/**动态的操作类型，新增***/
	private static String ACTION_ADD = "add";
	/**动态的操作类型，更新***/
	private static String ACTION_UPDATE = "update";
	/**动态的操作类型，删除***/
	private static String ACTION_DELETE = "delete";
	/**动态的操作类型，分享***/
	private static String ACTION_SHARE = "share";
	

//	public static enum Type {
//		CATEGORY("category"), POST("post"), THREAD("thread"), FORUM("forum"), GROUP(
//				"group"), MEMBER("member"), RESOURCE("resource");
//
//		private String name;
//
//		private Type(String name) {
//			this.name = name;
//		}
//
//		public String getName() {
//			return name;
//		}
//
//		public static Type transform(String name) {
//			if ("category".equalsIgnoreCase(name))
//				return CATEGORY;
//			else if ("post".equalsIgnoreCase(name))
//				return POST;
//			else if ("thread".equalsIgnoreCase(name))
//				return THREAD;
//			else if ("forum".equalsIgnoreCase(name))
//				return FORUM;
//			else if ("group".equalsIgnoreCase(name))
//				return GROUP;
//			else if ("member".equalsIgnoreCase(name))
//				return MEMBER;
//			else
//				return RESOURCE;
//		}
//	}
	/**被操作对象类型描述，也是结果类型，分类目录**/
	private static String OBJECT_TYPE_CATEGORY = "category";
	/**被操作对象类型描述，也是结果类型，帖子**/
	private static String OBJECT_TYPE_POST = "post";
	/**被操作对象类型描述，也是结果类型，主题**/
	private static String OBJECT_TYPE_THREAD = "thread";
	/**被操作对象类型描述，也是结果类型，论坛**/
	private static String OBJECT_TYPE_FORUM = "forum";
	/**被操作对象类型描述，也是结果类型，文件柜**/
	private static String OBJECT_TYPE_GROUP = "group";
	/**被操作对象类型描述，也是结果类型，member**/
	private static String OBJECT_TYPE_MEMBER = "member";
	/**被操作对象类型描述，也是结果类型，资源**/
	private static String OBJECT_TYPE_RESOURCE = "resource";
	
	
	/** 动态id **/
	@Id  
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 动态发起人id，外键（Member主键id） **/
	@ManyToOne(optional = false)
	@JoinColumn(name = "member_id")
	private Member member;

	/** 动态发起人名字，外键（Member候选键name字段） **/
	@Column(name = "member_name", length=200)
	private String memberName;

	/** 动态产生地id，目前产生地可能为全局、分类、柜子和讨论区四种 **/
	@Column(name = "position_id")
	private Integer positionId;

	/** 动态产生地类型，供数据库使用 **/
	@Column(name="position_type")
	//@Enumerated(EnumType.STRING)
	private String recordPositionType;

	/** 动态产生时间 **/
	@Column(name = "create_date", length=0)
	private Timestamp createDate;

	/** 动态对象id，对象可能为分类、帖子、主题、讨论区、柜子、马甲、资源 **/
	@Column(name = "target_id")
	private Integer targetId;

	/** 动态对象类型，供数据库使用 **/
	@Column(name="target_type")
	//@Enumerated(EnumType.STRING)
	private String recordTargetType;

	/** 动态的产生动作，供数据库使用 **/
	@Column(name="`action`")
	//@Enumerated(EnumType.STRING)
	private String recordAction;

	/** 动态的描述 **/
	@Column(name = "action_desc")
	private String actionDesc;

	/** 动态结果id，与targetId类似，可能为分类、帖子、主题、讨论区、柜子、马甲、资源 **/
	@Column(name = "result_id")
	private Integer resultId;


	/** 动态结果类型，供数据库使用 **/
	@Column(name="result_type")
	//@Enumerated(EnumType.STRING)
	private String recordResultType;

	/** 动态结果描述 **/
	@Column(name = "result_desc")
	private String resultDesc;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public Integer getPositionId() {
		return positionId;
	}

	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}


	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public Integer getTargetId() {
		return targetId;
	}

	public void setTargetId(Integer targetId) {
		this.targetId = targetId;
	}


	public String getActionDesc() {
		return actionDesc;
	}

	public void setActionDesc(String actionDesc) {
		this.actionDesc = actionDesc;
	}

	public Integer getResultId() {
		return resultId;
	}

	public void setResultId(Integer resultId) {
		this.resultId = resultId;
	}


	public String getResultDesc() {
		return resultDesc;
	}

	public void setResultDesc(String resultDesc) {
		this.resultDesc = resultDesc;
	}

	public String getRecordPositionType() {
		return recordPositionType;
	}

	public void setRecordPositionType(String recordPositionType) {
		this.recordPositionType = recordPositionType;

	}

	public String getRecordTargetType() {
		return recordTargetType;
	}

	public void setRecordTargetType(String recordTargetType) {
		this.recordTargetType = recordTargetType;

	}

	public String getRecordAction() {
		return recordAction;
	}

	public void setRecordAction(String recordAction) {
		this.recordAction = recordAction;

	}

	public String getRecordResultType() {
		return recordResultType;
	}

	public void setRecordResultType(String recordResultType) {
		this.recordResultType = recordResultType;

	}

}
