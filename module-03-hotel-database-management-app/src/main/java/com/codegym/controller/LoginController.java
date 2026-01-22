package com.codegym.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.codegym.connection.JdbcConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.io.IOException;

@WebServlet(name = "loginServlet", urlPatterns = {"/login", "/password", "/logout"})
public class LoginController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        switch (action) {
            case "/login":
                req.getRequestDispatcher("/WEB-INF/view/login/login.jsp").forward(req, resp);
                break;
            case "/password":
                req.getRequestDispatcher("/WEB-INF/view/login/password.jsp").forward(req, resp);
                break;
            case "/logout":
                HttpSession session = req.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                resp.sendRedirect(req.getContextPath() + "/login");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        if ("/login".equals(action)) {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            boolean authenticated = false;
            String roleCode = null;
            boolean canEdit = false;

            try {
                Connection conn = JdbcConnection.getConnection();
                if (conn != null) {
                    String sql = "SELECT r.code, r.can_edit FROM accounts a JOIN roles r ON a.role_id = r.id WHERE a.username = ? AND a.password = ?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        roleCode = rs.getString(1);
                        canEdit = rs.getBoolean(2);
                        authenticated = true;
                    }
                    conn.close();
                }
            } catch (Exception e) {
                authenticated = false;
            }

            if (authenticated) {
                HttpSession session = req.getSession(true);
                session.setAttribute("username", username);
                session.setAttribute("role", roleCode);
                session.setAttribute("canEdit", canEdit);
                resp.sendRedirect(req.getContextPath() + "/customers");
            } else {
                req.setAttribute("error", "Invalid username or password");
                req.getRequestDispatcher("/WEB-INF/view/login/login.jsp").forward(req, resp);
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
