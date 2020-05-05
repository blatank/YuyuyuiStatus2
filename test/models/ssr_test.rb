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

  # 速度
  test "speed should be present" do
    @ssr.speed = ""
    assert_not @ssr.valid?
  end
  
  test "speed should be in status range" do
    @valid_status.each do |speed|
      @ssr.speed = speed
      assert @ssr.valid?, "#{speed.inspect} should be valid"
    end
    
    @invalid_status.each do |speed|
      @ssr.speed = speed
      assert_not @ssr.valid?, "#{speed.inspect} should be invalid"
    end
  end

  # CRT
  test "crt should be present" do
    @ssr.crt = ""
    assert_not @ssr.valid?
  end
  
  test "crt should be in status range" do
    @valid_status.each do |crt|
      @ssr.crt = crt
      assert @ssr.valid?, "#{crt.inspect} should be valid"
    end
    
    @invalid_status.each do |crt|
      @ssr.crt = crt
      assert_not @ssr.valid?, "#{crt.inspect} should be invalid"
    end
  end

  # HP
  test "hp should be present" do
    @ssr.hp = ""
    assert_not @ssr.valid?
  end
  
  test "hp should be in status range" do
    valid_hp   = [1, 65536, 99999]
    invalid_hp = [0, -1, 1.5]
    
    valid_hp.each do |hp|
      @ssr.hp = hp
      assert @ssr.valid?, "#{hp.inspect} shoud be valid"
    end
    invalid_hp.each do |hp|
      @ssr.hp = hp
      assert_not @ssr.valid?, "#{hp.inspect} shoud not be valid"
    end
  end
  
  # ATK
  test "atk should be present" do
    @ssr.atk = ""
    assert_not @ssr.valid?
  end
  
  test "atk should be in status range" do
    valid_atk   = [1, 65536, 99999]
    invalid_atk = [0, -1, 1.5]
    
    valid_atk.each do |atk|
      @ssr.atk = atk
      assert @ssr.valid?, "#{atk.inspect} shoud be valid"
    end
    invalid_atk.each do |atk|
      @ssr.atk = atk
      assert_not @ssr.valid?, "#{atk.inspect} shoud not be valid"
    end
  end
  
  # cost
  test "cost should be present" do
    @ssr.cost = ""
    assert_not @ssr.valid?
  end  

  test "cost should be in status range" do
    valid_cost   = [1, 99, 50]
    invalid_cost = [0, -1, 1.5, 100]
    
    valid_cost.each do |cost|
      @ssr.cost = cost
      assert @ssr.valid?, "#{cost.inspect} shoud be valid"
    end
    invalid_cost.each do |cost|
      @ssr.cost = cost
      assert_not @ssr.valid?, "#{cost.inspect} shoud not be valid"
    end
  end
  
  # sp
  test "sp should be present" do
    @ssr.sp = ""
    assert_not @ssr.valid?
  end  

  test "sp should be in status range" do
    valid_sp   = [1, 99, 50]
    invalid_sp = [0, -1, 1.5, 100]
    
    valid_sp.each do |sp|
      @ssr.sp = sp
      assert @ssr.valid?, "#{sp.inspect} shoud be valid"
    end
    invalid_sp.each do |sp|
      @ssr.sp = sp
      assert_not @ssr.valid?, "#{sp.inspect} shoud not be valid"
    end
  end
  
  # 必殺技倍率
  test "sp_ratio should be present" do
    @ssr.sp_ratio = ""
    assert_not @ssr.valid?
  end
  
  test "sp_ratio should be in status range" do
    valid_sp_ratio   = [1, 5000, 500, 0]
    invalid_sp_ratio = [-1, 1.5, 5001]
    
    valid_sp_ratio.each do |sp_ratio|
      @ssr.sp_ratio = sp_ratio
      assert @ssr.valid?, "#{sp_ratio.inspect} shoud be valid"
    end
    invalid_sp_ratio.each do |sp_ratio|
      @ssr.sp_ratio = sp_ratio
      assert_not @ssr.valid?, "#{sp_ratio.inspect} shoud not be valid"
    end
  end

  # 必殺技倍率
  test "sp_atk should be present" do
    @ssr.sp_atk = ""
    assert_not @ssr.valid?
  end
  
  test "sp_atk should be in status range" do
    valid_sp_atk   = [1, 500000, 1000000, 0]
    invalid_sp_ratio = [-1, 1.5]
    
    valid_sp_atk.each do |sp_atk|
      @ssr.sp_atk = sp_atk
      assert @ssr.valid?, "#{sp_atk.inspect} shoud be valid"
    end
    invalid_sp_ratio.each do |sp_atk|
      @ssr.sp_atk = sp_atk
      assert_not @ssr.valid?, "#{sp_atk.inspect} shoud not be valid"
    end
  end
end
