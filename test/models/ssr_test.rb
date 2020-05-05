require 'test_helper'

class SsrTest < ActiveSupport::TestCase
  def setup
    @ssr  = ssrs(:ssrtest)
    @hero = heros(:wassy)
    @ssr.hero_id = @hero.id
    
    @valid_status   = [0, 20] # "F-", "S+"
    @invalid_status = [@valid_status.min-1, @valid_status.max+1, 1.5]
  end
  
  # とりあえずvalid?
  test "should be valid" do
    assert @ssr.valid?
  end
  
  # name validation
  test "name should be present" do
    @ssr.name = " "
    assert_not @ssr.valid?
  end
  
  # name validation(length)
  test "name should not be too long" do
    @ssr.name = "あ" * 21
    assert_not @ssr.valid?
  end
  
  # rare validation
  test "rare should be present" do
    @ssr.rare = "   "
    assert_not @ssr.valid?
  end
  
  # レアタイプの制限
  test "rare should be 4 rare type" do
    valid_rare   = %w[R SR SSR UR]
    invalid_rare = %w[rare SuperRare RR]
    
    valid_rare.each do |rare|
      @ssr.rare = rare
      assert @ssr.valid?, "#{rare.inspect} should be valid"
    end

    invalid_rare.each do |rare|
      @ssr.rare = rare
      assert_not @ssr.valid?, "#{rare.inspect} should be invalid"
    end
  end
  
  # color validation
  test "color should be present" do
    @ssr.color = "  "
    assert_not @ssr.valid?
  end
  
  # color validation(range)
  test "color should be pattern" do
    valid_color = 0..4
    invalid_color = [-1, 5, 1.5]
    
    # valid test
    valid_color.each do |color|
      @ssr.color = color
      assert @ssr.valid?, "#{color.inspect} should be valid"
    end
    
    # invalid test
    invalid_color.each do |color|
      @ssr.color = color
      assert_not @ssr.valid?, "#{color.inspect} should be invalid"
    end
  end
  
  # 踏ん張り
  test "stamina should be present" do
    @ssr.stamina = ""
    assert_not @ssr.valid?
  end
  
  test "stamina should be in status range" do
    @valid_status.each do |stamina|
      @ssr.stamina = stamina
      assert @ssr.valid?, "#{stamina.inspect} should be valid"
    end
    
    @invalid_status.each do |stamina|
      @ssr.stamina = stamina
      assert_not @ssr.valid?, "#{stamina.inspect} should be invalid"
    end
  end
    
end
