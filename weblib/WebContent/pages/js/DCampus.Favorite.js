DCampus.FavoriteData = {
  _deleteSuccess : function(){
      window.location.reload();
  }	
};
$j(function(){
	DCampus.FavoriteUI._getMyGroupsTemplate = TrimPath.parseTemplate($j("#myGroupTemplate").val());
	DCampus.FavoriteUI._getMyFavoriteTemplate = TrimPath.parseTemplate($j("#favoriteTemplate").val());
  	DCampus.FavoriteUI.init();
	$j(".deleteOne").bind("click",DCampus.FavoriteUI._doDeleteFunction)
});
DCampus.FavoriteUI = {
	init : function(){
	    $j("#myGroups-lst").html(DCampus.FavoriteUI._getMyGroupsTemplate.process(myGroupsJson));
		$j("#favorite-lst").html(DCampus.FavoriteUI._getMyFavoriteTemplate.process(getFavoriteJson));
	},
	_doDeleteFunction : function(){
	   if(confirm("是否删除?")) {
	      DCampus.Public.AjaxRequestFunction(System.site+"/user/deleteWatch.action","id="+$j(this).attr("rev"),"POST",DCampus.FavoriteData._deleteSuccess);
	   }
	}
};