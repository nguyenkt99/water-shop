<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo-lavie-ico.ico">
  <title>Water Shop</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
  <style>
  	*[id$=errors] {
  		color:red; font-style:"italic";
  	}
  </style>
</head>
<body>

<!-- Default form register -->
<form:form class="text-center border border-light p-5" action="register.htm" modelAttribute="customer" method="post">
	<h3>${message}</h3>
	<a class="mb-4" href="index.htm"> <img src="resources/images/logo-lavie.png" alt="logo" style="width: 80px"></a>
	<br>
	<br>
    <p class="h4 mb-4">Sign up</p>
	
	<form:errors path="id"/>
	<form:input path="id" id="defaultRegisterUsername" class="form-control mb-4" placeholder="Username"/>
	
	<form:errors path="password"/>
	<form:password path="password" id="defaultRegisterFormPassword" class="form-control mb-4" placeholder="Password" aria-describedby="defaultRegisterFormPasswordHelpBlock"/>
	
	<!-- Fullname -->
	<form:errors path="fullname"/>
	<form:input path="fullname" id="defaultRegisterFullname" class="form-control mb-4" placeholder="Fullname"/>
	
	<!-- Address -->
	<form:errors path="address"/>
	<form:input path="address" id="defaultRegisterAddress" class="form-control mb-4" placeholder="Address"/>
	
    <!-- E-mail -->
    <form:errors path="email"/>
    <form:input path="email" id="defaultRegisterFormEmail" class="form-control mb-4" placeholder="E-mail"/>
    
    <!-- Phone number -->
    <form:errors path="phonenumber"/>
    <form:input path="phonenumber" id="defaultRegisterPhoneNumber" class="form-control mb-4" placeholder="Phone number" aria-describedby="defaultRegisterFormPhoneHelpBlock"/>
	
    <!-- Newsletter -->
    <div class="custom-control custom-checkbox">
        <input type="checkbox" class="custom-control-input" id="defaultRegisterFormNewsletter">
        <label class="custom-control-label" for="defaultRegisterFormNewsletter">Subscribe to our newsletter</label>
    </div>

    <!-- Sign up button -->
    <button class="btn btn-info my-4 btn-block" type="submit">Sign up</button>

    <hr>

    <!-- Already have an account? -->
    <!-- <p>Already have an account? <a href="login.htm" target="_blank">Sign in</a></p> -->
    <p>Already have an account? <a href="login.htm">Sign in</a></p>
	
</form:form>
<!-- Default form register -->

</body>
</html>