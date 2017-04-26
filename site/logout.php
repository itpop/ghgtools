<?php
// Fred Yang. 2016-10-06
session_start();
session_unset();
session_destroy();

header("location:index.php");
exit();
?>