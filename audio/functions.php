<?php
session_start();
include_once ("../config.php");
$userID = $_SESSION['memberID'];
createUserXML($userID);
function createUserXML($userID) {
header("Content-type: text/xml");
echo "<?xml version='1.0' encoding='ISO-8859-1'?>";
echo "<PPGallery>";
$sql = "SELECT * FROM user_audio WHERE user_id 
= '$userID' ORDER BY audio_artist";
$result = mysql_query($sql);
while ($row = mysql_fetch_array($result)) {
uksort($row, 'strcasecmp');
echo "<item>";
echo "<title>$row[audio_artist]</title>";
echo "<thumb>$row[audio_screenshot]</thumb>";
echo "<full>$row[audio_screenshot]</full>";
echo "<caption>$row[audio_album]</caption>";
echo "<recording>$row[audio_label]</recording>";
echo "<description>$row[audio_description]</description>";
echo "<track_list>";
echo "<track>";
echo "<number>$row[audio_number]</number>";
echo "<title>$row[audio_title]</title>";
echo "<time>$row[audio_time]</time>";
echo "<url>$row[audio_content]</url>";
echo "</track>";
echo "</track_list>";
echo "</item>";
}
echo "</PPGallery>";
}
?>
