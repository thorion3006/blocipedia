$(function() {
  showdown.setFlavor('github');
  var converter = new showdown.Converter({
    'tables': true
  });
  var convert = function() {
    $('#preview').html(converter.makeHtml($('#wiki_body').val()));
  };
  convert();
  $('#wiki_body').keyup(convert);
});
