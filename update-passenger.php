<?php 
require("header.php");
require("connect.php");

// Start the session
session_start();

// Check if the user is not logged in
if (!isset($_SESSION["user"])) {
    // Redirect to the login page
    header("Location: login.php?redirect=update-passenger.php");
    exit();
}

if ($_POST) {
    // Retrieve the booking ID and new passenger details from the form
    $bookingID = $_POST['booking_id'];
    $firstName = $_POST['first_name'];
    $lastName = $_POST['last_name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];

    // Update the passenger details in the database
    $updatePassengerQuery = "
        UPDATE passengers 
        SET FirstName = ?, LastName = ?, Email = ?, PhoneNumber = ? 
        WHERE PassengerID = (SELECT PassengerID FROM bookings WHERE BookingID = ?)
    ";
    $updatePassengerStmt = $conn->prepare($updatePassengerQuery);
    $updatePassengerStmt->bind_param("sssii", $firstName, $lastName, $email, $phone, $bookingID);
    $updatePassengerStmt->execute();

    header("Location:manage-reservation.php");
} else {
    echo "<p>Error: Invalid request.</p>";
}

?>
