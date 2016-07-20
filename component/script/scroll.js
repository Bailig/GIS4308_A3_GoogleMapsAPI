var topoffset = 10;

$(".navbar a[href*='#']:not([href='#']), #doneArrow a[href*='#']:not([href='#']").click(function() {
if (location.pathname.replace(/^\//,'') === 
  this.pathname.replace(/^\//,'') && 
  location.hostname === this.hostname) {
  var target = $(this.hash);
  target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
  if (target.length) {
    $('html,body').animate({
      scrollTop: target.offset().top-topoffset+2
    }, 500);
    return false;
  } //target.length
} //click function
}); //smooth scrolling