/**
 * 
 */
package com.dcampus.sys.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dcampus.common.config.Global;
import com.dcampus.common.generic.GenericService;
import com.dcampus.common.web.BaseController;
import com.dcampus.sys.entity.FileInfo;

/**
 * 文件信息Ctrl
 * @author wfxu
 *
 */
@Controller
@RequestMapping(value = "")
public class FileInfoCtrl extends BaseController {
	@Autowired
	private GenericService genericService;

	@RequiresRoles("admin")
	@RequestMapping(value = "fileInfoDownload")
	public void fileInfoDownload(Integer fileInfoId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		FileInfo fileInfo = genericService.get(FileInfo.class, fileInfoId);
		if (fileInfo == null) {
			return;
		}
		File file = FileUtils.getFile(Global.getFileRootPath(), fileInfo.getFilePath());
		if (!file.exists()) {
			return;
		}
		OutputStream os = response.getOutputStream();
    	response.reset();  
    	//response.setContentType(request.getServletContext().getMimeType(fileInfo.getFilePath()));
    	response.setCharacterEncoding("UTF-8");
    	response.setHeader("Content-disposition", "attachment; filename=" + URLEncoder.encode(fileInfo.getFileName() + fileInfo.getFileType(), "UTF-8"));

    	FileInputStream fis = new FileInputStream(file);
    	if (fis != null) {
    		IOUtils.copy(fis, os);
    	}
        if (fis != null) {
	    	fis.close();
        }
        if (os != null) {
            os.close();
        }
	}
}
