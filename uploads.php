<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<title>meta5</title>
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<meta name="author" content="Kwansah Madani Interactive" />
<style type="text/css">
a {color: #0099CC; text-decoration: none;}
a:hover {text-decoration: underline;}
p {font: 14px arial, helvetica, times new roman;}
body {position: fixed; top: 0; left: 0; width: 99%; height: 100%; background: url(../img/7.png); background-repeat: no-repeat;}
.header {width: 101%; background: #EDEDED; font: 12px arial, helvetica, times new roman; margin: -8px -7px 5px -7px; padding: 12px 0px 15px; text-align: left; border-bottom: 1px solid #CCC;}
.uData {margin-left: 10px;}
.uAvatar {margin-left: 5px; float: left; width: 30px; height: 30px; border: 1px solid #CCC; padding: 2px; margin-top: -10px;}
#container {margin: 140px auto 0px auto; text-align: center; width: 370px; clear: both;}
.audio_page {text-align: left;}
.audio {background: #FFF; width: 400px; height: 300px; padding: 15px; border: 1px solid #9C9C9C; font-family: helvetica, arial, times new roman; font-size: 11px; font-weight: bold; -moz-box-shadow: 0px 0px 47px #FFF; -webkit-box-shadow: 0px 0px 47px #FFF; -moz-border-radius: 5px; -webkit-border-radius: 5px;}
.f-left {float: left;}
.f-right {float: right;}
.audio ul {margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 140px;}
.audio ul li {display: block;}
.button {width: 370px; padding: 5px 5px 10px 5px; text-align: center; clear: both;}
span, a {font: 12px arial, helvetica; text-decoration: none;}
.upload:hover, .vidView:hover, a:hover {cursor: pointer; text-decoration: underline;}
.popOut {width: 380px; height: 135px; background: #FCFCFC; padding: 25px 10px; border: 1px solid #666; -moz-border-radius: 5px; -webkit-border-radius: 5px;}
.myOpt {margin-top: 10px;}
.cpanel {width: 206px; height: 80px; /*position: fixed; bottom: 0; opacity: 1;*/ background: url(img/controlp.png); margin: 10px 0px 10px 85px; background-repeat: no-repeat; text-align: center; -moz-box-shadow: 0px 0px 5px #666; -webkit-box-shadow: 0px 0px 5px #666; -moz-border-radius: 5px; -webkit-browser-radius: 5px;}
.controls {float: left;}
#audio, #video, #info, #search {width: 60px; height: 60px; margin: 10px 0px 0px 0px;}
#audio {background: url(img/caudio.png); background-repeat: no-repeat; margin-left: 14px;}
#audio:hover {background: url(img/caudio_over.png); background-repeat: no-repeat; cursor: pointer;}
#video {background: url(img/cvideo.png); background-repeat: no-repeat;}
#video:hover {background: url(img/cvideo_over.png); background-repeat: no-repeat; cursor: pointer;}
#info {background: url(img/cinfo.png); background-repeat: no-repeat;}
#info:hover {background: url(img/cinfo_over.png); background-repeat: no-repeat; cursor: pointer;}
#navaudio, #navideo, #navinfo, #search, #navuploads {width: 60px; height: 60px; margin: 10px -2px 0px 0px;}
#navaudio {background: url(img/nav_audio.png); background-repeat: no-repeat; margin-left: 12px;}
#navaudio:hover {background: url(img/nav_audio_over.png); background-repeat: no-repeat; cursor: pointer;}
#navideo {background: url(img/nav_video.png); background-repeat: no-repeat;}
#navideo:hover {background: url(img/nav_video_over.png); background-repeat: no-repeat; cursor: pointer;}
#navinfo {background: url(img/nav_home.png); background-repeat: no-repeat;}
#navinfo:hover {background: url(img/nav_home_over.png); background-repeat: no-repeat; cursor: pointer;}
#search {background: url(img/nav_search.png); background-repeat: no-repeat;}
#search:hover {background: url(img/nav_search.png); background-repeat: no-repeat; cursor: pointer;}
#navuploads {background: url(img/nav_uploads.png); background-repeat: no-repeat;}
#navuploads:hover {background: url(img/nav_uploads_over.png); background-repeat: no-repeat; cursor: pointer;}
.containerFX {margin: 0px auto; width: 400px; text-align: center;}
.levelFX {background: url(img/cpanel.png); background-repeat: no-repeat; position: fixed; bottom: 0;width: 315px; height: 80px; text-align: center; margin: -40px 0px 10px 73px; text-align: center; -moz-box-shadow: 0px 0px 5px #666; -webkit-box-shadow: 0px 0px 5px #666; -moz-border-radius: 10px; -webkit-browser-radius: 10px;}
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script>
$(document).ready(function() {
	
	$('.levelFX').css({'opacity':'0'}).slideUp(0);
	$(window).bind('scroll resize', function(){
		$(".levelFX").css({'bottom': '0'});
	});
	$('.levelFX').css({'opacity':'1'}).delay(1000).slideDown(350);
		
});
</script>
</head>
<body>
<div id="container">
	<div class="audio">
		<div class="audio_page">
			<h1>UPLOADS</h1>
			<p style="line-height: 1.5em;">You can always add more files to further your experience with the META5. Please choose from the options below.</p>
		</div>
		<div class="popOut">
			<div class="myOpt">
				<span><a href="audio/upload.php">ADD MUSIC</a></span><span> | </span><span><a href="information.html">LEARN MORE</a></span><span> | </span><span><a href="video/upload.php">ADD VIDEOS</a></span>
			</div>
			<div class="cpanel">
				<div class="controls" id="audio"><a href="audio/upload.php"><img src="img/spaceholder.png" /></a></div>
				<div class="controls" id="info"><a href="information.html"><img src="img/spaceholder.png" /></a></div>
				<div class="controls" id="video"><a href="video/upload.php"><img src="img/spaceholder.png" /></a></div>
				<!--<div class="controls" id="search">&#160;</div>-->
			</div>
		</div>
	</div>
	<div class="audio" style="border-bottom: none; opacity: 0.35; height: 10px; margin-top: 20px;"></div>
</div>
<div class="containerFX">
	<div class="levelFX">
		<div class="controls" id="navaudio"><a href="audio/index.php"><img src="img/spaceholder.png" /></a></div>
		<div class="controls" id="navideo"><a href="video/index.php"><img src="img/spaceholder.png" /></a></div>
		<div class="controls" id="navuploads"><a href="uploads.php"><img src="img/spaceholder.png" /></a></div>
		<div class="controls" id="search"><img src="img/spaceholder.png" /></div>
		<div class="controls" id="navinfo"><a href="information.html"><img src="img/spaceholder.png" /></a></div>
	</div>
</div>
</body>
</html>