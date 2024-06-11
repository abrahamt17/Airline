<?php 
require("header.php");
require("connect.php");

if (!isset($_SESSION["user"])) {
    header("Location: login.php?redirect=modify-reservation.php");
    exit();
}


$userID = $_SESSION["user"]["UserID"];

if ($_POST) {
    $bookingID = $_POST['booking_id'];

    $bookingQuery = "
        SELECT b.BookingID, b.BookingDate, b.TotalPrice, b.Status, 
               p.PassengerID, p.FirstName, p.LastName, p.Email, p.PhoneNumber, 
               f.FlightID, f.Airline, f.FlightNumber, f.DepartureAirport, f.ArrivalAirport, 
               f.DepartureTime, f.ArrivalTime 
        FROM bookings b 
        JOIN passengers p ON b.PassengerID = p.PassengerID 
        JOIN Flights f ON b.FlightID = f.FlightID 
        WHERE b.BookingID = ? AND b.UserID = ?
    ";
    $bookingStmt = $conn->prepare($bookingQuery);
    $bookingStmt->bind_param("ii", $bookingID, $userID);
    $bookingStmt->execute();
    $bookingResult = $bookingStmt->get_result();

    if ($bookingResult->num_rows > 0) {
        $booking = $bookingResult->fetch_assoc();
        ?>

        <main class="main">
            <div class="container">
                <h1>Modify Reservation</h1>
                <h2>Booking ID: <?php echo $booking['BookingID']; ?></h2>
                <form action="process-modification.php" method="post">
                    <input type="hidden" name="booking_id" value="<?php echo $booking['BookingID']; ?>">

                    <h3>Modification Options:</h3>
                    <label>
                        <input type="radio" name="modification_option" value="cancel" required> Cancel Booking
                    </label><br>
                    <label>
                        <input type="radio" name="modification_option" value="edit_passenger" required> Edit Passenger Details
                    </label><br><br>

                    <button type="submit">Proceed</button>
                </form>
            </div>
        </main>

        <?php
    } else {
        echo "<p>Error: Booking not found or you do not have permission to modify this booking.</p>";
    }
} else {
    echo "<p>Error: Invalid request.</p>";
}

require("footer.php");
?>
