document.addEventListener("DOMContentLoaded", () => {
  const descriptionText = document.getElementById("description");
  const toggleButton = document.getElementById("toggleDescription");
  const maxHeight = 175;

  if (!descriptionText || !toggleButton) {
    return;
  }

  const isOverflown = descriptionText.scrollHeight > maxHeight;

  if (isOverflown) {
    descriptionText.classList.remove("expanded");
    toggleButton.style.display = "block";
    toggleButton.textContent = "Show More";

    descriptionText.style.maxHeight = `${maxHeight}px`;
  } else {
    descriptionText.style.maxHeight = "none";
    descriptionText.classList.add("expanded");
    toggleButton.style.display = "none";

    return;
  }

  toggleButton.addEventListener("click", () => {
    const isExpanded = descriptionText.classList.contains("expanded");

    if (isExpanded) {
      descriptionText.style.maxHeight = descriptionText.scrollHeight + "px";

      setTimeout(() => {
        descriptionText.classList.remove("expanded");
        descriptionText.style.maxHeight = "175px";
      }, 10);

      toggleButton.textContent = "Show More";
    } else {
      const fullHeight = descriptionText.scrollHeight;

      descriptionText.style.maxHeight = fullHeight + "px";

      descriptionText.classList.add("expanded");

      toggleButton.textContent = "Show Less";

      setTimeout(() => {
        if (descriptionText.classList.contains("expanded")) {
          descriptionText.style.maxHeight = "none";
        }
      }, 500);
    }
  });
});
