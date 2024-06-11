
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>airline</title>
    <link rel="stylesheet" href="./css/style.css">
    <script src="./js/index.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>
<body>

<header>
    <nav>
        <ul>
            <li><a href="home.php">Home</a></li>
            <li><a href="manage-reservation.php">Manage Reservations</a></li>
            <li><a href="travel-info.php">Travel Information</a></li>
            <?php session_start(); if(isset($_SESSION['user'])){?>
                 <li><a href="logout.php">Logout</a></li>
            <?php }else{?>
                <li><a href="login.php">Login/signup</a></li>
            <?php }?>

        </ul>
    </nav>
</header>

