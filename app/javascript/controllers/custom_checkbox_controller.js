import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "button", "switch", "off", "on"]

  connect() {
    this.updateSwitchVisualForCheckbox();
  }

  toggleCheckbox() {
    this.checkboxTarget.checked = !this.checkboxTarget.checked;
    this.updateSwitchVisualForCheckbox();
    const event = new Event('change', {
      bubbles: true,
      cancelable: true,
    });

    this.checkboxTarget.dispatchEvent(event);
  }

  updateSwitchVisualForCheckbox() {
    const isChecked = this.checkboxTarget.checked;

    if (isChecked) {
      this.buttonTarget.classList.replace("bg-gray-200", "bg-indigo-600");
      this.switchTarget.classList.replace("translate-x-0", "translate-x-full");
      this.offTarget.classList.add("opacity-0");
      this.onTarget.classList.remove("opacity-0");
    } else {
      this.buttonTarget.classList.replace("bg-indigo-600", "bg-gray-200");
      this.switchTarget.classList.replace("translate-x-full", "translate-x-0");
      this.offTarget.classList.remove("opacity-0");
      this.onTarget.classList.add("opacity-0");
    }

    this.buttonTarget.setAttribute("aria-checked", isChecked.toString());
  }
}

