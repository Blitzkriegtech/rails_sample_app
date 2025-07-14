// Menu manipulation

// Add toggle listeners to listen for clicks.
document.addEventListener("turbo:load", function() {
    let account = document.querySelector("#account");
    account.addEventListener("click", function(event) {
        event.preventDefault();
        let menu = document.querySelector("#dropdown-menu");
        menu.classList.toggle("active");
    });
});

// auto-dismiss messages with javascript

document.addEventListener("turbo:load", () => {
    setTimeout(() => {
        document.querySelectorAll(".alert").forEach(alert => {
            alert.style.transition = "opacity 0.5s";
            alert.style.opacity = "0";
            setTimeout(() => alert.remove(), 500);
        });
    }, 3000);
});