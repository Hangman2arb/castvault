import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "button", "span1", "span2", "span3",
    "checkboxSelectAll", "buttonSelectAll", "span1SelectAll",
    "span2SelectAll", "span3SelectAll", "container"];

  connect() {
    this.checkboxTargets.forEach((checkbox, index) => {
      this.updateSwitchVisual(checkbox, this.getRelatedElements(index));
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
    this.updateSwitchVisual(checkbox, this.getRelatedElements(checkboxIndex));

    if (!checkbox.checked && this.checkboxSelectAllTarget.checked) {
      this.checkboxSelectAllTarget.checked = false;
      this.updateSwitchVisualForSelectAllCheckbox();
    }
  }

  selectAllToggle() {
    const isChecked = !this.checkboxSelectAllTarget.checked;
    this.checkboxSelectAllTarget.checked = isChecked;
    this.checkboxTargets.forEach((checkbox, index) => {
      checkbox.checked = isChecked;
      this.updateSwitchVisual(checkbox, this.getRelatedElements(index));
    });
    this.updateSwitchVisualForSelectAllCheckbox();
  }

  updateSwitchVisual(checkbox, {button, span1, span2, span3, container}) {
    const isChecked = checkbox.checked;

    button.classList.replace(isChecked ? "bg-gray-200" : "bg-indigo-600", isChecked ? "bg-indigo-600" : "bg-gray-200");
    span1.classList.replace(isChecked ? "translate-x-0" : "translate-x-5", isChecked ? "translate-x-5" : "translate-x-0");
    this.toggleOpacity(span2, span3);
    container.classList.toggle("ring-1", isChecked);
    container.classList.toggle("ring-primary", isChecked);

    button.setAttribute("aria-checked", isChecked.toString());
  }

  updateSwitchVisualForSelectAllCheckbox() {
    const { button, span1, span2, span3, container } = this.getSelectAllElements();
    this.updateSwitchVisual(this.checkboxSelectAllTarget, {button, span1, span2, span3, container});
  }

  getRelatedElements(index) {
    return {
      button: this.buttonTargets[index],
      span1: this.span1Targets[index],
      span2: this.span2Targets[index],
      span3: this.span3Targets[index],
      container: this.containerTargets[index]
    };
  }

  getSelectAllElements() {
    return {
      button: this.buttonSelectAllTarget,
      span1: this.span1SelectAllTarget,
      span2: this.span2SelectAllTarget,
      span3: this.span3SelectAllTarget,
      container: this.containerTargets.find(container => container.getAttribute("data-select-all-target"))
    };
  }

  toggleOpacity(spanToShow, spanToHide) {
    spanToShow.classList.replace("opacity-0", "opacity-100");
    spanToHide.classList.replace("opacity-100", "opacity-0");
  }
}
