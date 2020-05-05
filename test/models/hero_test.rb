require 'test_helper'

class HeroTest < ActiveSupport::TestCase
  def setup
    @hero = heros(:wassy)
  end
  
  # 素でvalid似なることを確認
  test "shoud be valid" do
    assert @hero.valid?
  end
  
  # 名前が空白ではないこと
  test "name shoud be present" do
    @hero.name = "     "
    assert_not @hero.valid?
  end
  
  # 名前に文字数制限があること
  test "name shold not be too long" do
    @hero.name = "あああああああああああ"
    assert_not @hero.valid?
  end
  
  # 勇者タイプが空白ではないこと
  test "hero_type should be present" do
    @hero.hero_type = " "
    assert_not @hero.valid?
  end

  # 勇者タイプが空白ではないこと
  test "hero_type not be too long" do
    @hero.hero_type = "テスト"
    assert_not @hero.valid?
  end
  
  # 勇者タイプが意図しないタイプではないこと
  test "hero_type should be 4type" do
    valid_types   = %w[近接 範囲 遠射 巫女]
    invalid_types = %w[勇者 女 大赦]
    
    # 有効確認
    valid_types.each do |t|
      @hero.hero_type = t
      assert @hero.valid?, "#{t.inspect} should be valid"
    end
    
    # 無効確認
    invalid_types.each do |t|
      @hero.hero_type = t
      assert_not @hero.valid?, "#{t.inspect} should be invalid"
    end
      
  end
end
