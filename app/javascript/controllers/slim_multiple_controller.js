import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slim-multiple"
export default class extends Controller {
  connect() {
    new SlimSelect({
      select: this.element,
      settings: {
        closeOnSelect: false,
        placeholderText: this.element.getAttribute('data-placeholder'),
      },
    })
  }
}
