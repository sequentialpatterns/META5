<?php
session_start();
include_once ('../config.php');
$userID = $_SESSION['memberID'];
if (empty($userID)){
	header('Location: http://www.meta5.co/logon.php');
	exit;
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd"><html>
<head>
	<title>meta5</title>
	<meta name="description" content="" />
	<meta name="keywords" content="">
	<meta name="author" content="Kwansah Madani Interactive" />
	<style media="all" type="text/css">@import "../script/styles.css";</style>
	<script src="AC_RunActiveContent.js" language="javascript"></script>	
</head>
<body>
<!-- container begins -->
<div class="myImage">

	
			<script language="javascript">
					if (AC_FL_RunContent == 0) {
						alert("This page requires AC_RunActiveContent.js.");
					} else {
					AC_FL_RunContent(
						'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0',
						'width', '100%',
						'height', '100%',
						'src', 'metavideo',
						'quality', 'high',
						'pluginspage', 'http://www.macromedia.com/go/getflashplayer',
						'align', 'middle',
						'play', 'true',
						'loop', 'true',
						'scale', 'exactfit',
						'wmode', 'window',
						'devicefont', 'false',
						'id', 'metavideo',
						'bgcolor', '#F8F8F8',
						'name', 'metavideo',
						'menu', 'true',
						'allowFullScreen', 'true',
						'allowScriptAccess','sameDomain',
						'movie', 'metavideo',
						'salign', ''
					); //end AC code
				}
			</script>
			<noscript>
				<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="100%" height="100%" id="metavideo" align="middle">
				<param name="allowScriptAccess" value="sameDomain" />
				<param name="allowFullScreen" value="true" />
				<param name="movie" value="metavideo.swf" /><param name="quality" value="high" /><param name="scale" value="exactfit" /><param name="bgcolor" value="#F8F8F8" />	<embed src="metavideo.swf" quality="high" scale="exactfit" bgcolor="#F8F8F8" width="100%" height="100%" name="metavideo" align="middle" allowScriptAccess="sameDomain" allowFullScreen="true" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
				</object>
			</noscript>


</div>

	<!-- footer begins -->
	
	<div class="footer2">
		
		<ul>
						
			<li>KWANSAH MADANI</li>
			<li>ID: 01002463</li>
			<li>MFA: CANM</li>
			<li>FINAL REVIEW</li>
			<li>META5 PLAYER</li>
			<li>05.20.2009</li>
						
		</ul>
			
	</div>
	
	<!-- footer ends -->

</div>

<!-- container ends -->
		
</body>
</html>
