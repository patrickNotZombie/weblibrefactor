package com.dcampus.common.exception;

import com.dcampus.common.config.ResourceProperty;

/**
 * 圈子基本异常
 *
 * @author zim
 *
 */
public class GroupsException extends RuntimeException {
	private static final long serialVersionUID = -7106936545583738491L;

	public GroupsException() {
		super(ResourceProperty.getGroupsExceptionString());
	}

	public GroupsException(String msg) {
		super(msg);
	}

	public GroupsException(Throwable e) {
		super(e);
	}
}
