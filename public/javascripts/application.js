/*
 focus the element with class focus
 */
window.onerror = function(e) {
    console.log(e);
};

$(function() {
    // focus
    $('.focus').first().focus();
    // treeify
    $('div.treeview ul').treeview();
    // tabify
    $('.tabs').tabs();
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
        populate_content(this.href, $content_body);
    }
};

populate_content = function(href, $content_body) {
    $.get(href, {}, function(response) {
        $content_body.html(response);
        $content_body.css('backgroundColor', 'yellow');
        $content_body.animate({backgroundColor: 'white'}, 2000);
        $content_body.trigger('content-ready');
    });
};

// submit on change
$(function() {
    $('.submit_on_change').bind('change', function() {
        $(this).parent().submit();
    });
});

// ajaxify 2_col_content
$(function() {
    var $container_panels = $('.2_col_panel');
    $container_panels.each(function(index, element) {
        var $container_panel = $(element);

        var $side_panel = $('#' + $container_panel.attr('side-content'));
        var $main_panel = $('#' + $container_panel.attr('main-content'));
        var $action_panel = $('#' + $container_panel.attr('action-content'));
        var handle_click = handle_content_click($main_panel);

        $([$side_panel, $action_panel]).each(function(index, $element) {
            $element.find('a').bind('click', handle_click)
        });

        if ($.urlParam('selected') != undefined) {
            var selected = $.urlParam('selected');
            $side_panel.find('a').each(function(index, element) {
                var $element = $(element);
                var url_regex = new RegExp($element.attr('href'), 'g');
                if (url_regex.test(selected)) {
                    $element.click();
                }
            });
        } else {
            populate_content($side_panel.find('a').first().attr('href'), $main_panel);
        }

        $main_panel.bind('content-ready', function() {
            $main_panel.find('form').ajaxForm({
                target: $main_panel,
                error: function(xhr) {
                    $main_panel.html(xhr.responseText)
                    $main_panel.trigger('content-ready');
                },
                success: function(responseText, statusText, xhr, $form) {
                    var new_resource_path = xhr.getResponseHeader("Location").replace(/https?:\/\/.*?\//, '/');
                    location.href = location.pathname + '?selected=' + new_resource_path;
                }
            });
            $main_panel.find('a').bind('click', handle_click);
        });
    });
});

$.extend({
    urlParams: function() {
        var vars = [], hash;
        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).replace(/#.*$/gi, '').split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    },
    urlParam: function(name) {
        return $.urlParams()[name];
    }
});
