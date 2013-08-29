<?php

$database_username = "meta5";
$database_password = "Jeruz@lem1";
$database_host = "meta5.db.9375868.hostedresource.com";
$database_name = "meta5"; 

$handle =& mysql_connect ($database_host, $database_username, $database_password) or die (mysql_error());
$db_select = mysql_select_db ($database_name, $handle) or die (mysql_error());

?>