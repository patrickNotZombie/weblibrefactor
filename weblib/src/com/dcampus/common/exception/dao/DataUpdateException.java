package com.dcampus.common.exception.dao;

import com.dcampus.common.config.ResourceProperty;
import com.dcampus.common.exception.GroupsException;

/**
 * 数据更新异常
 *
 * @author zim
 *
 */
public class DataUpdateException extends GroupsException {
	private static final long serialVersionUID = -1563460892275183144L;

	public DataUpdateException() {
		super(ResourceProperty.getDataUpdateExceptionString());
	}

	public DataUpdateException(String msg) {
		super(msg);
	}
}
