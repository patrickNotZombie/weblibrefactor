package com.dcampus.sys.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.dcampus.common.util.CacheUtils;
import com.dcampus.sys.entity.Dict;
import com.dcampus.sys.service.DictService;

/**
 * 字典工具类
 */
@Service
@Lazy(false)
public class DictUtils implements ApplicationContextAware {

	public static final String Cache_key_dictListMap = "dictListMap";
	
	private static DictService dictService;
	
	/**
	 * 根据代码值及代码类型获取代码标签
	 * @param value
	 * @param type
	 * @param defaultValue
	 * @return
	 */
	public static String getDictName(String type, String code, String defaultName){
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(code)){
			for (Dict dict : getDictList(type)){
				if (type.equals(dict.getType()) && code.equals(dict.getCode())){
					return dict.getName();
				}
			}
		}
		return defaultName;
	}
	
	/**
	 * 根据代码值及代码类型获取代码英文标签
	 * @param value
	 * @param type
	 * @param defaultValue
	 * @return
	 */
	public static String getDictNameEn(String type, String code, String defaultName){
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(code)){
			for (Dict dict : getDictList(type)){
				if (type.equals(dict.getType()) && code.equals(dict.getCode())){
					return dict.getNameEn();
				}
			}
		}
		return defaultName;
	}
	
	/**
	 * 根据代码标签及代码类型获取代码值
	 * @param value
	 * @param type
	 * @param defaultValue
	 * @return
	 */
	public static String getDictCode(String type, String name, String defaultCode){
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(name)){
			for (Dict dict : getDictList(type)){
				if (type.equals(dict.getType()) && name.equals(dict.getName())){
					return dict.getCode();
				}
			}
		}
		return defaultCode;
	}

	@SuppressWarnings("unchecked")
	public static List<Dict> getDictList(String type){
		Map<String, List<Dict>> dictListMap = (Map<String, List<Dict>>) CacheUtils.get(Cache_key_dictListMap);
		if (dictListMap == null) {
			dictListMap = new HashMap<String, List<Dict>>();
			List<Dict> allDictList = dictService.findAllList(Dict.Status_enabled);
			if (allDictList != null && !allDictList.isEmpty()) {
				for (Dict dict : allDictList){
					List<Dict> dictList = dictListMap.get(dict.getType());
					if (dictList == null) {
						dictList = new ArrayList<Dict>();
						dictListMap.put(dict.getType(), dictList);
					}
					dictList.add(dict);
				}
			}
			CacheUtils.put(Cache_key_dictListMap, dictListMap);
		}
		return dictListMap.get(type);
	}

	@SuppressWarnings("unchecked")
	public static List<String> getDictTypeList(){
		List<String> dictTypeList = dictService.findTypeList();
		dictTypeList = dictTypeList != null ? dictTypeList : new ArrayList<String>();
		return dictTypeList;
	}

	public static void removeCache() {
		CacheUtils.remove(Cache_key_dictListMap);
	}
	public static void removeCache(String key) {
		CacheUtils.remove(key);
	}
	
	public void setApplicationContext(ApplicationContext applicationContext){
		dictService = (DictService) applicationContext.getBean("dictService");
	}
}
