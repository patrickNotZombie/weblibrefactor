package com.dcampus.weblib.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 下载日志实体
 * @author patrick
 *
 */




@Entity
@Table(name = "weblib_download_log")
public class DownloadLog extends Log{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**柜子名**/
	@Column(name="group_name")
	private String groupName;
	
	/**柜子id**/
	@ManyToOne(optional = false)
	@JoinColumn(name="group_id")
	private Group group;

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Group getGroup() {
		return group;
	}

	public void setGroup(Group group) {
		this.group = group;
	} 

    
	
	
	

}
