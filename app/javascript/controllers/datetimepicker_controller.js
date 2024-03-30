import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    console.log('sae')
    flatpickr(this.element, {
      enableTime: false,
      dateFormat: "Y-m-d",
      minDate: "today",
      defaultDate: this.element.value || new Date()
    });
  }
}

