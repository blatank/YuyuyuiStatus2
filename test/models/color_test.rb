require 'test_helper'

class ColorTest < ActiveSupport::TestCase
  def setup
    @color = colors(:red)
  end
  # color validation
  test "color should be present" do
    @color.name = "  "
    assert_not @color.valid?
  end
  
  # color validation(range)
  test "color should be pattern" do
    valid_color = %w[red blue yellow green purple]
    invalid_color = %w[gold white UR silver fire]
    
    # valid test
    valid_color.each do |color|
      @color.name = color
      assert @color.valid?, "#{color.inspect} should be valid"
    end
    
    # invalid test
    invalid_color.each do |color|
      @color.name = color
      assert_not @color.valid?, "#{color.inspect} should be invalid"
    end
  end
end
