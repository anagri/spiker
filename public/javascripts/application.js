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
        return function(event) {
            event.preventDefault();
            $.ajaxyLoad($body, this.href);
        }
    },

    ajaxyLoad: function($body, href) {
        var $self = $body;
        $.get(href, {}, function(response) {
            $self.html(response);
            $self.css('backgroundColor', 'yellow');
            $self.animate({backgroundColor: 'white'}, 2000);
            $self.trigger('content-ready');
        });
    },

    ajaxifyPanel: function($main_panel, $form_success_action) {
        $main_panel.find('a').unbind('click.tabsShow').bind('click.tabsShow', $.ajaxyClick($main_panel));
        $main_panel.find('form').ajaxForm({
            target: $main_panel,
            error: function(xhr) {
                $main_panel.html(xhr.responseText);
                $main_panel.trigger('content-ready');
            },
            success: $form_success_action
        });
    },

    tabsShow: function() {
        return function(event, ui) {
            var $panel = $(ui.panel);
            var $selected_tab = ui.index;
            var $container_panel = $panel.find('div.container');
            var $main_panel = $('.' + $container_panel.attr('main-content'));
            var $side_panel = $('.' + $container_panel.attr('side-content'));

            $side_panel.find('a').unbind('click.tabsShow').bind('click.tabsShow', $.ajaxyClick($main_panel));
            var $form_success_action = $.formSuccessAction($selected_tab);

            $main_panel.unbind('content-ready.tabsShow').bind('content-ready.tabsShow', function(event) {
                $.ajaxifyPanel($(this), $form_success_action);
            });

            $.ajaxifyPanel($main_panel, $form_success_action);
        }
    },

    formSuccessAction: function(selected_tab) {
        return function(responseText, statusText, xhr) {
            var new_resource_path = xhr.getResponseHeader("Location").replace(/https?:\/\/.*?\//, '/');
            location.href = location.pathname + '?selected=' + new_resource_path + '&tab=' + selected_tab;
        }
    }
});


$(function() {
    // focus
    $('.focus').first().focus();
    // treeify
    $('div.treeview ul').treeview();
    // tabify
    $('.tabs').tabs({
        show: $.tabsShow(),
        selected: $.urlParam('tab')
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
        var $side_panel = $('.' + $container_panel.attr('side-content'));
        var $main_panel = $('.' + $container_panel.attr('main-content'));

        var $result = $side_panel.find('a').first();
        console.log($.urlParam('selected'))
        if ($.urlParam('selected') != undefined) {
            var selected = $.urlParam('selected');
            var $required_elem = $side_panel.find("a[href$='" + selected + "']");
            if ($required_elem.size() != 0)
                $result = $required_elem;
        }
        $.ajaxyLoad($main_panel, $result.attr('href'));
    });
});


