require 'test_helper'

class HeroTypeTest < ActiveSupport::TestCase
  
  def setup
    @hero_type = HeroType.new(name: "近接")
  end
  
  # 勇者タイプが空白ではないこと
  test "hero_type should be present" do
    @hero_type.name = " "
    assert_not @hero_type.valid?
  end

  # 勇者タイプが空白ではないこと
  test "hero_type not be too long" do
    @hero_type.name = "テスト"
    assert_not @hero_type.valid?
  end
  
  # 勇者タイプが意図しないタイプではないこと
  test "hero_type should be 4type" do
    valid_types   = %w[近接 範囲 遠射 巫女]
    invalid_types = %w[勇者 女 大赦]
    
    # 有効確認
    valid_types.each do |t|
      @hero_type.name = t
      assert @hero_type.valid?, "#{t.inspect} should be valid"
    end
    
    # 無効確認
    invalid_types.each do |t|
      @hero_type.name = t
      assert_not @hero_type.valid?, "#{t.inspect} should be invalid"
    end
      
  end
end
