package com.dcampus.common.exception.dao;

import com.dcampus.common.config.ResourceProperty;
import com.dcampus.common.exception.GroupsException;

/**
 * 数据创建异常
 *
 * @author zim
 *
 */
public class DataCreationException extends GroupsException {
	private static final long serialVersionUID = -6474233724223249771L;

	public DataCreationException() {
		super(ResourceProperty.getDataCreationExceptionString());
	}

	public DataCreationException(String msg) {
		super(msg);
	}
}
