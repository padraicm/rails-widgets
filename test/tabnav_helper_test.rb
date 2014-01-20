require File.dirname(__FILE__) + '/test_helper'

class TabnavHelperTest < Test::Unit::TestCase
  def setup
    @view = ActionView::Base.new
    @view.extend Widgets::TabnavHelper
  end

  %w{tabnav render_tabnav add_tab}.each do |instance_method|
    define_method("test_presence_of_#{instance_method}_instance_method") do
      assert @view.protected_methods.include?(instance_method.to_sym),
        "#{instance_method} is not defined in #{@view.inspect}"
    end
  end
end
