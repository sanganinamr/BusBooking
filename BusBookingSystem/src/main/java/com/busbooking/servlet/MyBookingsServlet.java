package com.busbooking.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.busbooking.db.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT b.booking_id, bs.bus_number, bs.source, bs.destination, "
                    + "b.passenger_name, b.mobile, b.age, b.seat_number, "
                    + "b.journey_date, b.booking_date "
                    + "FROM bookings b "
                    + "JOIN buses bs ON b.bus_id = bs.bus_id "
                    + "WHERE b.user_id=? "
                    + "ORDER BY b.booking_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            int userId = (Integer) request.getSession().getAttribute("userId");
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            request.setAttribute("bookings", rs);

            RequestDispatcher rd = request.getRequestDispatcher("mybookings.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}