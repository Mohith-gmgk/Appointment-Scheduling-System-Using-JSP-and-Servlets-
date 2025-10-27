<!DOCTYPE html>
<html>
<head>
    <title>Appointment Scheduling System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6; /* Light gray background */
            color: #333;
            text-align: center;
            padding-top: 50px;
        }
        .container {
            width: 80%;
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #007bff; /* Blue heading */
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        a {
            color: #28a745; /* Green links */
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
            margin-top: 15px;
            padding: 10px 15px;
            border: 1px solid #28a745;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        a:hover {
            background-color: #28a745;
            color: white;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Welcome to the Appointment Scheduler</h1>
        <p>This is the starting page (index.jsp) of your application.</p>

        <%
            // This is a simple Java scriptlet for the current time
            java.util.Date currentDate = new java.util.Date();
        %>

        <p>Today's Date and Time: **<%= currentDate %>**</p>

        <p>
            <a href="bookAppointment.jsp">Click here to Book an Appointment</a>
        </p>

        <p>
            <a href="viewAppointments.jsp">View All Scheduled Appointments</a>
        </p>
    </div>
	<h1>Testing Purpose</h1>

</body>
</html>