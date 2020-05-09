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
  
  # color validation(unique)
  test "color should be unique" do
    new_color = @color.dup
    assert_not new_color.valid?
  end
  
  # color validation(range)
  test "color should be pattern" do
    valid_color = [:red, :blue, :yellow, :green, :purple]
    
    # valid test
    valid_color.each do |c|
      color = colors(c)
      assert color.valid?, "#{color.name.inspect} should be valid"
    end
  end
    
  # color validation(range)
  test "color should not be other pattern" do
    invalid_color = %w[gold white UR silver fire]
    
    # invalid test
    invalid_color.each do |color|
      @color.name = color
      assert_not @color.valid?, "#{color.inspect} should be invalid"
    end
  end

  # color meaining validation
  test "mean should be present" do
    @color.mean = "  "
    assert_not @color.valid?
  end
  
  # color meaining validation(range)
  test "mean should be pattern" do
    valid_mean = %w[赤 青 黄 緑 紫]
    invalid_mean = %w[金 白 UR 銀 火]
    
    # valid test
    valid_mean.each do |mean|
      @color.mean = mean
      assert @color.valid?, "#{mean.inspect} should be valid"
    end
    
    # invalid test
    invalid_mean.each do |mean|
      @color.mean = mean
      assert_not @color.valid?, "#{mean.inspect} should be invalid"
    end
  end
end
