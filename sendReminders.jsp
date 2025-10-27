<%@ page language="java" import="java.sql.*, java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reminder Service Trigger</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; padding: 50px; text-align: center; }
        .container { max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); }
        h1 { color: #dc3545; }
        .success { color: green; font-weight: bold; }
        .log { text-align: left; background-color: #f0f0f0; border: 1px solid #ccc; padding: 10px; margin-top: 20px;}
    </style>
</head>
<body>

    <div class="container">
        <h1>Daily Reminder Service</h1>
        <p><strong>NOTE:</strong> The reminder messages are now displayed directly below.</p>
        <hr>

        <%
            String dbURL = "jdbc:mysql://localhost:3306/appointmentsys";
            String dbUser = "root";
            String dbPass = ""; 

            int remindersSent = 0;
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            // Start of log output buffer
            StringBuilder logOutput = new StringBuilder();

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                
                // SQL uses database function to check appointments for exactly 1 day after today.
                String sql = "SELECT name, service, time, date FROM appointments WHERE date = DATE_ADD(CURDATE(), INTERVAL 1 DAY)";
                
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                
                logOutput.append("Checking appointments for tomorrow...<br>");

                while (rs.next()) {
                    String name = rs.getString("name");
                    String service = rs.getString("service");
                    String time = rs.getString("time");
                    String date = rs.getString("date");
                    
                    // Output reminder to the web page log
                    logOutput.append("✅ [SENT] Reminder to **" + name + "** for " + service + " on " + date + " at " + time + "<br>");
                    remindersSent++;
                }
                
                logOutput.append("<br>Total Reminders Processed: **" + remindersSent + "**");
        %>
                <h2 class="success">Reminder Task Complete!</h2>
                <p>Processed **<%= remindersSent %>** reminders for tomorrow's appointments.</p>
                
                <div class="log">
                    **Simulated Reminder Output Log:**
                    <hr>
                    <%= logOutput.toString() %>
                </div>
        <%
            } catch (Exception e) {
        %>
                <h2 style="color: red;">ERROR: Failed to run Reminder Service</h2>
                <p>Details: <%= e.getMessage() %></p>
        <%
            } finally {
                // Close resources
                try { if (rs != null) rs.close(); } catch (SQLException ignore) {}
                try { if (ps != null) ps.close(); } catch (SQLException ignore) {}
                try { if (conn != null) conn.close(); } catch (SQLException ignore) {}
            }
        %>
        <br>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>