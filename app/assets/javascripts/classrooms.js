document.addEventListener('polymer-ready', function() {

  var classrooms = document.querySelector("core-ajax.classrooms");

  classrooms.addEventListener("core-response", function(e) {
    console.log(e);
    document.querySelector('#classrooms-list').model = { response: e.detail.response };
  });

});
