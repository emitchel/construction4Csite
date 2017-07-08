// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require jquery-migrate.min.js
//= require bootstrap.min.js
//= require bootstrap-hover-dropdown.min.js
//= require wow.min.js
//= require dzsparallaxer.js
//= require bootstrap-hover-dropdown.min.js
//= require owl.carousel.min.js
//= require js-routes
//= require custom.js
//= require masterslider.js
//= require lightbox.js
//= require master-custom.js
//= require jquery.cubeportfolio.min.js
//= require swiper.js

(function ($, window, document, undefined) {
    'use strict';

    // init cubeportfolio
    $('#js-grid-agency').cubeportfolio({
        filters: '#js-filters-agency',
        loadMore: '#js-loadMore-agency',
        loadMoreAction: 'click',
        layoutMode: 'grid',
        defaultFilter: '*',
        animationType: 'slideLeft',
        gapHorizontal: 15,
        gapVertical: 0,
        gridAdjustment: 'responsive',
        mediaQueries: [{
            width: 1500,
            cols: 4
        }, {
            width: 1100,
            cols: 4
        }, {
            width: 800,
            cols: 3
        }, {
            width: 480,
            cols: 2
        }, {
            width: 320,
            cols: 1
        }],
        caption: 'zoom',
        displayType: 'fadeIn',
        displayTypeSpeed: 100
    });


})(jQuery, window, document);

function resizeToMax(id) {
    myImage = new Image()
    var img = document.getElementById(id);
    myImage.src = img.src;
    if (myImage.width > myImage.height) {
        img.style.width = "80%";
        img.style.height = "auto";
    } else {
        img.style.height = window.screen.height;
        img.style.width = "auto";
    }
}