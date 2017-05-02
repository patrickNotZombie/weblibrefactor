package com.dcampus.sys.entity;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.dcampus.common.persistence.BaseEntity;

/**
 * 字典Entity
 * @author wfxu
 */
@Entity
@Table(name = "sys_dict")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Dict extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/** 所属编码标准：国标编码 */
	public static final int Standard_country = 1;
	/** 所属编码标准：行标编码 */
	public static final int Standard_industry = 2;
	/** 所属编码标准：系统自定编码 */
	public static final int Standard_custom = 9;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 代码值 */
	private String code;

	/** 代码标签 */
	private String name;

	/** 代码标签(英文) */
	@Column(name="label_en")
	private String nameEn;
	
	/** 代码类别 */
	private String type;
	
	/** 所属编码标准 */
	private Integer standard = Standard_country;
	
	/** 代码说明 */
	private String desciption;
	
	/** 排序号 */
	private String sequence;
	
	public Dict() {
	}
	public Dict(Integer id) {
		this.id = id;
	}
	
	public static Map<Integer, String> getStandardMap() {
		Map<Integer, String> resultMap = new LinkedHashMap<Integer, String>();
		resultMap.put(Standard_country, "国标编码");
		resultMap.put(Standard_industry, "行标编码");
		resultMap.put(Standard_custom, "系统自定编码");
		return resultMap;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNameEn() {
		return nameEn;
	}
	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}
	public String getSequence() {
		return sequence;
	}
	public void setSequence(String sequence) {
		this.sequence = sequence;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDesciption() {
		return desciption;
	}
	public void setDesciption(String desciption) {
		this.desciption = desciption;
	}
	public Integer getStandard() {
		return standard;
	}
	public void setStandard(Integer standard) {
		this.standard = standard;
	}
}