package com.dcampus.sys.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;
import com.dcampus.common.util.NumberUtils;

/**
 * 文件记录
 * @author wfxu
 */
@Entity
@Table(name="sys_file_info")
public class FileInfo extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 文件名称 */
	@Column(name="file_name")
	private String fileName;

	/** 文件后缀，如：“.jpg” “.zip” */
	@Column(name="file_type")
	private String fileType;

	/** 文件大小，Bytes */
	@Column(name="file_size")
	private Long fileSize;
	
	/** 文件在磁盘中与Global.RootPath的相对路径 */
	@Column(name="file_path")
	private String filePath;

	/** 上传时间 */
	@Column(name="create_time")
	private Date createTime;
	
	public FileInfo() {
	}
	public FileInfo(Integer id) {
		this.id = id;
	}
	
	/**
	 * 获取文件大小字符串
	 * @return
	 */
	public String getFileSizeString() {
		if (fileSize >= (1024 * 1024 * 1024)) {
			return NumberUtils.getRoundDouble(new Double(fileSize) / (1024 * 1024 * 1024), 1) + "GB";
		} else if (fileSize >= (1024 * 1024)) {
			return NumberUtils.getRoundDouble(new Double(fileSize) / (1024 * 1024), 1) + "MB";
		} else if (fileSize >= (1024)) {
			return NumberUtils.getRoundDouble(new Double(fileSize) / (1024), 1) + "KB";
		} else {
			return fileSize + "B";
		}
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
