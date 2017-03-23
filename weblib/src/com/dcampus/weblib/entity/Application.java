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

import com.dcampus.common.persistence.BaseEntity;


/**
 * 应用类
 * 
 * @author patrick
 *
 */


@Entity
@Table(name = "weblib_application")
public class Application extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 应用名字* */
	@Column(length = 100)
	private String name;

	/** 应用描述* */
	@Column(name = "description", length = 500)
	private String desc;

	/** 创建者id，外键（Member主键id）* */
	@ManyToOne(optional = false)
	@JoinColumn(name = "creator_id")
	private Member member;

	/** 创建者名字，外键（Member候选键name字段）* */
	@Column(name = "creator_name")
	private String creatorName;

	/** 创建时间* */
	@Column(name = "create_date")
	private Timestamp createDate;
	
	/** 目录id，外键（Category主键id）* */
	@ManyToOne(optional = false)
	@JoinColumn(name = "category_id")
	private Category category;
	
	/** 应用总空间* */
	@Column(name = "total_space")
	private String totalSpace;
	
	/** 应用剩余可用空间* */
	@Column(name = "available_space")
	private String availableSpace;

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

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public String getTotalSpace() {
		return totalSpace;
	}

	public void setTotalSpace(String totalSpace) {
		this.totalSpace = totalSpace;
	}

	public String getAvailableSpace() {
		return availableSpace;
	}

	public void setAvailableSpace(String availableSpace) {
		this.availableSpace = availableSpace;
	}	
	
	


}
