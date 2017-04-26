<?php 
// Fred Yang. 2016-10-06
include "base.php"; 
?>
<html lang="en">
	<head>
		<title>Login</title>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

  <link rel="stylesheet" href="Custom_CSS/GHG_custom.css">

  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
  page. However, you can choose any other skin. Make sure you
  apply the skin class to the body tag so the changes take effect.
-->
<link rel="stylesheet" href="dist/css/skins/skin-black.min.css">
		<script language="javascript">
			<!--
			function confirmLogout() {
				if(window.confirm("Are you sure you want to logout? All unsaved data will be lost."))
					window.open('logout.php', '_parent');
			}
			//-->
		</script>
	</head>
	<body>
		
		<!-- Header Navbar -->
    <nav class="navbar navbar-static-top " role="navigation">
      <!-- Sidebar toggle button-->
      <div class="col-sm-14">
        <form class="form-inline pull-right" >
          <input  type="email" class="form-control" placeholder="Email" >
          <input type="password" class="form-control"  placeholder="Password">
          <button type="submit" class="btn">Login</button>
          <div class="col-sm-7 pull-right">
            <a href="password.html">Forgot password?</a>
          </div>
        </form>
      </nav>
    </div>
  </nav>
		<form id="login_form" method="post">
			<table>
			<tr><td>
				<?php
				function showPanel($state) {
					if($state != 0)
						echo "<tr class='login_msg'><td colspan=3>Email or password is incorrect</td></tr>";
					echo "<table><tr><td><input type='text' name='email' id='email' class='inputbox' maxlength=30 size=10 required></td>";
					echo "<td><input type='password' name='password' id='password' class='inputbox' maxlength=15 size=10 required></td>";
					echo "<td><input type='submit' value='Login' class='login_btn' title='Login'></td></tr>";
					echo "<tr class='login_txt'><td><label for='email'>Email</label></td><td><label for='password'>Password</label></td></tr>";
					echo "<tr class='login_txt_lnk'><td><a href='findPassword.php' target='_parent'>Forgot Password?</a></td>";
					echo "<td><a href='register.php' target='_parent'>Register</a></td></tr></table>";
				}
				
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
						}
					}
					else {
						showPanel(1);
					}
					
					sqlsrv_free_stmt($stmt);
				} else {
					showPanel(0);
				}
				
				?>
			</td></tr>
			</table>
		</form>
	</body>
</html>
