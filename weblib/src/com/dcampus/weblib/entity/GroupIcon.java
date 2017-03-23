package com.dcampus.weblib.entity;

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

import com.dcampus.common.persistence.BaseEntity;


/**
 * 柜子图标类
 * @author patrick
 *
 */

@Entity
@Table(name = "weblib_group_icon")
public class GroupIcon extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
//	public static enum Sort {
//		ID("id"), SEQUENCE("sequence");
//		private String name;
//
//		private Sort(String name) {
//			this.name = name;
//		}
//
//		public String getName() {
//			return name;
//		}
//	}
	
	@Id  
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	/** 图标名称 */
	private String name;
	
	/** 文件名称 */
	@Column(name = "file_name")
	private String fileName;
	
	/** 描述 */
	@Column(name="icon_desc")
	private String description;
	
	/** 顺序号 */
	@Column(name="enable_flag")
	private int sequence;
	
	/** 使用状态 */
	private boolean enable = true;
	
	/**该图标对应的柜子的集合*/
	@OneToMany(mappedBy="groupIcon" ,cascade=CascadeType.REMOVE, fetch=FetchType. LAZY)
    private Set<Group> groups = new HashSet<Group>();

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

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getSequence() {
		return sequence;
	}

	public void setSequence(int sequence) {
		this.sequence = sequence;
	}

	public boolean isEnable() {
		return enable;
	}

	public void setEnable(boolean enable) {
		this.enable = enable;
	}

	public Set<Group> getGroups() {
		return groups;
	}

	public void setGroups(Set<Group> groups) {
		this.groups = groups;
	}


	
	

}
