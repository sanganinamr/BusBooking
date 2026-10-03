package com.busbooking.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int busId = Integer.parseInt(request.getParameter("busId"));

        request.setAttribute("busId", busId);
        String journeyDate = request.getParameter("journeyDate");
        System.out.println("Journey Date = " + journeyDate);
        request.setAttribute("journeyDate", journeyDate);

        request.getRequestDispatcher("passenger.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("home.jsp");
    }
}