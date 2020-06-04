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
    @hero.filename = "a" * 256
    assert_not @hero.valid?
  end
  
  # icon_url
  test "icon_url should not be too long" do
    @hero.icon_url = "https://www.example.com/" + "a"*974 + "jpg"
    assert_not @hero.valid?
  end
  
  test "image_url should be image file" do 
    valid_files   = %w[jpeg jpg png gif svg bmp JPeG JPG Png Gif SVG BMp]
    invalid_files = %w[doc xls html htm cgi php]
    
    valid_files.each do |f|
      @hero.icon_url = "https://www.example.com/image_files/aaa-0001.#{f}"
      assert @hero.valid?, "#{f.inspect} should be valid"
    end
    
    invalid_files.each do |f|
      @hero.icon_url = "https://www.example.com/image_files/aaa-0001.#{f}"
      assert_not @hero.valid?, "#{f.inspect} should not be valid"
    end
  end
  
  test "image_url should be https protocol" do
    invalid_protocol = %w[http ftp ttp ttps]
    
    invalid_protocol.each do |p|
      @hero.icon_url = "#{p}://www.example.com/aaa.jpg"
      assert_not @hero.valid?, "#{p.inspect} should not be valid"
    end
  end
  

end
