<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<link href="../js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="../themes/default/css/global.css" rel="stylesheet" type="text/css"/>
<script src="../js/jquery/jquery-1.4.2.pack.js"></script>
<script src="../js/ckeditor/ckeditor.js"></script>
<script src="../js/jquery-validate/jquery.validate.js"></script>
<script src="../js/jquery/jquery.cookie.js"></script>
<script src="js/TrimPath_Template.js"></script>
<script src="js/DCampus.Public.js"></script>
<script>
var categoryJson = <ww:action name="getCategories" namespace="/category" executeResult="true" ignoreContextParams="true"/>;
window.onload = function()
{
	CKEDITOR.replace( 'desc',{
	toolbar_Basic :
	[
	['']
	],
	toolbar : 'Basic',
	uiColor : '#EAF2FA',
	language : 'zh-cn',
	skin : 'kama',
	resize_enabled : false,
	height : 150,
	toolbarCanCollapse  : false,
	entities : true
	});
};
$j(function(){
	/**圈子分类**/
	//var categoryTemplate = $j("#categoryTemplage").val();
	/*$j("#cCategories").html(categoryTemplate.process(categoryJson)).bind("change",function(){
	   DCampus.Step._saveObj = $j(this);
	});*/
	DCampus.Public.AjaxRequestFunction(System.site+"/category/getCategories.action","parentId="+$j("#fCategories :selected").val(),"POST",DCampus.Step._successGetCategories);


//验证成功后执行的方法
$j.validator.setDefaults({
	submitHandler: function() {
	   if ($j("#saveAddrError").val() == 1 && $j("#saveNameError").val() == 1) {
	     $j("#exitAddr").css("display","inline");
		 $j("#exitName").css("display","inline");
		 window.location.hash = "headerWrap";
	     return;
	   }
	   if($j("#saveNameError").val() == 1) {
	     $j("#exitName").css("display","inline");
		 window.location.hash = "headerWrap";
	     return;
	   }
	   if($j("#saveAddrError").val() == 1) {
	     $j("#exitAddr").css("display","inline");
		 window.location.hash = "headerWrap";
	     return;
	   }
	   var submitCategoryID = 0;
	   if($j(".sCategories").length == 1) {
	      submitCategoryID = $j(".sCategories").find(":selected").val();
	   } else {
	     submitCategoryID = $j(".sCategories").last().find(":selected").val();
		 if(submitCategoryID == 0) {
		    submitCategoryID = $j(".sCategories").last().prev().find(":selected").val();
		 }
	   }
       
	   if(submitCategoryID == 0) {
	     alert("请选择分类");
		 return;
	   }
		  var _value = CKEDITOR.instances.desc.document.getBody().getText();
	      DCampus.Public.AjaxRequestFunction(System.site+"/group/createGroup.action",$j(".submit").serialize()+"&categoryId="+submitCategoryID + "&desc=" + $j.trim(encodeURIComponent(_value)),"POST",DCampus.Step._successCreateGroups);
	      return;
	}
});
   //一些默认设置
   $j("input[name='categoryId']").val("");
   $j(".groups_rules_table tr").eq(0).find("td").addClass("hoverCreationActive");
   $j(".groups_rules_table tr").eq(0).find("td").find("input").attr("checked","true");
   //鼠标经过效果
   $j(".groups_rules_table td").hover(function(){
       $j(this).parent().find("td").addClass("hoverCreationTd");
   },function(){
      $j(this).parent().find("td").removeClass("hoverCreationTd");
   });
   //屏蔽选择其它权限设置
   $j(".groups_rules_table td").bind("click",function(){
        //不可选择其它选项
		if($j(".groups_rules_table td").index(this) > 2) {
		  return;
		}
       $j(this).parent().siblings().find("td").removeClass("hoverCreationActive");
	   $j(this).parent().find("td").addClass("hoverCreationActive");
	   $j(this).parent().find("input").attr("checked","true");
   });
   //同步输出地址名的方法
   $j("input[name='addr']").keyup(function(){
       $j(".address").find("b").text($j.trim($j(this).val()));
   });
   //初始化表单验证的方法
	$j("#creationForm").validate({
		rules: {
		    name: {
			   required : true
			},
			addr: {
			   required : true,
			   numbersAndEnglish:true
			}
		},
		messages: {
			name: "<span>&nbsp;</span>该字段不能为空",
			addr: {
			  required : "<span>&nbsp;</span>该字段不能为空",
			  numbersAndEnglish : '<span>&nbsp;</span>仅允许英文或数字并仅允许使用“_”连结'
			}
		}
	});


	//异步验证是否重名的方法
	$j("input[name='name']").bind("blur",function(){
		DCampus.Public.AjaxRequestFunction(System.site+"/group/checkGroupNameExists.action","name="+$j(this).val(),"POST",DCampus.Step._successCheckName);
	}).bind("keyup",function(){
	    if($j(this).val() == "") {
		   $j("#exitName").css("display","none");
		}
	});
	$j("input[name='addr']").bind("blur",function(){
		DCampus.Public.AjaxRequestFunction(System.site+"/group/checkGroupAddrExists.action","addr="+$j(this).val(),"POST",DCampus.Step._successCheckAddr);
	}).bind("keyup",function(){
	    if($j(this).val() == "") {
		   $j("#exitAddr").css("display","none");
		}
	});
	$j(".return").bind("click",function(){
	   history.go(-1);
	});
})
DCampus.Step = {
   _isExitName : false,
   _isExitAddr : false,
   _saveObj : $j("#fCategories"),
   _successCreateGroups : function(jsonObj){
      $j.cookie("createInfo",$j("input[name='name']").val()+","+$j("input[name='addr']").val());
      window.location.href="step02.jsp";
   },
   _successCheckName : function(jsonObj) {
      if(jsonObj.exists) {
	    $j("#exitName").css("display","inline");
		$j("#saveNameError").val("1");
	  } else {
	     $j("#exitName").css("display","none");
		 $j("#saveNameError").val("");
	  }
   },
   _successCheckAddr : function(jsonObj){
      if(jsonObj.exists) {
	    $j("#exitAddr").css("display","inline");
		$j("#saveAddrError").val("1");
	  } else {
	     $j("#exitAddr").css("display","none");
		 $j("#saveAddrError").val("");
	  }
   },
   _successGetCategories : function(jsonObj){
	  if(jsonObj.categories.length == 0) {
	      //$j("#sCategories").empty();
		  DCampus.Step._saveObj.nextAll().remove();
	  } else {
		  DCampus.Step._saveObj.nextAll().remove();
		  $j("#sCategories").append(" <select class='sCategories'><option value='0'>选择分类</option></select>");
		  
		  for(i=0;i<jsonObj.categories.length;i++) {
			$j(".sCategories").last().append("<option value='"+jsonObj.categories[i].id+"'>"+jsonObj.categories[i].displayName+"</option>");
		  }
		  
		  $j(".sCategories").unbind().bind("change",function(){
		     if($j(this).find(":selected").val() != 0) {
				 DCampus.Step._saveObj = $j(this);
				 DCampus.Public.AjaxRequestFunction(System.site+"/category/getCategories.action","parentId="+$j(this).find(":selected").val(),"POST",DCampus.Step._successGetCategories);
			 }
		  });
  
		  
	  }
   }
}


