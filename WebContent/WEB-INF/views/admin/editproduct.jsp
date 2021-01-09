<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<base href="${pageContext.servletContext.contextPath}/">
<!--     <link rel="icon" href="https://getbootstrap.com/docs/4.1/assets/img/favicons/favicon.ico">
 -->
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo-lavie-admin.ico">
    <title>Administrator</title>

<link rel="canonical"
	href="https://getbootstrap.com/docs/4.1/examples/dashboard/">

<!-- Bootstrap core CSS -->
<link
	href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">

<style>
*[id$=errors] {
	color: red;
	font-style: "italic";
}
</style>

</head>

<body>
	<nav
		class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
	<a class="navbar-brand col-sm-3 col-md-2 mr-0" href="">
      <img src="${pageContext.request.contextPath}/resources/images/logo-lavie-land.png" alt="logo" style="width: 60px;">
      Admin
    </a>
    <!-- <input class="form-control form-control-dark w-100" type="text" placeholder="Search" aria-label="Search"> -->
		<ul class="navbar-nav px-3">
			<c:if test="${sessionScope.username != null}">
				<li class="nav-item text-nowrap">
	          		<a class="nav-link" href="">${sessionScope.username}</a>
	        	</li>
			</c:if>
	    </ul>
	   	<ul class="navbar-nav navbar-right px-3">
	      	<li class="nav-item text-nowrap">
	          	<a class="nav-link" href="logout.htm">Log out</a>
	        </li> 
		</ul>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<nav class="col-md-2 d-none d-md-block bg-light sidebar">
				<div class="sidebar-sticky">
					<ul class="nav flex-column">
						<li class="nav-item"><a class="nav-link" href="#"> <span
								data-feather="home"></span> Dashboard <span class="sr-only">(current)</span>
						</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/order.htm"> <span
								data-feather="file"></span> Orders
						</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="${pageContext.request.contextPath}/admin/product.htm"> <span data-feather="shopping-cart"></span>
								Products
						</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/customer.htm"> <span
								data-feather="users"></span> Customers
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#"> <span
								data-feather="bar-chart-2"></span> Reports
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#"> <span
								data-feather="layers"></span> Integrations
						</a></li>
					</ul>

					<h6
						class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
						<span>Saved reports</span> <a
							class="d-flex align-items-center text-muted" href="#"> <span
							data-feather="plus-circle"></span>
						</a>
					</h6>
					<ul class="nav flex-column mb-2">
						<li class="nav-item"><a class="nav-link" href="#"> <span
								data-feather="file-text"></span> Current month
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#"> <span
								data-feather="file-text"></span> Last quarter
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#"> <span
								data-feather="file-text"></span> Social engagement
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#"> <span
								data-feather="file-text"></span> Year-end sale
						</a></li>
					</ul>
				</div>
			</nav>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4 mt-3">
				<h3><i>${message}</i></h3>
				<h2>Chỉnh sửa sản phẩm</h2>
				<form:form action="admin/editproduct.htm" modelAttribute="product"
					method="post" enctype="multipart/form-data">
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">Mã sản phẩm</label>
						<div class="col-sm-7">
							<form:input type="text" path="id" class="form-control" readonly="true"/>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">Tên sản phẩm</label>
						<div class="col-sm-7">
							<form:input type="text" path="name" class="form-control" />
							<form:errors path="name" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">Số lượng</label>
						<div class="col-sm-3">
							<form:input path="quantity" type="text" class="form-control" />
							<form:errors path="quantity" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">Đơn giá</label>
						<div class="col-sm-3">
							<form:input path="unitPrice" type="text" class="form-control" />
							<form:errors path="unitPrice" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">Quy cách</label>
						<div class="col-sm-7">
							<form:input path="specification" type="text" class="form-control" />
							<form:errors path="specification" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">Mô tả</label>
						<div class="col-sm-7">
							<form:textarea path="description" class="form-control"
								id="exampleFormControlTextarea1" rows="4" />
							<form:errors path="description" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">Tình trạng</label>
						<div class="col-sm-7">
							<form:radiobutton path="available" value="true"/> <label>&nbsp;Còn hàng</label> &emsp;
							<form:radiobutton path="available" value="false" />  <label>&nbsp;Hết hàng</label>
							<form:errors path="available" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label">Hình ảnh sản phẩm</label>
						<div class="col-sm-7">
							<div class="card" style="width:200px">
						    <img class="card-img-top" src="${pageContext.request.contextPath}/${product.image}" alt="Card image" style="width:100%">
						    <div class="card-body">
						      <p class="card-text">${product.image}</p>
						    </div>
						 	</div>
							<input
								type="file" name="photo" class="form-control-file"
								id="exampleFormControlFile1" />
							<form:errors path="image" />
						</div> 
					</div>

					<div class="form-group row">
						<div class="col-sm-10">
							<button type="submit" class="btn btn-primary">Cập nhật</button>
						</div>
					</div>
				</form:form>
			</main>
		</div>
	</div>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://getbootstrap.com/docs/4.1/assets/js/vendor/popper.min.js"></script>
	<script
		src="https://getbootstrap.com/docs/4.1/dist/js/bootstrap.min.js"></script>

	<!-- Icons -->
	<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
	<script>
		feather.replace()
	</script>

</body>
</html>
