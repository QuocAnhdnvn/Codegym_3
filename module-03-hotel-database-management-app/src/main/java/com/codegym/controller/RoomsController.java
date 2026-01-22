package com.codegym.controller;

import com.codegym.connection.JdbcConnection;
import com.codegym.model.dto.RoomDto;
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

@WebServlet(name = "roomsServlet", urlPatterns = {"/rooms", "/room-list"})
public class RoomsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("username") != null;
        if (loggedIn) {
            List<RoomDto> rooms = new ArrayList<>();
            try {
                Connection connection = JdbcConnection.getConnection();
                String query = "SELECT id, room_number, price, status, category_id FROM rooms ORDER BY id";
                PreparedStatement ps = connection.prepareStatement(query);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    RoomDto dto = new RoomDto();
                    dto.setId(rs.getInt("id"));
                    dto.setRoomNumber(rs.getString("room_number"));
                    dto.setPrice(rs.getBigDecimal("price"));
                    dto.setStatus(rs.getString("status"));
                    dto.setCategoryId(rs.getInt("category_id"));
                    rooms.add(dto);
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            req.setAttribute("rooms", rooms);
        } else {
            req.setAttribute("authError", "Please log in to view rooms.");
        }
        req.getRequestDispatcher("/WEB-INF/view/Room/rooms.jsp").forward(req, resp);
    }
}
