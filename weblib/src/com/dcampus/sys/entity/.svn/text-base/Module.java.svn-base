package com.dcampus.sys.entity;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;

/**
 * 业务模块定义
 * @author wfxu
 *
 */
@Entity
@Table(name="sys_module")
public class Module extends BaseEntity {

	private static final long serialVersionUID = 1L;

	/** 模块类别：固定模块 */
	public static final int Type_basic = 0;
	/** 模块类别：自定义模块 */
	public static final int Type_custom = 9;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 模块识别关键字 */
	@Column(name="keyword")
	private String key;

	/** 模块名称 */
	private String name;
	
	/** 模块类别 */
	private Integer type = Type_basic;
	
	public Module() {
	}

	public Module(Integer id) {
		this.id = id;
	}
	
	public static Map<Integer, String> getModuleTypeMap() {
		Map<Integer, String> resultMap = new LinkedHashMap<Integer, String>();
		resultMap.put(Type_basic, "固定模块");
		resultMap.put(Type_custom, "自定义模块");
		return resultMap;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}
