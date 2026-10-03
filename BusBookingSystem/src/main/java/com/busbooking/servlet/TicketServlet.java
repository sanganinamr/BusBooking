package com.busbooking.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.busbooking.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/TicketServlet")
public class TicketServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId =
            (Integer) request.getSession().getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int bookingId =
            Integer.parseInt(request.getParameter("bookingId"));

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT b.booking_id, bs.bus_number, bs.source, bs.destination, " +
                "bs.departure_time, bs.arrival_time, bs.fare, " +
                "b.passenger_name, b.mobile, b.age, b.seat_number, " +
                "b.journey_date, b.booking_date " +
                "FROM bookings b " +
                "JOIN buses bs ON b.bus_id = bs.bus_id " +
                "WHERE b.booking_id=? AND b.user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, bookingId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                request.setAttribute("bookingId",
                        rs.getInt("booking_id"));

                request.setAttribute("busNumber",
                        rs.getString("bus_number"));

                request.setAttribute("source",
                        rs.getString("source"));

                request.setAttribute("destination",
                        rs.getString("destination"));

                request.setAttribute("departure",
                        rs.getString("departure_time"));

                request.setAttribute("arrival",
                        rs.getString("arrival_time"));

                request.setAttribute("fare",
                        rs.getDouble("fare"));

                request.setAttribute("passenger",
                        rs.getString("passenger_name"));

                request.setAttribute("mobile",
                        rs.getString("mobile"));

                request.setAttribute("age",
                        rs.getInt("age"));

                request.setAttribute("seat",
                        rs.getString("seat_number"));

                request.setAttribute("journeyDate",
                        rs.getString("journey_date"));

                request.setAttribute("bookingDate",
                        rs.getString("booking_date"));

                request.getRequestDispatcher("ticket.jsp")
                       .forward(request, response);

            } else {

                response.sendRedirect("MyBookingsServlet");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}