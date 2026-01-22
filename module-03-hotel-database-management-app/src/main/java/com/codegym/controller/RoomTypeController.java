package com.codegym.controller;

import com.codegym.connection.JdbcConnection;
import com.codegym.model.dto.RoomTypeDto;
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

@WebServlet(name = "roomTypeServlet", urlPatterns = {"/room-types"})
public class RoomTypeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("username") != null;
        if (loggedIn) {
            List<RoomTypeDto> roomTypes = new ArrayList<>();
            try {
                Connection connection = JdbcConnection.getConnection();
                String query = "SELECT id, name, description FROM room_types ORDER BY id";
                PreparedStatement ps = connection.prepareStatement(query);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    RoomTypeDto dto = new RoomTypeDto();
                    dto.setId(rs.getInt("id"));
                    dto.setName(rs.getString("name"));
                    dto.setDescription(rs.getString("description"));
                    roomTypes.add(dto);
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            req.setAttribute("roomTypes", roomTypes);
        } else {
            req.setAttribute("authError", "Please log in to view room types.");
        }
        req.getRequestDispatcher("/WEB-INF/view/Room/room_types.jsp").forward(req, resp);
    }
}
