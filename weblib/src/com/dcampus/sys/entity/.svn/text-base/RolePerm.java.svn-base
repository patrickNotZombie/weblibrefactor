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


/**
 * 角色-操作权限
 */
@Entity
@Table(name="sys_role_perm")
public class RolePerm extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
    @ManyToOne(cascade=CascadeType.REFRESH, optional=false)
    @JoinColumn(name="perm_id")
	private Perm perm;

    @ManyToOne(cascade=CascadeType.REFRESH, optional=false)
    @JoinColumn(name="role_id")
	private Role role;
    
    public RolePerm() {
	}
    public RolePerm(Integer id) {
    	this.id = id;
	}
    public RolePerm(Role role, Perm perm) {
    	this.role = role;
    	this.perm = perm;
	}
    
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Perm getPerm() {
		return perm;
	}
	public void setPerm(Perm perm) {
		this.perm = perm;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
}
