/*
 focus the element with class focus
 */
window.onerror = function(msg, file, line) {
    console.log(msg + ',' + file + ',' + line);
};

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
    },

    ajaxyClick: function($body) {
        var $self = $body;
        if ($self == null) $self = this;
        return function(event) {
            event.preventDefault();
            $.ajaxyLoad($self, this.href);
        }
    },

    ajaxyLoad: function($body, href) {
        var $self = $body;
        if ($self == null) $self = this;
        $.get(href, {}, function(response) {
            $self.html(response);
            $self.css('backgroundColor', 'yellow');
            $self.animate({backgroundColor: 'white'}, 2000);
            $self.trigger('content-ready');
        });
    },

    ajaxifyPanel: function($container_panel) {
        var $main_panel = $('#' + $container_panel.attr('main-content'));
        $container_panel.find('a').bind('click', $.ajaxyClick($main_panel));

        $container_panel.find('form').ajaxForm({
            target: $main_panel,
            error: function(xhr) {
                $main_panel.html(xhr.responseText);
                $main_panel.trigger('content-ready');
            },
            success: function(responseText, statusText, xhr) {
                var new_resource_path = xhr.getResponseHeader("Location").replace(/https?:\/\/.*?\//, '/');
                location.href = location.pathname + '?selected=' + new_resource_path + location.hash;
            }
        });
    },

    contentReady: function() {
        return function(event) {
            $.ajaxifyPanel($(this));
        }
    },

    tabsShow: function() {
        return function(event, ui) {
            var $panel = $(ui.panel);
            var $container_panel = $panel.find('div.container');
            $.ajaxifyPanel($container_panel);
        }
    }
});


$(function() {
    // focus
    $('.focus').first().focus();
    // treeify
    $('div.treeview ul').treeview();
    // tabify
    $('.tabs').tabs({show: $.tabsShow()}).find('div.container').bind('content-ready', $.contentReady());
});

/*
 auto hide flash messages
 */

$(function() {
    $('.flash_info, .flash_error').delay(3000).animate({height: 0}, 1000, function() {
        $(this).hide();
    });
});


// submit on change
$(function() {
    $('.submit_on_change').bind('change', function() {
        $(this).parent().submit();
    });
});

// ajaxify 2_col_content
$(function() {
    var $container_panels = $('.2_col_panel:visible');
    $container_panels.each(function(index, element) {
        var $container_panel = $(element);
        var $side_panel = $('#' + $container_panel.attr('side-content'));
        var $main_panel = $('#' + $container_panel.attr('main-content'));
        var $action_panel = $('#' + $container_panel.attr('action-content'));
        var handle_click = $.ajaxyClick($main_panel);

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
            $.ajaxyLoad($main_panel, $side_panel.find('a').first().attr('href'));
        }
    });
});
