package com.dcampus.sys.service;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dcampus.common.generic.GenericDao;
import com.dcampus.common.service.BaseService;
import com.dcampus.sys.dao.MessageDao;
import com.dcampus.sys.entity.Message;

/**
 * @author wfxu
 *
 */
@Service
@Transactional(readOnly=false)
public class MessageService extends BaseService {

	@Autowired
	private GenericDao genericDao;
	@Autowired
	private MessageDao messageDao;
	
	public void saveOrUpdateMessage(Message message) {
		if (message.getId() != null && message.getId() > 0) {
			genericDao.update(message);
		} else {
			genericDao.save(message);
		}
	}
	public void saveOrUpdateMessages(Collection<Message> collection) {
		for (Message item : collection) {
			saveOrUpdateMessage(item);
		}
	}
	public void deleteMessage(Message message) {
		genericDao.delete(message);
	}
	public void deleteMessages(Collection<Message> collection) {
		for (Message item : collection) {
			deleteMessage(item);
		}
	}
	
	/**
	 * 接受消息用户阅读用户消息，获取信息同时刷新消息阅读时间
	 * @param messageId
	 * @return
	 */
	public Message readMessage(Integer messageId, Integer userId, String username) {
		return messageDao.readMessage(messageId, userId, username);
	}
	/**
	 * 增加用户消息
	 * @param fromUserId
	 * @param fromUserAccount
	 * @param fromUserName
	 * @param toUserId
	 * @param toUserAccount
	 * @param toUserName
	 * @param title
	 * @param content
	 */
	public void addMessage(Integer fromUserId, String fromUserAccount, String fromUserName,
			Integer toUserId, String toUserAccount, String toUserName,
			String title, String content) {
		messageDao.addMessage(fromUserId, fromUserAccount, fromUserName,
				toUserId, toUserAccount, toUserName,
				title, content);
	}
}
