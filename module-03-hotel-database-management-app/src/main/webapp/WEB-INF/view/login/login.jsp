<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 1/21/2026
  Time: 11:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>Login - SB Admin</title>
  <link href="${pageContext.request.contextPath}/static/css/styles.css" rel="stylesheet" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
</head>
<body class="bg-primary">
<div id="layoutAuthentication">
  <div id="layoutAuthentication_content">
    <main>
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-5">
            <div class="card shadow-lg border-0 rounded-lg mt-5">
              <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
              <div class="card-body">
                <form action="${pageContext.request.contextPath}/login" method="post">
                  <div class="form-group">
                    <label class="small mb-1" for="inputEmailAddress">Email or Username</label>
                    <input class="form-control py-4" id="inputEmailAddress" name="username" type="text" placeholder="Enter email or username" />
                  </div>
                  <div class="form-group">
                    <label class="small mb-1" for="inputPassword">Password</label>
                    <input class="form-control py-4" id="inputPassword" name="password" type="password" placeholder="Enter password" />
                  </div>
                  <div class="form-group">
                    <div class="custom-control custom-checkbox">
                      <input class="custom-control-input" id="rememberPasswordCheck" type="checkbox" />
                      <label class="custom-control-label" for="rememberPasswordCheck">Remember password</label>
                    </div>
                  </div>
                  <div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
                    <a class="small" href="${pageContext.request.contextPath}/password">Forgot Password?</a>
                    <button class="btn btn-primary" type="submit">Login</button>
                  </div>
                </form>
                <% if (request.getAttribute("error") != null) { %>
                  <div class="alert alert-danger mt-3"><%= request.getAttribute("error") %></div>
                <% } %>
              </div>
              <div class="card-footer text-center">
                <div class="small"><a href="#">Need an account? Sign up!</a></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
  <div id="layoutAuthentication_footer">
    <footer class="py-4 bg-light mt-auto">
      <div class="container-fluid">
        <div class="d-flex align-items-center justify-content-between small">
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
<script src="${pageContext.request.contextPath}/static/js/scripts.js"></script>
</body>
</html>

