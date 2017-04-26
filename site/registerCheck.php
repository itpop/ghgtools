<?php
    // Fred Yang. 2016-10-06
	// Check email availability.
	include "base.php";

	//check if email is empty
	if(isset($_POST["email"]))
	{
		//check if its an ajax request, exit if not
		if(!isset($_SERVER['HTTP_X_REQUESTED_WITH']) 
			AND strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) != 'xmlhttprequest') {
			die();
		} 

		$email = $_POST['email'];
		$result = 0;
		
		//check email in db
		$params = array(
						array(&$email, SQLSRV_PARAM_IN),
						array(&$result, SQLSRV_PARAM_INOUT)
						);

		$sql = "EXEC dbo.spUserCheckEmail @email = ?, @result=?";
		$stmt = sqlsrv_prepare($con, $sql, $params);
		
		if($stmt && sqlsrv_execute($stmt)) {
			sqlsrv_next_result($stmt);
			//if value is more than 0, email is not available
			if($result > 0) {
				echo "<span style='color:red'>This email already exists.</span>";
			}else{
				echo "<span style='color:green'>This email is unique.</span>";
			}
		}
		
		sqlsrv_free_stmt($stmt);
	}
?>