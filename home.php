<!-- 
    ********************Airline Reservation System********************
        
        * An airline reservation system is a powerful tool that allows airlines to: 
            > sell their inventory(Seats), 
            > manage their schedules, 
            > and track their passengers.

        * It is a vast database of information that includes 
            > flight schedules, 
            > fares, 
            > seat availability, and
            > passenger reservations. 

        * Airline reservation systems also allow passengers to 
            > book their tickets online, 
            > track their flights, and 
            > make changes to their reservations.
        
    @ List of Functionalities That are Included in Our Website:
        > Register for the website (SignUp and Login)
        > Booking
            + Search for available flights based on Departure, Arrival & Departure Date.
            + Book flight tickets.

        > Manage Reservvation (Booking)
            + Cancel flight tickets.
            + Review booking details.
            + Edit Passenger Details.
            + Check Status.
-->


<?php require("header.php")?>

    <main class="main">
        <section class="hero">
            <h1>Welcome to Our Airline</h1>
            <p>Discover the world with our reliable and comfortable flights.</p>
            <a href="search-form.php" class="cta-button">Explore Flights</a>
        </section>
        <section class="features">
            <div class="feature">
                <img src="img/plane.png" alt="Search Flights" >
                <h2>Search Flights</h2>
                <p>Find the perfect flight for your next journey with our easy-to-use search tool.</p>
            </div>
            <div class="feature">
                <img src="img/airplane-ticket.png" alt="Book Tickets">
                <h2>Book Tickets</h2>
                <p>Securely book your tickets online and enjoy a hassle-free travel experience.</p>
            </div>
            <div class="feature">
                <img src="img/support.png" alt="Customer Support">
                <h2>24/7 Customer Support</h2>
                <p>Our dedicated support team is available round the clock to assist you with any queries.</p>
            </div>
        </section>

        <section class="testimonial">
            <h2>What Our Customers Say</h2>
            <blockquote>"I had an amazing experience flying with this airline. The service was top-notch and the staff were very friendly."</blockquote>
            <cite>- Haileyesus Hajiso, Happy Customer</cite>
        </section>
    </main>


<?php require("footer.php")?>