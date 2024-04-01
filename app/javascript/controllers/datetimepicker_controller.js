import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      enableTime: false,
      dateFormat: 'd / m / Y',
      minDate: "today",
      defaultDate: this.element.value || new Date()
    });
  }
}