</script>
</head>
<body>
<div id="headerWrap">
  <div id="header">
<%@include file="header.jsp"%>
<%if(!isLogin) { %>
<script>
var locationHref = window.location.href;
if(locationHref.split("#").length > 1) {
   if(locationHref.split("#")[1] == "create") {
      window.location.href="<%=site%>/pages/login.jsp#/create/";
   }
} else {
   window.location.href="<%=site%>/pages/login.jsp";
}

</script>
<%}%>
  </div>
</div>
<div id="step01_PageHeader">创建圈子</div>
<h3 class="creation_step_bg creation_step01">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="173" class="current_step">第一步：填写圈子资料</td>
      <td width="173">第二步：成功创建圈子</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</h3>
<form id="creationForm" method="get">
<div id="creationWrap">
  <table  border="0" cellspacing="0" cellpadding="0" class="creationInfoTable">
    <tr>
      <th width="1%"><span class="requireMark">*</span>为您的圈子命名：</th>
      <td><input type="hidden" value="" id="saveNameError"/><input type="text" class="creation_text submit" name="name"/> <label class="error" style="display: none;" id="exitName"><span class="error-logo">&nbsp;</span><span class="error-content">圈子名已经已经被他人使用</span></label></td>
    </tr>
    <tr>
      <th width="1%"><span class="requireMark">*</span>圈子地址：</th>
      <td><input type="hidden" value="" id="saveAddrError"/><input type="text" class="creation_text submit" name="addr" maxlength="38"/> <label class="error" style="display: none;" id="exitAddr"><span class="error-logo">&nbsp;</span><span class="error-content">圈子地址已经已经被他人使用</span></label> <span class="address">http://<%=getSiteDomain%><%=site%>/<b></b>/</span></td>
    </tr>
    <%if(getService(session).getPermissionManager().isAdmin(memberID)){%>

    <tr>
      <th width="1%">圈主：</th>
      <td><input type="text" class="creation_text submit" name="creatorName" maxlength="38"/></td>
    </tr>   
    
    <%}%> 
    <tr>
      <th width="1%">圈子策略：</th>
      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="groups_rules_table">
          <tr>
            <td ><input type="radio" name="permissionType" class="submit" value="0"/></td>
            <td >允许浏览，需要加入才可发帖</td>
            <td>本策略允许用户访问，用户要发帖需要申请加入圈子方能发帖。适合某些团体学生社团。</td>
          </tr>
          <tr>
            <td width="15"><input type="radio" name="permissionType" class="submit" checked="checked" value="1"/></td>
            <td width="200">完全公开</td>
            <td>本策略允许任何人浏览和发帖，适合公开讨论场合使用</td>
          </tr>
          <tr>
            <td ><input type="radio" name="permissionType" class="submit"  value="2"/></td>
            <td >仅对会员公开</td>
            <td>本策略允许受邀请会员浏览和发帖，会员要加入本圈子必须经过申请，待审核内部讨论使用</td>
          </tr>
          <tr>
            <td ><input type="radio" name="permissionType" class="submit" value="3"/></td>
            <td >留言板</td>
            <td>本策略允许用户访问，用户发表的需经过圈子管理员审核。</td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <th width="1%">所属分类：</th>
      <td>
       <span id="sCategories"></span>
     </td>
    </tr>
    <tr>
      <th width="1%">圈子描述：</th>
      <td><textarea id="desc"  name="desc"></textarea></td>

    </tr>

  </table>
<div class="step_function_bar"><input type="submit" value="下一步" class="nextStep"/> <input type="button" value="返回" class="return"/></div>
</div>
</form>
<div id="copyright_frontpage">
<%@include file="footer.jsp"%>
</div>

<textarea id="categoryTemplage" class="displayNone">
{if categories.length == 0}
   <option value="">没有分类</option>
{/if}
{var i=0;}
{for category in categories}
{if i==0}
<option value="\${category.id}" selected="selected">\${category.name}</option>
{else}
<option value="\${category.id}">\${category.name}</option>
{/if}
{eval}
i++;
{/eval}
{/for}
</textarea>
<%=getSiteStatCode%>
</body>
</html>
