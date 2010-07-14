;
(function($) {
    $.extend({
        urlParams: function(options) {
            var vars = [], hash;
            var url = typeof options != "undefined" && options.url ? options.url : window.location.href;
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
                var $selected_tab_index = ui.index;
                var $container_panel = $panel.container();
                var $main_panel = $container_panel.mainContent();
                var $side_panel = $container_panel.sideContent();
                $side_panel.ajaxifyLinks($main_panel);
                var $form_success_action = $.formSuccessAction($selected_tab_index);

                $main_panel.safeBind('content-ready', function(event) {
                    $(this).ajaxifyPanel($form_success_action);
                });

                $main_panel.ajaxifyPanel($form_success_action);
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
        },

        prepare2PanelLayout: function() {
            return this.each(function(index, element) {
                var $container_panel = $(element);
                var $side_panel = $container_panel.sideContent();
                var $main_panel = $container_panel.mainContent();

                var $result = $side_panel.find('a').first();
                if ($.urlParam('selected') != undefined) {
                    var selected = $.urlParam('selected');
                    var $required_elem = $side_panel.find("a[href$='" + selected + "']");
                    if ($required_elem.size() != 0)
                        $result = $required_elem;
                }
                $result.triggerHandler('click');
            });
        }
    });
})(jQuery);

