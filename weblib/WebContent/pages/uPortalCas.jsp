<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DCampus Groups 登录</title>
<link href="../js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="../themes/default/css/global.css" rel="stylesheet" type="text/css" />
<%@include file="checklogin.jsp"%>
<script src="../js/jquery/jquery-1.3.2.pack.js"></script>
<script src="js/TrimPath_Template.js"></script>
<script src="js/DCampus.Public.js"></script>
<script>
// JavaScript Document
var Personal = (function(){
   return {
	  lstid : 0,//定义一个增量这个增量用来按顺序读取动态列表用
	  idArr : [],//定义一个保存动态圈子ID的数组
      _getGroupNewsSuccess : function(data){
		var _template = TrimPath.parseTemplate($j("#News_template").val());//调用模板
		$j("#News-Wrap").html(_template.process(data));//输出圈子动态名称列表
	   //DCampus.Public.ShowLoading("NewsLst"+Personal.lstid,"",0,60,1);//显示loading图标
	   if(Personal.idArr.length != 0) {
	   DCampus.Public.AjaxRequestFunction("/group/getNumberOfRecordsInDays.action","groupId="+Personal.idArr[Personal.lstid]+"&days=1","POST",Personal._getGroupNewsLstSuccess);//然后异步请求输出圈子的动态列表
	   }
	  },
	  _getGroupNewsLstSuccess : function(data){//输出圈子动态列表请求成功调用的方法
		var _template = TrimPath.parseTemplate($j("#News-lst_template").val());//调用模板
		$j("#NewsLst"+Personal.lstid).html(_template.process(data));	//输出动态列表
		Personal.lstid++;//递增
		if(Personal.lstid < Personal.idArr.length) {//跳出递归
		//DCampus.Public.ShowLoading("NewsLst"+Personal.lstid,"",0,60,1);//显示loading图标
		DCampus.Public.AjaxRequestFunction("/group/getNumberOfRecordsInDays.action","groupId="+Personal.idArr[Personal.lstid]+"&days=1","POST",Personal._getGroupNewsLstSuccess);//异步请求动态列表
		}
	  },
	  _getMoreGroupsListSuccess : function(data){//显示更多我的圈子
		for(i=0;i<data.groups.length;i++) {
			//for(j=0;j<$j(".personal_coR_table .title a").length;j++) {
			   //if(data.groups[i].name == $j(".personal_coR_table .title a").text())
			   //return;
			//}
	       $j(".moreMyGroups").append("<li><span class='ico ico01'>&nbsp;</span><a href='/"+data.groups[i].addr+"/'>"+data.groups[i].name+"</a></li>");       
		}
	  },
	  _successLogin : function(data){
			DCampus.Public.AjaxRequestFunction("/group/getMyGroupsByLastRecords.action","","POST",Personal._getGroupNewsSuccess);//获取动态圈子名列表
			DCampus.Public.AjaxRequestFunction("/user/getMemberList.action","","POST",Header._getMyMaJiaListSuccess,Header._getMyMaJiaListError);
			//DCampus.Public.AjaxRequestFunction("/group/getMyGroups.action","","POST",Personal._getMoreGroupsListSuccess);//获取更多我的圈子列表	  
	  } 
   }
})();
/**页面事件**/
$j(function(){
    if(!DCampus.HeaderUI.LoginStatus ) {
       DCampus.Public.AjaxRequestFunction("/login/casLogin.action","","POST",Personal._successLogin);
	} else {
        DCampus.Public.AjaxRequestFunction("/group/getMyGroupsByLastRecords.action","","POST",Personal._getGroupNewsSuccess);//获取动态圈子名列表
		DCampus.Public.AjaxRequestFunction("/user/getMemberList.action","","POST",Header._getMyMaJiaListSuccess,Header._getMyMaJiaListError);
	}
});


