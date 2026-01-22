<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Room Types</title>
  <link rel="stylesheet" href="<c:url value='/static/css/styles.css' />" type="text/css">
  <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
  <style>
    body { padding: 0; margin: 0; }
  </style>
  </head>
<body class="sb-nav-fixed">
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
  <a class="navbar-brand" href="<c:url value='/home'/>">Home</a>
  <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
</nav>
<div id="layoutSidenav">



  <div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
      <div class="sb-sidenav-menu">
        <div class="nav">
          <a class="nav-link" href="<c:url value='/room-types'/>">
            <div class="sb-nav-link-icon"><i class="fa-light fa-hotel"></i></div>
            Room types
          </a>
          <a class="nav-link" href="<c:url value='/rooms'/>">
            <div class="sb-nav-link-icon"><i class="fa-light fa-door-open"></i></div>
            Rooms
          </a>
        </div>
      </div>
    </nav>
  </div>


  <div id="layoutSidenav_content">
    <main>
      <div class="container-fluid">
        <h1 class="mt-4">Room Types</h1>
        <c:if test="${empty sessionScope.username}">
          <div class="alert alert-warning">Please log in to view room types.</div>
        </c:if>
        <c:if test="${not empty sessionScope.username}">
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              Room Types
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                  <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                  </tr>
                  </thead>
                  <tbody>
                  <jsp:useBean id="roomTypes" scope="request" type="java.util.List"/>
                  <c:forEach items="${roomTypes}" var="t">
                    <tr>
                      <td>${t.id}</td>
                      <td>${t.name}</td>
                      <td>${t.description}</td>
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
