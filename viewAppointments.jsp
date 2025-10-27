<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>View All Appointments</title>
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 8px;
        }
    </style>
</head>
<body>

    <h1>All Scheduled Appointments</h1>
    <a href="index.jsp">Home</a> | <a href="bookAppointment.jsp">Book New</a>
    <hr>

    <%
        // Database Connection Details (Same as Step 8)
        String dbURL = "jdbc:mysql://localhost:3306/appointmentsys";
        String dbUser = "root";
        String dbPass = ""; 

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // 1. Establish the connection and statement
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            stmt = conn.createStatement();

            // 2. Execute the query to fetch all appointments
            String sql = "SELECT id, name, service, date, time FROM appointments ORDER BY date, time";
            rs = stmt.executeQuery(sql);
    %>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Client Name</th>
                <th>Service</th>
                <th>Date</th>
                <th>Time</th>
            </tr>
        </thead>
        <tbody>

    <%
            // 3. Loop through the results (ResultSet)
            while (rs.next()) {
                // Retrieve data from the current row
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String service = rs.getString("service");
                String date = rs.getString("date");
                String time = rs.getString("time");
    %>
            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= service %></td>
                <td><%= date %></td>
                <td><%= time %></td>
            </tr>
    <%
            }
    %>
        </tbody>
    </table>

    <%
        } catch (ClassNotFoundException e) {
            out.println("<p>Driver Error: " + e.getMessage() + "</p>");
        } catch (SQLException e) {
            out.println("<p>Database Error: " + e.getMessage() + "</p>");
        } finally {
            // 5. Close resources
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>

</body>
</html>