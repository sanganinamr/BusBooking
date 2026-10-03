package com.busbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.busbooking.db.DBConnection;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
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
                "DELETE FROM bookings WHERE booking_id=? AND user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, bookingId);
            ps.setInt(2, userId);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect("MyBookingsServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}