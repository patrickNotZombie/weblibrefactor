package com.dcampus.weblib.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dcampus.common.config.ResourceProperty;
import com.dcampus.common.exception.dao.DataCreationException;
import com.dcampus.common.exception.dao.DataNotFoundException;
import com.dcampus.common.exception.dao.DataUpdateException;
import com.dcampus.common.generic.GenericDao;
import com.dcampus.common.util.MD5;
import com.dcampus.weblib.entity.UserBase;

/**
 * 
 * 所有与搜索查询有关的接口均未实现
 * 
 * 要对密码先进行MD5之后再存入
 * 
 * @author patrick
 *
 */

@Repository
public class UserBaseDao {
	
	@Autowired
	GenericDao genericDao;

	/**
	 * 创建用户,直接保存到数据库
	 * 
	 * 要对密码先进行MD5之后再存入
	 *
	 * @param userBase
	 * @return
	 * @throws DataCreationException
	 */
	public void createUserBase(UserBase userBase) throws DataCreationException{
		genericDao.create(userBase,ResourceProperty
				.getAlternateKeyAlreadyExistsString("UserBase", "account", userBase
						.getAccount()));
	}

	/**
	 * 更新用户
	 *
	 * @param userBase
	 * @throws DataUpdateException
	 */
	public void updateUserBase(UserBase userBase) throws DataUpdateException{
		genericDao.update(userBase, ResourceProperty
				.getAlternateKeyAlreadyExistsString("UserBase", "account", userBase
						.getAccount()));
	}
	
	/**
	 * 根据id获取帐号
	 *
	 * @param status
	 * @return
	 */
	public UserBase getUserBase(UserBase userBase) throws DataNotFoundException{
		return genericDao.get(UserBase.class, userBase.getId());
	}
	
	/**
	 * 根据account获取用户用户信息
	 *
	 * @param account
	 * @return
	 * @throws DataNotFoundException
	 */
	public UserBase getUserBase(String account) throws DataNotFoundException{
		return genericDao.findFirst("from UserBase u where u.account =  ?", account);
		
	}

	/**
	 * 删除用户
	 *
	 * @param account
	 */
	public void deleteUserBase(String account){
		UserBase t = getUserBase(account);
		genericDao.delete(t);
	}

	/**
	 * 获取所有帐号列表
	 * 
	 *
	 * @param status
	 * @param start
	 * @param limit
	 * @return
	 */
	public List<UserBase> getUserBases(String status, int start,
			int limit){
		return genericDao.findAll(start, limit, "from UserBase u where u.status = ?", status);
		
	}

	/**
	 * 获取用户总数
	 *
	 * @param status
	 * @return
	 */
	public long getNumberOfUserBases(String status){
		return  genericDao.findFirst("select count(u) from UserBase u where u.status = ?", status);
		
	}

	/**
	 * 检查帐户密码是否正确
	 * 简单的本地账号密码的验证
	 * 
	 * 没有Ladp的认证，把LADP验证放到service层或者action中进行判断
	 *
	 * @param account
	 * @param password
	 * @return boolean
	 * @throws DataNotFoundException
	 */
	public boolean checkAccount(String account, String password)
			throws DataNotFoundException{
		if (account == null || password == null || account.trim().length() == 0
				|| password.trim().length() == 0)
			throw new DataNotFoundException("用户帐户名或者密码为空");
		UserBase userBase = null;
		try {
			userBase = getUserBase(account);
		} catch(Exception e){
		}
		// 密码哈希
		String encryptionPassword = MD5.hash(password);
		//返回验证结果
		return encryptionPassword.equals(userBase.getPassword());

		
	}
	
	
	/**
	 * 更改帐户密码
	 * 
	 *在操作之前应该先对原密码进行检验
	 * 
	 * @param account
	 * @param password
	 * @throws DataUpdateException
	 */
	public void updatePassword(String account, String password)
			throws DataUpdateException{
		UserBase userBase = getUserBase(account);
		userBase.setPassword(MD5.hash(password));
		updateUserBase(userBase);
	}
	


//	/**
//	 * 根据查询条件获得总数
//	 * @param searchTerm
//	 * @return
//	 * @throws Exception
//	 */
//	public int getMatchCount(SearchTerm searchTerm) throws Exception{
//		
//	}
//	/**
//	 * 根据查询条件、排序获得用户帐户数组
//	 * @param searchTerm
//	 * @param sortTerm
//	 * @param pageTerm
//	 * @return
//	 * @throws Exception
//	 */
//	public IUserBaseBean[] getMatchContent(SearchTerm searchTerm,
//			SortTerm sortTerm, PageTerm pageTerm) throws Exception{
//		
//	}

	


}
