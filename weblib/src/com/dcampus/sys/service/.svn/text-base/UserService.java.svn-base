package com.dcampus.sys.service;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dcampus.common.generic.GenericDao;
import com.dcampus.common.security.Digests;
import com.dcampus.common.service.BaseService;
import com.dcampus.common.util.Encodes;
import com.dcampus.sys.entity.Perm;
import com.dcampus.sys.entity.Role;
import com.dcampus.sys.entity.RolePerm;
import com.dcampus.sys.entity.User;
import com.dcampus.sys.entity.UserRole;
import com.dcampus.sys.security.LocalRealm;

/**
 * UserService  权限用户信息service
 */
@Service
@Transactional(readOnly=false)
public class UserService extends BaseService {

	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;
	
	@Autowired
	private GenericDao genericDao;
	@Autowired
	private LocalRealm localRealm;
	
	
	public static void main(String[] args) {
		System.out.println(UserService.entryptPassword("mis"));
		System.out.println(UserService.validatePassword("mis", "e7653045dd260851e24c264b5d546ca7ac60f55c1b18630860455f49"));
	}
	

	/**
	 * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
	 */
	public static String entryptPassword(String plainPassword) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
		return Encodes.encodeHex(salt) + Encodes.encodeHex(hashPassword);
	}
	
	/**
	 * 验证密码
	 * @param plainPassword 明文密码
	 * @param password 密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String password) {
		byte[] salt = Encodes.decodeHex(password.substring(0,16));
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
		return password.equals(Encodes.encodeHex(salt) + Encodes.encodeHex(hashPassword));
	}
	
	//------------------------------------------------------------
	// User
	//-----------------------------------------------------------
	public void saveUser(User user) {
		genericDao.save(user);
	}
	public void saveOrUpdateUser(User user){
		if(user.getId() != null && user.getId() > 0)
			genericDao.update(user);
		else
			genericDao.save(user);
	}
	public void saveUsers(Collection<User> collection) {
		for (User item : collection) {
			saveUser(item);
		}
	}
	public void deleteUser(User user) {
		User deleteOne = genericDao.get(User.class, user.getId());
		genericDao.delete(deleteOne);
	}
	public void deleteUsers(Collection<User> collection) {
		for (User item : collection) {
			deleteUser(item);
		}
	}
	public User getUser(Integer id) {
		return genericDao.get(User.class, id);
	}
	public User getUserByUsername(String username) {
		return genericDao.findFirst("from User where username=?", username);
	}
	public void updateUserLoginInfo(Integer userId) {
		User user = genericDao.get(User.class, userId);
		user.setLastLoginIp(SecurityUtils.getSubject().getSession().getHost());
		user.setLastLoginTime(new Date());
		genericDao.update(user);
	}

	public void updatePasswordById(Integer id, String loginName, String newPassword) {
		User user = genericDao.get(User.class, id);
		user.setPassword(entryptPassword(newPassword));
		genericDao.update(user);
		localRealm.clearCachedAuthorizationInfo(loginName);
	}

	//------------------------------------------------------------
	// Role
	//-----------------------------------------------------------
	public void saveRole(Role role) {
		genericDao.save(role);
	}
	public void saveRoles(Collection<Role> collection) {
		for (Role item : collection) {
			saveRole(item);
		}
	}
	public void deleteRole(Role role) {
		Role deleteOne = genericDao.get(Role.class, role.getId());
		genericDao.delete(deleteOne);
	}
	public void deleteRoles(Collection<Role> collection) {
		for (Role item : collection) {
			deleteRole(item);
		}
	}
	public Role getRole(Integer id) {
		return genericDao.get(Role.class, id);
	}
	public Role getRoleByName(String name) {
		return genericDao.findFirst("from Role where name=?", name);
	}

	//------------------------------------------------------------
	// Perm
	//-----------------------------------------------------------
	public void savePerm(Perm perm) {
		genericDao.save(perm);
	}
	public void savePerms(Collection<Perm> collection) {
		for (Perm item : collection) {
			savePerm(item);
		}
	}
	public void deletePerm(Perm perm) {
		Perm deleteOne = genericDao.get(Perm.class, perm.getId());
		genericDao.delete(deleteOne);
	}
	public void deletePerms(Collection<Perm> collection) {
		for (Perm item : collection) {
			deletePerm(item);
		}
	}
	public Perm getPerm(String id) {
		return genericDao.get(Perm.class, id);
	}
	public Perm getPermByKey(String key) {
		return genericDao.findFirst("from Perm where key=?", key);
	}
	

	//------------------------------------------------------------
	// UserRole
	//-----------------------------------------------------------
	public void refreshUserRole(Integer userId, Collection<Role> newRoles) {
		List<UserRole> urList = genericDao.findAll("from UserRole where user.id=?", userId);
		if (urList.size() > 0) {
			for (UserRole item : urList) {
				genericDao.delete(item);
			}
		}
		for (Role item : newRoles) {
			genericDao.save(new UserRole(new User(userId), item));
		}
	}

	//------------------------------------------------------------
	// RolePerm
	//-----------------------------------------------------------
	public void refreshRolePerm(Integer roleId, Collection<Perm> newPerms) {
		List<RolePerm> rpList = genericDao.findAll("from RolePerm where role.id=?", roleId);
		if (rpList.size() > 0) {
			for (RolePerm item : rpList) {
				genericDao.delete(item);
			}
		}
		for (Perm item : newPerms) {
			genericDao.save(new RolePerm(new Role(roleId), item));
		}
	}
}
