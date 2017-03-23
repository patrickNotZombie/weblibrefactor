package com.dcampus.weblib.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.dcampus.common.persistence.BaseEntity;

/**
 * 
 * @author Pretty
 * 
 */

@Entity
@Table(name="weblib_perm")
public class Perm extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	/** 权限作用域类型，可能为:全局、分类、柜子（独立的）、讨论区、分类下的柜子（继承于分类）、未知**/
//	public static enum Type {
//		UNKNOWN, GLOBAL, CATEGORY, GROUP, FORUM, GROUP_OF_CATEGORY;
//
//		public static Type transform(int ordinal) {
//			switch (ordinal) {
//			case 1:
//				return GLOBAL;
//			case 2:
//				return CATEGORY;
//			case 3:
//				return GROUP;
//			case 4:
//				return FORUM;
//			case 5:
//				return GROUP_OF_CATEGORY;	
//			default:
//				return UNKNOWN;
//			}
//		}
//	}
	
	/** 权限作用域类型，全局**/
	private static final int PERM_TYPE_GLOBAL = 1;
	/** 权限作用域类型，分类**/
	private static final int PERM_TYPE_CATEGORY = 2;
	/** 权限作用域类型，柜子（独立的）**/
	private static final int PERM_TYPE_GROUP = 3;
	/** 权限作用域类型，讨论区**/
	private static final int PERM_TYPE_FORUM = 4;
	/** 权限作用域类型，分类下的柜子（继承于分类）**/
	private static final int PERM_TYPE_GROUPORCATEGORY = 5;
	/** 权限作用域类型，未知**/
	private static final int PERM_TYPE_UNKNOWN = 0;

	
	/** 全局权限类型id **/
	public static final long GLOBAL_TYPE_ID = 0;

	/** 全局非会员用户id **/
	public static final long GLOBAL_NONMEMBER_ID = -1;

	/** 全局会员用户id **/
	public static final long GLOBAL_MEMBER_ID = 0;
	
	/**权限ID**/
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	
	/** 权限所作用的用户id，外键（Member主键id） **/
	@ManyToOne(optional = false)
	@JoinColumn(name="member_id")
	private Member member;
	
	/** 权限作用域类型id，可能为 全局、分类、柜子、讨论区 **/
	@Column(name="type_id")
	private Integer typeId;
	
	/** 权限码 **/
	@Column(name="perm_code")
	private Long permCode;
	
	/** 权限作用域类型，分为category和group **/
	@Column(name="perm_type")
//	@Enumerated(EnumType.ORDINAL)
	private int permType;
	
	/**
	 * 是否将此权限继承至子文件夹
	 */
	@Column(name = "inherit_to_child")
	private boolean inheritToChild = true;
	
    /**
     * 是否覆盖父文件夹继承下来的权限
     */
	@Column(name = "override_parent")
	private boolean overrideParent = true;
	
    /**
     * 标志是否是继承下来的
     */
	@Transient
	private boolean inherited = true;

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

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Long getPermCode() {
		return permCode;
	}

	public void setPermCode(Long permCode) {
		this.permCode = permCode;
	}

	public int getPermType() {
		return permType;
	}

	public void setPermType(int permType) {
		this.permType = permType;

	}

	public boolean isInherited() {
		return inherited;
	}

	public void setInherited(boolean inherited) {
		this.inherited = inherited;
	}

	public boolean isInheritToChild() {
		return inheritToChild;
	}

	public void setInheritToChild(boolean inheritToChild) {
		this.inheritToChild = inheritToChild;
	}

	public boolean isOverrideParent() {
		return overrideParent;
	}

	public void setOverrideParent(boolean overrideParent) {
		this.overrideParent = overrideParent;
	}

}
