

const openTicket = document.getElementById("openTicket");
const ticketPopup = document.getElementById("ticketPopup");
const closeButton = document.querySelector(".close");
const ticketForm = document.getElementById("ticketForm");

openTicket.addEventListener("click", function() 
{
    ticketPopup.style.display = "block";
});

closeButton.addEventListener("click", function() 
{
    ticketPopup.style.display = "none";
});

window.addEventListener("click", function(event)
{
    if (event.target === ticketPopup) 
    {
        ticketPopup.style.display = "none";
    }
});


ticketForm.addEventListener("submit", function(event) 
{

   
    event.preventDefault();

    
    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const issue = document.getElementById("issue").value;
    const priority = document.getElementById("priority").value;
    const subject = document.getElementById("subject").value;
    const description = document.getElementById("description").value;

    alert(
        "Ticket Submitted Successfully!\n\n" +
        "Name: " + name + "\n" +
        "Email: " + email + "\n" +
        "Category: " + issue + "\n" +
        "Priority: " + priority + "\n" +
        "Subject: " + subject + "\n" +
        "Description: " + description
    );

    ticketForm.reset();

    ticketPopup.style.display = "none";
});
