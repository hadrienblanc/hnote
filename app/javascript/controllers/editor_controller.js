import { Controller } from "@hotwired/stimulus"
import { marked } from "marked"

export default class extends Controller {
  static targets = [
    "editor", "preview", "split",
    "btnEditor", "btnSplit", "btnPreview",
    "statChars", "statWords", "statLines"
  ]

  connect() {
    marked.setOptions({ gfm: true, breaks: true })
    this.render()
    this._keydown = this._handleKeydown.bind(this)
    document.addEventListener("keydown", this._keydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this._keydown)
  }

  render() {
    this.previewTarget.innerHTML = marked.parse(this.editorTarget.value)
    const v = this.editorTarget.value
    this.statCharsTarget.textContent = v.length.toLocaleString()
    this.statWordsTarget.textContent = (v.match(/\S+/g) || []).length.toLocaleString()
    this.statLinesTarget.textContent = v.split("\n").length.toLocaleString()
  }

  tab(e) {
    if (e.key !== "Tab") return
    e.preventDefault()
    const s = this.editorTarget.selectionStart
    const end = this.editorTarget.selectionEnd
    this.editorTarget.value = this.editorTarget.value.substring(0, s) + "  " + this.editorTarget.value.substring(end)
    this.editorTarget.selectionStart = this.editorTarget.selectionEnd = s + 2
    this.render()
  }

  setEditor()  { this._setMode("editor") }
  setSplit()   { this._setMode("split") }
  setPreview() { this._setMode("preview") }

  _setMode(mode) {
    this.splitTarget.classList.remove("mode-editor", "mode-preview")
    if (mode !== "split") this.splitTarget.classList.add("mode-" + mode)
    this.btnEditorTarget.classList.toggle("active", mode === "editor")
    this.btnSplitTarget.classList.toggle("active",  mode === "split")
    this.btnPreviewTarget.classList.toggle("active", mode === "preview")
  }

  _handleKeydown(e) {
    const mod = navigator.platform.toUpperCase().includes("MAC") ? e.metaKey : e.ctrlKey
    if (!mod) return
    if (e.key === "1") { e.preventDefault(); this._setMode("editor") }
    if (e.key === "2") { e.preventDefault(); this._setMode("split") }
    if (e.key === "3") { e.preventDefault(); this._setMode("preview") }
  }
}
