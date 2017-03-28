<%@ page contentType="text/html;charset=utf-8" %>
<ul class="list005 groupsMenu">
  <!--li><a href="#">个人资料</a></li-->
  <li><a href="inbox.jsp" rel="inbox">短消息</a></li>
  <li><a href="favorite.jsp" rel="favorite">收藏夹</a></li>
</ul>
<script>
	   for(i=0;i<$j(".list005").find("li").length;i++) {
			if($j("input[name='menu']").val() == $j(".list005").find("li").eq(i).find("a").attr("rel")) {
			   $j(".list005").find("li").eq(i).find("a").addClass("active");
			}
	   }
</script>
