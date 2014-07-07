Polymer('tb-new-classroom-form', {
  /**
   * Reset the form model and set csrf tokens ready to send requests
   * to the server
   */
  ready: function() {
    this.resetForm();
    this.csrfToken = document.querySelector('[name=csrf-token]').content
  },

  /**
   * Delegate the exposed toggle method to paper-dialog
   */
  toggle: function() {
    this.shadowRoot.querySelector('paper-dialog').toggle();
  },

  /**
   * Send the ajax request and reset the form
   */
  createClassroom: function(e) {
    this.shadowRoot.querySelector('core-ajax').go();
    this.resetForm();
  },

  /**
   * Clear the model through which form data is accessed
   */
  resetForm: function() {
    this.classroom = {
      name: "",
      description: ""
    };
  },

  /**
   * Notify the user that the classroom has been created
   */
  showToast: function() {
    this.shadowRoot.querySelector('paper-toast').show();
  }
});
