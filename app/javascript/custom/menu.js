// Menu manipulation

// Add toggle listeners to listen for clicks.
// document.addEventListener("turbo:load", function() {
//     let account = document.querySelector("#account");
//     account.addEventListener("click", function(event) {
//         event.preventDefault();
//         let menu = document.querySelector("#dropdown-menu");
//         menu.classList.toggle("active");
//     });
// });

// // auto-dismiss messages with javascript

// document.addEventListener("turbo:load", () => {
//     setTimeout(() => {
//         document.querySelectorAll(".alert").forEach(alert => {
//             alert.style.transition = "opacity 0.5s";
//             alert.style.opacity = "0";
//             setTimeout(() => alert.remove(), 500);
//         });
//     }, 3000);
// });

// Account dropdown toggle
document.addEventListener("turbo:load", function() {
    const account = document.getElementById("account");
    
    // Only add listener if element exists
    if (account) {
        account.addEventListener("click", function(event) {
            event.preventDefault();
            const menu = document.getElementById("dropdown-menu");
            
            if (menu) {
                menu.classList.toggle("active");
                
                // Close menu when clicking outside
                document.addEventListener("click", closeMenu);
            }
        });
    }
});

// Auto-dismiss messages
document.addEventListener("turbo:load", () => {
    const alerts = document.querySelectorAll(".alert");
    
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = "opacity 0.5s";
            alert.style.opacity = "0";
            setTimeout(() => alert.remove(), 500);
        }, 3000);
    });
});

// Close menu when clicking outside
function closeMenu(event) {
    const account = document.getElementById("account");
    const menu = document.getElementById("dropdown-menu");
    
    if (menu && menu.classList.contains("active")) {
        // Check if click is outside menu and account button
        if (!menu.contains(event.target) && !account.contains(event.target)) {
            menu.classList.remove("active");
            document.removeEventListener("click", closeMenu);
        }
    }
}

// Optional: Close menu with Escape key
document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") {
        const menu = document.getElementById("dropdown-menu");
        if (menu && menu.classList.contains("active")) {
            menu.classList.remove("active");
            document.removeEventListener("click", closeMenu);
        }
    }
});