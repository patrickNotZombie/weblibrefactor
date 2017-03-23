package com.dcampus.weblib.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dcampus.common.config.ResourceProperty;
import com.dcampus.common.exception.dao.DataCreationException;
import com.dcampus.common.exception.dao.DataNotFoundException;
import com.dcampus.common.exception.dao.DataUpdateException;
import com.dcampus.common.generic.GenericDao;
import com.dcampus.weblib.entity.GroupMemberBinding;
import com.dcampus.weblib.entity.Member;



@Repository
public class MemberDao {
	
	@Autowired
	GenericDao genericDao;
	
	/**
	 * 创建member
	 *
	 * @param member
	 * @return
	 * @throws DataCreationException
	 */
	public void createMember(Member member) throws DataCreationException{
		genericDao.create(member, ResourceProperty
				.getAlternateKeyAlreadyExistsString("Member",
						"name, account", member.getName()
								+ ", "
								+ member.getAccount()));
	}

	/**
	 * 删除member
	 *
	 * @param member
	 */
	public void deleteMember(Member member){
		genericDao.delete(member);
	}
	
	/**
	 * 批量删除member
	 *
	 * @param List<Member> members
	 */
	public void deleteMembers(List<Member> members){
		for(Member item : members)
		deleteMember(item);
	}

	/**
	 * 更新member
	 *
	 * @param member
	 * @throws DataUpdateException
	 */
	public void updateMember(Member member) throws DataUpdateException{
		genericDao.update(member,  ResourceProperty
				.getAlternateKeyAlreadyExistsString("Member",
						"name, account", member.getName()
								+ ", "
								+ member.getAccount()));
	}

	/**
	 * 检查member帐户密码是否正确
	 * 
	 * 移动到userBaseDao进行检查，此处已废弃
	 *
	 * @param account
	 * @param password
	 * @throws DataNotFoundException
	 */
	public void checkAccount(String account, String password)
			throws DataNotFoundException{
		
	}

	/**
	 * 根据id获取member信息
	 *
	 * @param id
	 * @return Member
	 * @throws DataNotFoundException
	 */
	public Member getMemberById(long id) throws DataNotFoundException{
		return genericDao.get(Member.class, id);
	}

	/**
	 * 根据member名字和账号获取member信息
	 *
	 * @param name
	 * @param account
	 * @param type
	 * @return Member
	 * @throws DataNotFoundException
	 */
	public Member getMemberByNameAccount(String name, String account, String type)
			throws DataNotFoundException{
		return genericDao.findFirst("from Member m where m.name = ? and m.account = ? and m.type = ?", name, account, type);
	}

	/**
	 * 根据姓名查找member
	 *
	 * @param name
	 * @return List<Member> members
	 * @throws DataNotFoundException
	 */
	public List<Member> getMembersByName(String name) throws DataNotFoundException{
		return genericDao.findAll("from Member m where m.name = ? order by m.create_date desc", name);
	}

	/**
	 * 根据member帐号获取member列表，如果在本地数据库中能查找到，则返回查找到的数据，否则从provider中获取
	 * 
	 * 现在只是从本地数据库查找,未加入provider
	 *
	 * @param account
	 * @return members
	 * @throws DataNotFoundException
	 */
	public List<Member> getMembersByAccount(String account)
			throws DataNotFoundException{
		return genericDao.findAll("from Member m where m.account = ? order by m.create_date desc", account);
	}

	/**
	 * 根据member帐户获取马甲列表，而不是先在柜子数据库中查找
	 * 
	 * 已弃用，没有马甲
	 *
	 * @param account
	 * @return members
	 */
	public List<Member> getRowMembers(String account){
		return null;
	}
	
	/**
	 * 获取所有member列表
	 *
	 * @param start
	 * @param limit
	 * @return
	 */
	public List<Member> getAllMembers(int start, int limit){
		return genericDao.findAll(start, limit, "from Member m where 1 = 1 order by m.create_dte");
	}

	/**
	 * 获取所有member总数
	 *
	 * @return
	 */
	public long getNumberOfAllMembers(){
		return genericDao.findFirst("select count(m) from Member m");
	}

