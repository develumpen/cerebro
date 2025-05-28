import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-photo"
// I probably don't need this controller, but I don't want to add inline JS.
export default class extends Controller {
  remove(event) {
    event.preventDefault()
    event.currentTarget.remove()
  }
}
