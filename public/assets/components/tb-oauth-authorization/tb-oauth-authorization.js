Polymer('tb-oauth-authorization', {
  ready: function() {
    this.csrfToken = document.querySelector('[name=csrf-token]').content;
    this.formData = JSON.stringify({
      client_id:     this.clientId,
      redirect_uri:  this.redirectURI,
      state:         this.state,
      response_type: this.responseType,
      scope:         this.scope
    });
    console.log(this.canSignIn);
  },
  approve: function(evt) {
    this.$.approve.go();
  },
  deny: function(evt) {
    this.$.deny.go();
  },
  changeUser: function(evt) {
    window.location.href = this.changeURL;
  },
  userImageLoaded: function(evt) {
    response = JSON.parse(evt.detail.response);
    if (response.image) {
      url = response.image.url;
      this.userImage = url.replace("sz=50", "sz=64");
    }

    if (response.cover) {
      this.$.cover.style.backgroundImage = "url(" + response.cover.coverPhoto.url + ")"
    }
  }
});
