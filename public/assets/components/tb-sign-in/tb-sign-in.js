Polymer('tb-sign-in', {
  /**
   * Obtain the CSRF token from the rendered view so we can make non-GET
   * requests to the server
   */
  ready: function() {
    this.csrfToken = document.querySelector('[name=csrf-token').content;
  },

  /**
   * Updates the form data properties that are used by various core-ajax
   * elements to send information to the server.
   */
  updateFormData: function() {
    // Generate a JSON string of all registration data
    this.registrationData = JSON.stringify({
      user: {
        email: this.email,
        password: this.password
      }
    });

    // Generate a JSON string of just the email address for a password reset
    this.forgotPasswordData = JSON.stringify({
      user: {
        email: this.email
      }
    });
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
  validatePassword: function() {
    return this.$.txtPassword.checkValidity();
  },

  /**
   * Validates Email and Password
   * @returns boolean True if all inputs are valid, false otherwise.
   */
  validateForm: function() {
    return this.validateEmail() && this.validatePassword();
  },

  /**
   * Dismiss all visible flashes on the form
   */
  dismissFlash: function() {
    this.$.flsActionSuccess.dismiss();
    this.$.flsActionError.dismiss();
  },

  /**
   * Handle responses
   */
  handleResponse: function(evt) {
    console.log(evt);
    try {
      var response = JSON.parse(evt.detail.response);
      if (response.location) window.location.href = response.location;
    } catch (e) { }
  },

  /**
   * Handle any ajax errors and display a flash with a (sometimes) useful error
   * message
   */
  ajaxError: function(evt) {
    this.dismissFlash();

    try {
      var response = JSON.parse(evt.detail.xhr.response);

      if (response.error) {
        switch (response.error) {
          case 'unknown_account':
            this.$.flsActionError.show("We can't seem to find an account for you. If you're new here, create an account!");
            break;

          case 'incorrect_details':
            this.$.flsActionError.show("Those details don't seem to be right. Tap the button if you've forgotten your password.");
            break;

          case 'email_taken':
            this.$.flsActionError.show("That email appears to be taken. Tap the button if you've forgotten your password.");
            break;
        }
      } else {
        this.$.flsActionError.show("An error occurred");
      };
    } catch (e) {
      this.$.flsActionError.show("An error occurred");
    }
  },

  /**
   * Let the user know we've sent them an email with their password reset
   * instructions.
   */
  passwordEmailSent: function() {
    console.log("Sent!");
    this.dismissFlash();
    this.$.flsActionSuccess.show("Check your inbox - we've sent you an email!");
  },

  /**
   * Invokes the signIn <core-ajax> call with the bound form data
   */
  signIn: function(evt) {
    if (this.validateForm()) {
      this.$.xhrSignIn.go();
      this.dismissFlash();
    }
  },

  /**
   * Invokes the signUp <core-ajax> call with the bound form data
   */
  signUp: function(evt) {
    if (this.validateForm()) {
      this.$.xhrSignUp.go();
      this.dismissFlash();
    }
  },

  /**
   * Invokes the forgotPassword <core-ajax> call with the email address in form
   * data
   */
  forgotPassword: function(evt) {
    if (this.validateEmail()) {
      this.$.xhrForgotPassword.go();
      this.dismissFlash();
    }
  },

  /**
   * Navigates to the Google sign in URL
   */
  googleSignIn: function(evt) {
    window.location.href = this.socialUrlGoogle;
  }
});
