<?php 
require("header.php");
require("connect.php");

if (!isset($_SESSION["user"])) {
    header("Location: login.php?redirect=manage-reservation.php");
    exit();
}

$userID = $_SESSION["user"]["UserID"];

$bookingQuery = "
    SELECT b.BookingID, b.BookingDate, b.Status, 
           p.FirstName, p.LastName, p.Email, p.PhoneNumber, 
           f.Airline, f.FlightNumber, f.DepartureAirport, f.ArrivalAirport, 
           f.DepartureTime, f.ArrivalTime 
    FROM bookings b 
    JOIN passengers p ON b.PassengerID = p.PassengerID 
    JOIN Flights f ON b.FlightID = f.FlightID 
    WHERE b.UserID = ?
";
$bookingStmt = $conn->prepare($bookingQuery);
$bookingStmt->bind_param("i", $userID);
$bookingStmt->execute();
$bookingResult = $bookingStmt->get_result();

?>

<main class="main">
    <div class="container">
        <h1>Manage Reservations</h1>
        <?php
        if ($bookingResult->num_rows > 0) {
            while ($booking = $bookingResult->fetch_assoc()) {
                echo "<div class='booking'>";
                echo "<h2>Booking ID: {$booking['BookingID']}</h2>";
                echo "<p>Booking Date: {$booking['BookingDate']}</p>";
                echo "<p>Status: {$booking['Status']}</p>";

                echo "<h3>Passenger Information</h3>";
                echo "<p>First Name: {$booking['FirstName']}</p>";
                echo "<p>Last Name: {$booking['LastName']}</p>";
                echo "<p>Email: {$booking['Email']}</p>";
                echo "<p>Phone: {$booking['PhoneNumber']}</p>";

                echo "<h3>Flight Information</h3>";
                echo "<p>Airline: {$booking['Airline']}</p>";
                echo "<p>Flight Number: {$booking['FlightNumber']}</p>";
                echo "<p>Departure Airport: {$booking['DepartureAirport']}</p>";
                echo "<p>Arrival Airport: {$booking['ArrivalAirport']}</p>";
                echo "<p>Departure Time: {$booking['DepartureTime']}</p>";
                echo "<p>Arrival Time: {$booking['ArrivalTime']}</p>";

                echo "<form action='modify-booking.php' method='post'>";
                echo "<input type='hidden' name='booking_id' value='{$booking['BookingID']}'>";
                echo "<button type='submit'>Modify Booking</button>";
                echo "</form>";

                echo "</div>";
                echo "<hr>";
            }
        } else {
            echo "<p>You have no bookings.</p>";
        }
        ?>
    </div>
</main>

<?php require("footer.php"); ?>
