<?php 
// Fred Yang. 2016-10-06
include "base.php"; 

if(!empty($_SESSION['UserId'])) {
	$userId = $_SESSION['UserId'];
	$email = '';
	$firstName = '';
	$lastName = '';
	$phone = '';
	$address = '';
	
	$params = array(
				array(&$userId, SQLSRV_PARAM_IN, null, SQLSRV_SQLTYPE_INT),
				array(&$email, SQLSRV_PARAM_INOUT, null, SQLSRV_SQLTYPE_VARCHAR(30)),
				array(&$firstName, SQLSRV_PARAM_INOUT, null, SQLSRV_SQLTYPE_VARCHAR(30)),
				array(&$lastName, SQLSRV_PARAM_INOUT, null, SQLSRV_SQLTYPE_VARCHAR(30)),
				array(&$phone, SQLSRV_PARAM_INOUT, null, SQLSRV_SQLTYPE_VARCHAR(15)),
				array(&$address, SQLSRV_PARAM_INOUT, null, SQLSRV_SQLTYPE_VARCHAR(70))
				);

	$sql = "EXEC dbo.spUserInfo @userId=?, @email=?, @firstName=?, @lastName=?, @phone=?, @address=?";
	$stmt = sqlsrv_prepare($con, $sql, $params);

	if($stmt && sqlsrv_execute($stmt)) {
		sqlsrv_next_result($stmt);
	}
	else {
		die( print_r( sqlsrv_errors(), true));
	}
	
	sqlsrv_free_stmt($stmt);
} else {
	header("location:javascript://history.go(-1)");
}
?>
<html lang="en">
 <head>
  <title>Edit Profile</title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="style/form.css">
  <script language="JavaScript" src="include/global.js" type="text/javascript"></script>  
  <script>
		/* 
			Validate first name using regular expression 
			Allowed: a-z, A-Z, dash(-), and underscore(_)
			Not allowed: numbers and invalid characters (#`!@$%, etc)
		*/
		function validateFirstName(){
			var name = $$('firstName', document);
			var pattern = /^[a-zA-Z_-]+$/;
			//if(name.value == null || name.value == '') return true;
			var val = name.value.replace(/\s/g, '');
			if(!pattern.test(val) || val.length < 2) {
				$$('errFirstName', document).innerHTML = "<span class=msg>Only letters, dashes, and underscores are allowed.</span>";
				return false;
			} else {
				$$('errFirstName', document).innerHTML = null;
				return true;
			}
		}
		
		/* 
			Validate last name using regular expression 
			Allowed: a-z, A-Z, dash(-), and underscore(_)
			Not allowed: numbers and invalid characters (#`!@$%, etc)
		*/
		function validateLastName(){
			var name = $$('lastName', document);
			var pattern = /^[a-zA-Z_-]+$/;
			//if(name.value == null || name.value == '') return true;
			var val = name.value.replace(/\s/g, '');
			if(!pattern.test(val) || val.length < 2) {
				$$('errLastName', document).innerHTML = "<span class=msg>Only letters, dashes, and underscores are allowed.</span>";
				return false;
			} else {
				$$('errLastName', document).innerHTML = null;
				return true;
			}
		}
		
		/* 
			Validate phone number. valid #: 
			(123)456-7890, +(123)456-7890, +(123)-456-7890,
			+(123)-456-7890, +(123)-456-78-90, 123-456-7890,
			123.456.7890, 1234567890, +31636363634, 075-63546725
		*/
		function validatePhone(){
			var phone = $$('phone', document);
			var pattern = /^[+]*[(]{0,1}[0-9]{1,3}[)]{0,1}[-\s\./0-9]*$/g;
			if(phone.value == null || phone.value == '') return true;
			var val = phone.value.replace(/\s/g, '');
			if(!pattern.test(val)) {
				$$('errPhone', document).innerHTML = "<span class=msg>Please enter a valid phone number (eg. 604.123.4567)</span>";
				return false;
			} else {
				$$('errPhone', document).innerHTML = null;
				return true;
			}
		}
		
		//validate password
		function validatePassword() {
			var password = $$('oldPassword', document);
			if(password.value == null || password.value == '') return true;
			if (password.value.length < 3) {
				$$('errPassword', document).innerHTML = "<span class=msg>Please enter your password.</span>";
				return false;
			} else {
				$$('errPassword', document).innerHTML = null;
				return true;
			}
		}
		
		function validatePassword1() {
			var newPassword = $$('newPassword', document);
			var newPassword1 = $$('newPassword1', document);
			if((newPassword.value == null || newPassword.value == '') 
				&& (newPassword1.value == null || newPassword1.value == '')) return true;
			if (newPassword.value != newPassword1.value || newPassword.value.length < 3) {
				//newPassword1.focus();
				$$('errPassword1', document).innerHTML = "<span class=msg>Password not matched.</span>";
				return false;
			} else {
				$$('errPassword1', document).innerHTML = null;
				return true;
			}
		}
		
		//validate form
		function validateForm(){
			var result = validateFirstName();
			if(result) result = validateLastName();
			if(result) result = validatePhone();
			if(result) result = validatePassword();
			if(result) result = validatePassword1();
			return result;
		}
  </script>  
 </head>
 <body>	
	<?php include "header.php"; ?>
	<div id="content">
		<div class="profile_content">
			<form id="profileForm" name="profileForm" action="editProfileDo.php" method="post" onsubmit="return validateForm()">
				<table class="content1">
					<tr>
						<td class="header1" colspan="2">Edit Profile</td>
					</tr>
					<tr>
						<td colspan="2" class="header2"><b><label for="realName">About You</label></b></td>
					</tr>
					<tr>
						<td class="postheader"><label for="email">Your email address</label></td>
						<td class="post">
							<input type="text" name="email" id="email" maxlength="50" size="30" value="<?php echo $email;?>" readonly>
						</td>
					</tr>
					<tr>
						<td class="postheader"><label for="firstName">What's your first name?</label></td>
						<td class="post">
							<input type="text" name="firstName" id="firstName" maxlength="30" size="30" value="<?php echo $firstName;?>" required>
							<div id="errFirstName"></div>
						</td>
					</tr>
					<tr>
						<td class="postheader"><label for="lastName">What's your last name?</label></td>
						<td class="post">
							<input type="text" name="lastName" id="lastName" maxlength="30" size="30" value="<?php echo $lastName;?>" required>
							<div id="errLastName"></div>
						</td>
					</tr>
					<tr>
						<td class="postheader"><label for="phone">Phone number</label></td>
						<td class="post">
							<input type="text" name="phone" id="phone" maxlength="15" size="30" value="<?php echo $phone;?>">
							<div id="errPhone"></div>
						</td>
					</tr>
					
					<tr>
						<td colspan="2" class="header2"><b><label for="address">Address</label></b></td>
					</tr>
					<tr>
						<td class="postheader"><label for="address">Where do you live?</label></td>
						<td class="post"><input type="text" name="address" id="address" maxlength="70" size="50" value="<?php echo $address;?>"></td>
					</tr>
					<tr>
						<td colspan="2" class="header2"><b><label for="oldPassword">Change Password</label></b></td>
					</tr>
					<tr>
						<td class="postheader"><label for="oldPassword">Old Password</label></td>
						<td class="post">
							<input type="password" name="oldPassword" id="oldPassword" maxlength="10" size="30" onblur="validatePassword()" required>
							<div id="errPassword"></div>
						</td>
					</tr>
					<tr>
						<td class="postheader"><label for="newPassword">New Password</label></td>
						<td class="post"><input type="password" name="newPassword" id="newPassword" maxlength="10" size="30"></td>
					</tr>
					<tr>
						<td class="postheader"><label for="newPassword1">Retype Password</label></td>
						<td class="post">
							<input type="password" name="newPassword1" id="newPassword1" maxlength="10" size="30" onblur="validatePassword1()">
							<div id="errPassword1"></div>
						</td>
					</tr>
					
					<tr>
						<td class="footer1" colspan="2">
							<input type="submit" name="Save" value="Save">&nbsp;&nbsp;
							<input type="reset" name="Cancel" value="Cancel">
						</td>
					</tr>
				</table>
			</form>	
		</div>
	</div>
	<?php include "footer.php"; ?>
 </body>
</html>
