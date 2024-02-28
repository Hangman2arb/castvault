import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [ "actions"];

  connect() {
    // Add a click event to the document
    document.addEventListener("click", this.documentClickHandler.bind(this));
  }

  disconnect() {
    // Remove document click event when controller disconnects
    document.removeEventListener("click", this.documentClickHandler.bind(this));
  }

  toggleDropdown() {
    this.actionsTarget.classList.toggle("hidden");
  }

  documentClickHandler(event) {
    // Check if the click happened outside of the actions button component
    if (!this.element.contains(event.target)) {
      this.hideDropdown();
    }
  }

  hideDropdown() {
    this.actionsTarget.classList.add("hidden");
  }

}
