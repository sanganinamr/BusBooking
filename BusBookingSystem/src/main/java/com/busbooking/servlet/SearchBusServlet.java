package com.busbooking.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.busbooking.db.DBConnection;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SearchBusServlet")
public class SearchBusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String journeyDate = request.getParameter("journeyDate");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM buses WHERE source=? AND destination=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, from);
            ps.setString(2, to);

            ResultSet rs = ps.executeQuery();

            response.setContentType("text/html");
            
            
            
            
            PrintWriter out = response.getWriter();

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Available Buses</title>");
            out.println("<link rel='stylesheet' href='search.css'>");
            out.println("</head>");
            out.println("<body>");            
            
            
            
            
            

            if (rs.next()) {

                
            	out.println("<div class='container'>");
            	out.println("<h1>Available Buses</h1>");

            	do {

            	    out.println("<div class='bus-card'>");

            	    out.println("<h2>" + rs.getString("bus_number") + "</h2>");
            	    out.println("<p><b>Route:</b> " + rs.getString("source") + " ➜ " + rs.getString("destination") + "</p>");
            	    out.println("<p><b>Departure:</b> " + rs.getString("departure_time") + "</p>");
            	    out.println("<p><b>Arrival:</b> " + rs.getString("arrival_time") + "</p>");
            	    out.println("<p><b>Fare:</b> ₹" + rs.getDouble("fare") + "</p>");
            	    
            	    int busId = rs.getInt("bus_id");

            	    PreparedStatement seatPs = con.prepareStatement(
            	    	    "SELECT COUNT(*) FROM bookings WHERE bus_id=? AND journey_date=?");

            	    	seatPs.setInt(1, busId);
            	    	seatPs.setString(2, journeyDate);
            	    	
            	    ResultSet seatRs = seatPs.executeQuery();

            	    int bookedSeats = 0;

            	    if (seatRs.next()) {
            	        bookedSeats = seatRs.getInt(1);
            	    }

            	    int availableSeats = 40 - bookedSeats;

            	    out.println("<p><b>Available Seats:</b> " + availableSeats + "</p>");
            	    
            	    out.println("<form action='BookServlet' method='post'>");
            	    out.println("<input type='hidden' name='journeyDate' value='" + journeyDate + "'>");
            	    out.println("<input type='hidden' name='busId' value='" + busId + "'>");
            	   

            	    out.println("<p><b>Journey Date:</b> " + journeyDate + "</p>");

            	    out.println("<button type='submit'>Book Now</button>");

            	    out.println("</form>");

            	    out.println("</div>");

            	} while (rs.next());

            	out.println("</div>");
            	out.println("</body>");
            	out.println("</html>");
            	
            } else {
            	out.println("<h2>No Bus Found</h2>");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}