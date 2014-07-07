Polymer('tb-user-chip', {
  page: 0,
  ready: function() {},

  expand: function(e) {
    console.log('e', e);
    this.page = 1;
  },

  contract: function(e) {
    console.log('c', e);
    this.page = 0;
  },
});
