import { Controller } from "@hotwired/stimulus"
import debounce from "debounce";

export default class extends Controller {
  static targets = ["start", "end", "startValue", "endValue", "startThumb", "endThumb", "progress"]
  static values = {
    minVal: Number,
    maxVal: Number,
    selectedMinVal: Number,
    selectedMaxVal: Number
  }




  updateStartValue(event) {
    let startValue = parseInt(this.startTarget.value, 10);
    let endValue = parseInt(this.endTarget.value, 10);

    if (startValue > endValue - this.stepValue()) {
      startValue = endValue - this.stepValue();
      this.startTarget.value = startValue;
    }

    this.startValueTarget.value = startValue;
    this.updateSlider();
  }

  updateEndValue(event) {
    let endValue = parseInt(this.endTarget.value, 10);
    let startValue = parseInt(this.startTarget.value, 10);

    if (endValue < startValue + this.stepValue()) {
      endValue = startValue + this.stepValue();
      this.endTarget.value = endValue;
    }

    this.endValueTarget.value = endValue;
    this.updateSlider();
  }

  stepValue() {
    return 1;
  }

  updateSlider() {
    const min = this.minValValue;
    const max = this.maxValValue;
    const startValue = parseInt(this.startTarget.value, 10);
    const endValue = parseInt(this.endTarget.value, 10);
    const startPercent = ((startValue - min) / (max - min)) * 100;
    const endPercent = ((max - endValue) / (max - min)) * 100;

    this.startThumbTarget.style.left = `${startPercent}%`;
    this.endThumbTarget.style.right = `${endPercent}%`;
    this.progressTarget.style.left = `${startPercent}%`;
    this.progressTarget.style.right = `${endPercent}%`;
  }

  handleStartValueInput(event) {
    const value = parseInt(event.target.value, 10);
    if (!isNaN(value) && value >= this.minValValue && value <= this.selectedMaxValValue) {
      this.startTarget.value = value;
      this.updateStartValue();
    }
  }

  handleEndValueInput(event) {
    const value = parseInt(event.target.value, 10);
    if (!isNaN(value) && value <= this.maxValValue && value >= this.selectedMinValValue) {
      this.endTarget.value = value;
      this.updateEndValue();
    }
  }
}
