import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slim"
export default class extends Controller {
  connect() {
    new SlimSelect({
      select: this.element,
      settings: {
        placeholderText: this.element.getAttribute('data-placeholder'),
      },
    })
  }
}
