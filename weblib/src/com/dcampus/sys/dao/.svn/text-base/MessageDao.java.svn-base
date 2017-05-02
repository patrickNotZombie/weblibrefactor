package com.dcampus.sys.dao;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dcampus.common.generic.GenericDao;
import com.dcampus.sys.entity.Message;

@Repository
public class MessageDao {

	@Autowired
	private GenericDao genericDao;
	
	public void addMessage(Integer fromUserId, String fromUserAccount, String fromUserName,
			Integer toUserId, String toUserAccount, String toUserName,
			String title, String content) {
		Message message = new Message();
		message.setFromUserId(fromUserId);
		message.setFromUserAccount(fromUserAccount);
		message.setFromUserName(fromUserName);
		message.setToUserId(toUserId);
		message.setToUserAccount(toUserAccount);
		message.setToUserName(toUserName);
		message.setTitle(title);
		message.setContent(content);
		message.setCreateTime(new Date());
		genericDao.save(message);
	}
	
	/**
	 * 接受消息的用户阅读消息
	 * @param messageId
	 * @param userId
	 * @param username
	 * @return
	 */
	public Message readMessage(Integer messageId, Integer userId, String username) {
		Message message = genericDao.get(Message.class, messageId);
		if (message == null) {
			return null;
		}
		//检查阅读账户是否有权限查看消息
		if ((message.getToUserId() != null && userId != null && userId > 0 && message.getToUserId() == userId.intValue())
				|| (message.getToUserAccount() != null && username != null && username.length() > 0 && message.getToUserAccount().equals(username))) {
			if (message.getReadTime() == null) {
				message.setReadTime(new Date());
				genericDao.update(message);
			}
			return message;
		}
		return null;
	}
}
