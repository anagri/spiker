/*
 focus the element with class focus
 */
window.onerror = function(msg, file, line) {
    $.debug(msg + ',' + file + ',' + line);
};

$(function() {
    // focus
    $('.focus').first().focus();
    // submit on change
    $('.submit_on_change').submitOnChange();
    // auto hide flash messages
    $('.flash_info, .flash_error').collapse();
    // tabify
    var tabs = $('.tabs').tabs({
        show: $.tabsShow(),
        selected: $.selectedTab(),
        event: 'change'
    });
    tabs.find('ul.ui-tabs-nav a').safeBind('click', function() {
        $.bbq.pushState({tab: $(this).parent().prevAll().length}, 2);
    });
    $(window).bind('hashchange', function() {
        var $state = $($.bbq.getState());
        if ($state.length == 1 && $.bbq.getState('tab') != undefined) {
            tabs.each(function() {
                var $tab = $(this).find('ul.ui-tabs-nav a').eq($.bbq.getState('tab', true));
                $tab.triggerHandler('change');
            });
        }
    });
    // treeify
    $('div.treeview ul').treeview();
});


