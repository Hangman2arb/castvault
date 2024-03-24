import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="loader"
export default class extends Controller {
  connect() {
    this.element.addEventListener('click', () => {
      this.showLoader();
    });
  }

  showLoader() {
    const loader = document.getElementById('loader-overlay');
    if (loader) {
      loader.classList.remove('hidden');
    }
  }

  hideLoader() {
    const loader = document.getElementById('loader-overlay');
    if (loader) {
      loader.classList.add('hidden');
    }
  }
}