	/**
	 * 查找member是否在某个柜子中
	 *
	 * @param memberId
	 * @param groupId
	 * @return
	 * @throws DataNotFoundException
	 * @throws DataAccessException
	 */
	public boolean findMemberInGroup(long memberId, long groupId)
			throws DataNotFoundException{
		GroupMemberBinding gmb = genericDao.findFirst("from GroupMemberBinding g where g.group_id = ?"
			+"and g.member_id = ?", groupId, memberId);
		if (gmb == null)
			throw new DataNotFoundException(ResourceProperty
					.getAlternateKeyNotFoundString(
							"GroupMemberBinding", "memberId, groupId",
							memberId + ", " + groupId)); 
		return gmb.getStatus() == GroupMemberBinding.STATUS_PASS;
	}

	/**
	 * 绑定member到柜子中
	 *
	 * @param memberId
	 * @param groupId
	 * @param bind
	 * @throws DataNotFoundException
	 * @throws DataCreationException
	 * @throws DataAccessException
	 */
	public void createMemberGroupBinding(int memberId, int groupId, boolean bind)
			throws DataNotFoundException, DataCreationException{
		GroupMemberBinding gmb = new GroupMemberBinding();
		gmb.setGroupId(groupId);
		gmb.setMemberId(memberId);
		gmb.setStatus(bind ? GroupMemberBinding.STATUS_PASS : GroupMemberBinding.STATUS_REQUEST);
		genericDao.create(gmb, ResourceProperty
				.getAlternateKeyAlreadyExistsString(
						"GroupMemberBinding", "memberId, groupId",
						memberId + ", " + groupId));
	}

	/**
	 * 将member从柜子中移除
	 *
	 * @param gmb
	 * @throws DataNotFoundException
	 */
	public void deleteMemberGroupBinding(long memberId,  long groupId)
			throws DataNotFoundException{
		GroupMemberBinding gmb = genericDao.findFirst("from GroupMemberBinding gmb where gmb.member_id = ?"
			+"and gmb.group_id =?", memberId,groupId);
		genericDao.delete(gmb);
	}

	/**
	 * 获取柜子中的所有member列表，包含会员和请求member
	 *
	 * @param groupId
	 * @param start
	 * @param limit
	 * @return 
	 * @throws DataNotFoundException
	 */
	public List<Member> getAllMembersInGroup(long groupId, int start, int limit){
		return genericDao.findAll(start, limit, "select m from Member m, GroupMemberBinding gmb where m.member_id = gmb.member_id "
				+"and gmb.group_id = ?", groupId);
	}

	/**
	 * 获取柜子所有member数量，包括会员和申请者
	 *
	 * @param groupId
	 * @return
	 */
	public long getNumberOfAllMembersInGroup(long groupId){
		return genericDao.findFirst("select count(m) from Member m, GroupMemberBinding gmb where m.member_id = gmb.member_id "
				+"and gmb.group_id = ?", groupId);
	}

	/**
	 * 获取柜子中的会员列表，不包含请求member
	 *
	 * @param groupId
	 * @param start
	 * @param limit
	 * @return
	 * @throws DataNotFoundException
	 */
	public List<Member> getMembersInGroup(long groupId, int start, int limit){
		return genericDao.findAll(start, limit, "select m from Member m, GroupMemberBinding gmb where m.member_id = gmb.member_id "
				+"and gmb.group_id = ? and gmb.status = ?", groupId, GroupMemberBinding.STATUS_PASS);
	}

	/**
	 * 获取柜子会员总数
	 *
	 * @param groupId
	 * @return
	 */
	public long getNumberOfMembersInGroup(long groupId){
		return genericDao.findFirst("select count(m) from Member m, GroupMemberBinding gmb where m.member_id = gmb.member_id "
				+"and gmb.group_id = ? and gmb.status = ?", groupId, GroupMemberBinding.STATUS_PASS);
	}

