function toggleArticleForm() {
    var form = document.getElementById("articleForm");
    var overlay = document.getElementById("articleOverlay");
    form.style.display = form.style.display === "none" ? "block" : "none";
    overlay.style.display = overlay.style.display === "none" ? "block" : "none";
}

function toggleSectionForm() {
    var form = document.getElementById("sectionForm");
    var overlay = document.getElementById("sectionOverlay");
    form.style.display = form.style.display === "none" ? "block" : "none";
    overlay.style.display = overlay.style.display === "none" ? "block" : "none";
}

function showDescription(description) {
    alert(description);
}
document.addEventListener("DOMContentLoaded", function() {
    // Ensure the initial state is consistent
    var form1 = document.getElementById("articleForm");
    var overlay1 = document.getElementById("articleOverlay");
    form1.style.display = "none";
    overlay1.style.display = "none";


    var form2 = document.getElementById("sectionForm");
    var overlay2 = document.getElementById("sectionOverlay");
    form2.style.display = "none";
    overlay2.style.display = "none";


});
//eltunik a bejelentkezes felirat
setTimeout(() => {
    const urlWithoutParams = window.location.origin + window.location.pathname;
    history.replaceState({}, document.title, urlWithoutParams);
}, 500);