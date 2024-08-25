import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-history"
export default class extends Controller {
  static targets = ['input', 'history']

  history = JSON.parse(localStorage.getItem('searchHistory')) || [];
  $historyContainer = $('#search-history-container');
  liClass = 'list-group-item list-group-item-action ps-6 py-2'

  initHistoryContainer() {
    this.$historyContainer.empty();
    this.history.forEach(item => {
      this.$historyContainer.append(`<a href="/articles?key_word=${item}" class="no-a-style"><li class="${this.liClass}">${item}</li></a>`);
    });
    this.loadHistory();
  }


  connect() {
    $(function () {
      console.log("Hey JQuery")
    })
  }

  registerHistory(event) {
    // use it in the future...
    // event.preventDefault();
    const currentValue = this.inputTarget.value;
    if (currentValue && !this.history.includes(currentValue)) {
      this.history.push(currentValue);
      localStorage.setItem("searchHistory", JSON.stringify(this.history));
    }
  }

  clearHistory() {
    localStorage.removeItem("searchHistory")
  }

  filterHistory() {
    console.log("filter")
    const query = this.inputTarget.value.toLowerCase();
    const history = JSON.parse(localStorage.getItem("searchHistory")) || [];

    const filteredHistory = history
      .filter(item => item.toLowerCase().includes(query))
      .slice(0, 5);

    this.updateHistoryUI(filteredHistory);
  }

  updateHistoryUI(filteredHistory) {
    const $historyContainer = $(this.historyTarget);

    $historyContainer.empty();

    filteredHistory.forEach(item => {
      $historyContainer.append(`<a href="/articles?key_word=${item}" class="no-a-style"><li class="${this.liClass}">${item}</li></a>`);
    });

    $historyContainer.toggle(filteredHistory.length > 0);
  }


  loadHistory() {
    this.updateHistoryUI(this.history.slice(0, 4)); // Optionally show top 5 on load
  }
}
