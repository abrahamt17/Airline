<?php 
require("header.php");
// Include the database configuration file
require 'connect.php';

if ($_POST) {
    // Check if username and password are set
    if (isset($_POST["username"]) && isset($_POST["password"])) {
        // Sanitize user input
        $username = htmlspecialchars($_POST["username"]);
        $password = htmlspecialchars($_POST["password"]);

        // Hash the password
        $hashed_password = md5($password);

        // Prepare and execute the SQL statement
        $stmt = $conn->prepare("SELECT * FROM Users WHERE Username=? AND PasswordHash=?");
        $stmt->bind_param("ss", $username, $hashed_password);
        $stmt->execute();
        
        // Check for errors
        if ($stmt->error) {
            die("Error: " . $stmt->error);
        }

        $result = $stmt->get_result();

        if ($result->num_rows == 1) {
            // Login successful, fetch user data
            $user = $result->fetch_assoc();
            
            // Store user data in session variable
            $_SESSION["user"] = $user;
            
            // Redirect to home.php
            header("Location: home.php");
            exit();
        } else {
            $error = "Invalid username or password";
        }

        // Close the statement
        $stmt->close();
    } else {
        $error = "Username and password are required.";
    }
}
?>

<main class="main">
    <div class="login-container">
        <h1>Login</h1>
        <?php
        // Display error message if login fails
        if (isset($error)) {
            echo "<p style='color: red;'>$error</p>";
        }
        ?>
        <form action="login.php" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
            <a href="signup.php">Sign Up</a>
        </form>
    </div>
</main>

<?php require("footer.php")?>
