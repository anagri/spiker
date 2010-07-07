/*
 focus the element with class focus
 */
$(function() {
    $('.focus').first().focus();
    $('div.treeview ul').treeview();
});

$(function() {
    // tabify
    $('.tabs').tabs({
        ajaxOptions: {
            error: function(xhr, status, index, anchor) {
                $(anchor.hash).html("Couldn't load this tab. We'll try to fix this as soon as possible. If this wouldn't be a demo.");
            }
        }
    });

    // parse anchor links, ajaxify
    $('.tabs').bind('tabsload', function(event, ui) {
        $panel = $(ui.panel);
        var content_body = '#' + $panel.find('div.side-bar').attr('rel');
        $panel.find('div#new_office_link a').bind('click', function(event) {
            event.preventDefault();
            $.get(this.href, {}, function(response) {
                $(content_body).html(response);
                $(content_body).css('backgroundColor', 'yellow');
                $(content_body).animate({backgroundColor: 'white'}, 2000);
                $(content_body).trigger('content-ready');
            });
        });

        // autoselect the first tab
        $('.side-bar ul li a').first().click();
    });

});


/*
 auto hide flash messages
 */

$(function() {
    $('.flash_info, .flash_error').delay(3000).animate({height: 0}, 1000, function() { $(this).hide(); });
});



