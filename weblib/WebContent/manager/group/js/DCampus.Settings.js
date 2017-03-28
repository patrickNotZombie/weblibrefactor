/**
   数据处理的Function
**/
DCampus.SettingsData = {
    _submitSuccess : function(){
	    alert("保存成功");
		window.location.reload();
	},
	_getValueSuccess : function(jsonObj){
	   if(jsonObj.site_close) {
	       $("[name='site_close']").eq(1).attr("checked","true");  
	   } else {
	       $("[name='site_close']").eq(0).attr("checked","true");
	   }
	   if(jsonObj.site_auditgroup) {
	       $("[name='site_audit_group']").eq(1).attr("checked","true");  
	   } else {
	       $("[name='site_audit_group']").eq(0).attr("checked","true");
	   }	   
	   $("[name='site_closereason']").val(jsonObj.site_closereason);//关闭原因
	   $("[name='site_statcode']").val(jsonObj.site_statcode);//统计代码
	   $("[name='smtp_sender']").val(jsonObj.smtp_sender);//邮箱地址
	   $("[name='site_domain']").val(jsonObj.site_domain);
	   $("[name='site_name']").val(jsonObj.site_name);
	   $("[name='site_seo_keywords']").val(jsonObj.site_seo_keywords);
	   $("[name='site_seo_description']").val(jsonObj.site_seo_description);	   
	   if(jsonObj.smtp_auth) { //是否认证
	       $("[name='smtp_auth']").eq(0).attr("checked","true");  
	   } else {
	       $("[name='smtp_auth']").eq(1).attr("checked","true");
	   }
	   
	   $("[name='smtp_sender']").val(jsonObj.smtp_sender);//邮箱地址
	   $("[name='smtp_port']").val(jsonObj.smtp_port == 0 ? 25 : jsonObj.smtp_port);//端口号
	   $("[name='smtp_username']").val(jsonObj.smtp_username == "null" ? "" : jsonObj.smtp_username);//用户名
	   $("[name='smtp_password']").val(jsonObj.smtp_password);//用户密码
	   $("[name='smtp_host']").val(jsonObj.smtp_host);//smtp主机

  	}
}
/**
    页面载入后执行
**/
$(function(){
  DCampus.SettingsUI._init();
  $("#settingSubmit").bind("click",DCampus.SettingsUI._settingSubmit_Function);//提交执行的方法
})

/**
   UI相关的Function
**/
DCampus.SettingsUI = {
	//页面初始化执行的函数
    _init : function(){
       DCampus.Public.AjaxRequestFunction(System.site+"/global/getGlobalConfig.action","","post",DCampus.SettingsData._getValueSuccess);//获取已填信息
    },
    _settingSubmit_Function : function(){
	  var settingValue = $(".settingValue").serialize();
	  DCampus.Public.AjaxRequestFunction(System.site+"/global/manageSite.action",settingValue,"post",DCampus.SettingsData._submitSuccess);
	}
}

