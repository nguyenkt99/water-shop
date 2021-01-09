<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
  <script src="https://mdbootstrap.com/previews/ecommerce-demo/js/jquery-3.4.1.min.js"></script>
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
			<li class="nav-item"><a class="nav-link" href="index.htm">TRANG CHỦ</a></li>
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

	<div class="container">
			<!--Section: Block Content-->
			<section class="mt-5 mb-4">
				<!--Grid row-->
				<div class="row">
					<!--Grid column-->
					<div class="col-lg-8">
						<!-- Card -->
						<div class="card wish-list mb-4">
							<div class="card-body">
							<br>
								<h5 class="mb-4">
									Cart (<span>${sessionScope.cart.getOrderDetails().size()}</span> items)
								</h5>
								
								<!-- Show items in the shopping carts -->
								<c:forEach var="item" items="${sessionScope.cart.orderDetails}">
									<div class="row mb-4">
									<div class="col-md-5 col-lg-3 col-xl-3">
										<div class="view zoom overlay z-depth-1 rounded mb-3 mb-md-0">
											<img class="img-fluid w-100"
												src="${item.product.image}"
												alt="Sample"> <a href="detail/${item.product.id}.htm">
												<div class="mask waves-effect waves-light">
													<img class="img-fluid w-100"
														src="${item.product.image}">
													<div
														class="mask rgba-black-slight waves-effect waves-light"></div>
												</div>
											</a>
										</div>
									</div>

									<div class="col-md-7 col-lg-9 col-xl-9">
										<div>
											<div class="d-flex justify-content-between">
												<div>
													<a href="detail/${item.product.id}.htm" style="color:black"><h5>${item.product.name}</h5></a>													
													<p class="mb-3 text-muted text-uppercase default">
														<fmt:formatNumber pattern="#,##0" value="${item.unitPrice}"/> VNĐ
														(${item.product.specification})
													</p>
												</div>
												<div>
													<%-- <div
														class="def-number-input number-input safari_only mb-0 w-100">
														<input class="quantity" min="0" name="quantity" value="${item.quantity}" type="number" readonly="readonly">
													</div> --%>
													<div>
														<a href="minusquantityitem/${item.product.id}.htm"><button class="minus" type="button">-</button></a>
														<input type="text" style="width: 40px" value="${item.quantity}" readonly="true">
														<a href="plusquantityitem/${item.product.id}.htm"><button class="plus" type="button">+</button></a>
													</div>
												</div>
											</div>
											<div
												class="d-flex justify-content-between align-items-center">
												<div>
													<a href="removeitem/${item.product.id}.htm" class="card-link-secondary small text-uppercase mr-3"><i
														class="fas fa-trash-alt mr-1"></i> Remove item </a>
												</div>
												<p class="mb-0">
													<%-- <span><strong>${item.unitPrice} (VNĐ)</strong></span> --%>
													<p><strong>Thành tiền: </strong><fmt:formatNumber pattern="#,##0" value="${item.quantity * item.unitPrice}"/> (VNĐ)</p>
												</p>
											</div>
										</div>
									</div>
								</div>
								<hr class="mb-4">	
								</c:forEach>
													
							</div>
						</div>
						<!-- Card -->
					</div>
					<!--Grid column-->

					<!-- Checkout -->
					<!--Grid column-->
					<div class="col-lg-4">
						<!-- Card -->
						<div class="card mb-4">
							<div class="card-body">
								<br> <br>
								<h5 class="mb-3">Thanh Toán</h5>

								<ul class="list-group list-group-flush">
									<li
										class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
										Tổng tiền hàng <span><fmt:formatNumber pattern="#,##0" value="${sessionScope.cart.amount}"/></span>
									</li>
									<li
										class="list-group-item d-flex justify-content-between align-items-center px-0">
										Phí vận chuyển <span>Miễn phí</span>
									</li>
									<li
										class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
										<div>
											<strong>Tổng thanh toán: </strong>
										</div> 
										<span class="h3 text-danger"><strong><fmt:formatNumber pattern="#,##0" value="${sessionScope.cart.amount}"/> (VNĐ)</strong></span>
									</li>
								</ul>

								<a href="checkout.htm"><button type="button"
									class="btn btn-primary btn-block waves-effect waves-light">go
									to checkout</button></a>

							</div>
						</div>
						<!-- Card -->
					</div>
					<!--Grid column-->
				</div>
				<!--Grid row-->
			</section>
			<!--Section: Block Content-->
		</div>
		
</body>
</html>