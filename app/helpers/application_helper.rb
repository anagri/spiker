module ApplicationHelper
  include TreeHelper
  include FormHelper

  def doctype
    %q{<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
         "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">}
  end

  def html
    %q{<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">}
  end

  def end_html
    %q{</html>}
  end
end
