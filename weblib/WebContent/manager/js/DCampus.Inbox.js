// JavaScript Document
$(function(){
 /**
     调用tab方法
 **/
 DCampus.Public.tabFunction("mouseover",".tab",".tabContent",DCampus.InboxUI.tabFunction,false); 			
  /**
      默认触发鼠标经过tab的动作
  **/
 $(".tabHanddle").find("a").eq(0).trigger("mouseover");

 /**
    请求发件箱列表
 **/
   DCampus.InboxUI._getInboxList("/user/getInboxMessage.action");

	/**
	   删除事件
	**/		 
	$(".btn-del-msgL").bind("click",function(){
			var checked = $(".slct-tbl").find("td :checked");
			var param = "";
			if(checked.length < 1) {
				alert("未选择列表");
			} else {
			  if(confirm("是否删除选中的 "+checked.length+" 条短消息？")) {			
				for(i=0;i<checked.length;i++){
				   var sign = "&id";
				   if(i==0) {
					  sign = "id";
				   }
				   param += (sign + "=" + checked.eq(i).val());
				 }
				   DCampus.Public.AjaxRequestFunction(DCampus.systemPath+"/user/deleteMessage.action",
													  param,"POST",DCampus.InboxUI._deleteMessageSuccess);
			  }
			}			    
	});		
			/**分页事件**/	  
			$(".nextPage").bind("click",function(){
				if (DCampus.InboxUI.pageNum < DCampus.InboxUI.pageCount) {
				   DCampus.InboxUI.pageNum = DCampus.InboxUI.pageNum + 1;
				   DCampus.InboxUI._pageScrollFunction(DCampus.InboxUI.pageNum,DCampus.InboxUI.requestURL);
				}		
			});
			 $(".prePage").bind("click",function(){
				  DCampus.InboxUI.pageNum = DCampus.InboxUI.pageNum - 1;
				  DCampus.InboxUI._pageScrollFunction(DCampus.InboxUI.pageNum,DCampus.InboxUI.requestURL);
			 });	
			 $(".go_botton").bind("click",function(){
				DCampus.InboxUI._pageScrollFunction($(this).parent().parent().parent().find(".pageInput").val(),DCampus.InboxUI.requestURL);
				$(".pageInput").val("");
			 });	
			 $(".pageInput").bind("keypress",function(event){
				  if(event.keyCode == 13) {
					   $(this).parent().parent().parent().find(".go_botton").trigger("click");
					   return false;
				  }
			 });

			 
});

