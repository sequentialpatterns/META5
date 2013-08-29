<?php
//activates the session
session_start();
$uname = $_SESSION['username'];
$uavatar = $_SESSION['avatar'];
$uDir = '/home/content/68/9375868/html/audio/music/' . $_SESSION['memberID'] . '/';
$uDirArt = '/home/content/68/9375868/html/audio/asset/photo/' . $_SESSION['memberID'] . '/';
//echo $_SESSION['memberID'] . "<br />";
//echo "<div class='header'><img src='" . $uavatar . "' class='uAvatar' /><span class='uData'>Welcome,&#160;" . $uname . "&#160;|&#160;<a href='../logon.php'>Not&#160;" . $uname . "?</a></span></div>";
// process form
if ($_POST['submit']) {
	include_once ("../config.php");
	//create userID directory if this is your first time uploading music...
	if(!is_dir($uDir)){
		mkdir($uDir, 0777);
	}
	//create userID directory if this is your first time uploading music artwork
	if(!is_dir($uDirArt)){
		mkdir($uDirArt, 0777);
	}
	$uploadDir = $uDir; // YOUR directory here
	// The next lines add the directory of the artist and the album
	$newDirectory = $uploadDir . $_POST['audio_artist'];  // adds the artist/album to the path
	//echo $newDirectory;
	if (!is_dir($newDirectory)){
		if( mkdir( $newDirectory , 0777 ) )
		{
			// print success information
			//echo 'Album folder was created!';
			//echo '<br>folder: <a href="' . $newDirectory . '">' . $newDirectory. '</a>';
			$newDirectory = $uploadDir . $_POST['audio_artist'] . '/' . $_POST['audio_album'] ;  // adds the artist/album to the path
			if(mkdir( $newDirectory , 0777)){
				//echo 'Artist folder was created!';
				//echo '<br>folder: <a href="' . $newDirectory . '">' . $newDirectory. '</a>';
			}  // end if create artist folder
	
		} else {
			$newDirectory = $uploadDir . $_POST['audio_artist'];  // adds the artist/album to the path
			// print error information
			//echo 'an error occurred attempting to create folder';
			//echo '<br>newDirectory: ' . $newDirectory;
			//echo '<br>php_errormsg: ' . $php_errormsg;
		} // end if rs
	} else {
		$newDirectory = $uploadDir . $_POST['audio_artist'] . '/' . $_POST['audio_album'] ;
	}
	//echo "audio content and name" . $_FILES['audio_content']['name'];   // print the file name
	//echo "<br />audio content without name" .  $_FILES['audio_content'];   // print the file name
	//echo "<br />audio content and tmp name" . $_FILES['audio_content']['tmp_name'];   // print the file name
	$uploadFile = $newDirectory . '/' . $_FILES['audio_content']['name'];   // this will be the NEW complete path.
	$webPath = "http://meta5.co/audio/music/" . $_SESSION['memberID'] . '/' . $_POST['audio_artist'] . '/' . $_POST['audio_album'] . '/' . $_FILES['audio_content']['name'] ;  // web path
	//cover art starts here
	$uploadArtDir = $uDirArt; // YOUR directory here
	$artDirectory = $uploadArtDir . $_POST['audio_screenshot'];   // this will be the NEW complete path.
	$uploadArtFile = $artDirectory . '/' . $_FILES['audio_screenshot']['name'];
	$webPathArt = "http://meta5.co/audio/asset/photo/" . $_SESSION['memberID'] . '/' . $_FILES['audio_screenshot']['name'];  // cover art web path
	//echo '<br />';
	//echo 'image can be found here: <a href="' . $artDirectory . '">' . $artDirectory . '</a>';
	//echo '<br />';
	if (move_uploaded_file($_FILES['audio_content']['tmp_name'], $uploadFile)) {
		$sql = "INSERT INTO user_audio ( memberID, audio_content, audio_title, audio_description, audio_album, audio_number, audio_label, audio_artist, audio_screenshot) VALUES ('$_SESSION[memberID]', '$webPath', '$_POST[audio_title]', '$_POST[audio_description]', '$_POST[audio_album]', '$_POST[audio_number]', '$_POST[audio_label]', '$_POST[audio_artist]', '$webPathArt')";
		if (mysql_query($sql)) {
		
		//echo "<a href = \"$webPath\">$_POST[audio_title]</a>&nbsp;".'has been successfully uploaded<br />';
		//echo "<br /><a href=\"$webPathArt\">$webPathArt</a>". 'has been successfully uploaded';
		//session_start();
		//$_SESSION = array();
		//$_SESSION['memberID'] = $row['memberID'];
		//$_SESSION['username'] = $row['username'];
		//$_SESSION['avatar'] = $row['avatar'];
		
		} else {
			echo mysql_error();
		}
	} else {
		echo 'file not uploaded';
	}
	if (move_uploaded_file($_FILES['audio_screenshot']['tmp_name'], $uploadArtFile)) {
		if (empty($_POST['audio_screenshot'])) {
			//echo '<br /><br />As you already knew, this information is returning empty<br />';
		}
		header("Location: http://meta5.co/audio/success.php");
		exit;
	}
}
?>
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
#container {margin: 50px auto 0px auto; text-align: center; width: 470px; clear: both;}
.audio_page {text-align: left;}
.audio {background: #FFF; width: 500px; height: 415px; padding: 15px 15px 20px 15px; border: 1px solid #9C9C9C; font-family: helvetica, arial, times new roman; font-size: 11px; font-weight: bold; -moz-box-shadow: 0px 0px 47px #FFF; -webkit-box-shadow: 0px 0px 47px #FFF; -moz-border-radius: 5px; -webkit-border-radius: 5px;}
h1 {margin-top: 0px;}
.button {width: 420px; padding: 0px 5px; text-align: center; clear: both;}
.f-left {float: left;}
.f-right {float: right;}
.audio ul {margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 140px;}
.audio ul li {display: block;}
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
#navaudio {background: url(../img/nav_audio.png); background-repeat: no-repeat; margin-left: 12px;}
#navaudio:hover {background: url(../img/nav_audio_over.png); background-repeat: no-repeat; cursor: pointer;}
#navideo {background: url(../img/nav_video.png); background-repeat: no-repeat;}
#navideo:hover {background: url(../img/nav_video_over.png); background-repeat: no-repeat; cursor: pointer;}
#navinfo {background: url(../img/nav_home.png); background-repeat: no-repeat;}
#navinfo:hover {background: url(../img/nav_home_over.png); background-repeat: no-repeat; cursor: pointer;}
#search {background: url(../img/nav_search.png); background-repeat: no-repeat;}
#search:hover {background: url(../img/nav_search.png); background-repeat: no-repeat; cursor: pointer;}
#navuploads {background: url(../img/nav_uploads.png); background-repeat: no-repeat;}
#navuploads:hover {background: url(../img/nav_uploads_over.png); background-repeat: no-repeat; cursor: pointer;}
.containerFX {margin: 0px auto; width: 400px; text-align: center;}
.levelFX {background: url(../img/cpanel.png); background-repeat: no-repeat; position: fixed; bottom: 0;width: 315px; height: 80px; text-align: center; margin: -40px 0px 10px 73px; text-align: center; -moz-box-shadow: 0px 0px 5px #666; -webkit-box-shadow: 0px 0px 5px #666; -moz-border-radius: 10px; -webkit-browser-radius: 10px;}
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
</script></head>

</head>
<body>

<div id="container">

	<div class="audio_page">

<!-- audio form -->

		<form enctype="multipart/form-data" action = "upload.php" method = "POST">

			<input type="hidden" name="MAX_FILE_SIZE" value="26000000" />


			<div class="audio">

				<h1>AUDIO UPLOADS</h1>
				<!--<p>Now is your chance to make it happen!</p>-->
				
				<div style="border: 1px solid #CCC; padding: 10px; background: #FCFCFC; -moz-border-radius: 5px; -webkit-border-radius: 5px;">
					<span class="f-left;">
	
						<ul style="margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 120px; float: left; display: block;">
	
							<li>ARTIST:</li>
							<li>ALBUM:</li>
							<li>RECORD LABEL:</li>
							<li>COVER ART:<span style="color: #EB2125;">*</span></li>
							<li>TRACK NAME:</li>
							<li>FILE:</li>
							<li>TRACK #:</li>
							<li>DESCRIPTION:</li>
	
						</ul>
	
					</span>
	
					<span class="f-left">
	
						<ul style="margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 120px; float: left; display: block;">
	
							<li><input type="text" name="audio_artist" /></li>
							<li><input type="text" name="audio_album" /></li>
							<li><input type="text" name="audio_label" /></li>
							<li><input type="file" name="audio_screenshot" value="" /></li>
							<li><input type="text" name="audio_title" /></li>
							<li><input type="file" name="audio_content" /></li>
							<li><input type="text" name="audio_number" /></li>
							<li><textarea rows="6" cols="26" name="audio_description" /></textarea></li>
	
						</ul>
					</span>
					<div class="button"><input type="submit" name="submit" value="Submit"></div>
					<p style="clear: both; color: #EB2125; margin-top: -5px; text-align: left; font: 11px arial, helvetica, times new roman;">*artwork must be 382x258.</p>
				</div>				
			</div>

			

		</form>

<!-- end audio form -->

	</div>
	<div class="audio" style="border-bottom: none; opacity: 0.35; height: 10px; margin-top: 20px;"></div>
</div>
<div class="containerFX">
	<div class="levelFX">
		<div class="controls" id="navaudio"><a href="index.php"><img src="../img/spaceholder.png" /></a></div>
		<div class="controls" id="navideo"><a href="../video/index.php"><img src="../img/spaceholder.png" /></a></div>
		<div class="controls" id="navuploads"><a href="../uploads.php"><img src="../img/spaceholder.png" /></a></div>
		<div class="controls" id="search"><img src="../img/spaceholder.png" /></div>
		<div class="controls" id="navinfo"><a href="../information.html"><img src="../img/spaceholder.png" /></a></div>
	</div>
</div>
</body>
</html>
