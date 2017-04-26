<?php 
// Fred Yang. 2016-10-06
include "base.php"; 
?>
<?php
if(!empty($_SESSION['UserId'])) {
	$userName = $_SESSION['FirstName'];
	echo "Welcome, $userName <a href='editProfile.php' target='_parent'><img src='images/profile.gif' alt='Profile' title='Profile'></a>&nbsp;&nbsp;&nbsp;";
	echo "<a href=# onclick='confirmLogout()'>logout</a>";
} elseif(!empty($_POST['email']) && !empty($_POST['password'])) {
	$email = $_POST['email'];
	$passwd = $_POST['password'];
	$userId = 1;
	$firstName = 'abcdefghijklmnopq';
	$params = array(
				array(&$email, SQLSRV_PARAM_IN),
				array(&$passwd, SQLSRV_PARAM_IN),
				array(&$userId, SQLSRV_PARAM_INOUT),
				array(&$firstName, SQLSRV_PARAM_INOUT)
				);

	$sql = "EXEC dbo.spUserFind @email = ?, @passwd = ?, @userId = ?, @firstName = ?";
	$stmt = sqlsrv_prepare($con, $sql, $params);

	if($stmt && sqlsrv_execute($stmt)) {
		sqlsrv_next_result($stmt);
		if($userId > 1) {
			$_SESSION['UserId'] = $userId;
			$_SESSION['FirstName'] = $firstName;
			echo "<meta http-equiv='refresh' content='0; url=loginPanel.php' />";
		}
		else {
			showPanel(1);
			//echo "err1";
		}
	}
	else {
		showPanel(1);
		//echo "err1a";
	}
	
	sqlsrv_free_stmt($stmt);
} else {
	showPanel(0);
	//echo "err12";
}
?>