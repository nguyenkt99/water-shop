<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo-lavie-ico.ico">
<title>Water Shop</title>
<meta charset="utf-8">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700&display=swap">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>


<link rel="stylesheet"
	href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb-pro.min.css">
<!-- Material Design Bootstrap Ecommerce -->
<link rel="stylesheet"
	href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb.ecommerce.min.css">

<!-- JQuery -->
<script
	src="https://mdbootstrap.com/previews/ecommerce-demo/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.min.js"></script>
<!-- MDB Ecommerce JavaScript -->
<script type="text/javascript"
	src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.ecommerce.min.js"></script>



<style type="text/css">
.card-img-top {
	height: 18vw;
	width: auto;
	object-fit: cover;
}

.crop-text-1 {
	-webkit-line-clamp: 1;
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-box-orient: vertical;
}

*[id$=errors] {
  		color:red; font-style:"italic";
}
</style>

</head>
<body>

	<nav class="navbar fixed-top navbar-expand-lg navbar-light bg-light">
		<!-- Brand/logo -->
		<a class="navbar-brand" href="index.htm"> <img
			src="resources/images/logo-lavie.png" alt="logo" style="width: 60px;">
		</a>

		<!-- Links -->
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="index.htm">TRANG
					CHỦ</a></li>
			<li class="nav-item"><a class="nav-link" href="#">TÌM HIỂU
					LAVIE</a></li>
			<!-- Dropdown -->
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbardrop"
				data-toggle="dropdown"> SẢN PHẨM </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="#">SẢN PHẨM MỚI</a>
				</div></li>
			<li class="nav-item"><a class="nav-link" href="#">LIÊN HỆ</a></li>
		</ul>

		<ul class="navbar-nav ml-auto">
			<c:if test="${sessionScope.username == null}">
				<li class="nav-item"><a class="nav-link" href="login.htm">LOGIN</a></li>
				<li class="nav-item"><a class="nav-link" href="register.htm">SIGN
						UP</a></li>
			</c:if>
			<c:if test="${sessionScope.username != null}">
				<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbardrop"
					data-toggle="dropdown"> ${sessionScope.username}
				</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="editprofile/${sessionScope.username}.htm">Edit profile</a>
					<a class="dropdown-item" href="orderlist/${sessionScope.username}.htm">Order list</a>
					<a class="dropdown-item" href="logout.htm">Logout</a>
				</div>
				</li>
			</c:if>
			<!-- cart icon -->
			<li class="nav-item"><a href="cart.htm"
				class="nav-link navbar-link-2 waves-effect"> <span
					class="badge badge-pill red">${numOfItems}</span><i
					class="fas fa-shopping-cart pl-0"></i>
			</a></li>
		</ul>
	</nav>

	<!-- <div class="container-fluid">
		<h3>Brand / Logo</h3>
		<p>When using the .navbar-brand class on images, Bootstrap 4 will
			automatically style the image to fit the navbar.</p>
	</div> -->

	<div class="container-fluid">
		<div class="row">
			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4 mt-3">
				<br> <br>
				<br>
				<h3><strong>${message}</strong></h3>
				<h2><i>THÔNG TIN CÁ NHÂN</i></h2>
				<form:form action="editprofile.htm" modelAttribute="customer" method="post">
					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">Username</label>
						<div class="col-sm-7">
							<form:input type="username" path="id" class="form-control" readonly="true"/>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">Mật khẩu mới</label>
						<div class="col-sm-7">
							<form:input type="password" path="password" class="form-control" id="inputPassword3"/>
							<form:errors path="password"/>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">Họ tên</label>
						<div class="col-sm-7">
							<form:input type="text" path="fullname" class="form-control"/>
							<form:errors path="fullname"/>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">Địa chỉ</label>
						<div class="col-sm-7">
							<form:input type="text" path="address" class="form-control"/>
							<form:errors path="address"/>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">Email</label>
						<div class="col-sm-7">
							<form:input type="email" path="email" class="form-control"/>
							<form:errors path="email"/>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">Số điện thoại</label>
						<div class="col-sm-7">
							<form:input type="text" path="phonenumber" class="form-control"/>
							<form:errors path="phonenumber"/>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-10">
							<button type="submit" class="btn btn-primary">Lưu thay đổi</button>
						</div>
					</div>
				</form:form>
			</main>
		</div>
	</div>
</body>
</html>