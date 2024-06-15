const reviewMarkSelect = document.querySelector("#review_mark_text");
const reviewMarkNum = document.querySelector("#review_mark_num");

const convertMarks = {
  Отлично: 5,
  Хорошо: 4,
  Удовлетворительно: 3,
  Неудовлетворительно: 2,
  Плохо: 1,
  Ужасно: 0,
};

if (reviewMarkSelect) {
  reviewMarkSelect.addEventListener("change", ({ target }) => {
    reviewMarkNum.value = convertMarks[target.value];
  });
}
