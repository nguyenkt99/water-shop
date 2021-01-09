<%@ page  pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo-lavie-ico.ico">
  <title>Lavie Water</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>


<body>
<!-- Default form login -->
<form class="text-center border border-light p-5" action="login.htm" method="post">
	<a class="mb-4" href="index.htm"> <img src="resources/images/logo-lavie.png" alt="logo" style="width: 80px"></a>
	<br>
	<br>
	<p class="h4 mb-4">Sign in</p>
    <!-- Username -->
    <input type="text" name="username" id="defaultLoginFormUsername" class="form-control mb-4" placeholder="Username">
    <!-- Password -->
    <input type="password" name="password" id="defaultLoginFormPassword" class="form-control mb-4" placeholder="Password">
    <div class="d-flex justify-content-around">
        <div>
            <!-- Remember me -->
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="defaultLoginFormRemember">
                <label class="custom-control-label" for="defaultLoginFormRemember">Remember me</label>
            </div>
        </div>
        <div>
            <!-- Forgot password -->
            <a href="forgot.htm">Forgot password?</a>
        </div>
    </div>

    <!-- Sign in button -->
    
	<p class="text-danger">${message}</p>
    <button class="btn btn-info btn-block my-4" type="submit">Sign in</button>

    <!-- Register -->
    <p>Not a member?
        <a href="register.htm">Register</a>
    </p>
</form>
<!-- Default form login -->

</body>
</html>