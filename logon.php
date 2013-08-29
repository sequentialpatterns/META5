<?php
// process form
if ($_POST['submit']) {
	include_once ("config.php");
	$sql = "SELECT * FROM user_info WHERE username = 
	'$_POST[username]' AND password = '$_POST[password]'";
	$result = mysql_query($sql);
	if (mysql_num_rows($result) > 0) {
		$row = mysql_fetch_array($result);
		session_start();
		$_SESSION = array();
		$_SESSION['memberID'] = $row['memberID'];
		$_SESSION['username'] = $row['username'];
		$_SESSION['avatar'] = $row['avatar'];
		header("Location: http://meta5.co/audio/index.php");
		exit;
	} else {
		echo 'error: ' . mysql_error();
		echo 'user info is not found in the DB.';
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
p {margin-top: -10px; font: 14px arial, helvetica, times new roman;}
body {position: fixed; top: 0; left: 0; width: 99%; height: 100%; background: url(../img/7.png); background-repeat: no-repeat;}
.header {width: 101%; background: #EDEDED; font: 12px arial, helvetica, times new roman; margin: -8px -7px 5px -7px; padding: 12px 0px 15px; text-align: left; border-bottom: 1px solid #CCC;}
.uData {margin-left: 10px;}
.uAvatar {margin-left: 5px; float: left; width: 30px; height: 30px; border: 1px solid #CCC; padding: 2px; margin-top: -10px;}
#container {margin: 100px auto 0px auto; text-align: center; width: 370px; clear: both;}
.audio_page {text-align: left;}
.audio {background: #FFF; width: 500px; height: 300px; padding: 15px; border: 1px solid #9C9C9C; font-family: helvetica, arial, times new roman; font-size: 11px; font-weight: bold; -moz-box-shadow: 0px 0px 47px #FFF; -webkit-box-shadow: 0px 0px 47px #FFF; -moz-border-radius: 5px; -webkit-border-radius: 5px;}
.f-left {float: left;}
.f-right {float: right;}
.audio ul {margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 140px;}
.audio ul li {display: block;}
.button {width: 415px; margin-top: -45px; padding: 5px 5px 10px 5px; text-align: center; clear: both;}
span, a {font: 12px arial, helvetica; text-decoration: none;}
.upload:hover, .vidView:hover, a:hover {cursor: pointer; text-decoration: underline;}
</style>
</head>
<body>

<div id="container" style="margin-top: 150px;">

	<div class="audio_page">

<!-- audio form -->

		<form enctype="multipart/form-data" action = "logon.php" method = "POST">

			<input type="hidden" name="MAX_FILE_SIZE" value="50000000" />


			<div class="audio" style="height: 250px;">
				<h1>LOGON</h1>
				<p>Now is your chance to make it happen!</p>
				<div style="border: 1px solid #CCC; padding: 10px; background: #FCFCFC; -moz-border-radius: 5px; -webkit-border-radius: 5px;">
					<span class="f-left;">
	
						<ul style="margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 120px; float: left; display: block;">
	
							<li>USERNAME:</li>
							<li>PASSWORD:</li>
							
						</ul>
	
					</span>
	
					<span class="f-left">
	
						<ul style="margin: 0px; padding: 0px; list-style-type: none; list-style-image: none; line-height: 2.5em; width: 120px; float: left; display: block;">
	
							<li><input type="text" name="username" /></li>
							<li><input type="password" name="password" /></li>
						</ul>
	
					</span>
					<div class="button"><input type="submit" name="submit" value="Submit"></div>
					<p style="font-size: 12px; width: 225px; margin: 0px 0px -15px !important;">Forgot your <span><a href="#">password</a>/<a href="#">login</a></span>?</p>
					<p style="padding-top: 20px; clear: both; font: 12px arial, helvetica, times new roman;">If you don't have a uname and password please <a href="registration.php">register here</a>.</p>
				</div>
			</div>
		</form>

<!-- end audio form -->

	</div>
	
	<div class="audio" style="border-bottom: none; opacity: 0.35; height: 10px; margin-top: 20px;"></div>

</div>

</body>
</html>
