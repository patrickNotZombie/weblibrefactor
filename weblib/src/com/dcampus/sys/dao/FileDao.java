package com.dcampus.sys.dao;

import java.io.File;
import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.io.FileUtils;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dcampus.common.config.Global;
import com.dcampus.common.generic.GenericDao;
import com.dcampus.sys.entity.FileInfo;

/**
 * @author wfxu
 *
 */
@Repository
public class FileDao {

	@Autowired
	private GenericDao genericDao;
	
	/**
	 * 获取实体工厂管理对象
	 */
	@PersistenceContext
	private EntityManager entityManager;
	
	/**
	 * 获取 SESSION
	 */
	public Session getSession(){  
		return (Session) entityManager.getDelegate();
	}
	
	/**
	 * 增加文件记录
	 */
	public void saveFile(FileInfo fileInfo) {
		fileInfo.setCreateTime(new Date());
		entityManager.persist(fileInfo);
	}
	/**
	 * 删除文件记录，同时删除磁盘中的物理文件
	 */
	public void deleteFile(FileInfo fileInfo) {
		FileInfo fi = entityManager.find(FileInfo.class, fileInfo.getId());
		if (fi != null) {
			genericDao.delete(fi);
			File file = FileUtils.getFile(Global.getFileRootPath(), fileInfo.getFilePath());
			if (file.exists()) {
				file.delete();
			}
		}
	}
}
