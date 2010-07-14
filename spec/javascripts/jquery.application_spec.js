require("spec_helper.js");
require("../../public/javascripts/jquery.application.js", {
    onload: function() {
        require('../../public/javascripts/js/jquery.ba-bbq.js');
        require('../../public/javascripts/js/jquery.form.js');
    }
});

Screw.Unit(function() {
    after(function(){ teardownFixtures() });

    describe("Jquery.application", function() {
        it("should return the selected tab from anchor", function() {
            mock($.bbq).should_receive('getState').with_arguments('tab').and_return(1);
            expect($.selectedTab()).to(equal, 1);
        });

        it("should return the selected tab from url params", function() {
            expect($.selectedTab({url: "http://test.com/?tab=2"})).to(equal, 2);
        });

        it("should parse the url params", function() {
            expect($.urlParams({url: "http://test.com/?arg1=1&arg2=2"})).to(equal, ['arg1', 'arg2']);
        });

        it("should return the url param value", function() {
            expect($.urlParam('arg1', {url: "http://test.com/?arg1=1&arg2=2"})).to(equal, 1);
            expect($.urlParam('arg2', {url: "http://test.com/?arg1=1&arg2=2"})).to(equal, 2);
        });

/*
        it("should load the ", function() {
            var $panel = $("<div class='tabs'/>");
            var $container = $("<div class='container' side-content='side_content' main-content='main_content'/>");
            var $side_panel = "<div class='side_content'/>";
            var $main_panel = "<div class='main_content'/>";

            fixture($panel.append($container.append($side_panel).append($main_panel)));
            // expect the side content is called to ajaxify links and target as main panel
            mock($panel).should_receive('container').and_return($container);
            mock($container).should_receive('mainContent').and_return($main_panel);
            mock($container).should_receive('sideContent').and_return($side_panel);

            mock($side_panel).should_receive('ajaxifyLinks');
            mock($main_panel).should_receive('ajaxifyLinks');

            var ui = {panel: $panel, index: 1};
            $.tabsShow()(null, ui);
        });
*/
    });
});
