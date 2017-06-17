$('document').ready(function() {
  $.getJSON('/states', function(ret) {
    $.each(ret, function(k,v) {
      $('#state').append($('<option>', {value: v, text: v}));
    });
  });

  $('#go').on('click', function(e) {
    e.preventDefault();
    window.location = "/data/" + $('#state').val();
  });
});
