Polymer('tb-classroom-detail', {
  members: [],
  results: [],
  stagedUsers: [],
  stagedUserIds: [],
  addPanelVisible: false,

  ready: function() {
    this.csrfToken = document.querySelector('[name=csrf-token]').content
  },

  membersLoaded: function(e) {
    this.members = e.detail.response.users;
  },
  dismiss: function(e) {
    this.fire('tb-dismiss', e);
    this.members = [];
  },
  toggleAddPanel: function() {
    this.addPanelVisible = !this.addPanelVisible;
  },
  handleSearchResult: function(e) {
    this.results = e.detail.response.users;
  },
  queueSearch: function(e) {
    this.runSearch();
  },
  runSearch: _.debounce(function(e) {
    this.shadowRoot.querySelector('core-ajax#search').go();
  }, 750),

  stageUser: function(e) {
    var model = e.target.templateInstance.model.user;
    if (this.stagedUsers.indexOf(model) === -1) {
      this.stagedUsers.push(e.target.templateInstance.model.user);
      this.stagedUserIds = _.map(this.stagedUsers, function(u) { return u.id });
    }
  },

  unstageUser: function(e) {
    var index = this.stagedUsers.indexOf(e.target.templateInstance.model.user);
    this.stagedUsers.splice(index, 1);
    this.stagedUserIds = _.map(this.stagedUsers, function(u) { return u.id });
  },

  commitUsers: function(e) {
    this.shadowRoot.querySelector('core-ajax#enroll-members').go();
  },

  onCommitted: function(e) {
    this.results = [];
    this.stagedUsers = [];
    this.stagedUserIds = [];

    this.addPanelVisible = false;
    this.members = e.detail.response.users;

    console.log(e);

    this.shadowRoot.querySelector('paper-toast.enrolled').show();
  },

  onWithdrawn: function(e) {
    this.members = e.detail.response.users;

    this.shadowRoot.querySelector('paper-toast.withdrawn').show();
  },

  withdrawMember: function(e) {
    this.withdrawnUserIds = [ e.target.templateInstance.model.member.id ];
    this.shadowRoot.querySelector('core-ajax#withdraw-members').go();
  }

});
