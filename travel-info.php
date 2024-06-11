<?php require("header.php")?>
<?php
// Include the database connection file
include 'connect.php';

// Fetch data from travelinfo table
$sql = "SELECT InfoType, Content FROM travelinfo";
$result = $conn->query($sql);

// Close the connection
$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Travel Information</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .header {
            text-align: center;
            margin-bottom: 50px;
        }
        .header h1 {
            font-size: 2.5em;
            color: #333;
            margin: 0;
        }
        .info-section {
            margin-bottom: 30px;
            border-left: 5px solid #007bff;
            padding-left: 15px;
            transition: all 0.3s ease;
        }
        .info-section:hover {
            background-color: #f1f1f1;
        }
        .info-section h2 {
            margin-top: 0;
            color: #007bff;
            font-size: 1.75em;
        }
        .info-section p {
            font-size: 1.1em;
            line-height: 1.6;
            color: #555;
        }
        .info-section i {
            margin-right: 10px;
            color: #007bff;
        }
        .footer {
            text-align: center;
            margin-top: 50px;
            padding: 20px;
            background-color:black;
            color: #fff;
        }
    </style>
</head>
<body>
 <main class="main">
    <div class="container">
        <div class="header">
            <h1>Travel Information</h1>
        </div>
        <?php if ($result->num_rows > 0): ?>
            <?php while($row = $result->fetch_assoc()): ?>
                <div class="info-section">
                    <h2><i class="fas fa-info-circle"></i><?php echo htmlspecialchars($row['InfoType']); ?></h2>
                    <p><?php echo nl2br(htmlspecialchars($row['Content'])); ?></p>
                </div>
            <?php endwhile; ?>
        <?php else: ?>
            <p>No travel information available.</p>
        <?php endif; ?>
    </div>
    <div class="footer">
        &copy; <?php echo date("Y"); ?> Airline Website. All rights reserved.
    </div>
 </main>
</body>
</html>
