
Polymer('tb-project', {
  ready: function() {},

  deleteProject: function(e) {
    console.log(e, this.project)
    id = this.project.id;
    this.shadowRoot.querySelector('core-ajax#delete-project').go();

  }
});
