<?php require("header.php"); require("connect.php")?>

<main class="main">
    <div class="container">
        <h1>Flight Booking</h1>
        <?php
        // Check if the flight ID is set in the URL
        if (isset($_GET['flight_id'])) {
            // Retrieve the flight ID from the URL
            $flightID = $_GET['flight_id'];
            
            // Prepare and execute the SQL query to retrieve detailed information about the selected flight, including the price
            $query = "
                SELECT f.*, p.Price, p.Currency
                FROM Flights f
                JOIN Price p ON f.FlightID = p.FlightID
                WHERE f.FlightID = ?";
            $stmt = $conn->prepare($query);
            $stmt->bind_param("i", $flightID);
            $stmt->execute();
            $result = $stmt->get_result();
            
            // Check if the flight exists in the database
            if ($result->num_rows > 0) {
                $flight = $result->fetch_assoc();
                // Display detailed information about the selected flight
                echo "<h2>Flight Details:</h2>";
                echo "<p>Airline: {$flight['Airline']}</p>";
                echo "<p>Flight Number: {$flight['FlightNumber']}</p>";
                echo "<p>Departure Airport: {$flight['DepartureAirport']}</p>";
                echo "<p>Arrival Airport: {$flight['ArrivalAirport']}</p>";
                echo "<p>Departure Time: {$flight['DepartureTime']}</p>";
                echo "<p>Arrival Time: {$flight['ArrivalTime']}</p>";
                echo "<p>Price: {$flight['Price']} {$flight['Currency']}</p>";
                
                // Redirect to passenger_info.php with the flight ID
                echo "<a href='passenger-info.php?flight_id={$flightID}' style='text-decoration: none;'><button>Proceed</button></a>";
            } else {
                // If the flight ID does not exist in the database, display an error message
                echo "<p>Error: Flight not found.</p>";
            }
        } else {
            // If the flight ID is not set, display an error message or redirect the user back to the search page
            echo "<p>Error: Flight ID not provided.</p>";
        }
        ?>
    </div>
</main>

<?php require("footer.php"); ?>
