<%@ page contentType="text/html;charset=utf-8" %>
<script src="<%=site%>/pages/js/DCampus.Header.js"></script>
<%if(isLogin) { %>
<script>
DCampus.HeaderUI.LoginStatus = true;
var myGroupsJson =  <ww:action name='getMyGroups' namespace='/group' executeResult='true' ignoreContextParams='false'/>;
var myOwnMemberList = <ww:action name='getMemberList' namespace='/user' executeResult='true' ignoreContextParams='false'/>;
</script>
<%} %>
<div id="headerWrap_in">
  <div class="header">
    <div class="logo">
    <%if(isLogin) { %>
      <div class="dropMenuMaJiaDiv_">我的圈子 <small id="changeMaJia">▼</small>
        <div class="dropMenuMaJia_ displayNone">
          <h3><a href="<%=site%>/pages/personal.jsp">
            <div class="home"></div>
            个人首页</a></h3>
          <div class="my-group-list" id="my-group-list">
          </div>
        </div>
      </div>
      <%} %>
    </div>
    <div class="header_right_bg">
	<%if(isLogin) { %>
      <table  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><span class="welcome">欢迎您，</span></td>
          <td><div class="dropMenuMaJiaDiv"><span class="currentMemberName"></span> <small  id="changeMaJia">▼</small>
              <div class="dropMenuMaJia displayNone">
                <h3>更换马甲</h3>
                <div class="MaJiaList" id="MaJiaList"></div>
              </div>
            </div></td>
           <td>|&nbsp;<a href="<%=site%>/pages/index.jsp">圈子首页</a>&nbsp;</td> 
          <td>|&nbsp;<a href="<%=site%>/pages/ucenter/inbox.jsp">短消息<span class="unreadCount displayNone">(<b></b>)</span></a>&nbsp;</td>
          <td>|&nbsp;<a href="<%=site%>/pages/ucenter/inbox.jsp">个人中心</a>&nbsp;</td>
          <td>|&nbsp;<a href="<%=site%>/pages/ucenter/favorite.jsp">收藏夹</a>&nbsp;</td>
          <td>|&nbsp;[<a href="<%=site%>/pages/logout.jsp?logout=true" class="_loginOut">退出</a>]</td>
        </tr>
      </table><%} else {%>
          <a href="<%=site%>/pages/login.jsp" class="login">登录</a>&nbsp;|&nbsp;<a href="<%=site%>/pages/index.jsp">圈子首页</a>
         <script>
		 if(typeof(json) != "undefined" && typeof(json.groupAddr) != "undefined") {
		    $j(".login").attr("href",$j(".login").attr("href")+"#"+json.groupAddr);
		 }
         </script>
	  <%} %>
    </div>

  </div>
</div>
<textarea id="myGroupsList_template" style="display:none">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <thead>
    <tr>
      <th align="left">我加入的圈子</th>
      <th align="right" class="dateHeader">创建日期</th>
    </tr>
  </thead>
  <tbody>
  {for group in groups}
    <tr>
      <td><a href="<%=site%>/\${group.addr}/index.jsp" onfocus="return this.blur()">\${group.name|escape}</a></td>
      <td class="date">\${group.creationDate|escape}</td>
    </tr>
    {/for}
  </tbody>
</table>
</textarea>
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

