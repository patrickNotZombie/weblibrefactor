package com.dcampus.sys.service;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dcampus.common.generic.GenericDao;
import com.dcampus.common.service.BaseService;
import com.dcampus.sys.entity.Dict;


/**
 * DictService  数据字典service
 */
@Service
@Transactional(readOnly=false)
public class DictService extends BaseService {

	@Autowired
	private GenericDao genericDao;
	
	public DictService() {
	}
	
	public List<Dict> findAllList() {
		return genericDao.findAll("from Dict where 1=1 order by type, code");
	}

	public List<Dict> findAllList(Integer status) {
		return genericDao.findAll("from Dict where status=? order by type, code", status);
	}

	public List<Dict> findList(String type) {
		return genericDao.findAll("from Dict where type=? order by code", type);
	}
	
	public List<String> findTypeList() {
		return genericDao.findAll("select type from Dict where 1=1 group by type");
	}
	
	public void saveDict(Dict dict) {
		genericDao.save(dict);
	}

	public void saveDicts(Collection<Dict> collection) {
		for (Dict item : collection) {
			saveDict(item);
		}
	}
	
	public void deleteDict(Dict dict) {
		Dict deleteOne = genericDao.get(Dict.class, dict.getId());
		genericDao.delete(deleteOne);
	}

	public void deleteDicts(Collection<Dict> collection) {
		for (Dict item : collection) {
			deleteDict(item);
		}
	}
	
	public Dict getDictById(Integer id) {
		return genericDao.get(Dict.class, id);
	}
}
