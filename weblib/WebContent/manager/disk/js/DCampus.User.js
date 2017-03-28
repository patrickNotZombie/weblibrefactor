
$(function(){
	  DCampus.UserUI.init();
	  $(".chooseGroups").bind("click",function(){
		if($(this).text() == "关闭") {
		   $("#groupsDialog").fadeOut("fast");
		   $(this).text("打开");
		} else {
			   $("#groupsDialog").fadeIn("fast");
			   $(this).text("关闭");		     
		  }
	  });
	  $(".searchGroups").bind("click",function(){
		  DCampus.UserUI.page1.doFlash("query="+$(".enterGroupsName").val(),1); 							   
	  });
	  $(".groupsList").bind("click",function(e){
			var target = $(e.target);
			if(target.is("a")) {
			   	$(".chooseMemberInput").text(target.text());
				$(".chooseGroups").text("打开");
				$("#groupsDialog").fadeOut("fast");
				DCampus.UserUI._getMemberList();   
			}
	  });
	  $(".peopleInput").bind("focus",function(){
			  DCampus.UserUI.checkName = setInterval(function(){
				 var param = "groupName=" + $(".chooseMemberInput").val() + "&name=" + $(".peopleInput").val();				  
				 DCampus.UserUI._getMemberList();
			  },1500);
	  }).bind("blur",function(){
	      clearInterval(DCampus.UserUI.checkName);
	  });
	  
	  $(".chooseMemberWrap").bind("click",function(e){
		   var target = $(e.target);
		   if(e.shiftKey) {
			   if(target.is("a")) {
				   var start = $(".chooseMemberWrap a").index($(".chooseMemberWrap a.active"));
				   var end = $(".chooseMemberWrap a").index(target);
                   if(start <= end) {
					   for(i=start;i<end+1;i++) {
						   $(".chooseMemberWrap a").eq(i).addClass("active");  
					   }
				   } else {
					   for(i=start;i>end-1;i--) {
						   $(".chooseMemberWrap a").eq(i).addClass("active"); 
					   }
				   }
			   }
			   return false;
		   }
		   if(e.ctrlKey) {
			   if(target.is("a")) {
				   if(target.is(".active")) {
				      target.removeClass("active");
				   } else {
				      target.addClass("active");
				   }
			   }
			   return false;   
		   }		   
		   if(target.is("a")) {
		       target.parent().siblings().find("a").removeClass("active");
			   if(target.is(".active")) {
				  target.removeClass("active");
			   } else {
				  target.addClass("active");
			   }
		   }
	  });
	  
	  $(".UserWrapListWrap").bind("click",function(e){
	       var target = $(e.target);
		   if(target.is("a")) {
		       target.parent().siblings().find("a").removeClass("active");
			   if(target.is(".active")) {
				  target.removeClass("active");
			   } else {
				  target.addClass("active");
			   }
			  
		   }
	  });
	  
	  $(".addMembers").bind("click",function(){
		   var param = "";
		   $.each($(".active"),function(n,i){
			   if(n==0) {
				   param += "name=" + $(this).text();   
			   } else {
				  param += "&name=" + $(this).text();   
			   }
		   })
			$.ajax({
				url:"/user/joinGroup.action?temp="+Math.random()
			   ,data : param + "&groupId=" + $("#getTopGroupId").val() + "&type=god"
			   ,dataType : "json"
			   ,type : "post"
			   ,success : function(data){
				   DCampus.UserUI._getCurrentMemberList();
				},
				error : function(message){
					 var json = jQuery.parseJSON(message.responseText);
					 alert(json.detail); 
				}
			});								 
	  });
	  
	  
	  $(".deleteMembers").bind("click",function(){
			$.ajax({
				url:"/user/deleteMemberFromGroup.action?temp="+Math.random()
			   ,data : "memberId=" + $(".UserWrapListWrap .active").attr("rev") + "&groupId=" + $("#getTopGroupId").val()
			   ,dataType : "json"
			   ,type : "post"
			   ,success : function(data){
				   DCampus.UserUI._getCurrentMemberList();
				},
				error : function(message){
					 var json = jQuery.parseJSON(message.responseText);
					 alert(json.detail); 
				}
			});			   
	  });
	  
})

DCampus.UserUI = {
	groups_start : 0,
	groups_limit : 18,//列表条数
    groups_liststep:10,      /** 分页显示长度 默认10**/	
    groups_pageNum:0,            /** 默认第一页开始**/	
    groups_pageCount:0,          /** 页数**/
    groups_totalCount:0,         /** 列表总数**/
    groups_listbegin:0,
    groups_listend:0,
	member_limit : 0,
	member_limit :20,
    member_liststep:10,      /** 分页显示长度 默认10**/	
    member_pageNum:0,            /** 默认第一页开始**/	
    member_pageCount:0,          /** 页数**/
    member_totalCount:0,         /** 列表总数**/
    member_listbegin:0,
    member_listend:0,	
	page1 : "",
	page2 : "",
	checkName : null,
    init : function(){
		  DCampus.UserUI._template = TrimPath.parseTemplate($("#members_template").val());
		  $(".chooseMemberWrap ul").html(DCampus.UserUI._template.process(allMembers));		
		  DCampus.UserUI._template2 = TrimPath.parseTemplate($("#currentMembers_template").val());
		  $(".UserWrapListWrap ul").html(DCampus.UserUI._template2.process(getMembers));				  
		  DCampus.UserUI.page1 = new DCampusPaging({
			 "limit":DCampus.UserUI.groups_limit             /** 显示条数默认20条    **/
			,"RequestPath" : "/group/searchGroups.action?temp="+Math.random()
			,"PageJson" : allGroups
			,"liststep" :  DCampus.UserUI.groups_liststep
			,"pageNum": DCampus.UserUI.groups_pageNum
			,"pageCount": DCampus.UserUI.groups_pageCount
			,"totalCount": DCampus.UserUI.groups_totalCount
			,"listbegin": DCampus.UserUI.groups_listbegin
			,"listend": DCampus.UserUI.groups_listend
			,"start" : DCampus.UserUI.groups_start		
			,"isPaging" : true
			,"onBeforeStart":function(){}
			 ,"onLoad" : function(data){
				  var _template = TrimPath.parseTemplate($("#groups_template").val());
				  $(".groupsList").html(_template.process(data));	
			  }
		});	
   },
   _getMemberList : function(){
	var getInput = $(".chooseMemberInput").text();
	if(getInput == "全部资源库") {
	   	getInput = "";
	}
	$.ajax({
	    url:"/user/searchMembers.action?temp="+Math.random()
	   ,data : "site="+System.site + "&groupName=" + getInput + "&name=" + $(".peopleInput").val() + "&start=0&limit=1000"
	   ,dataType : "json"
	   ,type : "get"
	   ,success : function(data){

	       $(".chooseMemberWrap ul").html(DCampus.UserUI._template.process(data));	
		},
		error : function(message){
			 var json = jQuery.parseJSON(message.responseText);
			 alert(json.detail); 
	    }
	});   
  },
  _getCurrentMemberList : function(){
	$.ajax({
	    url:"/user/getMembersInGroup.action?temp="+Math.random()
	   ,data : "groupId=" + $("#getTopGroupId").val() + " &start=0&limit=1000"
	   ,dataType : "json"
	   ,type : "get"
	   ,success : function(data){
	       $(".UserWrapListWrap ul").html(DCampus.UserUI._template2.process(data));	
		},
		error : function(message){
			 var json = jQuery.parseJSON(message.responseText);
			 alert(json.detail); 
	    }
	});  	    
  }


}