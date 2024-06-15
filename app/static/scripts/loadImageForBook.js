const imageUploadInput = document.querySelector("#imageUpload");
const loadImageForBookBlock = document.querySelector("#loadImageForBook");

if (loadImageForBookBlock) {
  loadImageForBookBlock.addEventListener("click", function () {
    imageUploadInput.click();
  });

  imageUploadInput.addEventListener("change", ({ target }) => {
    const file = target.files[0];
    const reader = new FileReader();
    reader.onload = () => {
      const img = document.querySelector(".border img");
      img.src = reader.result;
    };

    imageUploadInput.files = target.files;

    reader.readAsDataURL(file);
  });
}
