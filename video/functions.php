<?php
session_start();
include_once ("../config.php");
$userID = $_SESSION['memberID'];
//echo $userID;
createUserXML($userID);
function createUserXML($userID) {
header("Content-type: text/xml");
echo "<?xml version='1.0' encoding='ISO-8859-1'?>";
echo "<manual>";

//get user songs
$sql = "SELECT * FROM user_video WHERE user_id 
= '$userID'";

//print_r('$userID');

$result = mysql_query($sql);
while ($row = mysql_fetch_array($result)) {

echo "<item>";
echo "<title>$row[video_title]</title>";
echo "<asset>$row[video_screenshot]</asset>";
echo "<promo>$row[video_description]</promo>";
echo "<recording>$row[video_artist]</recording>";
echo "<caption>$row[video_content]</caption>";
echo "</item>";
}

echo "</manual>";
}
?>
