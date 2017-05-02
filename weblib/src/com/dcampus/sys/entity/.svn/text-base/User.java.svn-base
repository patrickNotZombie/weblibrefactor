package com.dcampus.sys.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;

import com.dcampus.common.persistence.BaseEntity;
import com.dcampus.lms.lms.entity.Course;
import com.dcampus.lms.lms.entity.CourseDiscuss;
import com.dcampus.lms.lms.entity.CourseMessage;
import com.dcampus.lms.lms.entity.CourseStudent;
import com.dcampus.lms.lms.entity.CourseTeacher;
import com.dcampus.lms.lms.entity.Courseware;
import com.dcampus.lms.lms.entity.HomeworkStudent;
import com.dcampus.lms.lms.entity.StudentNote;

/**
 * 用户信息
 * @author scut,xinlv
 *
 */
@Entity
@Table(name="sys_user")
public class User extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	/**用户账号状态，启用状态*/
	public static final int UserStatus_Enable = 1;
	
	/**用户账号状态，停用状态*/
	public static final int UserStatus_Disable = 2;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 账号 */
	@Column(name="user_name", unique=true)
	@Length(min=1, max=100)
	private String username;
	/** 登陆密码 */
	@Length(min=1, max=100)
	private String password;
	
	/** 名称 */
	@Length(min=1, max=100)
	private String name;
	
	/** 个人简介（用于教师简介）*/
	private String introduction;
		
	/** 所属部门 ，见Dict的部门 */
	private String department;
	
	/** 电子邮件 */
	@Email
	private String email;
	/** 联系电话 */
	private String phone;
	/** 通讯地址 */
	private String address;
	/** 通讯地址邮政编码 */
	private String zipcode;
	/** 传真 */
	private String fax;
	
	/** 存放个人照片的路径（文件名）*/
	private String photo;
	
	/** 用户账号状态*/
	@Column(name="user_status")
	private Integer userStatus = UserStatus_Enable;
	
	/** 创建时间 */
	@Column(name="create_time")
	private Date createTime;
	/** 最后登陆时间 */
	@Column(name="last_login_time")
	private Date lastLoginTime;
	/** 最后登陆ip */
	@Column(name="last_login_ip")
	private String lastLoginIp;
	
	/** 拥有的角色 */
	@OneToMany(mappedBy="user", cascade=CascadeType.REMOVE, fetch=FetchType.LAZY)
	private Set<UserRole> userRoles = new HashSet<UserRole>();
	
	/** 拥有的组 */
	@OneToMany(mappedBy="user", cascade=CascadeType.REMOVE, fetch=FetchType.LAZY)
    private Set<UserGroup> userGroups = new HashSet<UserGroup>();
	
	public Set<CourseTeacher> getCourseTeacher() {
		return courseTeacher;
	}
	public void setCourseTeacher(Set<CourseTeacher> courseTeacher) {
		this.courseTeacher = courseTeacher;
	}
	public Set<CourseStudent> getCourseStudent() {
		return courseStudent;
	}
	public void setCourseStudent(Set<CourseStudent> courseStudent) {
		this.courseStudent = courseStudent;
	}
	/** 参与教学的课程 */
	@OneToMany(mappedBy="teacher", cascade=CascadeType.REMOVE, fetch=FetchType.LAZY)
    private Set<CourseTeacher> courseTeacher = new HashSet<CourseTeacher>();
	
	/** 参与学习的课程 */
	@OneToMany(mappedBy="student", cascade=CascadeType.REMOVE, fetch=FetchType.LAZY)
    private Set<CourseStudent> courseStudent = new HashSet<CourseStudent>();
	
	/** 发布的讨论内容 */
	@OneToMany(mappedBy="creator",cascade=CascadeType.REMOVE,fetch=FetchType.LAZY)
	private Set<CourseDiscuss> discuss = new HashSet<CourseDiscuss>();
	
	/** 发布的消息**/
	@OneToMany(mappedBy="creator",cascade=CascadeType.REMOVE,fetch=FetchType.LAZY)
	private Set<CourseMessage> message = new HashSet<CourseMessage>();
	
	/**创建的课程*/
	@OneToMany(mappedBy="creator",cascade=CascadeType.REFRESH,fetch=FetchType.LAZY)
	private Set<Course> course = new HashSet<Course>();
	
	/** 需要完成的课程作业 */
	@OneToMany(mappedBy="student", cascade=CascadeType.REMOVE, fetch=FetchType.LAZY)
    private Set<HomeworkStudent> homeworkStudent = new HashSet<HomeworkStudent>();
	
	/** 所做的知识点笔记 */
	@OneToMany(mappedBy="creator", cascade=CascadeType.REMOVE, fetch=FetchType.LAZY)
    private Set<StudentNote> studentNote = new HashSet<StudentNote>();
	
	public User() {
	}
	public User(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public String getLastLoginIp() {
		return lastLoginIp;
	}
	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	public Set<UserRole> getUserRoles() {
		return userRoles;
	}
	public void setUserRoles(Set<UserRole> userRoles) {
		this.userRoles = userRoles;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}

	public Integer getUserStatus() {
		return userStatus;
	}
	public void setUserStatus(Integer userStatus) {
		this.userStatus = userStatus;
	}
	public Set<UserGroup> getUserGroups() {
		return userGroups;
	}
	public void setUserGroups(Set<UserGroup> userGroups) {
		this.userGroups = userGroups;
	}
	public Set<CourseDiscuss> getDiscuss() {
		return discuss;
	}
	public void setDiscuss(Set<CourseDiscuss> discuss) {
		this.discuss = discuss;
	}
	public Set<CourseMessage> getMessage() {
		return message;
	}
	public void setMessage(Set<CourseMessage> message) {
		this.message = message;
	}
	public Set<Course> getCourse() {
		return course;
	}
	public void setCourse(Set<Course> course) {
		this.course = course;
	}
	public Set<HomeworkStudent> getHomeworkStudent() {
		return homeworkStudent;
	}
	public void setHomeworkStudent(Set<HomeworkStudent> homeworkStudent) {
		this.homeworkStudent = homeworkStudent;
	}
	public Set<StudentNote> getStudentNote() {
		return studentNote;
	}
	public void setStudentNote(Set<StudentNote> studentNote) {
		this.studentNote = studentNote;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
}
