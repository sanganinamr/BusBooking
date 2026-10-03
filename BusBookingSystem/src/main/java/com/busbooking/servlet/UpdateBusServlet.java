package com.busbooking.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.busbooking.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateBusServlet")
public class UpdateBusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String busId = request.getParameter("bus_id");
        String busNumber = request.getParameter("busNumber");
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String departureTime = request.getParameter("departureTime");
        String arrivalTime = request.getParameter("arrivalTime");
        String fare = request.getParameter("fare");

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                "UPDATE buses SET "
                + "bus_number=?, "
                + "source=?, "
                + "destination=?, "
                + "departure_time=?, "
                + "arrival_time=?, "
                + "fare=? "
                + "WHERE bus_id=?";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setString(1, busNumber);
            ps.setString(2, source);
            ps.setString(3, destination);
            ps.setString(4, departureTime);
            ps.setString(5, arrivalTime);
            ps.setDouble(6, Double.parseDouble(fare));
            ps.setInt(7, Integer.parseInt(busId));

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            if (result > 0) {

                response.sendRedirect("manage-buses.jsp");

            } else {

                response.getWriter().println(
                    "Bus update failed!"
                );

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Error: " + e.getMessage()
            );

        }

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("manage-buses.jsp");

    }
}