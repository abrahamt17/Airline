<?php
require("header.php");
require("connect.php");

// Check if the user is not logged in
if (!isset($_SESSION["user"])) {
    // Redirect to the login page
    header("Location: login.php");
    exit();
}

// Check if booking_id is provided
if (!isset($_GET['booking_id'])) {
    echo "<div class='container'><p>Error: Booking ID not provided.</p></div>";
    exit();
}

$bookingID = $_GET['booking_id'];

// Fetch booking details
$bookingQuery = "
    SELECT b.BookingID, b.BookingDate, b.TotalPrice, b.Status, 
           p.FirstName, p.LastName, p.Email, p.PhoneNumber, 
           f.Airline, f.FlightNumber, f.DepartureAirport, f.ArrivalAirport, 
           f.DepartureTime, f.ArrivalTime 
    FROM bookings b 
    JOIN passengers p ON b.PassengerID = p.PassengerID 
    JOIN Flights f ON b.FlightID = f.FlightID 
    WHERE b.BookingID = ?
";
$bookingStmt = $conn->prepare($bookingQuery);
$bookingStmt->bind_param("i", $bookingID);
$bookingStmt->execute();
$bookingResult = $bookingStmt->get_result();

if ($bookingResult->num_rows == 0) {
    echo "<div class='container'><p>Error: Booking not found.</p></div>";
    exit();
}

$booking = $bookingResult->fetch_assoc();

// Generate random gate and seat
$gate = rand(1, 30);
$seatRow = rand(11, 30);
$seatColumn = chr(rand(65, 70)); // A-F
$seat = $seatRow . $seatColumn;
?>

<main class="main">
    <div class="container">
        <div class="ticket">
            <div class="ticket-header">
                <h1>Boarding Pass</h1>
                <div class="ticket-info">
                    <p>Flight: <?php echo $booking['FlightNumber']; ?></p>
                    <p>Boarding Time: 10:20</p>
                    <p>Gate: <?php echo $gate; ?></p>
                    <p>Seat: <?php echo $seat; ?></p>
                    <p>Class: Economy</p>
                </div>
            </div>
            <div class="ticket-body">
                <div class="passenger-info">
                    <h2>Passenger Name: <?php echo $booking['FirstName'] . " " . $booking['LastName']; ?></h2>
                    <p>From: <?php echo $booking['DepartureAirport']; ?></p>
                    <p>To: <?php echo $booking['ArrivalAirport']; ?></p>
                    <p>Date: <?php echo date("dM", strtotime($booking['BookingDate'])); ?></p>
                </div>
                <div class="flight-info">
                    <p>Airline: <?php echo $booking['Airline']; ?></p>
                    <p>Departure Time: <?php echo $booking['DepartureTime']; ?></p>
                    <p>Arrival Time: <?php echo $booking['ArrivalTime']; ?></p>
                </div>
            </div>
            <div class="ticket-footer">
                <p>E-TICKET <?php echo $bookingID; ?></p>
            </div>
        </div>
    </div>
</main>
<?php require("footer.php"); ?>
