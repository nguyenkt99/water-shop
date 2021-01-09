<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
	
    <!-- <link rel="icon" href="https://getbootstrap.com/docs/4.1/assets/img/favicons/favicon.ico"> -->

    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo-lavie-admin.ico">
    <title>Administrator</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.1/examples/dashboard/">

    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
  </head>

  <body>
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="">
      <img src="${pageContext.request.contextPath}/resources/images/logo-lavie-land.png" alt="logo" style="width: 60px;">
      Admin
    </a>
    <!-- <input class="form-control form-control-dark w-100" type="text" placeholder="Search" aria-label="Search"> -->
      <ul class="navbar-nav navbar-right px-3">
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
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/index.htm">
                  <span data-feather="home"></span>
                  Dashboard <span class="sr-only">(current)</span>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/order.htm">
                  <span data-feather="file"></span>
                  Orders
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/product.htm">
                  <span data-feather="shopping-cart"></span>
                  Products
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/customer.htm">
                  <span data-feather="users"></span>
                  Customers
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="bar-chart-2"></span>
                  Reports
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="layers"></span>
                  Integrations
                </a>
              </li>
            </ul>

            <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
              <span>Saved reports</span>
              <a class="d-flex align-items-center text-muted" href="#">
                <span data-feather="plus-circle"></span>
              </a>
            </h6>
            <ul class="nav flex-column mb-2">
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  Current month
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  Last quarter
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  Social engagement
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  Year-end sale
                </a>
              </li>
            </ul>
          </div>
        </nav>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
        	<br>
          <h2>CHI TIẾT ĐƠN HÀNG ${orderId}</h2>
          <hr>
          <div>
          	<p class="h5 font-weight-bold"><i class="fa fa-location-arrow" style="font-size:25px;color:orange"></i>  Địa chỉ nhận hàng</p>
			<p><strong>&emsp; &emsp; ${order.customer.fullname} &emsp; ${order.customer.phonenumber}</strong>	&emsp; ${order.customer.address}	</p>
		  </div>
		  <br>
          <div class="table-responsive">
            <table class="table table-striped table-sm">
              <thead>
                <tr>
                  <th>Id</th>
                  <th>Sản phẩm</th>
                  <th>Đơn giá</th>
                  <th>Số lượng</th>
                  <th>Thành tiền</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
              <c:forEach var="od" items="${orderdetails}">
                <tr>
                  <td>${od.id}</td>      
                  <td><img src="${pageContext.request.contextPath}/${od.product.image}" height="40"> ${od.product.name}</td>
                  <td><fmt:formatNumber pattern="#,##0" value="${od.unitPrice}"/> (VNĐ)</td>
                  <td>${od.quantity}</td>
                  <td><fmt:formatNumber pattern="#,##0" value="${od.unitPrice * od.quantity}"/> (VNĐ)</td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
          <div class="col-md-12 text-right">
			<p>Tổng thanh toán: <strong class="text-primary"><fmt:formatNumber pattern="#,##0" value="${order.amount}"/> (VNĐ)</strong></p>
		  </div>
        </main>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>
    <script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.1/dist/js/bootstrap.min.js"></script>

    <!-- Icons -->
    <script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
    <script>
      feather.replace()
    </script>

  </body>
</html>