	/**
	 * 获取柜子中请求member列表
	 * 
	 * 目测不用了
	 * 
	 * @param groupId
	 * @param start
	 * @param limit
	 * @return
	 * @throws DataNotFoundException
	 */
	public void getRequestingMembersInGroup(long groupId, int start, int limit){
		
	}

	/**
	 * 获取柜子请求member总数
	 * 
	 *目测不用了
	 *
	 * @param groupId
	 * @return
	 */
	public long getNumberOfRequestingMembersInGroup(long groupId){
		return 0;
	}

	/**
	 * 获取某个member所在的所有柜子
	 *
	 * @param memberId
	 * @return 小柜子id列表
	 * @throws DataAccessException
	 */
	public List<Long> getGroupsForMember(long memberId){
		return genericDao.findAll("select gmb.group_id from GroupMemberBinding gmb where gmb.member_id = ?", memberId);
	}
	
	/**
	 * 
	 * @return 所有的groupmemberbindings
	 * 
	 */
	public  List<GroupMemberBinding> getAllBindings(){
		return genericDao.findAll("from  GroupMemberBinding gmb where gmb.status = ?",  GroupMemberBinding.STATUS_PASS);
	}

	/**
	 * 更新member柜子绑定
	 *
	 * @param memberId
	 * @param groupId
	 * @param bind
	 * @throws DataNotFoundException
	 */
	public void updateMemberGroupBinding(long memberId, long groupId, boolean bind)
			throws DataNotFoundException, DataUpdateException{
		GroupMemberBinding binding = genericDao.findFirst("from GroupMemberBinding gmb where gmb.member_id = ?"
				+"and gmb.group_id =?", memberId,groupId);
		binding.setStatus(bind ? GroupMemberBinding.STATUS_PASS
				: GroupMemberBinding.STATUS_REQUEST);
		genericDao.update(binding, "");
	}



	/**
	 * 根据member删除柜子member绑定
	 *
	 * @param memberId
	 * @return
	 */
	public void deleteBindingByMember(long memberId){
		List<GroupMemberBinding> bindings = genericDao.findAll("from GroupMemberBinding gmb where gmb.member_id = ?", memberId);
		for(GroupMemberBinding binding :bindings){
			genericDao.delete(binding);
		}
	}

	/**
	 * 根据柜子删除柜子member绑定
	 *
	 * @param groupId
	 * @return
	 */
	public void deleteBindingByGroup(long groupId){
		List<GroupMemberBinding> bindings = genericDao.findAll("from GroupMemberBinding gmb where gmb.group_id = ?", groupId);
		for(GroupMemberBinding binding :bindings){
			genericDao.delete(binding);
		}
	}
//
//	// ////////////////////////////////////////////////////////////////////////
//
//	/**
//	 * 创建帐户
//	 *
//	 * @param bean
//	 * @throws DataCreationException
//	 */
//	public void createAccount(IUserBaseBean bean) throws DataCreationException;
//
//	/**
//	 * 删除帐户
//	 *
//	 * @param account
//	 */
//	public void deleteAccount(String account);
//
//	/**
//	 * 获取帐户列表
//	 *
//	 * @param status
//	 * @param start
//	 * @param limit
//	 * @return
//	 */
//	public IUserBaseBean[] getAccounts(IUserBaseBean.Status status, int start,
//			int limit);
//
//	/**
//	 * 获取帐户总数
//	 *
//	 * @param status
//	 * @return
//	 */
//	public long getNumberOfAccounts(IUserBaseBean.Status status);
//
//	/**
//	 * 更新帐户
//	 *
//	 * @param bean
//	 * @throws DataUpdateException
//	 */
//	public void updateAccount(IUserBaseBean bean) throws DataUpdateException;
//
//	/**
//	 * 更改帐户密码
//	 *
//	 * @param account
//	 * @param password
//	 * @throws DataUpdateException
//	 */
//	public void updatePassword(String account, String password)
//			throws DataUpdateException;
//
//	/**
//	 * 查找member帐号信息
//	 *
//	 * @param account
//	 * @return
//	 * @throws DataNotFoundException
//	 */
//	public IUserBaseBean getAccount(String account) throws DataNotFoundException;

}
