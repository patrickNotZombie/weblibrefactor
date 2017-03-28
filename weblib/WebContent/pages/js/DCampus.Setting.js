// JavaScript Document
DCampus.SettingData = {
   _saveSettingSuccess : function(){
      DCampus.Public.AjaxRequestFunction(System.site+"/group/setAuditPost.action","groupId="+mygroupId+"&audit="+$j("[name='audit']:checked").val(),"POST",function(){$j("body").message({message:"保存成功"});},function(){});	  
   }	
}

$j(function(){
	  /**
	       执行存储的事件
	  **/	
	  $j(".saveSettings").bind("click",function(){
		 DCampus.Public.AjaxRequestFunction(System.site+"/group/modifyGroupPermission.action","groupId="+mygroupId+"&permissionType="+$j("[name='permType']:checked").val(),"POST",DCampus.SettingData._saveSettingSuccess);
		 
	  });
	  switch(json.auditPost) {
		 case 1:$j("[name='audit']").eq(2).attr("checked","checked");break;
		 case 2:$j("[name='audit']").eq(1).attr("checked","checked");break;
		 case 3:$j("[name='audit']").eq(0).attr("checked","checked");break;
	  }
	  switch(json.usage) {
	     case "normal":$j("[name='permType']").eq(0).attr("checked","checked");break;
		 case "public":$j("[name='permType']").eq(1).attr("checked","checked");break;
		 case "private":$j("[name='permType']").eq(2).attr("checked","checked");break;
		 case "guestbook":$j("[name='permType']").eq(3).attr("checked","checked");break;
	  }
	  


});

DCampus.SettingUI = {

}