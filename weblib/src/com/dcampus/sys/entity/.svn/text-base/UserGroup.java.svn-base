package com.dcampus.sys.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;

/**用户分组信息*/
@Entity
@Table(name="sys_use_group")
public class UserGroup extends BaseEntity{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
    @ManyToOne(cascade=CascadeType.REFRESH, optional=false)
    @JoinColumn(name="user_id")
	private User user;

    @ManyToOne(cascade=CascadeType.REFRESH, optional=false)
    @JoinColumn(name="group_id")
	private Group group;
    
	public UserGroup() {
	}
    public UserGroup(Integer id) {
    	this.id = id;
	}
    public UserGroup(User user, Group group) {
    	this.user = user;
    	this.group = group;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Group getGroup() {
		return group;
	}
	public void setGroup(Group group) {
		this.group = group;
	}
    
    
}
