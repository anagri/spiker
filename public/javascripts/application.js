/*
 focus the element with class focus
 */
window.onerror = function(msg, file, line) {
    console.log(msg + ',' + file + ',' + line);
};

$(function() {
    // focus
    $('.focus').first().focus();
    // submit on change
    $('.submit_on_change').submitOnChange();
    // auto hide flash messages
    $('.flash_info, .flash_error').collapse();
    // tabify
    $('.tabs').tabs({
        show: $.tabsShow(),
        selected: $.selectedTab()
    });
    // treeify
    $('div.treeview ul').treeview();
});


