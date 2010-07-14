require("spec_helper.js");
require("../../public/javascripts/jquery.application.js");

Screw.Unit(function(){
  describe("Jquery.application", function(){
    it("does something", function(){
      expect("hello").to(equal, "hello");
    });
  });
});
