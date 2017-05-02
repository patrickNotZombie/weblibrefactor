package com.dcampus.sys.security;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import com.dcampus.sys.entity.User;

/**
 * 授权用户信息，权限模块中登录用户信息封装
 */
public class Principal implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String username;
	private String name;
	private Map<String, Object> cacheMap;

	public Principal(User user) {
		this.id = user.getId();
		this.username = user.getUsername();
		this.name = user.getName();
	}

	public Principal(Integer id, String username, String name) {
		this.id = id;
		this.username = username;
		this.name = name;
	}
	
	public Integer getId() {
		return id;
	}
	public String getUsername() {
		return username;
	}
	public String getName() {
		return name;
	}
	public Map<String, Object> getCacheMap() {
		if (cacheMap==null){
			cacheMap = new HashMap<String, Object>();
		}
		return cacheMap;
	}
}
