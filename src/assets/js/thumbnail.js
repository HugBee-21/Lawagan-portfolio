document.addEventListener("DOMContentLoaded", function () {
  const mainImage = document.getElementById("mainImage");
  const thumbnails = document.querySelectorAll(".images__thumbnail img");

  if (
    thumbnails.length > 0 &&
    !document.querySelector(".images__thumbnail img.active")
  ) {
    thumbnails[0].classList.add("active");
    mainImage.src = thumbnails[0].getAttribute("data-src");
  }

  thumbnails.forEach((thumb) => {
    thumb.addEventListener("click", () => {
      mainImage.src = thumb.getAttribute("data-src");

      thumbnails.forEach((img) => img.classList.remove("active"));

      thumb.classList.add("active");
    });
  });
});
