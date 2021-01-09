<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
<!--     <link rel="icon" href="https://getbootstrap.com/docs/4.1/assets/img/favicons/favicon.ico">
 -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo-lavie-admin.ico">
    <title>Administrator</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.1/examples/dashboard/">

    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
  </head>

  <body>
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
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
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="home"></span>
                  Dashboard <span class="sr-only">(current)</span>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="order.htm">
                  <span data-feather="file"></span>
                  Orders
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="product.htm">
                  <span data-feather="shopping-cart"></span>
                  Products
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link active" href="customer.htm">
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
          <h2>Customers</h2>
			
          <div class="table-responsive">
            <table class="table table-striped table-sm">
              <thead>
                <tr>
                  <th>Tài khoản</th>
                  <th>Mật khẩu</th>
                  <th>Họ tên</th>
                  <th>Địa chỉ</th>
                  <th>Số điện thoại</th>
                  <th>Email</th>
      			  <th>Kích hoạt</th>	
                  <th></th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
              	<c:forEach var="c" items="${customers}">
              		<tr>
	                  <td>${c.id}</td>
	                  <td>${c.password}</td>
	                  <td>${c.fullname}</td>
	                  <td>${c.address}</td>
	                  <td>${c.phonenumber}</td>
	                  <td>${c.email}</td>
	                  <c:if test="${c.activated == false}">
	                  	<td>Chưa kích hoạt</td>
	                  </c:if>
	                  <c:if test="${c.activated == true}">
	                  	<td>Đã kích hoạt</td>
	                  </c:if>	             
	                  <td><a href="customerorder/${c.id}.htm">Đơn hàng</a></td>
                	</tr>
              	</c:forEach>
              </tbody>
            </table>
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
