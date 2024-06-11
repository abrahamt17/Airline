<?php 
require("header.php");
require("connect.php");

// Start the session
session_start();

// Check if the user is not logged in
if (!isset($_SESSION["user"])) {
    // Redirect to the login page
    header("Location: login.php?redirect=passenger-info.php");
    exit();
}

if ($_POST) {
    // Check if all form fields are set
    if (isset($_POST['flight_id'], $_POST['first_name'], $_POST['last_name'], $_POST['email'], $_POST['phone'])) {
        // Retrieve form data
        $flightID = $_POST['flight_id'];
        $firstName = $_POST['first_name'];
        $lastName = $_POST['last_name'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];

        // Insert into passengers table
        $passengerQuery = "INSERT INTO passengers (FirstName, LastName, Email, PhoneNumber) VALUES (?, ?, ?, ?)";
        $passengerStmt = $conn->prepare($passengerQuery);
        $passengerStmt->bind_param("ssss", $firstName, $lastName, $email, $phone);
        $passengerStmt->execute();
        
        // Retrieve the ID of the last inserted passenger
        $passengerID = $conn->insert_id;

        // Fetch the total price from the price table
        $priceQuery = "SELECT Price FROM price WHERE FlightID = ?";
        $priceStmt = $conn->prepare($priceQuery);
        $priceStmt->bind_param("i", $flightID);
        $priceStmt->execute();
        $priceResult = $priceStmt->get_result();
        $totalPrice = $priceResult->fetch_assoc()['Price'];

        // Fetch the status from the Flights table
        $statusQuery = "SELECT Status FROM Flights WHERE FlightID = ?";
        $statusStmt = $conn->prepare($statusQuery);
        $statusStmt->bind_param("i", $flightID);
        $statusStmt->execute();
        $statusResult = $statusStmt->get_result();
        $status = $statusResult->fetch_assoc()['Status'];

        // Insert into bookings table
        $bookingQuery = "INSERT INTO bookings (UserID, FlightID, BookingDate, TotalPrice, Status,PassengerID) VALUES (?, ?, CURDATE(), ?, ?,?)";
        $bookingStmt = $conn->prepare($bookingQuery);
        $userID = $_SESSION['user']['UserID'];
        $bookingStmt->bind_param("iidsi", $userID, $flightID, $totalPrice, $status,$passengerID);
        $bookingStmt->execute();
        
        // Retrieve the ID of the last inserted booking
        $bookingID = $conn->insert_id;

        if ($passengerStmt && $bookingStmt) {
            // Redirect to the success page
            header("Location: success.php?booking_id=$bookingID");
            exit();
        }
    } else {
        echo "<div class='container'><p>Error: Please fill out all fields.</p></div>";
    }
}
?>

<main class="main">
    <div class="container">
        <h1>Passenger Information</h1>
        <?php
        if (isset($_GET['flight_id'])) {
            $flightID = $_GET['flight_id'];
            $query = "SELECT * FROM Flights WHERE FlightID = ?";
            $stmt = $conn->prepare($query);
            $stmt->bind_param("i", $flightID);
            $stmt->execute();
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                $flight = $result->fetch_assoc();
                $priceQuery = "SELECT Price FROM price WHERE FlightID = ?";
                $priceStmt = $conn->prepare($priceQuery);
                $priceStmt->bind_param("i", $flightID);
                $priceStmt->execute();
                $priceResult = $priceStmt->get_result();
                $price = $priceResult->fetch_assoc()['Price'];

                echo "<h2>Flight Details:</h2>";
                echo "<p>Airline: {$flight['Airline']}</p>";
                echo "<p>Flight Number: {$flight['FlightNumber']}</p>";
                echo "<p>Departure Airport: {$flight['DepartureAirport']}</p>";
                echo "<p>Arrival Airport: {$flight['ArrivalAirport']}</p>";
                echo "<p>Departure Time: {$flight['DepartureTime']}</p>";
                echo "<p>Arrival Time: {$flight['ArrivalTime']}</p>";
                echo "<p>Price: {$price} birr</p>";

                // Form for entering passenger information
                echo "<h2>Enter Passenger Information:</h2>";
                echo '<form action="" method="post" class="passenger-form">';
                echo '<input type="hidden" name="flight_id" value="' . $flightID . '">'; // Hidden field to pass flight ID
                echo '<div class="form-group"><label for="first_name">First Name:</label><input type="text" name="first_name" required></div>';
                echo '<div class="form-group"><label for="last_name">Last Name:</label><input type="text" name="last_name" required></div>';
                echo '<div class="form-group"><label for="email">Email:</label><input type="email" name="email" required></div>';
                echo '<div class="form-group"><label for="phone">Phone:</label><input type="text" name="phone" required></div>';
                echo '<button type="submit">Continue to Confirmation</button>';
                echo '</form>';
            } else {
                echo "<p>Error: Flight not found.</p>";
            }
        } else {
            echo "<p>Error: Flight ID not provided.</p>";
        }
        ?>
    </div>
</main>

<?php require("footer.php"); ?>
