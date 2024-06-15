const visiblePasswordButton = document.querySelector("#visiblePassword");

if (visiblePasswordButton) {
  visiblePasswordButton.addEventListener("click", () => {
    const passwordInput = visiblePasswordButton.previousElementSibling;

    if (passwordInput.type === "password") {
      passwordInput.type = "text";
    } else {
      passwordInput.type = "password";
    }
  });
}
