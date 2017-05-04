$(function() {
  showdown.setFlavor('github');
	var $textarea = $('textarea');
	var $preview = $('<div id="preview" />').insertAfter($textarea);
	var convert = new showdown.Converter().makeHtml;

	$textarea.keyup(function() {
		$preview.html(convert($textarea.val()));
	}).trigger('keyup');
});
