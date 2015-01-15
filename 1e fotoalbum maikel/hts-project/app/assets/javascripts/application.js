// This is a manifest file that'll be compiled into application.js, which will include all the files
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
//= require jquery_ujs
//= require turbolinks
//= require jquery.fancybox
//= require jquery.turbolinks
//= require_tree .

$(document).ready(function() {
    $(".fancybox").fancybox({
        openEffect	: 'none',
        closeEffect	: 'none',
        parent      : 'body'
    });
    $(".fancybox_iframe").fancybox({
        type        : 'iframe',
        maxWidth	: 800,
        maxHeight	: 600,
        fitToView	: false,
        width		: '70%',
        height		: '70%',
        autoSize	: false,
        closeClick	: false,
        openEffect	: 'none',
        closeEffect	: 'none'
    });

    $(".alert-success, .alert-danger").click(function(){
        $(".flash").animate({'margin-top': "-61px"}, 600); 
        return false;
    });
    
    setTimeout(
      function() {
        $(".alert-success").animate({'margin-top': "-61px"}, 600); 
            return false;
      }, 2500);
});