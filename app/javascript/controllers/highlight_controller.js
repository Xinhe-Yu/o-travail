import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="highlight"
export default class extends Controller {

  connect() {
    console.log(this.element);
    this.wrapPatterns();
  }


  wrapPatterns() {
    const pattern = /[L|R|D](\.\s)?\d{1,4}(-\d{1,3})*/g;

    const text = this.element.innerHTML;
    const modifiedText = text.replace(pattern, match => {
        return `<a href="/articles" class="fs-7 internal-link fw-bold">${match}</a>`;
      });
    this.element.innerHTML = modifiedText;
  }
}
