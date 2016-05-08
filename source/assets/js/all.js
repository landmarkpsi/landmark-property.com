= require plugins/jquery/jquery-migrate.min
//= require plugins/bootstrap/js/bootstrap.min
//= require back-to-top
//= require smoothScroll
//= require jquery.parallax
//= require counter/waypoints.min
//= require counter/jquery.counterup.min
//= require revolution-slider/rs-plugin/js/jquery.themepunch.tools.min
//= require revolution-slider/rs-plugin/js/jquery.themepunch.revolution
//= require cube-portfolio/cubeportfolio/js/jquery.cubeportfolio.min
//= require plugins/revolution-slider
//= require plugins/cube-portfolio/cube-portfolio-3
//= require gmap/gmap
//= require readmore
//= require app
//= require custom

jQuery(document).ready(function() {
    App.init();
    App.initCounter();
    App.initParallaxBg();
    RevolutionSlider.initRSfullScreenOffset();
});
