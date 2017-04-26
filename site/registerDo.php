<?php
    // Fred Yang. 2016-10-06
	// Stores user's information (firstName, lastName, password, email,etc)
	// upon form submission.
	include "base.php";
	include "global.php";

	$email = $_POST['email'];
	$firstName = $_POST['firstName'];
	$lastName = $_POST['lastName'];
	$passwd = $_POST['password'];
	$phone = "6041234567";
	$address = "123";
	$userId = 1;
	$level = 1;
	$isValid = 1;
	$passwd1 = null;
	$joinDate = null;

	if(!empty($email) && !empty($passwd)) {
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
				showMessageRedirect(REGISTER_SUCCESS, 0);
				sqlsrv_free_stmt($stmt);
				return;
			}
		}
		/*else {
			die( print_r( sqlsrv_errors(), true));
		}*/
		
		sqlsrv_free_stmt($stmt);
	}
	showMessageRedirect(REGISTER_ERROR, 1);
	
?>