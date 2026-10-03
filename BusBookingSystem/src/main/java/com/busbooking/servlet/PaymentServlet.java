package com.busbooking.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

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

        request.setAttribute("busId", busId);
        request.setAttribute("journeyDate", journeyDate);
        request.setAttribute("seatNumber", seatNumber);
        request.setAttribute("name", name);
        request.setAttribute("mobile", mobile);
        request.setAttribute("age", age);
        request.setAttribute("amount", amount);

        request.getRequestDispatcher("payment.jsp")
               .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("home.jsp");
    }
}