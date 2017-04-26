<?php
    // Fred Yang. 2016-10-06
	// Saves user's updated information (realName, password, email, gender, age,
	// city, occupation, hobbies, userIp) when the form is submitted.
	
	include "base.php";
	include "global.php";
	
	$userId = $_SESSION['UserId'];
	$email = $_POST['email'];
	$firstName = $_POST['firstName'];
	$lastName = $_POST['lastName'];
	$phone = $_POST['phone'];
	$address = $_POST['address'];
	$passwd = $_POST['oldPassword'];
	$passwd1 = $_POST['newPassword'];
	$level = 1;
	$isValid = 1;
	$joinDate = null;
	
	if(!empty($email)) {
		$params = array(
						array(&$userId, SQLSRV_PARAM_INOUT),
						array(&$email, SQLSRV_PARAM_IN),
						array(&$passwd, SQLSRV_PARAM_IN),
						array(&$passwd1, SQLSRV_PARAM_IN),
						array(&$firstName, SQLSRV_PARAM_IN),
						array(&$lastName, SQLSRV_PARAM_IN),
						array(&$phone, SQLSRV_PARAM_IN),
						array(&$address, SQLSRV_PARAM_IN),
						array(&$joinDate, SQLSRV_PARAM_IN),
						array(&$level, SQLSRV_PARAM_IN),
						array(&$isValid, SQLSRV_PARAM_IN)
						);

		$sql = "EXEC dbo.spUserUpdate @userId=?, @email=?, @passwd=?, @passwd1=?, @firstName=?, @lastName=?,"
				."@phone=?, @address=?, @joinDate=?, @level=?, @isValid=?";
		$stmt = sqlsrv_prepare($con, $sql, $params);
		if($stmt && sqlsrv_execute($stmt)) {
			sqlsrv_next_result($stmt);
			if($userId > 1) {
				$_SESSION['FirstName'] = $firstName;
				showMessageRedirect(EDIT_MSG, 0);
				sqlsrv_free_stmt($stmt);
				return;
			}
		}
		/*else {
			die( print_r( sqlsrv_errors(), true));
		}*/
		
		sqlsrv_free_stmt($stmt);
	}
	showMessageRedirect(EDIT_MSG1, 2);
	
?>