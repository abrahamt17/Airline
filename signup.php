<?php
// Include the database configuration file
require 'connect.php';

// Function to validate input data
function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

// Initialize variables and set them to empty values
$full_name = $email_address = $password = $phone_number = $address = $date_of_birth = "";
$errors = array();

if ($_POST) {
    // Validate input data
    $full_name = test_input($_POST["full_name"]);
    $email_address = test_input($_POST["email_address"]);
    $password = test_input($_POST["password"]);
    $phone_number = test_input($_POST["phone_number"]);
    $address = test_input($_POST["address"]);
    $date_of_birth = test_input($_POST["date_of_birth"]);

    // Validate email address
    if (!filter_var($email_address, FILTER_VALIDATE_EMAIL)) {
        $errors[] = "Invalid email format";
    }

    // Validate password length
    if (strlen($password) < 6) {
        $errors[] = "Password must be at least 6 characters long";
    }

    // If there are no errors, proceed with database insertion
    if (empty($errors)) {
        // Hash the password
        $hashed_password = md5($password);

        // Prepare an SQL statement to prevent SQL injection
        $stmt = $conn->prepare("INSERT INTO Users (Username, PasswordHash, Email, PhoneNumber, DateJoined) VALUES (?, ?, ?, ?, ?)");
        $date_joined = date("Y-m-d"); // Get the current date
        $stmt->bind_param("sssss", $full_name, $hashed_password, $email_address, $phone_number, $date_joined);

        // Execute the statement
        if ($stmt->execute()) {
            $success_message = "Sign up successful!";
        } else {
            $error_message = "Error: " . $stmt->error;
        }

        // Close the statement
        $stmt->close();
    } else {
        // Display errors
        foreach ($errors as $error) {
            $error_message = "<p>$error</p>";
        }
    }
    // Close the connection
    $conn->close();
}
?>

<?php require("header.php")?>
<main class="main">
    <div class="signup-form">
        <h2>Sign Up for Airline Account</h2>
        <?php
        // Display error or success message within signup-form div
        if (isset($error_message)) {
            echo "<div class='error' style='color: red;'>$error_message</div>";
        } elseif (isset($success_message)) {
            echo "<div class='success'style='color: green;'>$success_message</div>";
        }
        ?>
        <form action="signup.php" method="post">
            <input type="text" placeholder="Full Name" required name="full_name">
            <input type="email" placeholder="Email Address" required name="email_address">
            <input type="password" placeholder="Password" required name="password">
            <input type="tel" placeholder="Phone Number" required name="phone_number">
            <input type="text" placeholder="Address" required name="address">
            <input type="date" placeholder="Date of Birth" required name="date_of_birth">
            <button type="submit">Sign Up</button>
        </form>
    </div>
</main>
<?php require("footer.php")?>
