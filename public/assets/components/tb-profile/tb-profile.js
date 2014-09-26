Polymer('tb-profile', {
  email: "",
  currentPassword: "",
  newPassword: "",

  /**
   * Obtain the CSRF token from the rendered view so we can make non-GET
   * requests to the server
   */
  ready: function() {
    this.csrfToken = document.querySelector('[name=csrf-token').content;
  },

  /**
   * Fired when the user profile is read from the server
   */
  profileLoaded: function(evt) {
    try {
      this.profile = JSON.parse(evt.detail.response);
      this.email = this.profile.email;
    } catch (e) { console.log(e, evt); }
  },

  /**
   * Fired when the user's email is updated
   */
  emailUpdated: function(evt) {
    this.$.flsActionSuccess.show("Email address updated! Check your inbox to confirm the change.");
    try {
      this.profile = JSON.parse(evt.detail.response).user;
      this.email = this.profile.email;
    } catch (e) { console.log(e, evt); }
  },

  /**
   * Fired when the user's password is updated
   */
  passwordUpdated: function(evt) {
    this.$.flsActionSuccess.show("Password updated!");
    try {
      this.newPassword = '';
      //this.currentPassword = '';
    } catch (e) { console.log(e, evt); }
  },

  /**
   * Executes the POST to resend the confirmation email
   */
  resendConfirmation: function() {
    this.dismissFlash();
    this.$.xhrResendConfirmation.go();
  },

  confirmationResent: function() {
    this.dismissFlash();
    this.$.flsActionSuccess.show("Sent! Check your inbox for the confirmation email.");
  },

  /**
   * Executes the POST to update the user's email address
   */
  updateEmail: function() {
    this.dismissFlash();
    if (this.validateEmail()) this.$.xhrUpdateEmail.go();
  },

  /** Updates the data to send when updating the email address */
  updateEmailData: function() {
    this.emailData = JSON.stringify({
      user: {
        email: this.email
      }
    });
  },

  /**
   * Executes the POST to update the user's password
   */
  updatePassword: function() {
    this.dismissFlash();
    if (this.validatePasswords()) this.$.xhrUpdatePassword.go();
  },

  /** Updates the data to send when updating the email address */
  updatePasswordData: function() {
    this.passwordData = JSON.stringify({
      user: {
        //current_password: this.currentPassword,
        password:     this.newPassword
      }
    });
  },

  /**
   * Handle any ajax errors and display a flash with a (sometimes) useful error
   * message
   */
  ajaxError: function(evt) {
    this.dismissFlash();

    try {
      var response = JSON.parse(evt.detail.xhr.response);

      if (response.messages) {
        this.$.flsActionError.show(response.messages[0]);
      } else {
        this.$.flsActionError.show("An error occurred");
      };
    } catch (e) {
      this.$.flsActionError.show("An error occurred");
    }
  },

  /**
   * Validates email input
   * @returns boolean True if the input is valid, false otherwise.
   */
  validateEmail: function() {
    return this.$.txtEmail.checkValidity();
  },

  /**
   * Validates password input
   * @returns boolean True if the input is valid, false otherwise.
   */
  validatePasswords: function() {
    return this.validateNewPassword(); //this.validateCurrentPassword() && this.validateNewPassword();
  },
  validateNewPassword: function() {
    return this.$.txtNewPassword.checkValidity();
  },
  //validateCurrentPassword: function() {
  //  return this.$.txtCurrentPassword.checkValidity();
  //},

  /**
   * Dismiss all visible flashes on the form
   */
  dismissFlash: function() {
    this.$.flsActionSuccess.dismiss();
    this.$.flsActionError.dismiss();
  }
});
