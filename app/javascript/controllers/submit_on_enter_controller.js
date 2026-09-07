import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-on-enter"
// Enter submits the form; Shift+Enter inserts a newline.
export default class extends Controller {
  send(event) {
    if (event.key !== "Enter" || event.shiftKey || event.isComposing) return

    event.preventDefault()
    this.element.requestSubmit()
    event.target.value = ""
  }
}
