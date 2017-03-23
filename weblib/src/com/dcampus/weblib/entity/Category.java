package com.dcampus.weblib.entity;

import java.sql.Timestamp;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.dcampus.common.persistence.BaseEntity;


/**
 * category分类对应的是存储管理中的文件柜所在目录
 * 
 * 现在父分类为空时表示根目录，之前采取的方案时为0时表示根目录
 * 
 *添加path分类路径
 * 
 * @author patrick
 *
 */

@Entity
@Table(name = "weblib_category")
public class Category extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	
	/**分类id*/
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	
	/**父分类,为空时表示根目录*/
	@ManyToOne
	@JoinColumn(name = "parent_id")
	private Category parent;
	 
	/**添加分类路径**/
	private String path;

	/** 分类名字 **/
	@Column(length=100)
	private String name;
	
	/** 分类显示名称 */
	@Column(name = "display_name", length=100)
	private String displayName;

	/** 分类描述 **/
	@Column(name="description",length=500)
	private String desc;

	/** 分类创建时间 **/
	@Column(name = "create_date")
	private Timestamp createDate;

	/** 分类状态，供数据库使用 **/
	@Column(name="`status`")
	private int categoryStatus;
	
	/** 排列序号 **/
	@Column(name="order_no")
	private double order;
	
	/**该目录分类下的应用集合*/
	@OneToMany(mappedBy="category" ,cascade=CascadeType.REMOVE, fetch=FetchType. LAZY)
    private Set<Application> applications = new HashSet<Application>();
	
	/**该目录分类下的子分类集合*/
	@OneToMany(mappedBy="parent" ,cascade=CascadeType.REMOVE, fetch=FetchType. LAZY)
    private Set<Category> childs = new HashSet<Category>();
	
	/**该目录分类下的子柜子集合*/
	@OneToMany(mappedBy="category" ,cascade=CascadeType.REMOVE, fetch=FetchType. LAZY)
    private Set<Group> groups = new HashSet<Group>();

	/**该目录分类下的子柜子集合*/
	@OneToMany(mappedBy="category" ,cascade=CascadeType.REMOVE, fetch=FetchType. LAZY)
    private Set<GroupResource> groupResources = new HashSet<GroupResource>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Category getParent() {
		return parent;
	}

	public void setParent(Category parent) {
		this.parent = parent;
	}

	public Set<Category> getChilds() {
		return childs;
	}

	public void setChilds(Set<Category> childs) {
		this.childs = childs;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}


	/******************************************************/
	public int getCategoryStatus() {
		return categoryStatus;
	}

	public void setCategoryStatus(int status) {
		categoryStatus = status;
	}

	public double getOrder() {
		return order;
	}

	public void setOrder(double order) {
		this.order = order;
	}
	
	public static final Comparator<Category> COMPARE_SORT_ORDER = new Comparator<Category>() {
        public int compare(Category r1, Category r2) {
        	double order1 = r1.getOrder();
        	double order2 = r2.getOrder();
            if (order1 == order2) {
            	return r1.getId() > r2.getId() ? 1 : -1; 
            }
            return (order1 < order2) ? -1 : 1;
        }
    };


	public Set<Application> getApplications() {
		return applications;
	}

	public void setApplications(Set<Application> applications) {
		this.applications = applications;
	}

	public Set<Group> getGroups() {
		return groups;
	}

	public void setGroups(Set<Group> groups) {
		this.groups = groups;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Set<GroupResource> getGroupResources() {
		return groupResources;
	}

	public void setGroupResources(Set<GroupResource> groupResources) {
		this.groupResources = groupResources;
	}
	
	
	
	

	

}