/**
    全部页面UI封装函数
**/
DCampus.InboxUI = {
		limit : 15,//列表条数
		start : 0,//开始值
		liststep : 10,	
		pageNum : 1,	
		pageCount : 0,
		totalCount : 0,
		listbegin : 0,
		listend : 0,	
		requestURL : null,/**初始化记录URL变量**/
		saveMessageTopic : "",
		saveMessageName : "",
		tabFunction : function(thisObj){/**滑动tab效果**/
			$(".tabCover").width(thisObj.width());
			$(".tabCover").text(thisObj.text())
			$(".tabCover").animate({left:thisObj.offset().left-20+"px"},"fast",function(){/**给每个tab绑定一个事件**/
				switch($(".tabHanddle").find("a").index(thisObj)) {
				   case 0:DCampus.InboxUI._getInboxList("/user/getInboxMessage.action");break;
				   case 1:DCampus.InboxUI._getInboxList("/user/getSentboxMessage.action");break;
				   case 2:
					 /**调用发短消息模板**/
					 var _template = TrimPath.parseTemplate($("#sendMessage_template").val());
					 $(".inbox-lst").html(_template.process());
					  /**
						 发送消息邀请事件
					  **/
					  $(".sendShortMessageToInvite").bind("click",function(){	
						  var param = "";
						  var receiverName = $("[name='receiverName']").val().split(",");
						  for(i=0;i<receiverName.length;i++) {
							 param += "&receiverName=" + receiverName[i]
						  }																			
						  DCampus.Public.AjaxRequestFunction(DCampus.systemPath+"/user/sendMessage.action","topic="+$("input[name='topic']").val()+"&body="+$("[name='body']").val()+param,"POST",DCampus.InboxUI._sendMessageInviteSuccess);
					  }); 		 
					  if(DCampus.InboxUI.saveMessageName != "" && DCampus.InboxUI.saveMessageTopic !="") {
						  $("[name='receiverName']").val(DCampus.InboxUI.saveMessageName);
						  $("[name='topic']").val("Re:"+DCampus.InboxUI.saveMessageTopic);
					  }
				      break;
				} 			
			});
		},
		/**
		   取列表的主要方法
		**/
		_getInboxList : function(requestURL){
		   DCampus.InboxUI.requestURL = requestURL;/**复制请求URL**/
				  window.location.hash = "/p/1"
				  DCampus.InboxUI._pageScrollFunction(0);
		},	
		/**
		   分页主要方法
		**/
		_pageScrollFunction : function(pageNum){
			/**关闭管理窗**/
			$(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});
			$(".threads-lst").hide();
			DCampus.Public.ShowLoading("tabContent0","",0,100,0);/**显示loading图标**/
			DCampus.InboxUI.pageNum = pageNum;
			DCampus.InboxUI.start = (DCampus.InboxUI.pageNum - 1) * DCampus.InboxUI.limit;
			if(DCampus.InboxUI.start < 0) {
			  DCampus.InboxUI.start = 0;
			}
			DCampus.Public.AjaxRequestFunction(DCampus.systemPath+DCampus.InboxUI.requestURL,"start="+DCampus.InboxUI.start+"&limit="+DCampus.InboxUI.limit,"POST",DCampus.InboxUI._requestInboxListSuccess,DCampus.InboxUI._requestInboxListFail);
		},
	   _requestInboxListSuccess : function(jsonObj){	
			DCampus.Public.HideLoading("tabContent0");
			$(".inbox-lst").hide();/**隐藏列表**/
			/**调用主题列表模板**/
			var _template = TrimPath.parseTemplate($("#inbox_and_outbox_template").val());
			$(".inbox-lst").html(_template.process(jsonObj));
			$(".inbox-lst").show();/**显示列表**/
			/**下面是分页的逻辑**/
			$(".totalCount").text(jsonObj.totalCount);
			DCampus.InboxUI.totalCount = jsonObj.totalCount;
			DCampus.InboxUI.pageCount = DCampus.InboxUI.totalCount / DCampus.InboxUI.limit;
			if (DCampus.InboxUI.pageCount * DCampus.InboxUI.limit < DCampus.InboxUI.totalCount) {
				DCampus.InboxUI.pageCount++;
			}
			if(DCampus.InboxUI.pageNum != 0) {
			 window.location.hash = "/p/"+DCampus.InboxUI.pageNum;
			}
			if(DCampus.InboxUI.pageNum > Math.ceil(DCampus.InboxUI.pageCount)) {
			   return;
			}			
			if(DCampus.InboxUI.pageNum > 1) {
			  $(".prePage").show();
			} else {
			  $(".prePage").hide();
			}
			if(Math.ceil(DCampus.InboxUI.pageCount) > 1) {
			  $(".nextPage").show();
			} else {
			  $(".nextPage").hide();
			}	
			if(DCampus.InboxUI.pageNum ==  Math.ceil(DCampus.InboxUI.pageCount)) {/**如果当前页等于最大页数，隐藏下一页**/
			   $(".nextPage").hide();
			}
			if (DCampus.InboxUI.pageNum <= 0) {
				DCampus.InboxUI.pageNum = 1;
			}
			if (DCampus.InboxUI.pageNum > DCampus.InboxUI.pageCount && DCampus.InboxUI.pageCount > 0) {
				DCampus.InboxUI.pageNum = Math.ceil(DCampus.InboxUI.pageCount);
			}
			DCampus.InboxUI.start = (DCampus.InboxUI.pageNum - 1) * DCampus.InboxUI.limit;
			if (DCampus.InboxUI.start < 0) {
				DCampus.InboxUI.start = 0;
			}
			DCampus.InboxUI.listbegin = DCampus.InboxUI.pageNum - Math.ceil(DCampus.InboxUI.liststep / 2);//从第几页开始显示分页信息
			if (DCampus.InboxUI.listbegin < 1) {
				DCampus.InboxUI.listbegin = 1;
			}
			DCampus.InboxUI.listend = DCampus.InboxUI.pageNum + DCampus.InboxUI.liststep / 2;
			if (DCampus.InboxUI.listend > DCampus.InboxUI.pageCount) {
				DCampus.InboxUI.listend = DCampus.InboxUI.pageCount + 1;
			}
			$(".pageNumA").empty();
			for (var i = DCampus.InboxUI.listbegin; i < DCampus.InboxUI.listend; i++) {
			   var current = (i == DCampus.InboxUI.pageNum ? "class='currentPage'" : "");
			   $(".pageNumA").append("<a "+current+" href='javascript:DCampus.InboxUI._pageScrollFunction("+i+");void(0);'>"+i+"</a> ");
			}		
			$(".myThreadPagenum").text(DCampus.InboxUI.pageNum);
			$(".myThreadpageCount").text(Math.ceil(DCampus.InboxUI.pageCount));		
		   /**select管理插件**/
		   $(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf",toolWrapID:"ManageToolWrap"});
		   /**点击短消息事件**/
		   $(".slct-tbl").find("a").bind("click",function(){
			   if($(this).parent().parent().next(".messageList").css("display") == "none") {
				  $(".messageList").addClass("displayNone"); 
				  $(this).parent().parent().next(".messageList").removeClass("displayNone");  
			   } else {
				  $(".messageList").addClass("displayNone"); 
			   }
			});
			 /**删除短消息**/
			 $(".deleteOneMessage").bind("click",function(){
			     if(confirm("是否删除该条短消息？") ){
					DCampus.Public.AjaxRequestFunction(DCampus.systemPath+"/user/deleteMessage.action","id="+$(this).attr("id"),"POST",DCampus.InboxUI._deleteMessageSuccess);
				 }
			 });	
			 /**回复短消息**/
			 $(".sendMessageReply").bind("click",function(){
			       DCampus.InboxUI.saveMessageTopic = $(this).attr("messagetitle");
		           DCampus.InboxUI.saveMessageName = $(this).attr("id");
				   $(".tabHanddle").find("a").eq(2).trigger("mouseover");
			 });
			 
			 $(".closeFieldButton").bind("click",function(){
			    $(this).parent().parent().parent().parent().parent().addClass("displayNone");
			 });
		},
		/**
		   请求消息列表失败
		**/
		_requestInboxListFail : function(){
		    window.location.href = DCampus.systemPath+ "/groups/login.jsp";
		},
		/**
		   发送短消息成功回调函数
		**/
		_sendMessageInviteSuccess : function() {
		   alert("发送成功!");	
		    $(".tabHanddle").find("a").eq(0).trigger("mouseover");
		},
		_deleteMessageSuccess : function(){
		   alert("删除成功！");
		   DCampus.InboxUI._getInboxList(DCampus.InboxUI.requestURL);
		}
}