import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["labelMonthly", "labelYearly", "monthlyPrices", "annuallyPrices"];

  priceMonthly() {
    this.labelMonthlyTarget.classList.add("bg-primary");
    this.labelMonthlyTarget.classList.remove("bg-transparent");
    this.labelMonthlyTarget.classList.add("text-dark");
    this.labelMonthlyTarget.classList.remove("text-shadowy-200");

    this.labelYearlyTarget.classList.remove("bg-primary");
    this.labelYearlyTarget.classList.add("bg-transparent");
    this.labelYearlyTarget.classList.remove("text-dark");
    this.labelYearlyTarget.classList.add("text-shadowy-200");

    this.monthlyPricesTarget.classList.remove("hidden");
    this.annuallyPricesTarget.classList.add("hidden");
  }

  priceYearly() {
    this.labelMonthlyTarget.classList.remove("bg-primary");
    this.labelMonthlyTarget.classList.add("bg-transparent");
    this.labelMonthlyTarget.classList.remove("text-dark");
    this.labelMonthlyTarget.classList.add("text-shadowy-200");

    this.labelYearlyTarget.classList.add("bg-primary");
    this.labelYearlyTarget.classList.remove("bg-transparent");
    this.labelYearlyTarget.classList.add("text-dark");
    this.labelYearlyTarget.classList.remove("text-shadowy-200");

    this.monthlyPricesTarget.classList.add("hidden");
    this.annuallyPricesTarget.classList.remove("hidden");
  }
}
