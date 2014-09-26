Polymer('tb-admin-users', {
  ready: function() { },
  searchTerm: '',
  selected: 0,
  results: [],
  results2: [],

  runSearch: _.debounce(function() {

    if (this.searchTerm !== "") {
      this.searchData = JSON.stringify({ q: this.searchTerm });
      this.$.xhrSearch.go();
    } else {
      if (this.selected) {
        console.log("putting into 1");
        this.results  = [];
      } else {
        console.log("putting into 2");
        this.results2 = [];
      }

      console.log("displaying " + ((this.selected) ? "1" : "2"));
      this.selected = this.selected ? 0 : 1;

      console.log(this.selected, this.results, this.results2);
    }
  }, 700),

  /**
   * Handle search response
   */
  searchResponse: function(evt) {
    try {
      var response = JSON.parse(evt.detail.response);

      if (this.selected) {
        console.log("putting into 1");
        this.results  = response.users;
      } else {
        console.log("putting into 2");
        this.results2 = response.users;
      }

      console.log("displaying " + ((this.selected) ? "1" : "2"));
      this.selected = this.selected ? 0 : 1;
      console.log(this.selected, this.results, this.results2);
    } catch (e) {
      console.log(e,evt);
    }
  },

  /**
   * Handle any ajax errors and display a flash with a (sometimes) useful error
   * message
   */
  ajaxError: function(evt) {
    try {
      var response = JSON.parse(evt.detail.xhr.response);
    } catch (e) {
      console.log(e,evt);
    }
  }
});
