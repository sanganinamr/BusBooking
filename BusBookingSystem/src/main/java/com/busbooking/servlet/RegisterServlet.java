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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("RegisterServlet Called");

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Empty field check
        if (fullname == null || fullname.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || mobile == null || mobile.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || confirmPassword == null || confirmPassword.trim().isEmpty()) {

            response.getWriter().println(
                "<script>" +
                "alert('Please fill all fields!');" +
                "window.history.back();" +
                "</script>"
            );
            return;
        }

        // Password match check
        if (!password.equals(confirmPassword)) {

            response.getWriter().println(
                "<script>" +
                "alert('Password and Confirm Password do not match!');" +
                "window.history.back();" +
                "</script>"
            );
            return;
        }

        try {

            Connection con = DBConnection.getConnection();

            // Check Email OR Mobile already registered
            String checkSql =
                "SELECT email, mobile FROM users WHERE email=? OR mobile=?";

            PreparedStatement checkPs =
                con.prepareStatement(checkSql);

            checkPs.setString(1, email);
            checkPs.setString(2, mobile);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {

                String existingEmail = rs.getString("email");
                String existingMobile = rs.getString("mobile");

                rs.close();
                checkPs.close();
                con.close();

                if (email.equalsIgnoreCase(existingEmail)
                        && mobile.equals(existingMobile)) {

                    response.getWriter().println(
                        "<script>" +
                        "alert('Email and Mobile Number are already registered!');" +
                        "window.history.back();" +
                        "</script>"
                    );

                } else if (email.equalsIgnoreCase(existingEmail)) {

                    response.getWriter().println(
                        "<script>" +
                        "alert('Email is already registered!');" +
                        "window.history.back();" +
                        "</script>"
                    );

                } else {

                    response.getWriter().println(
                        "<script>" +
                        "alert('Mobile Number is already registered!');" +
                        "window.history.back();" +
                        "</script>"
                    );
                }

                return;
            }

            rs.close();
            checkPs.close();

            // New user registration
            String sql =
                "INSERT INTO users(full_name, email, mobile, password) " +
                "VALUES (?, ?, ?, ?)";

            PreparedStatement ps =
                con.prepareStatement(
                    sql,
                    java.sql.Statement.RETURN_GENERATED_KEYS
                );

            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, password);

            int result = ps.executeUpdate();

            if (result > 0) {

                ResultSet generatedKeys =
                    ps.getGeneratedKeys();

                if (generatedKeys.next()) {

                    int userId =
                        generatedKeys.getInt(1);

                    request.getSession()
                           .setAttribute("userId", userId);
                }

                generatedKeys.close();
                ps.close();
                con.close();

                response.sendRedirect("home.jsp");

            } else {

                ps.close();
                con.close();

                response.getWriter().println(
                    "<script>" +
                    "alert('Registration Failed!');" +
                    "window.history.back();" +
                    "</script>"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "<script>" +
                "alert('Something went wrong during registration!');" +
                "window.history.back();" +
                "</script>"
            );
        }
    }
}