package com.busbooking.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.busbooking.db.DBConnection;

@WebServlet("/ConfirmBookingServlet")
public class ConfirmBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String busId = request.getParameter("busId");
        String journeyDate = request.getParameter("journeyDate");
        String seatNumber = request.getParameter("seatNumber");
        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String age = request.getParameter("age");
        String amount = request.getParameter("amount");

        System.out.println("Bus ID = " + busId);
        System.out.println("Journey Date = " + journeyDate);
        System.out.println("Seat = " + seatNumber);
        System.out.println("Name = " + name);
        System.out.println("Mobile = " + mobile);
        System.out.println("Age = " + age);
        System.out.println("Amount = " + amount);

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO bookings " +
                         "(user_id, bus_id, passenger_name, mobile, age, seat_number, journey_date, amount) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            Integer userId = (Integer) request.getSession().getAttribute("userId");

            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            ps.setInt(1, userId);
            ps.setInt(2, Integer.parseInt(busId));
            ps.setString(3, name);
            ps.setString(4, mobile);
            ps.setInt(5, Integer.parseInt(age));
            ps.setString(6, seatNumber);
            ps.setString(7, journeyDate);
            ps.setDouble(8, Double.parseDouble(amount));

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("success.jsp");
            } else {
                response.getWriter().println("Booking Failed!");
            }

            ps.close();
            con.close();

        	} catch (Exception e) {
        		e.printStackTrace();
        		response.getWriter().println("Error: " + e.getMessage());
        	}

    }
}