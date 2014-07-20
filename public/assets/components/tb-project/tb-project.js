
Polymer('tb-project', {
  ready: function() {
    this.csrfToken = document.querySelector('[name=csrf-token]').content;
  },

  deleteProject: function(e) {
    console.log(e, this.project)
    id = this.project.id;
    this.shadowRoot.querySelector('core-ajax#delete-project').go();
    this.fire('tb-project-deleted', e);
    this.remove();
  }
});
