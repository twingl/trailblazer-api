Polymer('tb-app', {
  pages: {
    home: {
      page: 0,
      title: "Trailblazer"
    },
    classrooms: {
      page: 1,
      title: "Classes"
    },
    domain: {
      page: 2,
      title: "Configure Domain"
    },
    signout: {
      page: 3,
      title: ""
    }
  },
  ready: function() { },
  toggleDrawer: function() {
    this.$.drawerPanel.togglePanel();
  },
  userProfileLoaded: function(e) {
    this.userProfile = e.detail.response;
  },
  menuSelected: function(e) {
    this.mainPanel = this.pages[e.detail.item.id].page;
    this.title = this.pages[e.detail.item.id].title;
  }
});
