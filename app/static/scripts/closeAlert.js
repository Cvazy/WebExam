function closeAlert(button) {
  const currentBlock = button.closest(".alert");

  currentBlock.classList.add("!hidden");
}
