require 'test_helper'

class HerosAllUpdateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @hero = heros(:wassy)
  end
  
  test "should not access without login" do
    
    # 変更前の平均値
    pre_atk_ave = @hero.atk_ave
    pre_hp_ave = @hero.hp_ave
    pre_stamina_ave = @hero.stamina_ave
    pre_speed_ave = @hero.speed_ave
    pre_crt_ave = @hero.crt_ave
    pre_cost_ave = @hero.cost_ave
    pre_sp_ave = @hero.sp_ave
    pre_sp_ratio_ave = @hero.sp_ratio_ave
    pre_sp_atk_ave = @hero.sp_atk_ave
    pre_ssr_count = @hero.ssr_count
    pre_ur_count = @hero.ur_count
    
    # all updateにアクセス
    get heros_allupdate_path
    
    # rootにリダイレクトされることを確認 
    assert_redirected_to root_url
    follow_redirect!
    
    # flashはない
    assert_not !!flash[:success]
    
    # 平均値が更新されていない
    @hero.reload
    assert_equal pre_atk_ave, @hero.atk_ave
    assert_equal pre_hp_ave, @hero.hp_ave
    assert_equal pre_stamina_ave, @hero.stamina_ave
    assert_equal pre_speed_ave, @hero.speed_ave
    assert_equal pre_crt_ave, @hero.crt_ave
    assert_equal pre_cost_ave, @hero.cost_ave
    assert_equal pre_sp_ave, @hero.sp_ave
    assert_equal pre_sp_ratio_ave, @hero.sp_ratio_ave
    assert_equal pre_sp_atk_ave, @hero.sp_atk_ave
    assert_equal pre_ssr_count, @hero.ssr_count
    assert_equal pre_ur_count, @hero.ur_count
  end
  
  test "should access with login" do
    # ログインする
    log_in_as(@user)
    
    # 変更前の平均値
    pre_atk_ave = @hero.atk_ave
    pre_hp_ave = @hero.hp_ave
    pre_stamina_ave = @hero.stamina_ave
    pre_speed_ave = @hero.speed_ave
    pre_crt_ave = @hero.crt_ave
    pre_cost_ave = @hero.cost_ave
    pre_sp_ave = @hero.sp_ave
    pre_sp_ratio_ave = @hero.sp_ratio_ave
    pre_sp_atk_ave = @hero.sp_atk_ave
    pre_ssr_count = @hero.ssr_count
    pre_ur_count = @hero.ur_count
    
    # all updateページにアクセス
    get heros_allupdate_path
    
    # rootにリダイレクトされる
    assert_redirected_to root_url
    
    # flashはある
    assert_not flash.empty?
    
    # 平均値が更新されている
    @hero.reload
    assert_not_equal pre_atk_ave, @hero.atk_ave
    assert_not_equal pre_hp_ave, @hero.hp_ave
    assert_not_equal pre_stamina_ave, @hero.stamina_ave
    assert_not_equal pre_speed_ave, @hero.speed_ave
    assert_not_equal pre_crt_ave, @hero.crt_ave
    assert_not_equal pre_cost_ave, @hero.cost_ave
    assert_not_equal pre_sp_ave, @hero.sp_ave
    assert_not_equal pre_sp_ratio_ave, @hero.sp_ratio_ave
    assert_not_equal pre_sp_atk_ave, @hero.sp_atk_ave
    assert_not_equal pre_ssr_count, @hero.ssr_count
    assert_not_equal pre_ur_count, @hero.ur_count
    
    # flash
    assert_not flash.empty?
  end
  

end
