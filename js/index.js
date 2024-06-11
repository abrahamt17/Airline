function validateForm() {
    var departure = document.getElementById("departure").value;
    var arrival = document.getElementById("arrival").value;
    var date = document.getElementById("date").value;

    if (departure === "" || arrival === "" || date === "") {
        alert("Please fill out all required fields.");
        return false;
    }

    return true;
}

/* for sidebar */
document.getElementById('menu-icon').addEventListener('click', function(){
    console.log("error is free");
    const sidebar=document.getElementsByClassName('sidebar')[0];
    sidebar.style.display = 'block';
});


