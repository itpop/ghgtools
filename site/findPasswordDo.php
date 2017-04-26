<?php
    // Fred Yang. 2016-10-06
	// Updates the user's password with a temporary one (5-bit) 
	
	include "base.php";
	include "global.php";
	
	$email = $_POST['email'];
	$passwd = substr(uniqid('', true), -5);

	if(!empty($email)) {
		$params = array(
						array(&$email, SQLSRV_PARAM_IN),
						array(&$passwd, SQLSRV_PARAM_IN)
						);

		$sql = "EXEC dbo.spUserFindPassword @email=?, @passwd=?";
		$stmt = sqlsrv_prepare($con, $sql, $params);
		
		if($stmt && sqlsrv_execute($stmt)) {
			sqlsrv_next_result($stmt);
			showMessage($passwd);
		} else {
			showMessageRedirect(RECOVER_MSG2, 2);
		}
		
		sqlsrv_free_stmt($stmt);
	}
	
?>