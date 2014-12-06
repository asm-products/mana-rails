$(document).ready(function() {



// Feature Detections
var IS_MOBILE_SAFARI_7 = !!navigator.userAgent.match(/i(Pad|Phone|Pod).+(Version\/7\.\d+ Mobile)/i);

// SVG Fallbacks
if(!Modernizr.svg) {
    $('.logo').attr('src', 'logo.png');
}


// vw & vh units for intro
if(Modernizr.cssvwunit == false && Modernizr.cssvhunit == false || IS_MOBILE_SAFARI_7) {
    $('.full-screen-container').css('width', window.innerWidth + 'px').css('height', window.innerHeight + 'px');
}






// Navigation Slide
$('.js-nav-slide').on('click', function() {

    event.preventDefault();
    var href = $(this).attr('href');
    href = href.substring(1,href.length);
    anker = $("a[name='"+ href +"']");
    
    $('html,body').animate({scrollTop: anker.offset().top}, 'slow');
});



});