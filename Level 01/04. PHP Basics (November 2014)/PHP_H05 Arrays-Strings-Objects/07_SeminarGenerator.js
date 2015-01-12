'use strict';

var table = document.getElementById( 'main-table' );

table.addEventListener( 'mouseover', function( e ) {
    e.stopPropagation();
    if (e.target.tagName == 'A') {
        e.target.parentNode
            .querySelector( '.details-box' )
            .classList
            .add( 'visible' );
    }
});

table.addEventListener( 'mousemove', function( e ) {
    e.stopPropagation();
    var detailsBox = e.target.parentNode.querySelector( '.visible' );
    if (detailsBox) {
        detailsBox.style.left = e.clientX + 5;
        detailsBox.style.top = e.clientY + 5;
    }
});

table.addEventListener( 'mouseout', function( e ) {
    e.stopPropagation();
    if (e.target.tagName == 'A') {
        e.target.parentNode
            .querySelector( '.details-box' )
            .classList
            .remove( 'visible' );
    }
});