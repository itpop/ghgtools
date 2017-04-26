<!doctype html>
<html lang="en">
 <head>
  <title>Recover Password</title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="style/form.css"> 
  <script language="JavaScript" src="include/global.js" type="text/javascript"></script>  
  <script>		
		function validateEmail() {
			var email = $$('email', document);
			var pattern = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			if (!pattern.test(email.value)) {
				//email.focus();
				$$('errEmail', document).innerHTML = "<span class=msg>youremail@example.com</span>";
				return false;
			} else {
				$$('errEmail', document).innerHTML = null;
				return true;
			}			
		}
		
		//validate form
		function validateForm(){
			var result = validateEmail();
			return result;
		}
  </script>   
 </head>
 <body>
	<?php include "header.php"; ?>

	<div id="content">
		<div class="findpassword_content">
			<form id="findPassForm" name="findPassForm" action="findPasswordDo.php" method="post" onsubmit="return validateForm()">
				<table class="content2">
					<tr>
						<td class="header1" colspan="2">Recover Password</td>
					</tr>
					
					<tr>
						<td class="postheader2"><label for="email">Email Address</label></td>
						<td class="post">
							<input type="text" name="email" id="email" maxlength="50" size="30" onblur="validateEmail()" required>
							<div id="errEmail"></div>
						</td>
					</tr>
					<tr>
						<td class="footer1" colspan="2">
							<input type="submit" name="Submit">&nbsp;&nbsp;
							<input type="reset" name="Reset">
						</td>
					</tr>
				</table>
			</form>	
		</div>
	</div>		
	<?php include "footer.php"; ?>
 </body>
</html>