</script>
<style>
.personal_coR_table {width:99% !important;}
.container005 {width:99% !important;margin:0;}
body {background:#fff;}
.container005 .middle {border:0;min-height:200px;padding-left:5px;}
.personal_coR_table .info h3 {padding:0;font-weight:normal !important;}
.personal_coR_table .info div.title {width:auto;}
.personal_coR_table .info div.title a {font-size:12px;line-height:150%;}
.personal_coR_table .info li,.personal_coR_table .info span.date{line-height:150%;}
.personal_coR_table .info a.more {line-height:120%;}
.dropMenuMaJia ul li a {height:15px;line-height:15px;}
.personal_coR_table .info div.title a {color:#333;font-weight:normal;}
</style>
</head>
<body>
<script>


var Header = (function(){
   return {

	  _getMyMaJiaListSuccess : function(jsonObj){
	   /**调用输出主题列表**/
	   var _template = TrimPath.parseTemplate($j("#MaJiaList_template").val());
	   $j(".MaJiaList").html(_template.process(jsonObj));  	
	   $j(".currentMemberName").text(jsonObj.memberName);
	   if($j(".personal_user_name").length != 0) {
	      $j(".personal_user_name").text(jsonObj.memberName);
	   }
	   $j(".MaJiaList").find("a").bind("click",function(){
	       DCampus.Public.AjaxRequestFunction("/login/selectMember.action","&memberId="+$j(this).attr("rel"),"POST",Header._chooseMaJiaSuccess);
	   });
	  },

	  _chooseMaJiaSuccess : function(jsonObj){
		  window.location.reload();
	  },
	  _CheckLoginSuccess : function(jsonObj){
	     DCampus.HeaderUI.LoginStatus = jsonObj.loginStatus;
	  }
   }
})();
$j(function(){
	$j(".dropMenuMaJiaDiv ").hover(function(){
	  $j(".dropMenuMaJia").removeClass("displayNone");
	},function(){
	  $j(".dropMenuMaJia").addClass("displayNone");
	});
	$j(".dropMenuMaJiaDiv_").hover(function(){
	  $j(".dropMenuMaJia_").removeClass("displayNone");
      if($j(".my-group-list").height() > 419) {
	     $j(".my-group-list").height(420);
	  }
	},function(){
	  $j(".dropMenuMaJia_").addClass("displayNone");
	});
	$j(".loginOut").bind("click",function(){
		DCampus.Public.LogoutOut();								 
	});
});
DCampus.HeaderUI = {
	LoginStatus : null
};


</script>


<%
   if(isLogin) {
%>
<script>
  DCampus.HeaderUI.LoginStatus = true;
	</script>
<%
  }
%>

<textarea id="MaJiaList_template" style="display:none">
    <ul>
    {for member in members}
       
{if member.id == memberId}
      <li><a href="javascript:void(0)" rel="\${member.id}" title="\${member.name}" class="currentMaJia">\${member.name|escape}</a></li>
      {else}
      <li><a href="javascript:void(0)" rel="\${member.id}" title="\${member.name}">\${member.name|escape}</a></li>
      {/if} 
      
    {/for}
    </ul>
</textarea>


<div class="container005">
      <div class="middle">
        
<div style="text-align:right;padding:5px 0 0 0;">  
      
      <table  border="0" cellspacing="0" cellpadding="0" style="float:left;">
        <tr>
         
          <td><div class="dropMenuMaJiaDiv">当前马甲：<span class="currentMemberName"></span> <small  id="changeMaJia">▼</small>
              <div class="dropMenuMaJia displayNone">
                <h3>更换马甲</h3>
                <div class="MaJiaList"></div>
              </div>
            </div></td>
 
        </tr>
      </table></div>
        <div id="News-Wrap" style="clear:both;"></div>
      </div>
    </div>


<!--圈子动态的圈子名称模板-->
<textarea id="News_template" style="display:none">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_coR_table">
{var i = 0;}
{for group in groups}
          <tr>
            <td class="info" valign="top"><h3>
                <div class="title"><a href="/\${group.addr}/index.jsp" target="_blank">\${group.name|escape}</a></div>
                <div style="float:left;margin-left:10px;"><span>今日：</span>(<span style="color:#f00;float:none;" class="News-lst NewsLst\${i}" id="NewsLst\${i}"> </span>)</div>
                <a href="/\${group.addr}/index.jsp" class="more" target="_blank">更多>></a></h3>
         </td>
          </tr>
          {eval}
          Personal.idArr[i] = group.id;
           i++;
          {/eval}
{/for}
</table>
</textarea>

<!--圈子动态的圈子动态列表模板-->
<textarea id="News-lst_template" style="display:none">
\${totalCount|escape}
</textarea>

</body>
</html>
