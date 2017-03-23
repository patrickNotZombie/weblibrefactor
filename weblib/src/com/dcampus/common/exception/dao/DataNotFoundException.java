package com.dcampus.common.exception.dao;

import com.dcampus.common.config.ResourceProperty;
import com.dcampus.common.exception.GroupsException;

/**
 * 相关数据不存在异常
 *
 * @author zim
 *
 */
public class DataNotFoundException extends GroupsException {
	private static final long serialVersionUID = -6115368696516963384L;

	public DataNotFoundException() {
		super(ResourceProperty.getDataNotFoundExceptionString());
	}

	public DataNotFoundException(String msg) {
		super(msg);
	}
}
