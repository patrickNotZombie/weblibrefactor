// JavaScript Document
DCampus.SettingData = {
   _saveSettingSuccess : function(){
      $j("body").message({message:"保存成功"});
   }
}

$j(function(){
	/**
	   调用TAB方法
	**/
	$j("#manageIFrame").attr("src","pages/group/setting.jsp?groupId="+json.groupId);
	DCampus.Public.tabFunction("click",".tab",".tabContent",DCampus.SettingUI.tabExtendFunction,false);
	parent.DCampus.Public.setIFrameHeight("#manageIFrame",$j(window).height());
	if(location.href.split("#")[1] == "audit") {
	   $j(".tabHanddle").find("a").eq(1).trigger("click");
	}
});

DCampus.SettingUI = {
		tabExtendFunction : function(thisObj){/**滑动tab效果**/
            if($j(".tabCover").text() == thisObj.text())
			return;
			$j(".tabCover").width(thisObj.width());
			$j(".tabCover").text(thisObj.text());
			$j(".tabCover").animate({left:thisObj.offset().left-20+"px"},"fast");
			switch($j(".tabHanddle a").index(thisObj)) {
			    case 0 :  $j("#manageIFrame").attr("src","pages/group/setting.jsp?groupId="+json.groupId);break;
				case 1 :  $j("#manageIFrame").attr("src","pages/group/auditMember.jsp?groupId="+json.groupId);;break;
				case 2 :  $j("#manageIFrame").attr("src","pages/group/auditThreads.jsp?groupId="+json.groupId);;break;
				case 3 :  $j("#manageIFrame").attr("src","pages/group/auditPosts.jsp?groupId="+json.groupId);;break;
			}
		}
}