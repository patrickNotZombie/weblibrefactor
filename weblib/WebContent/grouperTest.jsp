
<%@page import="java.awt.*"%>
<%@page import="java.io.*"%>
<%@page import="com.sun.image.codec.jpeg.*"%>
<jsp:directive.page import="java.awt.image.BufferedImage"/>
<jsp:directive.page import="com.dcampus.groups.util.Thumbnail"/>
<%
	int quality = 50;
	String fileName = "/home/groups/resource/webapps/ROOT/WEB-INF/resource/118/1297499905121.JPG";
	File _file = new File(fileName); // 读入文件
	BufferedImage img = javax.imageio.ImageIO.read(_file); // 构造Image对象
	int	width = img.getWidth(null); // 得到源图宽
	int	height = img.getHeight(null); // 得到源图长
	out.println(width);
	
	
	Thumbnail thum = new Thumbnail(_file, _file.getParent(), "min.JPG");
	out.println(thum.resize(0.5,50));
	/*
	String outFilename = "/home/groups/resource/webapps/ROOT/min_a.jpg";
	Image image = Toolkit.getDefaultToolkit().getImage(filename);
	       MediaTracker mediaTracker = new MediaTracker( new Container());
	       mediaTracker.addImage(image, 0);
	       try {

	           mediaTracker.waitForID(0);

	           int imageWidth = image.getWidth( null );

	           int imageHeight = image.getHeight( null );

	           int thumbHeight = imageHeight;
	           
	           int thumbWidth = imageWidth;
	           
	           BufferedImage thumbImage = new BufferedImage(thumbWidth,

	                  thumbHeight, BufferedImage.TYPE_INT_RGB );

	           Graphics2D graphics2D = thumbImage.createGraphics();

	           graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION ,

	                  RenderingHints.VALUE_INTERPOLATION_BILINEAR );

	           graphics2D.drawImage(image, 0, 0, thumbWidth, thumbHeight, null );

	           // save thumbnail image to outFilename

	           BufferedOutputStream outStream = new BufferedOutputStream(

	                  new FileOutputStream(outFilename));

	 

	           JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder (outStream);

	           JPEGEncodeParam param = encoder

	                  .getDefaultJPEGEncodeParam(thumbImage);

	           quality = Math.max (0, Math.min (quality, 100));

	           param.setQuality(( float ) quality / 100.0f, false );

	           encoder.setJPEGEncodeParam(param);

	           encoder.encode(thumbImage);

	           outStream.close();

	       } catch (Exception e) {
	           // TODO Auto-generated catch block
	           e.printStackTrace();
	       }*/
%>