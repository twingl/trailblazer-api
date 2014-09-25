Polymer('tb-flash', {
  type: 'notice',
  visible: false,

  show: function(message) {
    this.message = message;
    this.visible = true;
  },

  dismiss: function() {
    this.message = '';
    this.visible = false;
  }
});
