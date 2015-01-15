var eventDate = new Date(2015,2,14);
var now = new Date();
var count = eventDate - now;
var seconds = count/1000;
var days = Math.ceil(seconds / (60*60*24));
$("#count-day").html(days);

$(".page-header").css("height",window.innerHeight);
$(window).on("resize",function(){
	$(".page-header").css("height",window.innerHeight);
});
$(window).on("scroll",function(){
	if($(window).scrollTop() > window.innerHeight)
	{
		$("nav.header").addClass("header-fixed");
	}
	else{
		$("nav.header").removeClass("header-fixed");
	}		
});