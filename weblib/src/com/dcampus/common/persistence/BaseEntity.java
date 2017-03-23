/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.dcampus.common.persistence;

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.persistence.MappedSuperclass;




/**
 * Entity支持类
 * @author ThinkGem
 * @version 2013-01-15
 */
@MappedSuperclass
public abstract class BaseEntity implements Serializable {

	public static final long serialVersionUID = 1L;

	/** 记录状态：普通状态*/
	public static final int STATUS_NORMAL = 1;
	/** 记录状态：关闭状态 */
	public static final int STATUS_CLOSE = 2;



	/** 最近更新时间 */
	private Date lastModified;
	
	

	

	public Date getLastModified() {
		return lastModified;
	}
	
	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}
	
}
