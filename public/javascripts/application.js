/*
 focus the element with class focus
 */
window.onerror = function(e) {
    console.log(e);
};


$(function() {
    $('.focus').first().focus();
    $('div.treeview ul').treeview();
});

$(function() {
    // tabify
    $('.tabs').tabs({
        ajaxOptions: {
            error: function(xhr, status, index, anchor) {
                $(anchor.hash).html("Couldn't load this tab. We'll try to fix this as soon as possible.");
            }
            // TODO : send out ajax request about error report
        }
    });

    // TODO convert to jquery plugins

    // parse anchor links, ajaxify
    $('.tabs').bind('tabsload', function(event, ui) {
        var $panel = $(ui.panel);

        // unbind old event from content_body
        if (typeof($content_body) != "undefined") {
            $content_body.unbind('content-ready');
        }

        $content_body = $('#' + $panel.find('div.side_content').attr('rel'));
        $panel.find('div.container a').bind('click', handle_content_click($content_body));

        // autoselect the first tab
        if (typeof(content_body_location) != "undefined" && content_body_location != null) {
            $('.side_content ul li a').each(function(index, element) {
                var $element = $(element);
                var url_regex = new RegExp($element.attr('href'), 'g');
                if (url_regex.test(content_body_location)) {
                    $element.click();
                }
            });
            content_body_location = null;
        } else {
            $panel.find('div.side_content ul li a').first().click();
        }


        // assign new event handler
        $content_body.bind('content-ready', function() {
            $content_body.find('form').ajaxForm({
                target: $content_body,
                error: function(xhr) {
                    $content_body.html(xhr.responseText)
                    $content_body.trigger('content-ready');
                },
                success: function(responseText, statusText, xhr, $form) {
                    content_body_location = xhr.getResponseHeader("Location");
                    var $tabs = $('.tabs');
                    $tabs.tabs('load', $tabs.tabs('option', 'selected'));
                }
            });
            $content_body.find('a').bind('click', handle_content_click($content_body));
        });
    });
});


/*
 auto hide flash messages
 */

$(function() {
    $('.flash_info, .flash_error').delay(3000).animate({height: 0}, 1000, function() {
        $(this).hide();
    });
});


handle_content_click = function($content_body) {
    return function(event) {
        event.preventDefault();
        $.get(this.href, {}, function(response) {
            $content_body.html(response);
            $content_body.css('backgroundColor', 'yellow');
            $content_body.animate({backgroundColor: 'white'}, 2000);
            $content_body.trigger('content-ready');
        });
    }
};

// submit on change
$(function() {
    $('.submit_on_change').bind('change', function(){
        $(this).parent().submit();
    });
});


