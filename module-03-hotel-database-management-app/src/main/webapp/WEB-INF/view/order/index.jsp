<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>Orders</title>
  <link rel="stylesheet" href="<c:url value='/static/css/styles.css' />" type="text/css">
  <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
  <a class="navbar-brand" href="<c:url value='/home'/>">Home</a>
  <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
  <ul class="navbar-nav ml-auto ml-md-0">
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
        <a class="dropdown-item" href="#">Settings</a>
        <a class="dropdown-item" href="#">Activity Log</a>
        <div class="dropdown-divider"></div>
        <c:choose>
          <c:when test="${empty sessionScope.username}">
            <a class="dropdown-item" href="<c:url value='/login'/>">Login</a>
          </c:when>
          <c:otherwise>
            <a class="dropdown-item" href="<c:url value='/logout'/>">Logout</a>
          </c:otherwise>
        </c:choose>
      </div>
    </li>
  </ul>
</nav>
<div id="layoutSidenav">



  <div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
      <div class="sb-sidenav-menu">
        <div class="nav">
          <div class="sb-sidenav-menu-heading">Menu</div>
          <a class="nav-link" href="/">
            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
            Home
          </a>
          <div class="sb-sidenav-menu-heading">Addons</div>
          <a class="nav-link" href="<c:url value='/customers'/>">
            <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
            Customers
          </a>
          <a class="nav-link" href="<c:url value='/order'/>">
            <div class="sb-nav-link-icon"><i class="fa-light fa-file-invoice-dollar"></i></div>
            Order
          </a>
          <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseAccount" aria-expanded="false" aria-controls="collapseAccount">
            <div class="sb-nav-link-icon"><i class="fa-light fa-address-card"></i></div>
            Account
            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
          </a>
          <div class="collapse" id="collapseAccount" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
            <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionAccount">
              <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#accountCollapseAuth" aria-expanded="false" aria-controls="accountCollapseAuth">
                Authentication
                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
              </a>
              <div class="collapse" id="accountCollapseAuth" aria-labelledby="headingOne" data-parent="#sidenavAccordionAccount">
                <nav class="sb-sidenav-menu-nested nav">
                  <c:choose>
                    <c:when test="${empty sessionScope.username}">
                      <a class="nav-link" href="<c:url value='/login'/>">Login</a>
                    </c:when>
                    <c:otherwise>
                      <a class="nav-link" href="<c:url value='/logout'/>">Logout</a>
                    </c:otherwise>
                  </c:choose>
                  <a class="nav-link" href="#">Register</a>
                  <a class="nav-link" href="<c:url value='/password'/>">Forgot Password</a>
                </nav>
              </div>
            </nav>
          </div>
        </div>
      </div>
    </nav>
  </div>

  <div id="layoutSidenav_content">
    <main>
      <div class="container-fluid">
        <h1 class="mt-4">Orders</h1>
        <ol class="breadcrumb mb-4">
          <li class="breadcrumb-item"><a href="<c:url value='/home'/>">Home</a></li>
          <li class="breadcrumb-item active">Orders</li>
        </ol>
        <c:if test="${empty sessionScope.username}">
          <div class="alert alert-warning">Please log in to view order information.</div>
        </c:if>
        <c:if test="${not empty sessionScope.username}">
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              Room Bookings
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                  <tr>
                    <th>Order ID</th>
                    <th>Customer ID</th>
                    <th>Room ID</th>
                    <th>Check-in Time</th>
                    <th>Check-out Time</th>
                    <th>Order Price</th>
                  </tr>
                  </thead>
                  <tbody>
                  <jsp:useBean id="orders" scope="request" type="java.util.List"/>
                  <c:forEach items="${orders}" var="order">
                    <tr>
                      <td>${order.orderId}</td>
                      <td>${order.customerId}</td>
                      <td>${order.roomId}</td>
                      <td>${order.checkInTime}</td>
                      <td>${order.checkOutTime}</td>
                      <td>${order.orderPrice}</td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </c:if>
      </div>
    </main>
    <footer class="py-4 bg-light mt-auto">
      <div class="container-fluid">
        <div class="d-flex align-items-center justify-content-between small">
          <div class="text-muted">Copyright &copy; Your Website 2020</div>
          <div>
            <a href="#">Privacy Policy</a>
            &middot;
            <a href="#">Terms &amp; Conditions</a>
          </div>
        </div>
      </div>
    </footer>
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="<c:url value='/static/js/scripts.js' />"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
<script src="<c:url value='/static/assets/demo/datatables-demo.js' />"></script>
</body>
</html>
