<?php require("header.php")?>
<?php
// Include the database connection configuration
include 'connect.php';

// Fetch available locations from the database
$query = "SELECT name FROM locations";
$result = mysqli_query($conn, $query);

$locations = array();
while ($row = mysqli_fetch_assoc($result)) {
    $locations[] = $row['name'];
}

// Convert PHP array to JavaScript array using json_encode
$js_locations = json_encode($locations);


$search_results = [];

// Check if the form is submitted
if ($_GET) {
    // Retrieve form data
    $departure = $_GET['departure'];
    $arrival = $_GET['arrival'];
    $departureDate = $_GET['departure_date'];

    // Prepare and execute the SQL query with prepared statements
    $query = "SELECT * FROM Flights WHERE DepartureAirport = ? AND ArrivalAirport = ? AND DATE(DepartureTime) = ?";
    $stmt = $conn->prepare($query);

    // Bind parameters
    $stmt->bind_param("sss", $departure, $arrival, $departureDate);

    // Execute the statement
    if ($stmt->execute()) {
        // Get result
        $result = $stmt->get_result();

        // Fetch and store the search results
        while ($row = $result->fetch_assoc()) {
            $search_results[] = $row;
        }
    } else {
        die("Error executing statement: " . $stmt->error);
    }

    // Close statement
    $stmt->close();
}
?>


   <main class="main">
    <div class="container">
        <form action="search-form.php" method="GET" class="search-form" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="departure">Departure:</label>
                <input type="text" id="departure" name="departure" required>
            </div>
            <div class="form-group">
                <label for="arrival">Arrival:</label>
                <input type="text" id="arrival" name="arrival" required>
            </div>
            <div class="form-group">
                <label for="departure_date">Departure Date:</label>
                <input type="date" id="departure_date" name="departure_date" required>
            </div>
           
            <button type="submit" value="search Flights">Search Flights</button>
        </form>
    </div>
    <div class="search-results">
        <?php
        if ($_GET && !empty($search_results)) {
            echo "<h2>Search Results:</h2>";
            echo "<ul>";
            foreach ($search_results as $flight) {
                echo "<li>Flight from {$flight['DepartureAirport']} to {$flight['ArrivalAirport']}, Departure time: {$flight['DepartureTime']}, Arrival time: {$flight['ArrivalTime']}<button class='book-flight' data-flight-id='{$flight['FlightID']}' id='book-now'>Book Now</button></li>";
            }
            echo "</ul>";
        } else if($_GET && empty($search_results)) {
            echo "<h2>No result!</h2>";
        }
        ?>
    </div>
</main>


    <script>
$(document).ready(function() {
    var availableLocations = <?php echo $js_locations; ?>;

    $("#departure, #arrival").autocomplete({
        source: availableLocations
    });
});

$(document).ready(function() {
    // Function to handle booking when "Book Now" button is clicked
    $(".book-flight").click(function() {
        // Get the flight ID from the data attribute
        var flightID = $(this).data('flight-id');
        
        // Redirect to booking page with the flight ID
        window.location.href = "booking.php?flight_id=" + flightID;
    });

    var availableLocations = <?php echo $js_locations; ?>;
    $("#departure, #arrival").autocomplete({
        source: availableLocations
    });
});

</script>
<?php require("footer.php")?>