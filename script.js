
// Get HTML elements
const openTicket = document.getElementById("openTicket");
const ticketPopup = document.getElementById("ticketPopup");
const closeButton = document.querySelector(".close");
const ticketForm = document.getElementById("ticketForm");

// Open the ticket popup
openTicket.addEventListener("click", function() {
    ticketPopup.style.display = "block";
});

// Close the ticket popup
closeButton.addEventListener("click", function() {
    ticketPopup.style.display = "none";
});

// Close popup when clicking outside the form
window.addEventListener("click", function(event) {
    if (event.target === ticketPopup) {
        ticketPopup.style.display = "none";
    }
});

// Handle ticket submission
ticketForm.addEventListener("submit", function(event) {

    // Prevent page from refreshing
    event.preventDefault();

    // Get information from the form
    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const issue = document.getElementById("issue").value;
    const priority = document.getElementById("priority").value;
    const subject = document.getElementById("subject").value;
    const description = document.getElementById("description").value;

    // Display confirmation message
    alert(
        "Ticket Submitted Successfully!\n\n" +
        "Name: " + name + "\n" +
        "Email: " + email + "\n" +
        "Category: " + issue + "\n" +
        "Priority: " + priority + "\n" +
        "Subject: " + subject + "\n" +
        "Description: " + description
    );

    // Clear the form
    ticketForm.reset();

    // Close the popup
    ticketPopup.style.display = "none";
});
