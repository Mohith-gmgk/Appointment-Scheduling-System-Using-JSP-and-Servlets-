<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Processing</title>
</head>
<body>

    <h1>Appointment Processing...</h1>
    <a href="index.jsp">Home</a>
    <hr>

    <%
        // Database Connection Details
        String dbURL = "jdbc:mysql://localhost:3306/appointmentsys";
        String dbUser = "root"; 
        String dbPass = "";     

        // 1. Get Form Data
        String service = request.getParameter("service");
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            // =======================================================
            // 2. AVAILABILITY CHECK LOGIC (NEW CODE)
            // =======================================================
            String checkSql = "SELECT COUNT(*) FROM appointments WHERE service = ? AND date = ? AND time = ?";
            ps = conn.prepareStatement(checkSql);
            ps.setString(1, service);
            ps.setString(2, date);
            ps.setString(3, time);
            
            rs = ps.executeQuery();
            int existingBookings = 0;
            if (rs.next()) {
                existingBookings = rs.getInt(1); // Get the count from the first column
            }
            
            // Close the ResultSet and PreparedStatement used for the check
            rs.close();
            ps.close();

            if (existingBookings > 0) {
                // =======================================================
                // UNAVAILABLE - SEND ERROR MESSAGE
                // =======================================================
    %>
                <h2 style="color:red;">❌ Booking Failed: Slot Unavailable!</h2>
                <p>The appointment for **<%= service %>** on **<%= date %>** at **<%= time %>** is already booked.</p>
                <p>Please go back and select a different time or service.</p>
                <a href="bookAppointment.jsp">Try Booking Again</a>
    <%
            } else {
                // =======================================================
                // AVAILABLE - PROCEED WITH INSERT
                // =======================================================
                String insertSql = "INSERT INTO appointments (name, service, date, time) VALUES (?, ?, ?, ?)";
                ps = conn.prepareStatement(insertSql);
                
                ps.setString(1, name);
                ps.setString(2, service);
                ps.setString(3, date); 
                ps.setString(4, time); 
                
                int rowCount = ps.executeUpdate();
                
                if (rowCount > 0) {
    %>
                    <h2>✅ Success!</h2>
                    <p>Thank you, **<%= name %>**! Your appointment has been successfully booked.</p>
                    <ul>
                        <li>**Service:** <%= service %></li>
                        <li>**Date:** <%= date %></li>
                        <li>**Time:** <%= time %></li>
                    </ul>
    <%
                } else {
    %>
                    <h2 style="color:red;">❌ Error!</h2>
                    <p>Failed to book the appointment due to a database issue.</p>
    <%
                }
            } // End of availability check

        } catch (Exception e) {
            // General error handler
            out.println("<h2>System Error:</h2>" + e.getMessage());
        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>

</body>
</html>