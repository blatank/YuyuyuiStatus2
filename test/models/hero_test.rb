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
end
