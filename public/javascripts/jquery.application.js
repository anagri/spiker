;
(function($) {
    $.extend({
        debug: function(msg) {
            if (typeof(console) != "undefined") console.log(msg);
        },

        urlParams: function(options) {
            var vars = [], hash;
            var url = typeof options != "undefined" && options.url ? options.url : window.location.href;

            if (url.indexOf('?') == -1) return vars;

            var hashes = url.slice(url.indexOf('?') + 1).replace(/#.*$/gi, '').split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        },

        urlParam: function(name, options) {
            return $.urlParams(options)[name];
        },

        selectedTab: function(options) {
            if ($.bbq.getState('tab')) {
                return $.bbq.getState('tab');
            }
            return $.urlParam('tab', options);
        },

        tabsShow: function() {
            return function(event, ui) {
                var $panel = $(ui.panel);
                var selected_tab_index = ui.index;
                var $container_panel = $panel.container();
                var $main_panel = $container_panel.mainContent();
                var $side_panel = $container_panel.sideContent();

                $side_panel.histrifyLinks($main_panel);

                // first assign the current tab in hash if not present
                if($.bbq.getState('tab') == undefined) {
                    $.bbq.pushState({tab: selected_tab_index}, 2);
                }

                // look out for hashchange events
                $(window).safeBind('hashchange', function(e) {
                    var selected = $.bbq.getState('selected');
                    if (selected != undefined) {
                        var $link = $side_panel.find("a[href$='" + selected + "']");
                        $link.trigger('change');
                    }
                });

                var $form_success_action = $.formSuccessAction(selected_tab_index);
                $main_panel.safeBind('content-ready', function(event) {
                    $(this).ajaxifyPanel($form_success_action);
                });

                $main_panel.ajaxifyPanel($form_success_action);

                // trigger the selected
                var $result = $side_panel.find('a').first();
                if ($.bbq.getState('selected') != undefined) {
                    var selected = $.bbq.getState('selected');
                    var $required_elem = $side_panel.find("a[href$='" + selected + "']");
                    if ($required_elem.size() != 0)
                        $result = $required_elem;
                }
                $result.triggerHandler('click');
            }
        },

        formSuccessAction: function(selected_tab_index) {
            return function(responseText, statusText, xhr) {
                var new_resource_path = xhr.getResponseHeader("Location").replace(/https?:\/\/.*?\//, '/');
                location.href = location.pathname + '?selected=' + new_resource_path + '&tab=' + selected_tab_index;
            }
        }
    });


    $.fn.extend({
        histrifyLinks: function($out_panel) {
            return this.each(function() {
                $(this).find('a').each(function() {
                    var $self = $(this);
                    $self.safeBind('click', function(event) {
                        event.preventDefault();
                        var force_trigger = $.bbq.getState('selected') == $self.attr('pathname');
                        $.bbq.pushState({selected: $self.attr('pathname')}, 0);
                        if (force_trigger) $self.triggerHandler('change');
                    });
                    $self.safeBind('change', $out_panel.ajaxyClick());
                });
            });
        },

        ajaxifyLinks: function($out_panel) {
            return this.each(function() {
                $(this).find('a').safeBind('click', $out_panel.ajaxyClick());
            });
        },

        ajaxyClick: function() {
            var $self = $(this);
            return function(event) {
                event.preventDefault();
                $self.ajaxyLoad(this.href);
            }
        },

        ajaxyLoad: function(href) {
            return this.each(function() {
                var $self = $(this);
                $.get(href, {}, function(response) {
                    $self.html(response);
                    $self.css('backgroundColor', 'yellow');
                    $self.animate({backgroundColor: 'white'}, 2000);
                    $self.trigger('content-ready');
                });
            });
        },

        collapse: function(options) {
            var settings = {
                delay: 3000,
                animate: {height: 0},
                time_period: 1000
            };
            if (options) $.extend(options, settings);

            return this.each(function() {
                $(this).delay(settings.delay).animate(settings.animate, settings.time_period, function() {
                    $(this).hide();
                });
            });
        },

        submitOnChange: function() {
            return this.each(function() {
                $(this).safeBind('change', function() {
                    $(this).parent().submit();
                });
            });
        },

        ajaxifyPanel: function($form_success_action) {
            return this.each(function() {
                var $self = $(this);
                $self.find('a').safeBind('click', $self.ajaxyClick());
                $self.find('form').ajaxForm({
                    target: $self,
                    error: function(xhr) {
                        $self.html(xhr.responseText);
                        $self.trigger('content-ready');
                    },
                    success: $form_success_action
                });
            });
        },

        safeBind: function(event, handler) {
            return this.each(function() {
                $(this).unbind(event + '.application').bind(event + '.application', handler);
            });
        },

        container: function() {
            return this.find('div.container');
        },

        sideContent: function() {
            return this.find('.' + this.attr('side-content'));
        },

        mainContent: function() {
            return this.find('.' + this.attr('main-content'));
        }
    });
})(jQuery);

