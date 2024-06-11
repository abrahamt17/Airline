<?php
// Database configuration
$servername = 'localhost';
$username = 'root';
$password = '';
$database = 'airline_databse';

// Create a database connection
$conn = new mysqli($servername, $username, $password, $database);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
