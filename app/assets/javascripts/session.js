// This is a manifest file that'll be compiled into session.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require materialize/animation
//= require materialize/velocity.min
//= require materialize/hammer.min
//= require materialize/jquery.hammer
//= require materialize/global
//= require materialize/waves
//= require materialize/forms
//= require materialize/buttons

'use strict';

jQuery.ajax({
  url: "https://trailblazer-by-twingl.atlassian.net/s/b54e5d2f8dc4abbaa73e599d6914669a-T/en_US-isb2pu/70102/b6b48b2829824b869586ac216d119363/2.0.7/_/download/batch/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector-embededjs/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector-embededjs.js?locale=en-US&collectorId=0704d02a",
  type: "get",
  cache: true,
  dataType: "script"
});

jQuery.ajax({
  url: "https://trailblazer-by-twingl.atlassian.net/s/b54e5d2f8dc4abbaa73e599d6914669a-T/en_US-isb2pu/70102/b6b48b2829824b869586ac216d119363/2.0.7/_/download/batch/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector-embededjs/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector-embededjs.js?locale=en-US&collectorId=eca668be",
  type: "get", cache: true,
  dataType: "script"
});

window.ATL_JQ_PAGE_PROPS = $.extend(window.ATL_JQ_PAGE_PROPS || {}, {
  "eca668be": {
    triggerFunction: function(showCollectorDialog) { //bugs
      jQuery("#bug").click(function(e) {
        e.preventDefault();
        showCollectorDialog();
      });
    }
  },
  "0704d02a": {
    triggerFunction: function(showCollectorDialog) { //feedback
      jQuery("#feedback").click(function(e) {
        e.preventDefault();
        showCollectorDialog();
      });
    }
  }
});

$(document).ready(function() {

  var getSignInMethod = function(email, callback) {
    $.get('/sign_in_method', { email: email }, function(response) {
      callback(response.method);
    });
  };

  var resetForm = function() {
    $('.actions.actions-sign-up').hide();
    $('.actions.actions-sign-in').hide();
    $('.actions.actions-oauth').hide();
    $('.actions.actions-default').show();

    $('.forgot-password').text('Forgot password?');
    $('.input-field.password').hide();
    $('input#password').val('');

    $('form').attr('target', '/sign_in');
  };

  var showForm = function(method) {
    $('.has-loader.active').removeClass('active');

    switch(method) {
      case 'sign_up':
        $('.actions.actions-sign-up').show();
        $('.actions.actions-sign-in').hide();
        $('.actions.actions-oauth').show();
        $('.actions.actions-default').hide();

        $('.input-field.password').show();
        $('input#password').focus();

        $('form').attr('target', '/sign_up');
        break;

      case 'password':
        $('.actions.actions-sign-up').hide();
        $('.actions.actions-sign-in').show();
        $('.actions.actions-oauth').hide();
        $('.actions.actions-default').hide();

        $('.input-field.password').show();
        $('input#password').focus();

        $('form').attr('target', '/sign_in');
        break;

      case 'oauth':
        $('.actions.actions-sign-up').hide();
        $('.actions.actions-sign-in').show();
        $('.actions.actions-oauth').show();
        $('.actions.actions-default').hide();

        $('.input-field.password').show();
        $('input#password').focus();

        $('form').attr('target', '/sign_in');
        break;

      default:
        resetForm();
        break;
    }
  };

  
  var nextStage = function() {
    var target = $('.btn.next');

    if ($('input#email').hasClass('invalid') || $('input#email').val() == "") {
      $('input#email').focus();

      $(target).addClass('shake');
      setTimeout(function() {
        $(target).removeClass('shake')
      }, 1000);

    } else {
      $(target).addClass('active');

      getSignInMethod($('input#email').val(), showForm);
    }
  };

  $('.next').click(nextStage);
  $('input#email').keypress(function(e) {
    if (e.which === 13) nextStage();
  });

  $('input#email').focus(function(evt) {
    showForm();
  });

  $('.forgot-password').click(function(evt) {
    var authenticity_token = $('meta[name=csrf-token]').attr('content');
    var email = $('input#email').val();

    $.post('/forgot_password', { user: { email: email }, authenticity_token: authenticity_token }, function(response) {
      $('.forgot-password').text("We've sent you an email with instructions");
    });
  });

  var submitPasswordForm = function() {
    var authenticity_token = $('meta[name=csrf-token]').attr('content');
    var email = $('input#email').val();
    var password = $('input#password').val();

    $('.btn.sign-in').addClass('active');
    $('.btn.sign-up').addClass('active');
    $.ajax($('form').attr('target'), {
      method: 'POST',
      data: { user: { email: email, password: password }, authenticity_token: authenticity_token },
      success: function(response) {
        window.location = response.location;
      },
      error: function(response, error, exception) {
        console.log(response);

        $('input#password').focus();

        $('.btn.sign-in').removeClass('active');
        $('.btn.sign-up').removeClass('active');
        $('.btn.sign-in').addClass('shake');
        $('.btn.sign-up').addClass('shake');
        setTimeout(function() {
          $('.btn.sign-in').removeClass('shake');
          $('.btn.sign-up').removeClass('shake');
        }, 1000);
      }
    });
  };

  $('.btn.sign-in').click(submitPasswordForm);
  $('input#password').keypress(function(e) {
    if (e.which === 13) submitPasswordForm();
  });

});
