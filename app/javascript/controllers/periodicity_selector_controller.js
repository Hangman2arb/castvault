import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="periodicity-selector"
export default class extends Controller {
  static targets = ["label", "monthlyPrices", "annuallyPrices"];

  toggleClass() {
    this.labelTargets.forEach((label) => {
      const input = label.querySelector("input");
      const isChecked = input.checked;
      const isForManager = label.dataset.type === 'for_manager';

      label.classList.toggle("bg-primary", isChecked && isForManager);
      label.classList.toggle("bg-transparent", !isChecked);

      if (isForManager) {
        label.classList.toggle("text-white", isChecked);
        label.classList.toggle("text-shadowy-200", !isChecked);
      }

      if (input.value === "monthly") {
        this.toggleVisibility(isChecked, this.monthlyPricesTarget, this.annuallyPricesTarget);
      } else if (input.value === "annually") {
        this.toggleVisibility(isChecked, this.annuallyPricesTarget, this.monthlyPricesTarget);
      }
    });
  }

  toggleVisibility(isChecked, toShow, toHide) {
    if (isChecked) {
      toShow.classList.remove("hidden");
      toHide.classList.add("hidden");
    }
  }
}
