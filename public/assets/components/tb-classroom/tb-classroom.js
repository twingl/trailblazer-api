Polymer('tb-classroom', {

  ready: function() {
    this.csrfToken = document.querySelector('[name=csrf-token]').content
  },

  classroom: {
    name: "",
    description: ""
  },

  deleteClassroom: function(e) {
    this.shadowRoot.querySelector('core-ajax').go();
    this.remove();
  }
});

