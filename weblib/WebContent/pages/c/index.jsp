<%@ page contentType="text/html;charset=utf-8" %>
<%@include file="checklogin.jsp"%>
<!doctype html>
<!-- The DOCTYPE declaration above will set the    -->
<!-- browser's rendering engine into               -->
<!-- "Standards Mode". Replacing this declaration  -->
<!-- with a "Quirks Mode" doctype may lead to some -->
<!-- differences in layout.                        -->

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=10" />
    <meta name="gwt:property" content="locale=zh_CN">
    <!--                                                               -->
    <!-- Consider inlining CSS to reduce the number of requested files -->
    <!--                                                               -->
   

    <!--                                           -->
    <!-- Any title is fine                         -->
    <!--                                           -->
    <title>DCampus Weblib</title>
    
    <!--                                           -->
    <!-- This script loads your compiled module.   -->
    <!-- If you add any GWT meta tags, they must   -->
    <!-- be added before this line.                -->
    <!--                                           -->

     <link type="text/css" rel="stylesheet" href="js/jquery-lightbox-0.5/css/jquery.lightbox-0.5.css">
     

     
     <script>if(!<%=isLogin%>){window.location.href = "login.jsp"};</script>
    <script type="text/javascript" language="javascript" src="library/library.nocache.js"></script>
     
    
    <script src="js/jquery-lightbox-0.5/js/jquery.js" type="text/javascript"></script>
    <script src="js/ui.core.js" type="text/javascript"></script>
	<script src="js/ui.draggable.js" type="text/javascript"></script>
    <script src="js/jquery-lightbox-0.5/js/jquery.lightbox-gwt.js" type="text/javascript"></script>
    <link type="text/css" rel="stylesheet" href="Library.css">
     <script>
		/*$.ajax({
			url:"/user/status.action?temp="+Math.random()
			,dataType : "json"
			,type : "get"
			,success : function(data){	
			   if(data.status == "guest") {
				 window.location.href = "login.jsp";
			   }
			}
		});   */  
		function getIsChrome(){
			var ua = navigator.userAgent;
			ua = ua.toUpperCase();
			if(ua.indexOf("CHROME") > 0 ){
				return true;
			}
			return false;
		}

     </script>
     
  </head>

  <!--                                           -->
  <!-- The body can have arbitrary html, or      -->
  <!-- you can leave the body empty if you want  -->
  <!-- to create a completely dynamic UI.        -->
  <!--                                           -->
  <body scroll="no">
  
    <script src="zeroclipboard/ZeroClipboard.js" type="text/javascript"></script>
    <script src="zeroclipboard/myClipboard.js" type="text/javascript"></script>
  </body>

</html>
