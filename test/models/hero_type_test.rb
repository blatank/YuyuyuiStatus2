require 'test_helper'

class HeroTypeTest < ActiveSupport::TestCase
  
  def setup
    @hero_type = hero_types(:kinsetsu)
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
  
  # ユニークであること
  test "hero_type should be unique" do
    new_type = @hero_type.dup
    assert_not new_type.valid?
  end
  
  # 存在する勇者タイプは有効になること
  test "hero_type should be 4type" do
    valid_types = [:kinsetsu, :hani, :ensya, :miko]
    
    valid_types.each do |t|
      hero_type = hero_types(t)
      assert hero_type.valid?, "#{hero_type.name.inspect} should be valid"
    end
  end
  
  # 勇者タイプが意図しないタイプではないこと
  test "hero_type should not be out of 4type" do
    invalid_types = %w[勇者 女 大赦]
    
    # 無効確認
    invalid_types.each do |t|
      @hero_type.name = t
      assert_not @hero_type.valid?, "#{t.inspect} should be invalid"
    end
      
  end
end
