import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="reset-form"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }
  reset() {
    this.element.reset();
  }
}
