package com.dcampus.weblib.entity;

import java.util.Arrays;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.dcampus.common.persistence.BaseEntity;


/**
 * member表示用户管理中用到的各种实体,该字段为接入grouper之后加入
 * grouper中的用户组、组织映射到圈子中作为圈子的member存在
 * 根据type分为三类
 * floder,team,person 分别表示组织，组和组中的人
 * 
 * 
 * 暂时还未加入资源共享等属性
 * @author patrick
 *
 */


@Entity
@Table(name = "weblib_member")
public class Member extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**member的状态，正常，过期和未知*/  //直接用BaseEntity中定义的就好
//	public static enum Status {
//		UNKNOWN, NORMAL, EXPIRED;
//		public static Status transform(int ordinal) {
//			switch (ordinal) {
//			case 1:
//				return NORMAL;
//			case 2:
//				return EXPIRED;
//			default:
//				return UNKNOWN;
//			}
//		}
//	}
	/**member的类型，用户组织,用户组和个人*/
//	public static enum Type {
//		FOLDER("folder"), TEAM("team"), PERSON("person");
//
//		private String name;
//
//		private Type(String name) {
//			this.name = name;
//		}
//
//		public String getName() {
//			return name;
//		}
//
//		public static Type transform(String name) {
//			if ("folder".equalsIgnoreCase(name))
//				return FOLDER;
//			if ("team".equalsIgnoreCase(name))
//				return TEAM;
//			return PERSON;
//		}
//	}
//	
	/**member的类型，用户组织*/
	private static final String MEMBER_TYPE_FOLDER = "folder";
	/**member的类型，用户组*/
	private static final String MEMBER_TYPE_TEAM = "team";
	/**member的类型，个人*/
	private static final String MEMBER_TYPE_PERSON = "person";
	
	
	/** member的id **/
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;

	/** member名字 **/
	private String name;

	/** member签名 **/
	private String signature;

	/** member头像路径 **/
	private String icon;

	/** member的用户名 **/
	private String account;

	/** member使用的email **/
	private String email;
	

	/** member状态,供数据库使用 **/
	@Column(name="status")
	private int memberStatus ;
	
	/** member类型，可能为 用户、用户组、组织。该字段为接入grouper之后加入，grouper中的用户组、组织映射到圈子中作为圈子的马甲存在 **/
	@Column(name="type")
	private String memberType;

	
	/** 排序 **/
	@Column
	private Double priority = 100d;
	
	/**所在组织id*/
	@Column(name = "folder_id")
	private Integer folderId;
	
	/**该用户对应的应用集合*/
	@OneToMany(mappedBy = "member",cascade=CascadeType.REMOVE,fetch=FetchType.LAZY)
	private Set<Application> applications = new HashSet<Application>();
	
	/**该用户对应的动态（操作）集合*/
	@OneToMany(mappedBy = "member",cascade=CascadeType.REMOVE,fetch=FetchType.LAZY)
	private Set<GroupRecord> groupRecords = new HashSet<GroupRecord>();
	
	/**该用户对应的权限集合*/
	@OneToMany(mappedBy = "member",cascade=CascadeType.REMOVE,fetch=FetchType.LAZY)
	private Set<Perm> perms = new HashSet<Perm>();
	
	/**该用户对应的分享外链集合*/
	@OneToMany(mappedBy = "member",cascade=CascadeType.REMOVE,fetch=FetchType.LAZY)
	private Set<ResourceCode> ResourceCodes = new HashSet<ResourceCode>();
	
	/**该用户对应的分享提供集合*/
	@OneToMany(mappedBy = "provider",cascade=CascadeType.REMOVE,fetch=FetchType.LAZY)
	private Set<GroupResourceShare> provideResources = new HashSet<GroupResourceShare>();
	
	/**该用户对应的分享接收集合*/
	@OneToMany(mappedBy="recipient",cascade=CascadeType.REMOVE,fetch=FetchType.LAZY)
	private Set<GroupResourceReceive> receiveResources = new HashSet<GroupResourceReceive>();
	
	/**该用户对应的创建的资源集合*/
	@OneToMany(mappedBy="member",cascade=CascadeType.REMOVE,fetch=FetchType.LAZY)
	private Set<GroupResource> groupResources = new HashSet<GroupResource>();
	
	
	public Member() {
	}
	public Member(Integer id) {
		this.id = id;
	}
	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getFolderId() {
		return folderId;
	}
	public void setFolderId(Integer folderId) {
		this.folderId = folderId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}


	public int getMemberStatus() {
		return memberStatus;
	}

	public void setMemberStatus(int memberStatus) {
		this.memberStatus = memberStatus;

	}


	public String getMemberType() {
		return memberType;
	}

	public void setMemberType(String memberType) {
		this.memberType = memberType;

	}
	public Double getPriority() {
		return priority;
	}
	public void setPriority(Double priority) {
		this.priority = priority;
	}
	/**优先级比较*/
	public static void main(String[] args) {
		
		Member m1 = new Member(1);
		m1.setPriority(1d);
		
		Member m2 = new Member(2);
		m2.setPriority(2d);
		
		Member m3 = new Member(3);
		m3.setPriority(3d);
		
		Member[] ms = new Member[]{m1,m2,m3};
		Arrays.sort(ms, new Comparator<Member>() {
			@Override
			public int compare(Member o1, Member o2) {
				double d1 = o1.getPriority() == null ? 0 : o1.getPriority().doubleValue();
				double d2 = o2.getPriority() == null ? 0 : o2.getPriority().doubleValue();
				if (d1 > d2) {
					return 1;
				} else if (d1 < d2){
					return -1;
				} else {
					Long id1 = o1.getId() == null ? 0 : o1.getId().longValue();
					Long id2 = o2.getId() == null ? 0 : o2.getId().longValue();
					if (id1 == id2) {
						return 0;
					}
					return id1 > id2 ? 1 : -1; 
				}
			}
			
		});
		
		for (Member m : ms) {
			System.out.println(m.getPriority()+"  "+m.getId());
		}
		
	}
	public Set<GroupResourceShare> getProvideResources() {
		return provideResources;
	}
	public void setProvideResources(Set<GroupResourceShare> provideResources) {
		this.provideResources = provideResources;
	}
	public Set<GroupResourceReceive> getReceiveResources() {
		return receiveResources;
	}
	public void setReceiveResources(Set<GroupResourceReceive> receiveResources) {
		this.receiveResources = receiveResources;
	}
	public Set<Application> getApplications() {
		return applications;
	}
	public void setApplications(Set<Application> applications) {
		this.applications = applications;
	}
	public Set<GroupRecord> getGroupRecords() {
		return groupRecords;
	}
	public void setGroupRecords(Set<GroupRecord> groupRecords) {
		this.groupRecords = groupRecords;
	}
	public Set<Perm> getPerms() {
		return perms;
	}
	public void setPerms(Set<Perm> perms) {
		this.perms = perms;
	}
	public Set<ResourceCode> getResourceCodes() {
		return ResourceCodes;
	}
	public void setResourceCodes(Set<ResourceCode> resourceCodes) {
		ResourceCodes = resourceCodes;
	}
	public Set<GroupResource> getGroupResources() {
		return groupResources;
	}
	public void setGroupResources(Set<GroupResource> groupResources) {
		this.groupResources = groupResources;
	}

	
	
	
}
