<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<%@include file="checklogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>WebLib2011 首页</title>
<meta name="Keywords" content="" />
<meta name="Description" content=""/>
<link href="themes/blue/css/disk.css" rel="stylesheet" type="text/css" />
<script src="js/DCampus.FrontpageAllInOne.js"></script>
<script>
if(!<%=isLogin%>) {
  parent.window.location.href = "../login.jsp";
}
var getForumID = <ww:action name="getDefaultCmsForums" namespace="/forum" executeResult="true" ignoreContextParams="true"/>;
var groupNewsJSON =  <ww:action name='getMyGroupsByLastRecords' namespace='/group' executeResult='true' ignoreContextParams='false'><ww:param name="start" value="0"></ww:param><ww:param name="limit" value="5"></ww:param></ww:action>;

var privateID = [];
for(i=0;i<getForumID.private.length;i++) {
     privateID[i] = getForumID.private[i].id;
}
function openFolder(location_groupId,parentId){
  
  var _url = "location_groupId="+(-location_groupId)+"&parentId="+parentId
  
  parent.window.location.hash = _url;
}
jQ(function(){
    if(typeof(parent.DCampus) != "undefined")
	parent.DCampus.IndexUI.hideQuota();
	DCampus.FrontpageUI.getResourceById("paper",47);//获取简报
	DCampus.FrontpageData._getGroupNewsSuccess(groupNewsJSON);//显示最新动态
	//DCampus.FrontpageUI.getThreads("metting",privateID[0]);
	DCampus.FrontpageUI.getRss("metting","../RSS/renshi.jsp");
	DCampus.FrontpageUI.getRss("jianxun","../RSS/qiye.jsp");
	
	//DCampus.FrontpageUI.getThreads("jianxun",privateID[1]);
 
});
DCampus.FrontpageUI = {
  template : null,
  getThreads : function(handler,id){
     jQuery.ajax({
	     url:"/thread/getThreads.action?temp="+Math.random()
		 ,data : "forumId="+id+"&start=0&limit=10"
		 ,dataType : "json"
		 ,success:function(data){
		      jQuery("."+handler).empty();
			  for(i=0;i<data.threads.length;i++) {
				jQuery("."+handler).append("<li><a href='../detail.jsp?threadId="+data.threads[i].id+"' target='_blank'>"+data.threads[i].topic+"</a></li>");
			  }
			  jQuery("."+handler).parent().parent().find(".link").attr({"href":"../list.jsp?forumID="+id,"target":"_blank"});
		 }
	 });
  },
  getRss : function(handler,url){
     jQuery.ajax({
	     url:url
		 ,success:function(data){
		      jQuery("."+handler).empty();
			  var getitem = jQuery(data).find("item");
			  for(i=0;i<getitem.length;i++) {
				jQuery("."+handler).append("<li><a href='"+getitem.eq(i).find("link").text()+"' target='_blank'>"+getitem.eq(i).find("title").text()+"</a></li>");
			  }
			  jQuery("."+handler).parent().parent().find(".link").attr({"href":""+jQuery(data).find("link").eq(0).text()+"","target":"_blank"});
		 }
	 });
  }  
  ,getResourceById : function(handler,groupId){
		var obj = jQuery("."+handler);
		obj.empty();
		jQuery.ajax({
			url : "/group/getResources.action"
			,data : "parentId=" + (-groupId) + "&start=0&limit=10"
			,dataType : "json"
			,success : function(data){
			  for(i=0;i<data.resources.length;i++) {
				 if(data.resources[i].type != 1) {
				   obj.append("<li><a href='/group/downloadResource.action?id="+data.resources[i].id+"'>"+data.resources[i].displayName+"</a></li>");
				} else {
				  obj.append("<li  style='background:url(\"../images/icons/16/folder_closed.gif\") 5px 4px no-repeat;padding-left:30px;'><a href='javascript:openFolder("+data.parentId+","+data.resources[i].id+")'>"+data.resources[i].displayName+"</a></li>");
				}
			  }
			}
		});
   }
};
DCampus.FrontpageData = {
   lstid : 0,//定义一个增量这个增量用来按顺序读取动态列表用
   idArr : [],//定义一个保存动态圈子ID的数组
   random_lstid : 0,//定义一个增量这个增量用来按顺序读取动态列表用
   random_idArr : [],//定义一个保存动态圈子ID的数组
   getRssSuccess : function(data){
   
   }
   ,_getGroupNewsSuccess : function(data){
	   DCampus.Public.AjaxRequestFunction("/group/getAllGroupRecords.action?temp="+Math.random(),"start=0&limit=10","get",DCampus.FrontpageData._getGroupNewsLstSuccess);//然后异步请求输出圈子的动态列表
	},
	_getGroupNewsLstSuccess : function(data){//输出圈子动态列表请求成功调用的方法
		var _template = TrimPath.parseTemplate(jQuery("#News_template").val());//调用模板
		jQuery("#News-Wrap").html(_template.process(data));	//输出动态列表
	  }
};
</script>
</head>
<body style="padding:5px;padding-top:10px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%"><div class="area">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="27" class="bgTopL"></td>
            <td class="bgTop"><h3><span><a href="javascript:void(0)" class="link">企业文化</a></span> <a href="#" class="more link" target="_blank">&nbsp;</a></h3></td>
            <td class="bgTopR"></td>
          </tr>
        </table>
        <div class="box"><ul class="jianxun"><span class="loadText">加载中...</span></ul></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="4" class="bgBottomL"></td>
            <td class="bgBottom">&nbsp;</td>
            <td class="bgBottomR"></td>
          </tr>
        </table>
      </div>
      </td>
    <td width="50%"><div class="area">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="27" class="bgTopL"></td>
            <td class="bgTop"><h3><span><a href="javascript:void(0)" class="link">人事行政信息</a></span>  <a href="#" class="link more">&nbsp;</a></h3></td>
            <td class="bgTopR"></td>
          </tr>
        </table>
        <div class="box"><ul class="metting"><span class="loadText">加载中...</span></ul></div>
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="4" class="bgBottomL"></td>
            <td class="bgBottom">&nbsp;</td>
            <td class="bgBottomR"></td>
          </tr>
        </table>
      </div>
      </td>
  </tr>
  <tr>
    <td width="50%"><div class="area">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="27" class="bgTopL"></td>
            <td class="bgTop"><h3><span>资源库动态</span> <!--a href="#" class="more link">&nbsp;</a--></h3></td>
            <td class="bgTopR"></td>
          </tr>
        </table>
        <div class="box"><div id="News-Wrap"></div></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="4" class="bgBottomL"></td>
            <td class="bgBottom">&nbsp;</td>
            <td class="bgBottomR"></td>
          </tr>
        </table>
      </div>
      </td>
    <td width="50%"><div class="area">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="27" class="bgTopL"></td>
            <td class="bgTop"><h3>软件工具<!--a href="#" class="more link">&nbsp;</a--></h3></td>
            <td class="bgTopR"></td>
          </tr>
        </table>
        <div class="box"><ul class="paper"><span class="loadText">加载中...</span></ul></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="4" class="bgBottomL"></td>
            <td class="bgBottom">&nbsp;</td>
            <td class="bgBottomR"></td>
          </tr>
        </table>
      </div>
      </td>
  </tr>
</table>
<textarea id="newsTemplate" style="display:none">
{for thread in threads}
   <li><a href="../detail.jsp?threadId=\${thread.id}" target="_blank">\${thread.topic}</a></li>
{/for}
</textarea>
<!--圈子动态的圈子名称模板-->
<textarea id="News_template" style="display:none">
<ul class="News-lst NewsLst" id="NewsLst">
{for record in records}
<li><span>\${record.memberName|escape}</span> \${record.desc|escape} <span class="date">\${record.creationDate}</span></li>
{/for}
</ul>
</textarea>
</body>
</html>
