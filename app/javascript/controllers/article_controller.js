import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="article"
export default class extends Controller {
  static targets = ['button', 'text']

  modalTarget = document.getElementById("staticBackdrop");

  connect() {
    this.initLinkstyle()
  }

  initLinkstyle() {
    const links = this.element.querySelectorAll("a");
    const rp = /^([L|l]?'?articles?\W)?[L|D|R]\.\W\d{1,4}(-\d{1,3})*(\W?.{0,2}\W?)?([L|D|R]\.\W\d{1,4}(-\d{1,3})*)?$/;

    links.forEach(link => {
      if (rp.test(link.textContent.trim())) {
        link.setAttribute('data-bs-toggle', 'modal');
        link.setAttribute('type', 'button');
        link.setAttribute('data-bs-target', '#staticBackdrop');
        link.classList.add('internal-link');
      }
    })
  }

  toggleButton() {
    console.log("clicked")
    this.element.classList.toggle('expanded');
    this.element.classList.toggle('collapsed');
  }
}
