<?php

//activates the session

session_start();

// process form

if ($_POST['submit']) {

include_once ("config.php");
$uploadDir = '/home/content/68/9375868/html/video_uploads/'; // YOUR directory here
$uploadFile = $uploadDir . $_FILES['video_content']['name'];   // this will be the NEW complete path.
$webPath = "http://meta5.co/video_uploads/" . $_FILES['video_content']['name'];  // web path



if (move_uploaded_file($_FILES['video_content']['tmp_name'], $uploadFile)) {

$sql = "INSERT INTO user_video (memberID, video_content, video_title, video_screenshot, video_description) VALUES
('$_SESSION[memberID]', '$webPath', '$_POST[video_title]', '$_POST[video_screenshot]', '$_POST[video_description]')";

if (mysql_query($sql)) {

echo "<a href = \"$webPath\">$_POST[video_title]</a>&nbsp;".'has been successfully uploaded';

} else {

echo mysql_error();
}

} else {

echo 'file not uploaded';
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

body {background: #FFFFFF; width: 800px;}
#container {margin: 10px auto; text-align: center;}
.video_page {text-align: center;}
.video {width: 400px; height: 300px; padding: 15px; border: 1px solid #CCCCCC; border-bottom: none;font-family: helvetica, arial, times new roman; font-size: 11px; font-weight: bold;}
.f-left {float: left;}
.f-right {float: right;}
.video ul {margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 140px;}
.video ul li {display: block;}
.button {width: 400px; padding: 15px; text-align: center; border: 1px solid #CCCCCC; border-top: none;}

</style>

</head>
<body>

<div id="container">

	<div class="video_page">
	
<!-- video form -->

		<form enctype="multipart/form-data" action = "audio.php" method = "POST">
			
			<input type="hidden" name="MAX_FILE_SIZE" value="30000000" />
			
			
			<div class="video">
		
				<span class="f-left;">
		
					<ul style="margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 120px; float: left; display: block;">
		
						<li>UPLOAD:</li>
						<li>TITLE:</li>
						<li>SCREENSHOT:</li>
						<li>DESCRIPTION:</li>
						
					</ul>
			
				</span>
		
				<span class="f-left">
			
					<ul style="margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 120px; float: left; display: block;">
		
						<li><input type="file" name="video_content" /></li>
						<li><input type="text" name="video_title" /></li>
						<li><input type="file" name="video_screenshot" /></li>
						<li><textarea rows="10" cols="26" name="video_description" /></textarea></li>
				
					</ul>
		
				</span>	
			
			</div>
		
			<div class="button">
	
				<input type="submit" name="submit" value="Submit">

			</div>
	
	
		</form>
		
<!-- end video form -->

	</div>	
	
</div>

</body>
</html>