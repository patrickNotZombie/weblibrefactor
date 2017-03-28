// JavaScript Document
$j(function(){	
	   $j("[name='memberName']").focus();
	  //发送消息邀请事件
	  $j("[name='shortMessage_invite']").submit(function(){$j(".sendShortMessageToInvite").trigger("click");return false;})
	  $j(".sendShortMessageToInvite").bind("click",function(){
		  var param = "";
		  var _formObj = $j("[name='shortMessage_invite']");
		  var receivers = _formObj.find("[name='memberName']").val().split(",");
		  for(i=0;i<receivers.length;i++) {
		     param += "&receivers=" + receivers[i]
		  }
		 
	      DCampus.Public.AjaxRequestFunction(System.site+"/group/inviteMember.action","type="+_formObj.find("[name='type']").val()+param+"&invitationBody="+encodeURIComponent(_formObj.find("[name='invitationBody']").val())+"&groupId="+json.groupId,"POST",DCampus.InviteUI._sendMessageInviteSuccess);
	  });
	  //发送邮件
	  $j(".sendEMailToInvite").bind("click",function(){
		  var param = "";
		  var _formObj = $j("[name='email_invite']");
		  var receivers = _formObj.find("[name='memberName']").val().split(",");
		  for(i=0;i<receivers.length;i++) {
		     param += "&receivers=" + receivers[i]
		  }													 
	      DCampus.Public.AjaxRequestFunction(System.site+"/group/inviteMember.action","type="+_formObj.find("input[name='type']").val()+param+"&invitationBody="+_formObj.find("[name='invitationBody']").val()+"&groupId="+json.groupId,"POST",DCampus.InviteUI._sendMessageInviteSuccess);	     
	  });
	 //检查发送人是否与当前马甲名相同
	 /*$j("input[name='memberName']").bind("blur",function(e){
		   DCampus.Public.AjaxRequestFunction(System.site+"/user/getMemberList.action","","get",DCampus.InviteUI._checkUsername);
	 });*/	  
	 //调用tab方法
     DCampus.Public.tabFunction("click",".tab",".tabContent",DCampus.InviteUI.tabFunction); 
    //默认触发鼠标经过tab的动作
	 $j(".tabHanddle").find("a").eq(0).trigger("click");
	 DCampus.InviteUI._editArea();//发送内容样式切换
     $j(".tabMenu a").bind("mouseover",function(){
		 for(i=0;i<$j(".tabForm").length;i++){
		    $j(".tabForm").eq(i).attr("name","");
		 }
		 $j(".tabContent"+$j(".tabMenu a").index(this)).find(".tabForm").eq(0).attr("name","memberName");
		 $j(".tabContent"+$j(".tabMenu a").index(this)).find(".tabForm").eq(1).attr("name","invitationBody");
		 DCampus.InviteUI._editArea();//发送内容样式切换
	 });
});
DCampus.InviteUI = {
	_sendMessageInviteSuccess : function() {
	   //$j("body").message({message:"发送成功"});
	   $j("[name='memberName']").val("");
	   var _saveHtml = $j(".tabContent0").html();
	   $j(".tabContent0").html("<div class='sendInviteWrap'><p class='font'>发送成功</p><p><a href='javascript:void(0)' class='continue'>继续邀请</a> <a href='javascript:void(0)' class='return'>返回圈子首页</a></p></div>");
	   $j(".sendInviteWrap .continue").bind("click",function(){
			$j(".tabContent0").html(_saveHtml);
			$j(".sendShortMessageToInvite").bind("click",function(){
				  var param = "";
				  var _formObj = $j("[name='shortMessage_invite']");
				  var receivers = _formObj.find("[name='memberName']").val().split(",");
				  for(i=0;i<receivers.length;i++) {
					 param += "&receivers=" + receivers[i]
				  }
				 
				  DCampus.Public.AjaxRequestFunction(System.site+"/group/inviteMember.action","type="+_formObj.find("[name='type']").val()+param+"&invitationBody="+encodeURIComponent(_formObj.find("[name='invitationBody']").val())+"&groupId="+json.groupId,"POST",DCampus.InviteUI._sendMessageInviteSuccess);
			});			
			$j("[name='memberName']").focus();
	   });
	   $j(".sendInviteWrap .return").bind("click",function(){
		   window.location.href = "index.jsp";										   
	   });	   
	},
	_checkUsername : function(data){
		for(i=0;i<$j("[name='memberName']").val().split(",").length;i++) {
		   if($j("[name='memberName']").val().split(",")[i] == data.memberName) {
		      $j("body").message({message:"不能邀请自己",warning:true});
		   }   
		}
	},
	tabFunction : function(thisObj){//滑动tab效果
		$j(".tabCover").width(thisObj.width());
		$j(".tabCover").text(thisObj.text())
		$j(".tabCover").animate({left:thisObj.offset().left-20+"px"},"fast");
	},
	_editArea : function(){
	  //发送内容样式切换
	  $j("textarea[name='invitationBody']").bind("focus",function(){
		  $j(this).addClass("invitationStyleActive");
	  }).bind("blur",function(){
		 $j(this).removeClass("invitationStyleActive");
	  });	
	}
}