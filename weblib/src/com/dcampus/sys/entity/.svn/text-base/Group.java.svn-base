package com.dcampus.sys.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.validator.constraints.Length;

import com.dcampus.common.persistence.BaseEntity;
import com.dcampus.lms.lms.entity.CourseOpen;

/** 用户分组信息 */
@Entity
@Table(name="sys_group")
public class Group extends BaseEntity{
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	@Column(unique=true)
	@Length(min=1, max=100)
	private String name;
	
	@Length(min=1,max=400)
	private String remark;
	
	public Group() {
	}
	public Group(Integer id) {
		this.id = id;
	}
	
	/** 组内的用户*/
	@OneToMany(mappedBy="group", cascade=CascadeType.REMOVE, fetch=FetchType.LAZY)
	private Set<UserGroup> userGroups = new HashSet<UserGroup>();
	
	/**课程公开，限定组内的用户**/
	@OneToMany(mappedBy="group", cascade=CascadeType.REMOVE, fetch=FetchType.LAZY)
	private Set<CourseOpen> courseOpens = new HashSet<CourseOpen>();
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Set<UserGroup> getUserGroups() {
		return userGroups;
	}
	public void setUserGroups(Set<UserGroup> userGroups) {
		this.userGroups = userGroups;
	}
	public Set<CourseOpen> getCourseOpens() {
		return courseOpens;
	}
	public void setCourseOpens(Set<CourseOpen> courseOpens) {
		this.courseOpens = courseOpens;
	}
}
