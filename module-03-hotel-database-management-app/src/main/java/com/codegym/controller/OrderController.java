package com.codegym.controller;

import com.codegym.connection.JdbcConnection;
import com.codegym.model.dto.RoomBookingDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "orderServlet", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("username") != null;
        if (loggedIn) {
            List<RoomBookingDto> orders = new ArrayList<>();
            try {
                Connection connection = JdbcConnection.getConnection();
                String query = "SELECT order_id, customer_id, room_id, check_in_time, check_out_time, order_price FROM room_bookings ORDER BY order_id";
                PreparedStatement ps = connection.prepareStatement(query);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    RoomBookingDto dto = new RoomBookingDto();
                    dto.setOrderId(rs.getInt("order_id"));
                    dto.setCustomerId(rs.getInt("customer_id"));
                    dto.setRoomId(rs.getInt("room_id"));
                    dto.setCheckInTime(rs.getTimestamp("check_in_time"));
                    dto.setCheckOutTime(rs.getTimestamp("check_out_time"));
                    dto.setOrderPrice(rs.getDouble("order_price"));
                    orders.add(dto);
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            req.setAttribute("orders", orders);
        } else {
            req.setAttribute("authError", "Please log in to view order information.");
        }
        req.getRequestDispatcher("/WEB-INF/view/order/index.jsp").forward(req, resp);
    }
}
