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
//= require jquery.turbolinks
//= require jquery.fancybox

//= require twitter/typeahead

//= require twitter/typeahead.min

//= require bootstrap-sprockets

$(document).ready(function() {
    $(".fancybox").fancybox({
        parent      : 'body',
        openEffect	: 'none',
        closeEffect	: 'none'
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

    $(".notice, .alert").click(function(){
        $(".flash").animate({'margin-top': (-$( ".flash" ).height() - 61) +"px"}, 600); 
        return false;
    });
    
    setTimeout(
      function() {
        $(".notice").animate({'margin-top': (-$( ".flash" ).height() - 61) +"px"}, 600); 
            return false;
      }, 2500);
});