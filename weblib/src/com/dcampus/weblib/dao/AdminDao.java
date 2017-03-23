package com.dcampus.weblib.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dcampus.common.config.ResourceProperty;
import com.dcampus.common.exception.dao.DataCreationException;
import com.dcampus.common.exception.dao.DataNotFoundException;
import com.dcampus.common.exception.dao.DataUpdateException;
import com.dcampus.common.generic.GenericDao;
import com.dcampus.weblib.entity.Admin;



/**
 * AdminDao
 * 只是查询数据库，把其他的判断放到service层去判断
 * 
 * 之前的dao中包含太多if判断语句
 * 现在全部放到service层中去判断
 * 
 * @author patrick
 *
 */
@Repository
public class AdminDao {
	@Autowired
	GenericDao genericDao;
	
	/**
	 * 创建管理员项
	 * 
	 * @param admin
	 * @return
	 * @throws DataNotFoundException
	 * @throws DataCreationException
	 */
	public void createAdmin(Admin admin) throws DataNotFoundException,
			DataCreationException{
		genericDao.create(admin, "");
	}
	
	/**
	 * 删除管理员项
	 * 
	 * @param admin
	 * @return
	 * @throws DataNotFoundException
	 * @throws DataCreationException
	 */
	public void deleteAdmin(Admin admin) throws DataNotFoundException,
			DataCreationException{
		genericDao.delete(admin);
	}
	
	/**
	 * 根据memberId删除管理员
	 * 
	 * @param memberId
	 * @return
	 */
	public void deleteByMember(long memberId){
		Admin a = genericDao.findFirst("from Admin a where a.member_id = ?", memberId);
		deleteAdmin(a);
		
	}
	/**
	 * 批量删除管理员项
	 * 
	 * @param admins
	 * @return
	 */
	public void delete(List<Admin> admins){
		for (Admin a : admins){
			deleteAdmin(a);
		}
	}



	/**
	 * 更新管理员项
	 * 
	 * @param admin
	 * @throws DataNotFoundException
	 * @throws DataUpdateException
	 */
	public void updateAdmin(Admin admin) throws DataNotFoundException,
			DataUpdateException{
		genericDao.update(admin, ResourceProperty
				.getAlternateKeyAlreadyExistsString("Admin", "memberId",
						admin.getMember()));
	}

	/**
	 * 根据memberid查找管理员
	 * 
	 * @param memberId
	 * @return
	 * @throws DataNotFoundException
	 */
	public Admin getAdmin(long memberId) throws DataNotFoundException{
		Admin result =  genericDao.findFirst("from Admin a where a.member_id = ?", memberId);
		if (result == null)
			throw new DataNotFoundException(ResourceProperty
					.getAlternateKeyNotFoundString("Admin", "memberId",
							memberId));
		return result;
	}

	/**
	 * 获取某种类型的管理员信息
	 * 只是查询数据库，把其他的判断放到service层去判断
	 * 例如type为空时返回所有记录
	 * @param type
	 * @return
	 */
	public List<Admin> getAdminByType(int type){
		return genericDao.findAll("from Admin a where a.type = ?", type);
	}
	
	/**
	 * 获取某种类型的管理员数量
	 * 只是查询数据库，把其他的判断放到service层去判断
	 * 例如type为空时返回所有记录
	 * 查询出来的数据包括一个系统机器人
	 * 
	 * @param type
	 * @return
	 */
	public long countAdmin(int type){
		return genericDao.findFirst("seletc count(a) from Admin a where a.type = ?", type);
	}

}
