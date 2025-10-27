<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e6f0ff; /* Light blue background */
            color: #333;
            padding-top: 30px;
            text-align: center;
        }
        .form-container {
            width: 90%;
            max-width: 500px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: left;
        }
        h1 {
            color: #0056b3;
            text-align: center;
        }
        hr {
            border: 0;
            height: 1px;
            background-color: #ccc;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"], input[type="date"], input[type="time"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box; /* Important for padding/border not affecting width */
        }
        input[type="submit"] {
            background-color: #28a745; /* Green button */
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        .nav-links a {
            color: #007bff;
            margin-right: 15px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Book a New Appointment</h1>
        <div class="nav-links">
            <a href="index.jsp">Home</a> | <a href="viewAppointments.jsp">View All</a>
        </div>
        <hr>

        <form action="saveAppointment.jsp" method="POST">

            <label for="service">Service Type:</label>
            <select id="service" name="service" required>
                <option value="Haircut">Haircut</option>
                <option value="Checkup">Doctor Checkup</option>
                <option value="Consultation">Legal Consultation</option>
            </select>

            <label for="name">Your Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="date">Date:</label>
            <input type="date" id="date" name="date" required>

            <label for="time">Time:</label>
            <input type="time" id="time" name="time" required>

            <input type="submit" value="Confirm Booking">

        </form>
    </div>
</body>
</html>