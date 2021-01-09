<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo-lavie-ico.ico">
<title>Water Shop</title>
<meta charset="utf-8">
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->

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



<base href="${pageContext.servletContext.contextPath}/">
<style type="text/css">
/* .container {
	margin-top: 100px;
} */
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

	<div class="container mt-5">
		<div class="row">
			<div class="col-md-5 mt-5">
				<img src="${product.image}" class="img-fluid" alt="...">
			</div>

			<div class="col-md-6 mt-5 pt-5">
				<h2>
					<strong>${product.name}</strong>
				</h2>
				<p>
					<strong>Trạng Thái: </strong>${product.available?'Còn hàng':'Hết hàng'}</p>
				<p>
					<strong>Quy cách: </strong>${product.specification}</p>

				<h3 class="text-danger">
					<strong><fmt:formatNumber pattern="#,##0" value="${product.unitPrice}"/> (VNĐ)</strong>
				</h3>

				<p class="pt-1">${product.description}</p>
				
				<!-- get productId, quantity(in orderDetail) transfer to controller -->
				<form action="addbuycartfromdetail/${product.id}.htm" method="post">
					<c:if test="${product.available == false || product.quantity == 0}">
					<div class="number-input md-number-input">
						<label for="quantity">Số lượng: </label> <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.quantity}">
						<button class="btn btn-info" name="btnAddToCart" type="submit" disabled><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
						<div><button class="btn btn-danger" name="btnBuyNow"type="submit" disabled><i class="fas fa-shopping-cart"></i> Mua ngay</button></div>
					</div>
					</c:if>
				</form>
				<form action="addbuycartfromdetail/${product.id}.htm" method="post">
					<c:if test="${product.available == true && product.quantity > 0}">
					<div class="number-input md-number-input">
						<label for="quantity">Số lượng: </label> <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.quantity}">
						<button class="btn btn-info" name="btnAddToCart" type="submit"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
						<div><button class="btn btn-danger" name="btnBuyNow"type="submit"><i class="fas fa-shopping-cart"></i> Mua ngay</button></div>
					</div>
					</c:if>
				</form>
			</div>
		</div>
	</div>


</body>
</html>

