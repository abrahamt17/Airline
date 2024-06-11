<?php 
require("header.php");
require("connect.php");

// Start the session
session_start();

// Check if the user is not logged in
if (!isset($_SESSION["user"])) {
    // Redirect to the login page
    header("Location: login.php?redirect=process-modification.php");
    exit();
}

// Retrieve the user ID from the session
$userID = $_SESSION["user"]["UserID"];

if ($_POST) {
    // Retrieve the booking ID and modification option from the form
    $bookingID = $_POST['booking_id'];
    $modificationOption = $_POST['modification_option'];

    // Fetch the booking details from the database
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

        // Handle each modification option
        if ($modificationOption == "cancel") {
            // Cancel the booking by deleting the booking row from the bookings table
            $deleteBookingQuery = "DELETE FROM bookings WHERE BookingID = ?";
            $deleteBookingStmt = $conn->prepare($deleteBookingQuery);
            $deleteBookingStmt->bind_param("i", $bookingID);
            $deleteBookingStmt->execute();

            // Cancel the passenger information associated with this booking
            $passengerID = $booking['PassengerID'];
            $deletePassengerQuery = "DELETE FROM passengers WHERE PassengerID = ?";
            $deletePassengerStmt = $conn->prepare($deletePassengerQuery);
            $deletePassengerStmt->bind_param("i", $passengerID);
            $deletePassengerStmt->execute();

            if ($deleteBookingStmt->affected_rows > 0 && $deletePassengerStmt->affected_rows > 0) {
                header("Location:manage-reservation.php");
            } else {
                echo "<p>Error: Unable to cancel the booking. Please try again later.</p>";
            }

        } elseif ($modificationOption == "edit_passenger") {
            // Display form to edit passenger details
            ?>
            <main class="main">
                <div class="container">
                    <h1>Edit Passenger Details</h1>
                    <form action="update-passenger.php" method="post">
                        <input type="hidden" name="booking_id" value="<?php echo $booking['BookingID']; ?>">
                        <label for="first_name">First Name:</label>
                        <input type="text" id="first_name" name="first_name" value="<?php echo $booking['FirstName']; ?>" required><br><br>
                        <label for="last_name">Last Name:</label>
                        <input type="text" id="last_name" name="last_name" value="<?php echo $booking['LastName']; ?>" required><br><br>
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<?php echo $booking['Email']; ?>" required><br><br>
                        <label for="phone">Phone Number:</label>
                        <input type="tel" id="phone" name="phone" value="<?php echo $booking['PhoneNumber']; ?>" required><br><br> 
                        <button type="submit">Update Passenger</button>
                    </form>
                </div>
            </main>
            <?php
        }

    } else {
        echo "<p>Error: Booking not found or you do not have permission to modify this booking.</p>";
    }
} else {
    echo "<p>Error: Invalid request.</p>";
}

require("footer.php");
?>
