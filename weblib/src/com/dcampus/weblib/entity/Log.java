package com.dcampus.weblib.entity;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import com.dcampus.common.persistence.BaseEntity;



/**
 * 日志类的基类
 * 主要是操作者的信息
 * @author patrick
 *
 */
@MappedSuperclass
public class Log extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
//	/**所有操作动作的枚举*/
//	public static enum Action{
//		ADD("添加"),DELETE("删除"),MODIFY("修改"),MOVE("移动"),COPY("复制"),
//		//LOGIN("登录"),UPLOAD("上传"),DOWNLOAD("下载"),
//		CLOSE("关闭"),OPEN("打开"),EXPORT("导出"),IMPORT("导入"),RECOMMEND("推荐"),
//		CANCEL("取消"),SET("设置"),SEND("发送"),APPLY("申请"),ACTIVATE("激活"),AUDIT("审核"),
//		RESTORE("还原"),SHIELD("屏蔽"),PREVIEW("预览");
//
//		private String name;
//		private Action(String name){
//			this.name = name;
//		}
//		public String getName(){
//			return name;
//		}
//	}
	
	private static final String ACTION_TYPE_ADD = "添加";
	private static final String ACTION_TYPE_DELETE = "删除";
	private static final String ACTION_TYPE_MODIFY = "修改";
	private static final String ACTION_TYPE_MOVE = "移动";
	private static final String ACTION_TYPE_COPY= "复制";
	private static final String ACTION_TYPE_CLOSE= "关闭";
	private static final String ACTION_TYPE_OPEN = "打开";
	private static final String ACTION_TYPE_EXPORT = "导出";
	private static final String ACTION_TYPE_IMPORT = "导入";
	private static final String ACTION_TYPE_RECOMMEND = "推荐";
	private static final String ACTION_TYPE_CANCEL = "取消";
	private static final String ACTION_TYPE_SET = "设置";
	private static final String ACTION_TYPE_SEND = "发送";
	private static final String ACTION_TYPE_APPLY = "申请";
	private static final String ACTION_TYPE_ACTIVATE = "激活"; 
	private static final String ACTION_TYPE_RESTORE = "还原";
	private static final String ACTION_TYPE_SHIELD = "屏蔽";
	private static final String ACTION_TYPE_PREVIEW = "预览";
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	
	/**账户**/
	@Column(name="account")
	private String account;
	
	/**操作者姓名**/
	@Column(name="member_name")
	private String memberName;
   
	/**操作者id**/
	@Column(name="member_id")
	private Integer memberId;
	
	/**ip地址**/
	@Column(name="ip")
	private String ip;

	/**创建时间**/
	@Column(name="create_date",length=0)
	private Date createDate;

	/**终端**/
	@Column(name="terminal")
	private String terminal;

	/**动作**/
	@Column(name="action")
	private String action;

	/**描述**/
	@Column(name="description")
	private String description;

	/**操作对象**/
	@Column(name="target_object")
	private String targetObject;

	/**操作对象id**/
	@Column(name="target_object_id")
	private Integer targetObjectId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getTerminal() {
		return terminal;
	}

	public void setTerminal(String terminal) {
		this.terminal = terminal;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTargetObject() {
		return targetObject;
	}

	public void setTargetObject(String targetObject) {
		this.targetObject = targetObject;
	}

	public Integer getTargetObjectId() {
		return targetObjectId;
	}

	public void setTargetObjectId(Integer targetObjectId) {
		this.targetObjectId = targetObjectId;
	}
	
	
	
	

}
