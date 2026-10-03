package com.busbooking.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.busbooking.db.DBConnection;

@WebServlet("/AddBusServlet")
public class AddBusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String bus_id = request.getParameter("bus_id");
        String busNumber = request.getParameter("busNumber");
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String departureTime = request.getParameter("departureTime");
        String arrivalTime = request.getParameter("arrivalTime");
        String fare = request.getParameter("fare");
        int totalSeats = 40;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO buses "
                    + "(bus_id, bus_number, source, destination, "
                    + "departure_time, arrival_time, fare, total_seats) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, bus_id);
            ps.setString(2, busNumber);
            ps.setString(3, source);
            ps.setString(4, destination);
            ps.setString(5, departureTime);
            ps.setString(6, arrivalTime);
            ps.setDouble(7, Double.parseDouble(fare));
            ps.setInt(8, totalSeats);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            if (result > 0) {

                response.sendRedirect("manage-buses.jsp");

            } else {

                response.getWriter().println("Bus not added!");

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

        response.sendRedirect("add-bus.jsp");
    }
}