
/* =====================================
   GET HTML ELEMENTS
   ===================================== */

// Get the ticket popup
const ticketPopup = document.getElementById("ticketPopup");

// Get the Create Ticket button
const openTicket = document.getElementById("openTicket");

// Get the close button
const closeButton = document.querySelector(".close");

// Get the ticket form
const ticketForm = document.getElementById("ticketForm");


/* =====================================
   OPEN TICKET POPUP
   ===================================== */

openTicket.addEventListener("click", function()
{
    const firstName = document.getElementById("firstName").value;
    const lastName = document.getElementById("lastName").value;
    const department = document.getElementById("department").value;
    const email = document.getElementById("userEmail").value;

    if (!firstName || !lastName || !department || !email)
    {
        alert("Please complete your employee information in Preferences first.");
        return;
    }

    ticketPopup.style.display = "block";
});

/* =====================================
   SAVE PREFERENCES
   ===================================== */

const savePreferences = document.getElementById("savePreferences");

savePreferences.addEventListener("click", function()
{
    const firstName = document.getElementById("firstName").value;
    const lastName = document.getElementById("lastName").value;
    const department = document.getElementById("department").value;
    const email = document.getElementById("userEmail").value;

    if (!firstName || !lastName || !department || !email)
    {
        alert("Please complete all required fields.");
        return;
    }

    alert("Your preferences have been saved successfully!");
});

/* =====================================
   CLOSE TICKET POPUP
   ===================================== */

// Close popup when X is clicked
closeButton.addEventListener("click", function()
{
    ticketPopup.style.display = "none";
});

// Close popup when clicking outside the form
window.addEventListener("click", function(event)
{
    if (event.target === ticketPopup) {
        ticketPopup.style.display = "none";
    }
});



/* =====================================
   SUBMIT SUPPORT TICKET
   ===================================== */

ticketForm.addEventListener("submit", function(event)
{
    // Prevent page from refreshing
    event.preventDefault();

    // Get employee information from Preferences
    const firstName = document.getElementById("firstName").value;
    const lastName = document.getElementById("lastName").value;
    const department = document.getElementById("department").value;
    const email = document.getElementById("userEmail").value;

    // Get issue information from the ticket popup
    const issue = document.getElementById("issue").value;
    const priority = document.getElementById("priority").value;
    const subject = document.getElementById("subject").value;
    const description = document.getElementById("description").value;

    // Check that employee information has been entered
    if (!firstName || !lastName || !department || !email)
    {
        alert("Please complete your employee information in Preferences first.");
        return;
    }

    // Display successful submission message
    alert(
        "Ticket Submitted Successfully!\n\n" +
        "First Name: " + firstName + "\n" +
        "Last Name: " + lastName + "\n" +
        "Department: " + department + "\n" +
        "Email: " + email + "\n" +
        "Category: " + issue + "\n" +
        "Priority: " + priority + "\n" +
        "Subject: " + subject + "\n" +
        "Description: " + description
    );

    // Clear the ticket form
    ticketForm.reset();

    // Close the popup
    ticketPopup.style.display = "none";
});
