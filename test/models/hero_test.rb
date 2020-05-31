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
  
  # 名前がユニークであること
  test "name shoud be unique" do
    new_hero = @hero.dup
    assert_not new_hero.valid?
  end
  
  # filename
  test "filename should be present" do
    @hero.filename = " "
    assert_not @hero.valid?
  end
  
  test "filename should not be too long" do
    @hero.filename = "a" * 252 + ".csv"
    assert_not @hero.valid?
  end
  
  test "filename should be csv" do
    valid_files   = %w[aaa.csv aaa.CsV]
    invalid_files = %w[aaa.txt aaa.html aaa.bin aaa.zip aaa.csv.html]

    valid_files.each do |f|
      @hero.filename = f
      assert @hero.valid?, "#{f.inspect} should be valid"
    end
    
    invalid_files.each do |f|
      @hero.filename = f
      assert_not @hero.valid?, "#{f.inspect} should not be valid"
    end
  end
end
