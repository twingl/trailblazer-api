Polymer('tb-classroom-detail', {
  searchInput: "",
  members: [],
  projects: [],
  project: {
    name: "",
    description: ""
  },
  projectPayload: "",
  results: [],
  stagedUsers: [],
  stagedUserIds: [],
  createProjectVisible: false,
  addMembersVisible: false,

  ready: function() {
    this.csrfToken = document.querySelector('[name=csrf-token]').content
  },

  membersLoaded: function(e) {
    this.members = e.detail.response.users;
  },

  projectsLoaded: function(e) {
    this.projects = e.detail.response.projects
  },

  dismiss: function(e) {
    this.searchInput = '';
    this.results = [];
    this.members = [];
    this.stagedUsers = [];
    this.stagedUserIds = [];
    this.addMembersVisible = false;
    this.createProjectVisible = false;
    this.fire('tb-dismiss', e);
  },

  confirmDeletion: function(e) {
    this.shadowRoot.querySelector('#really-delete').toggle();
  },

  deleteClassroom: function(e) {
    this.shadowRoot.querySelector('core-ajax#delete-classroom').go();
    var deletedClassroom = this.classroom;
    this.fire('tb-delete-classroom', deletedClassroom);
    this.dismiss(e);
  },

  toggleCreateProject: function() {
    this.createProjectVisible = !this.createProjectVisible;
  },

  createProject: function(e) {
    this.projectPayload = JSON.stringify(this.project);
    this.shadowRoot.querySelector('core-ajax#create-project').go();
  },

  onProjectCommitted: function(e) {
    this.project = {
      name: "",
      description: ""
    };
    this.projectPayload = "";
    this.stagedUsers = [];
    this.stagedUserIds = [];

    this.createProjectVisible = false;
    this.projects.push(e.detail.response);

    this.shadowRoot.querySelector('paper-toast.project-created').show();
  },

  toggleAddMembers: function() {
    this.addMembersVisible = !this.addMembersVisible;
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

  onUsersCommitted: function(e) {
    this.results = [];
    this.stagedUsers = [];
    this.stagedUserIds = [];

    this.addMembersVisible = false;
    this.members = e.detail.response.users;

    this.shadowRoot.querySelector('paper-toast.enrolled').show();
  },

  onMembersWithdrawn: function(e) {
    this.members = e.detail.response.users;

    this.shadowRoot.querySelector('paper-toast.withdrawn').show();
  },

  withdrawMember: function(e) {
    this.withdrawnUserIds = [ e.target.templateInstance.model.member.id ];
    this.shadowRoot.querySelector('core-ajax#withdraw-members').go();
  }

});
