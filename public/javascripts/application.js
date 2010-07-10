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
    // treeify
    $('div.treeview ul').treeview();
    // tabify
    $('.tabs').tabs({
        show: $.tabsShow(),
        selected: $.urlParam('tab')
    });
    $('.2_col_panel').prepare2PanelLayout();
});


