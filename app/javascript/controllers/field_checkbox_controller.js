import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "button", "span1", "span2", "span3",
                    "checkboxSelectAll", "buttonSelectAll", "span1SelectAll",
                    "span2SelectAll", "span3SelectAll", "container"];

  connect() {
    this.checkboxTargets.forEach((checkbox, index) => {
      this.updateSwitchVisualForCheckbox(checkbox, index);
    });
  }

  toggleCheckbox(event) {
    if (event.target.tagName === 'INPUT') {
      return;
    }

    const checkboxIndex = this.checkboxTargets.indexOf(event.currentTarget.querySelector('[data-field-checkbox-target="checkbox"]'));

    if (checkboxIndex === -1) return;

    const checkbox = this.checkboxTargets[checkboxIndex];
    checkbox.checked = !checkbox.checked;

    this.updateSwitchVisualForCheckbox(checkbox, checkboxIndex);
  }

  updateSwitchVisualForCheckbox(checkbox, index) {
    const isChecked = checkbox.checked;
    const button = this.buttonTargets[index];
    const span1 = this.span1Targets[index];
    const span2 = this.span2Targets[index];
    const span3 = this.span3Targets[index];
    const container = this.containerTargets[index];

    if (isChecked) {
      button.classList.replace("bg-gray-200", "bg-primary");
      span1.classList.replace("translate-x-0", "translate-x-5");
      span2.classList.add("opacity-0");
      span2.classList.remove("opacity-100");
      span3.classList.add("opacity-100");
      span3.classList.remove("opacity-0");
      container.classList.add("ring-1");
      container.classList.add("ring-primary");
    } else {
      if(this.checkboxSelectAllTarget.checked){
        this.checkboxSelectAllTarget.checked = !this.checkboxSelectAllTarget.checked;
        this.updateSwitchVisualForSelectAllCheckbox();
      }
      button.classList.replace("bg-primary", "bg-gray-200");
      span1.classList.replace("translate-x-5", "translate-x-0");
      span2.classList.add("opacity-100");
      span2.classList.remove("opacity-0");
      span3.classList.add("opacity-0");
      span3.classList.remove("opacity-100");
      container.classList.remove("ring-1");
      container.classList.remove("ring-primary");
    }

    button.setAttribute("aria-checked", isChecked.toString());
  }

  selectAllToggle(event) {
    this.checkboxSelectAllTarget.checked = !this.checkboxSelectAllTarget.checked;
    const isChecked = this.checkboxSelectAllTarget.checked ;
    this.checkboxTargets.forEach((checkbox, index) => {
      checkbox.checked = isChecked;
      this.updateSwitchVisualForCheckbox(checkbox, index);
    });
    this.updateSwitchVisualForSelectAllCheckbox();
  }

  updateSwitchVisualForSelectAllCheckbox() {
    const isChecked = this.checkboxSelectAllTarget.checked;
    const button = this.buttonSelectAllTarget;
    const span1 = this.span1SelectAllTarget;
    const span2 = this.span2SelectAllTarget;
    const span3 = this.span3SelectAllTarget;
    const container = this.containerTarget;

    if (isChecked) {
      button.classList.replace("bg-gray-200", "bg-primary");
      span1.classList.replace("translate-x-0", "translate-x-5");
      span2.classList.add("opacity-0");
      span2.classList.remove("opacity-100");
      span3.classList.add("opacity-100");
      span3.classList.remove("opacity-0");
      container.classList.add("ring-1");
      container.classList.add("ring-primary");
    } else {
      button.classList.replace("bg-primary", "bg-gray-200");
      span1.classList.replace("translate-x-5", "translate-x-0");
      span2.classList.add("opacity-100");
      span2.classList.remove("opacity-0");
      span3.classList.add("opacity-0");
      span3.classList.remove("opacity-100");
      container.classList.remove("ring-1");
      container.classList.remove("ring-primary");
    }

    button.setAttribute("aria-checked", isChecked.toString());
  }
}
