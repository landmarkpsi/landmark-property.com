/* Write here your custom javascript codes */
$('.readmore').readmore();

$('#property-links').on('change', function () {
    var url = $(this).val(); // get selected value
    if (url) { // require a URL
        window.location = url; // redirect
    }
    return false;
});